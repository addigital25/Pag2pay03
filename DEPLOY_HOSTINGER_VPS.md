# 🚀 Guia Completo de Deploy - Pag2Pay na Hostinger VPS

## 📋 Pré-requisitos

1. **VPS Hostinger Contratado** (a partir de R$19/mês)
2. **Domínio configurado** apontando para o IP do VPS
3. **Acesso SSH** ao servidor
4. **Ubuntu 20.04/22.04** (recomendado)

---

## 🛠️ PASSO 1: Configuração Inicial do Servidor

### 1.1 Conectar ao VPS via SSH

```bash
ssh root@seu-ip-vps
# Ou se já criou outro usuário:
ssh usuario@seu-ip-vps
```

### 1.2 Atualizar o Sistema

```bash
sudo apt update && sudo apt upgrade -y
```

### 1.3 Criar Usuário (se estiver como root)

```bash
# Criar novo usuário
adduser usuario

# Adicionar ao grupo sudo
usermod -aG sudo usuario

# Trocar para o novo usuário
su - usuario
```

---

## 📦 PASSO 2: Instalar Dependências

### 2.1 Instalar Node.js 18.x

```bash
# Adicionar repositório NodeSource
curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash -

# Instalar Node.js
sudo apt install -y nodejs

# Verificar instalação
node --version  # deve mostrar v18.x.x
npm --version   # deve mostrar 9.x.x
```

### 2.2 Instalar PM2 (Gerenciador de Processos)

```bash
sudo npm install -g pm2

# Verificar instalação
pm2 --version
```

### 2.3 Instalar Nginx

```bash
sudo apt install nginx -y

# Iniciar e habilitar
sudo systemctl start nginx
sudo systemctl enable nginx

# Verificar status
sudo systemctl status nginx
```

### 2.4 Instalar Certbot (SSL/HTTPS Grátis)

```bash
sudo apt install certbot python3-certbot-nginx -y
```

---

## 📂 PASSO 3: Fazer Upload do Código

### Opção A: Via SCP (do seu computador)

```bash
# No seu computador local
scp pag2pay-v10.3-menu-fix.tar.gz usuario@seu-ip-vps:/home/usuario/
```

### Opção B: Via Git (recomendado)

```bash
# No servidor VPS
cd /home/usuario

# Instalar git se necessário
sudo apt install git -y

# Clonar repositório (ou fazer upload)
# Se usar git:
git clone https://seu-repositorio.git pag2pay

# Se usar o arquivo tar.gz:
tar -xzf pag2pay-v10.3-menu-fix.tar.gz
mv afterpay-mvp pag2pay
```

---

## ⚙️ PASSO 4: Configurar Backend

### 4.1 Navegar para pasta do backend

```bash
cd /home/usuario/pag2pay/backend
```

### 4.2 Criar arquivo .env

```bash
nano .env
```

Cole o seguinte conteúdo (ajuste conforme necessário):

```env
PORT=3001
NODE_ENV=production

FRONTEND_URL=https://seu-dominio.com
ADMIN_URL=https://seu-dominio.com/admin

JWT_SECRET=MUDE-ISSO-PARA-UMA-CHAVE-SECRETA-FORTE-E-ALEATORIA
SESSION_SECRET=MUDE-ISSO-TAMBEM-PARA-OUTRA-CHAVE-DIFERENTE
```

**Salvar:** `Ctrl + O`, depois `Enter`
**Sair:** `Ctrl + X`

### 4.3 Instalar dependências

```bash
npm install --production
```

### 4.4 Iniciar com PM2

```bash
# Iniciar aplicação
pm2 start server.js --name pag2pay-backend

# Configurar para iniciar automaticamente após reboot
pm2 startup
# Copie e execute o comando que o PM2 mostrar

# Salvar configuração
pm2 save

# Verificar status
pm2 list
pm2 logs pag2pay-backend
```

---

## 🎨 PASSO 5: Configurar Frontend

### 5.1 Navegar para pasta do frontend

```bash
cd /home/usuario/pag2pay/frontend
```

### 5.2 Criar arquivo .env.production

```bash
nano .env.production
```

Cole:

```env
VITE_API_URL=https://seu-dominio.com
```

