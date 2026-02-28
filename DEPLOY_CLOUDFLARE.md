# ☁️ Guia Completo de Deploy - Pag2Pay na Cloudflare (GRÁTIS)

## 💰 Custo Total: R$ 0/mês
(até 100.000 requisições/dia)

---

## 🎯 Arquitetura

```
Frontend → Cloudflare Pages (GRÁTIS)
Backend → Sua VPS / Vercel / Railway (API mantém Node.js)
Banco → Supabase PostgreSQL (GRÁTIS até 500MB)
CDN → Cloudflare (GRÁTIS, global)
SSL → Cloudflare (GRÁTIS, automático)
```

**Por que essa arquitetura?**
- Frontend estático ultra-rápido no Cloudflare Pages
- Backend continua em Node.js (sem reescrever para Workers)
- PostgreSQL robusto e gerenciado no Supabase
- Performance global automática

---

## 📋 Pré-requisitos

1. ✅ Conta GitHub (grátis)
2. ✅ Conta Cloudflare (grátis) - https://dash.cloudflare.com/sign-up
3. ✅ Conta Supabase (grátis) - https://supabase.com
4. ✅ Domínio próprio (opcional, mas recomendado)

---

## 🗄️ PARTE 1: Configurar Banco de Dados (Supabase)

### 1.1 Criar Projeto Supabase

1. Acesse https://supabase.com
2. Clique em **"Start your project"**
3. **Sign in** com GitHub
4. Clique em **"New Project"**
5. Preencha:
   - **Name:** `pag2pay`
   - **Database Password:** Crie uma senha forte (anote!)
   - **Region:** South America (São Paulo) - melhor latência
   - **Pricing Plan:** Free
6. Clique **"Create new project"**
7. Aguarde ~2 minutos para provisionar

### 1.2 Criar Tabelas no Banco

1. No painel Supabase, vá em **"SQL Editor"** (menu lateral)
2. Clique em **"New query"**
3. Cole o conteúdo do arquivo `database-schema.sql`
4. Clique em **"Run"** (ou Ctrl + Enter)
5. ✅ Deve mostrar "Success. No rows returned"

### 1.3 Obter Credenciais do Banco

1. Vá em **"Settings"** → **"Database"**
2. Copie:
   - **Host:** `db.xxx.supabase.co`
   - **Database name:** `postgres`
   - **Port:** `5432`
   - **User:** `postgres`
   - **Password:** (a senha que você criou)

3. Ou use a **Connection string** pronta:
```
postgresql://postgres:[SUA-SENHA]@db.xxx.supabase.co:5432/postgres
```

**Salve essas informações!** Você vai usar no backend.

---

## 🔧 PARTE 2: Preparar Backend

### Opção A: Hospedar Backend na Vercel/Railway (Recomendado - GRÁTIS)

#### 2A.1 Deploy no Railway (Mais Fácil)

1. Acesse https://railway.app
2. Clique **"Start a New Project"**
3. **"Deploy from GitHub repo"**
4. Autorize acesso ao GitHub
5. Selecione seu repositório `pag2pay`
6. Na pasta, escolha `afterpay-mvp/backend`
7. Adicione variáveis de ambiente:

```env
PORT=3001
NODE_ENV=production
FRONTEND_URL=https://seu-dominio.pages.dev
DATABASE_URL=postgresql://postgres:[SUA-SENHA]@db.xxx.supabase.co:5432/postgres
JWT_SECRET=sua-chave-secreta-aleatoria-123456
SESSION_SECRET=outra-chave-secreta-654321
```

8. Clique **"Deploy"**
9. Aguarde build (1-2 min)
10. Copie a URL do backend: `https://pag2pay-backend.up.railway.app`

#### 2A.2 Deploy no Vercel (Alternativa)

1. Acesse https://vercel.com
2. **"Add New"** → **"Project"**
3. Importe repositório GitHub
4. Configure:
   - **Framework Preset:** Other
   - **Root Directory:** `afterpay-mvp/backend`
   - **Build Command:** (deixe vazio)
   - **Output Directory:** (deixe vazio)
5. Adicione variáveis de ambiente (mesmas acima)
6. **"Deploy"**
7. Copie a URL: `https://pag2pay-backend.vercel.app`

### Opção B: Backend no Hostinger VPS

Se preferir manter no VPS:
- Siga o guia `DEPLOY_HOSTINGER_VPS.md`
- A URL do backend será: `https://api.seu-dominio.com`

