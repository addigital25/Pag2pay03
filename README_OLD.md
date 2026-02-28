# 🌟 Pag2Pay - Plataforma de Vendas e Afiliados

Sistema completo de gestão de produtos digitais, vendas e programa de afiliados.

## 🚀 Deploy Rápido - Hostinger VPS

**Leia o guia completo:** [DEPLOY_HOSTINGER_VPS.md](./DEPLOY_HOSTINGER_VPS.md)

### Resumo Rápido:

```bash
# 1. Instalar dependências no servidor
sudo apt update && sudo apt upgrade -y
curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash -
sudo apt install -y nodejs nginx certbot python3-certbot-nginx
sudo npm install -g pm2

# 2. Fazer upload do código
scp pag2pay-v10.3-menu-fix.tar.gz usuario@seu-servidor:/home/usuario/
# No servidor:
tar -xzf pag2pay-v10.3-menu-fix.tar.gz
mv afterpay-mvp pag2pay

# 3. Configurar Backend
cd pag2pay/backend
cp .env.example .env
nano .env  # Editar com suas configurações
npm install --production
pm2 start server.js --name pag2pay-backend
pm2 startup && pm2 save

# 4. Configurar Frontend
cd ../frontend
nano .env.production  # VITE_API_URL=https://seu-dominio.com
npm install
npm run build
sudo mkdir -p /var/www/pag2pay
sudo cp -r dist/* /var/www/pag2pay/

# 5. Configurar Nginx
sudo nano /etc/nginx/sites-available/pag2pay
# Cole a configuração do guia
sudo ln -s /etc/nginx/sites-available/pag2pay /etc/nginx/sites-enabled/
sudo nginx -t && sudo systemctl restart nginx

# 6. SSL/HTTPS
sudo certbot --nginx -d seu-dominio.com -d www.seu-dominio.com

# ✅ Pronto! Acesse https://seu-dominio.com
```

## 🔐 Logins de Teste

### Usuário
- URL: `https://seu-dominio.com/login`
- Email: `usuario@pag2pay.com`
- Senha: `usuario123`

### Administrador
- URL: `https://seu-dominio.com/admin/login`
- Email: `admin@pag2pay.com`
- Senha: `admin123`

## 📂 Estrutura do Projeto

```
pag2pay/
├── backend/           # API Node.js + Express
│   ├── server.js     # Servidor principal
│   ├── database.json # Banco de dados (migrar para PostgreSQL em produção)
│   └── .env          # Variáveis de ambiente
├── frontend/          # React + Vite + TailwindCSS
│   ├── src/
│   └── dist/         # Build de produção
├── deploy.sh         # Script de deploy automático
└── DEPLOY_HOSTINGER_VPS.md  # Guia completo
```

## 🛠️ Desenvolvimento Local

```bash
# Backend
cd backend
npm install
npm start  # Roda na porta 3001

# Frontend (em outro terminal)
cd frontend
npm install
npm run dev  # Roda na porta 3000
```

## 📦 Tecnologias

**Frontend:**
- React 18
- Vite
- TailwindCSS
- React Router

**Backend:**
- Node.js
- Express
- CORS
- UUID

**Produção:**
- Nginx (servidor web)
- PM2 (gerenciamento de processos)
- Certbot/Let's Encrypt (SSL)

## 🔒 Segurança

**IMPORTANTE antes de colocar em produção:**

1. ✅ Trocar `JWT_SECRET` e `SESSION_SECRET` no `.env`
2. ✅ Configurar firewall (UFW)
3. ✅ Instalar Fail2Ban
4. ✅ Migrar `database.json` para PostgreSQL
5. ✅ Configurar backup automático

## 💰 Custos (Hostinger VPS)

- VPS KVM 1: R$ 19/mês (2GB RAM)
- VPS KVM 2: R$ 29/mês (4GB RAM) ← Recomendado
- Domínio: ~R$ 40/ano
- SSL: Grátis

**Total:** ~R$ 32/mês

## 📞 Suporte

Problemas? Verifique:
```bash
pm2 logs pag2pay-backend
sudo tail -f /var/log/nginx/error.log
sudo systemctl status nginx
```

---

**Desenvolvido com ❤️ para Pag2Pay**