**Salvar e sair** (`Ctrl + O`, `Enter`, `Ctrl + X`)

### 5.3 Instalar dependências e compilar

```bash
npm install
npm run build
```

Isso criará a pasta `dist` com os arquivos estáticos.

### 5.4 Criar diretório web

```bash
sudo mkdir -p /var/www/pag2pay
sudo chown -R $USER:$USER /var/www/pag2pay
```

### 5.5 Copiar arquivos compilados

```bash
cp -r dist/* /var/www/pag2pay/
```

---

## 🌐 PASSO 6: Configurar Nginx

### 6.1 Criar configuração do site

```bash
sudo nano /etc/nginx/sites-available/pag2pay
```

Cole a seguinte configuração:

```nginx
server {
    listen 80;
    server_name seu-dominio.com www.seu-dominio.com;

    # Frontend - Servir arquivos estáticos
    root /var/www/pag2pay;
    index index.html;

    location / {
        try_files $uri $uri/ /index.html;
    }

    # Backend API - Proxy reverso
    location /api {
        proxy_pass http://localhost:3001;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection 'upgrade';
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
        proxy_cache_bypass $http_upgrade;
    }

    # Segurança - Bloquear acesso a arquivos sensíveis
    location ~ /\. {
        deny all;
    }

    # Logs
    access_log /var/log/nginx/pag2pay-access.log;
    error_log /var/log/nginx/pag2pay-error.log;
}
```

**IMPORTANTE:** Substitua `seu-dominio.com` pelo seu domínio real!

**Salvar e sair** (`Ctrl + O`, `Enter`, `Ctrl + X`)

### 6.2 Ativar o site

```bash
# Criar link simbólico
sudo ln -s /etc/nginx/sites-available/pag2pay /etc/nginx/sites-enabled/

# Remover site padrão (opcional)
sudo rm /etc/nginx/sites-enabled/default

# Testar configuração
sudo nginx -t

# Se OK, reiniciar Nginx
sudo systemctl restart nginx
```

---

## 🔒 PASSO 7: Configurar SSL/HTTPS com Certbot

### 7.1 Obter certificado SSL (GRÁTIS)

```bash
sudo certbot --nginx -d seu-dominio.com -d www.seu-dominio.com
```

Siga as instruções:
1. Digite seu email
2. Aceite os termos
3. Escolha se quer compartilhar email (opcional)
4. **IMPORTANTE:** Escolha opção 2 (redirecionar HTTP para HTTPS)

### 7.2 Renovação automática

```bash
# Testar renovação
sudo certbot renew --dry-run

# O Certbot já configura renovação automática
# Verificar se está ativo:
sudo systemctl status certbot.timer
```

---

## ✅ PASSO 8: Verificar Funcionamento

### 8.1 Verificar serviços

```bash
# Backend
pm2 status
pm2 logs pag2pay-backend --lines 50

# Nginx
sudo systemctl status nginx

# Verificar porta 3001 (backend)
sudo netstat -tlnp | grep 3001
```

### 8.2 Testar no navegador

1. **Frontend:** https://seu-dominio.com
2. **Login Usuário:** https://seu-dominio.com/login
3. **Login Admin:** https://seu-dominio.com/admin/login

### 8.3 Testar API

```bash
curl https://seu-dominio.com/api/products
```

---

## 🔄 PASSO 9: Script de Deploy Automático (Opcional)

### 9.1 Copiar script de deploy

```bash
cp /home/usuario/pag2pay/deploy.sh /home/usuario/
chmod +x /home/usuario/deploy.sh
```

### 9.2 Editar script

```bash
nano /home/usuario/deploy.sh
```

Ajuste os caminhos se necessário.

### 9.3 Usar script

```bash
# Futuros deploys:
cd /home/usuario
./deploy.sh
```

---

## 🛡️ PASSO 10: Segurança Adicional

### 10.1 Firewall (UFW)

```bash
# Instalar UFW
sudo apt install ufw -y

# Permitir SSH, HTTP e HTTPS
sudo ufw allow ssh
sudo ufw allow 'Nginx Full'

# Ativar firewall
sudo ufw enable

# Verificar status
sudo ufw status
```

### 10.2 Fail2Ban (proteção contra brute force)