---

## 🎨 PARTE 3: Deploy do Frontend (Cloudflare Pages)

### 3.1 Preparar Código

No seu computador:

```bash
cd afterpay-mvp/frontend

# Criar arquivo .env.production
echo "VITE_API_URL=https://pag2pay-backend.up.railway.app" > .env.production
# OU se usou Vercel:
# echo "VITE_API_URL=https://pag2pay-backend.vercel.app" > .env.production
# OU se usou VPS:
# echo "VITE_API_URL=https://api.seu-dominio.com" > .env.production
```

### 3.2 Fazer Push para GitHub

```bash
# Na raiz do projeto
git add .
git commit -m "Preparar para deploy Cloudflare"
git push origin main
```

### 3.3 Conectar ao Cloudflare Pages

1. Acesse https://dash.cloudflare.com
2. Vá em **"Workers & Pages"**
3. Clique **"Create application"**
4. Aba **"Pages"** → **"Connect to Git"**
5. Clique **"Connect GitHub"**
6. Autorize Cloudflare
7. Selecione repositório `pag2pay`
8. Configure build:

```
Project name: pag2pay
Production branch: main
Build command: npm run build
Build output directory: dist
Root directory: afterpay-mvp/frontend
```

9. **Environment variables:**
```
VITE_API_URL = https://pag2pay-backend.up.railway.app
```

10. Clique **"Save and Deploy"**
11. Aguarde build (2-3 min)
12. ✅ Deploy concluído!

Sua URL será: `https://pag2pay.pages.dev`

### 3.4 Adicionar Domínio Personalizado (Opcional)

1. No Cloudflare Pages, vá em **"Custom domains"**
2. Clique **"Set up a custom domain"**
3. Digite: `seu-dominio.com`
4. Siga as instruções para configurar DNS
5. SSL é automático! 🔒

---

## ✅ PARTE 4: Testar Tudo

### 4.1 Testar Backend

```bash
curl https://pag2pay-backend.up.railway.app/api/products
```

Deve retornar os 3 produtos de demonstração.

### 4.2 Testar Frontend

Acesse no navegador:
- **Frontend:** https://pag2pay.pages.dev
- **Login Usuário:** https://pag2pay.pages.dev/login
- **Login Admin:** https://pag2pay.pages.dev/admin/login

**Credenciais:**
- Usuário: `usuario@pag2pay.com` / `usuario123`
- Admin: `admin@pag2pay.com` / `admin123`

### 4.3 Verificar Banco

No Supabase:
1. Vá em **"Table Editor"**
2. Selecione tabela `users`
3. Deve ver os 2 usuários criados

---

## 🔄 PARTE 5: Deploy Automático

### 5.1 CI/CD Automático (Já Configurado!)

Agora todo `git push` faz deploy automático:

```bash
# Fazer mudanças no código
git add .
git commit -m "Nova feature"
git push origin main

# Cloudflare Pages detecta e faz deploy automático!
# Railway/Vercel também!
```

### 5.2 Ver Logs de Deploy

**Cloudflare Pages:**
1. https://dash.cloudflare.com
2. **"Workers & Pages"** → Seu projeto
3. **"Deployments"** → Ver logs

**Railway:**
1. https://railway.app
2. Seu projeto → **"Deployments"**

---

## 🛡️ PARTE 6: Segurança

### 6.1 Configurar CORS no Backend

Já está configurado no código! Apenas certifique-se que a variável `FRONTEND_URL` está correta.

### 6.2 Trocar Senhas Padrão

**IMPORTANTE:** Antes de usar em produção:

1. No Supabase SQL Editor:
```sql
UPDATE users 
SET password = 'nova-senha-forte-admin' 
WHERE email = 'admin@pag2pay.com';

UPDATE users 
SET password = 'nova-senha-forte-usuario' 
WHERE email = 'usuario@pag2pay.com';
```

2. Ou implemente hash de senha (bcrypt) no backend

### 6.3 Variáveis de Ambiente

Trocar chaves secretas para valores aleatórios:

```bash
# Gerar chaves aleatórias
openssl rand -base64 32
```

Atualizar no Railway/Vercel:
- `JWT_SECRET`
- `SESSION_SECRET`

---

## 📊 PARTE 7: Monitoramento

### 7.1 Cloudflare Analytics (Grátis)

