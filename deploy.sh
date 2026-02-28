#!/bin/bash

# Script de Deploy Automático - Pag2Pay
# Para Hostinger VPS

echo "🚀 Iniciando deploy do Pag2Pay..."

# Cores para output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Configurações
PROJECT_DIR="/home/usuario/pag2pay"
BACKEND_DIR="$PROJECT_DIR/backend"
FRONTEND_DIR="$PROJECT_DIR/frontend"

# 1. Atualizar código
echo -e "${BLUE}📥 Atualizando código...${NC}"
cd $PROJECT_DIR
git pull origin main

# 2. Backend
echo -e "${BLUE}🔧 Atualizando Backend...${NC}"
cd $BACKEND_DIR
npm install --production
pm2 restart pag2pay-backend || pm2 start server.js --name pag2pay-backend

# 3. Frontend
echo -e "${BLUE}🎨 Compilando Frontend...${NC}"
cd $FRONTEND_DIR
npm install
npm run build

# 4. Copiar build para nginx
echo -e "${BLUE}📦 Atualizando arquivos estáticos...${NC}"
sudo rm -rf /var/www/pag2pay/*
sudo cp -r dist/* /var/www/pag2pay/

# 5. Reiniciar Nginx
echo -e "${BLUE}🔄 Reiniciando Nginx...${NC}"
sudo systemctl restart nginx

# 6. Verificar status
echo -e "${BLUE}✅ Verificando serviços...${NC}"
pm2 list
sudo systemctl status nginx --no-pager

echo -e "${GREEN}✨ Deploy concluído com sucesso!${NC}"
echo -e "${GREEN}🌐 Acesse: https://seu-dominio.com${NC}"
