<template>
  <div class="container">
    <h1>Busca de Operadoras de Saúde</h1>
    
    <div class="search-box">
      <input
        v-model="searchTerm"
        @keyup.enter="searchOperators"
        placeholder="Digite nome, CNPJ ou razão social..."
        :disabled="loading"
      />
      <button 
        @click="searchOperators" 
        :disabled="loading || searchTerm.length < 2"
      >
        {{ loading ? 'Buscando...' : 'Buscar' }}
      </button>
    </div>

    <div v-if="error" class="error-message">
      {{ error }}
    </div>

    <div v-if="loading" class="loading-indicator">
      <div class="spinner"></div>
      <p>Carregando...</p>
    </div>

    <template v-if="searchPerformed">
      <div v-if="results.length > 0" class="results-container">
        <h2>Resultados ({{ count }})</h2>
        <div 
          v-for="op in results" 
          :key="op.registro_ans" 
          class="operator-card"
        >
          <h3>{{ op.nome_fantasia || op.razao_social }}</h3>
          <p><strong>CNPJ:</strong> {{ formatCNPJ(op.cnpj) }}</p>
          <p><strong>Registro ANS:</strong> {{ op.registro_ans }}</p>
          <p><strong>Modalidade:</strong> {{ op.modalidade || 'Não informado' }}</p>
        </div>
      </div>

      <div v-else class="no-results">
        Nenhum resultado encontrado para "{{ searchTerm }}"
      </div>
    </template>
  </div>
</template>

<script>
import api from '@/services/api'
import { ref } from 'vue'

export default {
  setup() {
    const searchTerm = ref('')
    const results = ref([])
    const count = ref(0)
    const loading = ref(false)
    const error = ref('')
    const searchPerformed = ref(false)

    const formatCNPJ = (cnpj) => {
      if (!cnpj) return 'Não informado'
      return cnpj.replace(/^(\d{2})(\d{3})(\d{3})(\d{4})(\d{2})$/, '$1.$2.$3/$4-$5')
    }

    const searchOperators = async () => {
      if (searchTerm.value.length < 2) return
      
      loading.value = true
      error.value = ''
      searchPerformed.value = true
      
      try {
        const response = await api.get('/api/buscar', {
          params: {
            query: searchTerm.value,
          },
          timeout: 10000
        })
        
        // Verificação robusta da resposta
        if (response && response.results) {
          results.value = response.results
          count.value = response.count || 0
        } else {
          throw new Error('Formato de resposta inválido')
        }
        
      } catch (err) {
        error.value = err.response?.data?.detail || err.message || 'Erro desconhecido'
        results.value = []
        count.value = 0
      } finally {
        loading.value = false
      }
    }

    return {
      searchTerm,
      results,
      count,
      loading,
      error,
      searchPerformed,
      searchOperators,
      formatCNPJ
    }
  }
}
</script>

<style scoped>
/* Estilos mantidos do seu código original */
.container {
  max-width: 800px;
  margin: 0 auto;
  padding: 2rem;
}
.search-box {
  display: flex;
  gap: 1rem;
  margin-bottom: 2rem;
}

input {
  flex: 1;
  padding: 0.75rem;
  font-size: 1rem;
  border: 1px solid #ddd;
  border-radius: 4px;
}

button {
  padding: 0.75rem 1.5rem;
  background-color: #42b983;
  color: white;
  border: none;
  border-radius: 4px;
  cursor: pointer;
}

button:disabled {
  background-color: #ccc;
  cursor: not-allowed;
}

.error-message {
  color: #d32f2f;
  background-color: #ffebee;
  padding: 1rem;
  border-radius: 4px;
  margin-bottom: 1rem;
}

.loading-indicator {
  display: flex;
  justify-content: center;
  padding: 2rem;
}

.spinner {
  width: 40px;
  height: 40px;
  border: 4px solid rgba(0,0,0,0.1);
  border-left-color: #42b983;
  border-radius: 50%;
  animation: spin 1s linear infinite;
}

@keyframes spin {
  to { transform: rotate(360deg); }
}

.operator-card {
  border: 1px solid #eee;
  border-radius: 8px;
  padding: 1.5rem;
  margin-bottom: 1rem;
}

.no-results {
  text-align: center;
  color: #666;
  padding: 2rem;
}
</style>