1. No Cloudflare Pages
2. **"Analytics"**
3. Ver:
   - Requisições
   - Bandwidth
   - Visitantes únicos
   - Países

### 7.2 Supabase Dashboard

1. No Supabase
2. **"Database"** → **"Database"** (menu)
3. Ver:
   - Tamanho do banco
   - Conexões ativas
   - Queries mais lentas

### 7.3 Uptime Monitoring (Grátis)

Use https://uptimerobot.com (grátis):
1. Cadastre-se
2. **"Add New Monitor"**
3. Monitore:
   - Frontend: `https://pag2pay.pages.dev`
   - Backend: `https://pag2pay-backend.up.railway.app/api/products`

---

## 💡 PARTE 8: Otimizações

### 8.1 Cloudflare Cache

Já está otimizado automaticamente! Assets são cacheados globalmente.

### 8.2 Compressão

Cloudflare comprime automaticamente (Brotli/Gzip).

### 8.3 Minificação

Cloudflare minifica HTML/CSS/JS automaticamente.

### 8.4 HTTP/3

Já está ativo! Cloudflare usa HTTP/3 (QUIC) automaticamente.

---

## 🚀 Comparação: Cloudflare vs VPS

| Recurso | Cloudflare + Railway + Supabase | Hostinger VPS |
|---------|--------------------------------|---------------|
| **Custo/mês** | R$ 0 | R$ 29 |
| **Performance** | ⭐⭐⭐⭐⭐ Global | ⭐⭐⭐ 1 servidor |
| **Escalabilidade** | ⭐⭐⭐⭐⭐ Automática | ⭐⭐ Manual |
| **Manutenção** | ⭐⭐⭐⭐⭐ Zero | ⭐⭐ Você cuida |
| **Deploy** | ⭐⭐⭐⭐⭐ Git push | ⭐⭐⭐ SSH manual |
| **SSL/HTTPS** | ⭐⭐⭐⭐⭐ Automático | ⭐⭐⭐⭐ Certbot |
| **Backup** | ⭐⭐⭐⭐⭐ Automático | ⭐⭐ Manual |
| **CDN** | ⭐⭐⭐⭐⭐ Incluído | ❌ Não |

---

## ❓ Troubleshooting

### Problema: CORS Error

**Solução:** Verificar variável `FRONTEND_URL` no backend:
```bash
# No Railway/Vercel
FRONTEND_URL=https://pag2pay.pages.dev
```

### Problema: Banco não conecta

**Solução:** Verificar `DATABASE_URL`:
```bash
# Formato correto:
postgresql://postgres:SENHA@db.xxx.supabase.co:5432/postgres
```

### Problema: Build falha

**Solução:** Ver logs no Cloudflare Pages:
1. **"Deployments"** → Último deploy → **"View build log"**

---

## 📈 Limites Planos Gratuitos

### Cloudflare Pages
- ✅ 500 builds/mês
- ✅ 100 GB-hours/mês
- ✅ Banda ilimitada
- ✅ Builds simultâneos: 1

### Supabase (Free Tier)
- ✅ 500 MB database
- ✅ 50.000 usuários autenticados
- ✅ 2 GB bandwidth/mês
- ✅ 1 GB file storage

### Railway (Free Trial)
- ⚠️ $5 crédito grátis inicial
- Depois: ~$5-10/mês

**Alternativa:** Manter backend no VPS Hostinger (R$ 29/mês) e só frontend na Cloudflare (grátis).

---

## 🎉 Conclusão

Agora você tem:

✅ Frontend global ultra-rápido (Cloudflare)  
✅ Backend escalável (Railway/Vercel)  
✅ Banco robusto PostgreSQL (Supabase)  
✅ SSL/HTTPS automático  
✅ Deploy automático com Git  
✅ CDN global  
✅ Backup automático  
✅ R$ 0/mês para começar  

---

## 🔄 Migrar de VPS para Cloudflare Depois

Se começou no VPS e quer migrar:

1. Deploy frontend no Cloudflare Pages (PARTE 3)
2. Manter backend no VPS
3. Atualizar `VITE_API_URL` para `https://api.seu-dominio.com`
4. Pronto! Melhor dos 2 mundos

---

## 📞 Próximos Passos

1. ✅ Implementar autenticação JWT robusta
2. ✅ Adicionar rate limiting
3. ✅ Implementar cache Redis
4. ✅ Adicionar testes automatizados
5. ✅ Configurar CI/CD com testes

**Boa sorte! 🚀**
