#!/bin/bash

echo "🚀 Instalando AfterPay MVP..."
echo ""

# Instalar backend
echo "📦 Instalando dependências do backend..."
cd backend
npm install
cd ..

echo ""

# Instalar frontend
echo "📦 Instalando dependências do frontend..."
cd frontend
npm install
cd ..

echo ""
echo "✅ Instalação concluída!"
echo ""
echo "Para executar a aplicação:"
echo ""
echo "1. Backend (em um terminal):"
echo "   cd backend && npm start"
echo ""
echo "2. Frontend (em outro terminal):"
echo "   cd frontend && npm run dev"
echo ""
echo "3. Acesse http://localhost:3000"
echo ""
