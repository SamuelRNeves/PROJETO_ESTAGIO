@echo off
docker start redis || docker run -d -p 6379:6379 --name redis redis
call .\env\Scripts\activate
python server.py