```bash
sudo apt install fail2ban -y
sudo systemctl enable fail2ban
sudo systemctl start fail2ban
```

### 10.3 Atualizar chaves secretas

**MUITO IMPORTANTE:** Edite o arquivo `.env` e troque as chaves secretas:

```bash
cd /home/usuario/pag2pay/backend
nano .env
```

Gere chaves aleatórias:
```bash
# Gerar chave aleatória
openssl rand -base64 32
```

---

## 📊 PASSO 11: Monitoramento (Opcional mas Recomendado)

### 11.1 PM2 Monitoring

```bash
pm2 install pm2-logrotate
pm2 set pm2-logrotate:max_size 10M
pm2 set pm2-logrotate:retain 7
```

### 11.2 UptimeRobot (Gratuito)

1. Cadastre-se em https://uptimerobot.com
2. Adicione monitor HTTP para seu domínio
3. Configure alertas por email

---

## 🔧 Manutenção e Comandos Úteis

### Ver logs do backend
```bash
pm2 logs pag2pay-backend
pm2 logs pag2pay-backend --lines 100
```

### Reiniciar backend
```bash
pm2 restart pag2pay-backend
```

### Ver logs do Nginx
```bash
sudo tail -f /var/log/nginx/pag2pay-error.log
sudo tail -f /var/log/nginx/pag2pay-access.log
```

### Reiniciar Nginx
```bash
sudo systemctl restart nginx
```

### Atualizar código e fazer novo deploy
```bash
cd /home/usuario/pag2pay
git pull  # se usar git
./deploy.sh  # ou executar manualmente os passos
```

### Backup do banco de dados
```bash
cp /home/usuario/pag2pay/backend/database.json /home/usuario/backup-$(date +%Y%m%d).json
```

---

## ❗ Troubleshooting (Solução de Problemas)

### Problema: Site não carrega

**Verificar:**
```bash
sudo systemctl status nginx
sudo nginx -t
pm2 status
```

### Problema: API não funciona (erro de CORS)

**Verificar arquivo `.env` do backend:**
```bash
cd /home/usuario/pag2pay/backend
cat .env
```

Deve ter:
```
FRONTEND_URL=https://seu-dominio.com
```

**Reiniciar backend:**
```bash
pm2 restart pag2pay-backend
```

### Problema: SSL não funciona

**Verificar certificado:**
```bash
sudo certbot certificates
```

**Renovar manualmente:**
```bash
sudo certbot renew
sudo systemctl restart nginx
```

### Problema: Porta 80 ou 443 em uso

**Verificar o que está usando:**
```bash
sudo netstat -tlnp | grep :80
sudo netstat -tlnp | grep :443
```

---

## 📱 Próximos Passos (Recomendados)

1. ✅ **Migrar para PostgreSQL** (atualmente usando database.json)
2. ✅ **Configurar backup automático**
3. ✅ **Adicionar autenticação JWT mais robusta**
4. ✅ **Implementar rate limiting**
5. ✅ **Configurar CDN (Cloudflare)**
6. ✅ **Adicionar testes automatizados**

---

## 💰 Custos Estimados (Hostinger VPS)

- **VPS KVM 1:** R$ 19/mês (2GB RAM, 20GB SSD)
- **VPS KVM 2:** R$ 29/mês (4GB RAM, 40GB SSD) ← **Recomendado**
- **VPS KVM 4:** R$ 49/mês (8GB RAM, 80GB SSD)
- **Domínio:** ~R$ 40/ano
- **SSL:** Grátis (Let's Encrypt)

**Total mínimo:** ~R$ 22,50/mês (VPS + domínio)

---

## 🎉 Conclusão

Se seguiu todos os passos, sua plataforma Pag2Pay está no ar com:

✅ HTTPS (SSL) configurado
✅ Backend rodando com PM2
✅ Frontend servido pelo Nginx
✅ Domínio personalizado
✅ Deploy automático
✅ Segurança básica configurada

**Acesse:** https://seu-dominio.com

---

## 📞 Suporte

Se tiver problemas, verifique:
1. Logs do PM2: `pm2 logs`
2. Logs do Nginx: `sudo tail -f /var/log/nginx/error.log`
3. Status dos serviços: `pm2 status` e `sudo systemctl status nginx`

**Boa sorte! 🚀**
