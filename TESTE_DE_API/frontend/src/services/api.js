import axios from "axios";

const api = axios.create({
  baseURL: process.env.NODE_ENV === 'production' 
    ? 'https://seu-backend-produtivo.com/api' 
    : 'http://localhost:8000',
  timeout: 10000,
  headers: {
    'Content-Type': 'application/json'
  }
});

// Interceptor simplificado
api.interceptors.response.use(
  response => response.data,
  error => {
    if (error.response) {
      return Promise.reject(error.response.data?.detail || error.message);
    }
    return Promise.reject(error.message || 'Erro desconhecido');
  }
);

export default api;