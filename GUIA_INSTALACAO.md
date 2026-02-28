# 📘 Guia Completo de Instalação - AfterPay MVP

Este guia irá ajudá-lo a instalar e executar a plataforma AfterPay no seu computador local.

---

## 📋 Pré-requisitos

Antes de começar, você precisa ter instalado:

### 1. Node.js (versão 18 ou superior)

**Windows:**
1. Acesse: https://nodejs.org/
2. Baixe a versão LTS (recomendada)
3. Execute o instalador
4. Siga as instruções (Next, Next, Install)

**macOS:**
```bash
# Usando Homebrew
brew install node

# OU baixe direto do site
# https://nodejs.org/
```

**Linux (Ubuntu/Debian):**
```bash
# Atualizar repositórios
sudo apt update

# Instalar Node.js
sudo apt install nodejs npm

# OU usar versão mais recente via NodeSource
curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash -
sudo apt-get install -y nodejs
```

**Verificar instalação:**
```bash
node --version
# Deve mostrar: v18.x.x ou superior

npm --version
# Deve mostrar: 9.x.x ou superior
```

---

## 📦 Baixar o Projeto

### Opção 1: Baixar os arquivos do workspace CREAO
Se você está no workspace CREAO, os arquivos já estão disponíveis em:
```
/home/user/workspaces/.../afterpay-mvp/
```

### Opção 2: Baixar manualmente
1. Copie toda a pasta `afterpay-mvp` para seu computador
2. Certifique-se de manter a estrutura de pastas:
```
afterpay-mvp/
├── backend/
│   ├── server.js
│   └── package.json
├── frontend/
│   ├── src/
│   ├── index.html
│   ├── package.json
│   └── vite.config.js
└── README.md
```

---

## 🚀 Instalação Passo a Passo

### MÉTODO 1: Instalação Automática (Recomendado)

#### Windows:
1. Abra o **Prompt de Comando** ou **PowerShell**
2. Navegue até a pasta do projeto:
```bash
cd caminho\para\afterpay-mvp
```

3. Execute o script de instalação:
```bash
# Se estiver no Linux/Mac
chmod +x install.sh
./install.sh

# No Windows, execute manualmente:
# Abra 2 terminais e siga o MÉTODO 2
```

---

### MÉTODO 2: Instalação Manual (Windows/Linux/Mac)

#### Passo 1: Instalar Backend

Abra um terminal e execute:

```bash
# Navegue até a pasta do backend
cd afterpay-mvp/backend

# Instale as dependências
npm install

# Você verá algo como:
# added 71 packages in 5s
```

#### Passo 2: Instalar Frontend

Abra **OUTRO** terminal (mantenha o primeiro aberto) e execute:

```bash
# Navegue até a pasta do frontend
cd afterpay-mvp/frontend

# Instale as dependências
npm install

# Você verá algo como:
# added 131 packages in 15s
```

---

## ▶️ Executar a Aplicação

Agora você precisa iniciar DOIS servidores (backend e frontend).

### Terminal 1 - Backend (API)

```bash
# Vá para a pasta backend
cd afterpay-mvp/backend

# Inicie o servidor
npm start

# Você verá:
# 🚀 Servidor rodando na porta 3001
# 📊 API disponível em http://localhost:3001/api
```

**⚠️ IMPORTANTE: Mantenha este terminal aberto!**

---

### Terminal 2 - Frontend (Interface)

```bash
# Vá para a pasta frontend
cd afterpay-mvp/frontend

# Inicie o servidor de desenvolvimento
npm run dev

# Você verá:
# VITE v5.4.21  ready in 175 ms
# ➜  Local:   http://localhost:3000/
```

**⚠️ IMPORTANTE: Mantenha este terminal aberto também!**

---

## 🌐 Acessar a Plataforma

Com os dois terminais rodando:

1. Abra seu navegador (Chrome, Firefox, Edge, etc.)
2. Acesse: **http://localhost:3000**
3. Pronto! A plataforma AfterPay está funcionando! 🎉

---

## 🧪 Testar a Aplicação

### 1. Página Inicial
- Você verá 3 produtos no catálogo
- Seção "Como Funciona o AfterPay"

### 2. Fazer uma Compra
1. Clique em **"Comprar"** em qualquer produto
2. Preencha o formulário (pode usar dados fictícios):
   - Nome: João Silva
   - Email: joao@example.com
   - Telefone: (11) 98765-4321
   - Endereço: Rua das Flores, 123
   - Cidade: São Paulo
   - Estado: SP
   - CEP: 01234-567
3. Clique em **"Confirmar Pedido"**
4. Você verá a página de confirmação!

### 3. Acessar o Dashboard
1. Clique em **"Dashboard"** no menu superior
2. Você verá:
   - Estatísticas (pedidos, receitas)
   - Lista de todos os pedidos
   - Botões para atualizar status

### 4. Gerenciar Pedidos
No Dashboard, clique nos botões:
1. **"Marcar como Enviado"** (amarelo → azul)
2. **"Marcar como Entregue"** (azul → roxo)
3. **"Marcar como Pago"** (roxo → verde)

Veja as estatísticas atualizarem em tempo real! 📊

---

## 🛑 Parar os Servidores

Quando quiser parar a aplicação:

1. Vá em cada terminal (backend e frontend)
2. Pressione: **Ctrl + C** (Windows/Linux) ou **Cmd + C** (Mac)
3. Confirme com: **Y** ou **S** (se perguntado)

---

## 🔄 Reiniciar a Aplicação

Para usar novamente:

1. Abra 2 terminais
2. **Terminal 1**: `cd afterpay-mvp/backend && npm start`
3. **Terminal 2**: `cd afterpay-mvp/frontend && npm run dev`
4. Acesse: http://localhost:3000

---

## ❗ Solução de Problemas

### Problema: "npm: comando não encontrado"
**Solução:** Node.js não está instalado. Volte para "Pré-requisitos" e instale o Node.js.

### Problema: "Porta 3000 já está em uso"
**Solução:**
```bash
# Encontrar processo usando a porta
# Windows:
netstat -ano | findstr :3000

# Linux/Mac:
lsof -i :3000

# Matar o processo ou use outra porta editando vite.config.js
```

### Problema: "Porta 3001 já está em uso"
**Solução:**
```bash
# Encontrar e matar processo
# Windows:
netstat -ano | findstr :3001
taskkill /PID <número_do_pid> /F

# Linux/Mac:
lsof -i :3001
kill -9 <PID>
```

### Problema: Página carrega mas está em branco
**Solução:**
1. Verifique se o backend está rodando
2. Abra o Console do navegador (F12)
3. Veja se há erros de conexão
4. Certifique-se que ambos servidores estão ativos

### Problema: Produtos não aparecem
**Solução:**
1. Verifique se o arquivo `backend/database.json` existe
2. Se não existir, será criado automaticamente ao iniciar o backend
3. Reinicie o backend: Ctrl+C e `npm start` novamente

---

## 📂 Estrutura de Arquivos

```
afterpay-mvp/
│
├── backend/                    # Servidor API
│   ├── server.js              # Código principal do servidor
│   ├── package.json           # Dependências do backend
│   └── database.json          # Banco de dados (criado automaticamente)
│
├── frontend/                  # Interface do usuário
│   ├── src/
│   │   ├── pages/            # Páginas da aplicação
│   │   │   ├── ProductList.jsx       # Catálogo
│   │   │   ├── Checkout.jsx          # Finalizar compra
│   │   │   ├── OrderConfirmation.jsx # Confirmação
│   │   │   └── Dashboard.jsx         # Painel admin
│   │   ├── App.jsx           # Rotas principais
│   │   ├── main.jsx          # Ponto de entrada
│   │   └── index.css         # Estilos globais
│   ├── index.html            # HTML principal
│   ├── package.json          # Dependências do frontend
│   └── vite.config.js        # Configuração do Vite
│
├── README.md                  # Documentação geral
├── GUIA_INSTALACAO.md        # Este guia
└── install.sh                # Script de instalação automática
```

---

## 🎯 Próximos Passos

Depois de testar a aplicação:

1. **Personalizar produtos**: Edite `backend/server.js` (linha 14-36)
2. **Mudar cores**: Edite arquivos em `frontend/src/pages/`
3. **Adicionar funcionalidades**: Veja `FEATURES.md` para ideias
4. **Testar API**: Use `API_EXAMPLES.md` para exemplos

---

## 🆘 Precisa de Ajuda?

Se encontrar problemas:

1. Verifique se Node.js está instalado: `node --version`
2. Confirme que as dependências foram instaladas: veja `node_modules/` nas pastas
3. Certifique-se que ambos servidores estão rodando
4. Verifique se as portas 3000 e 3001 estão livres

---

## 📝 Resumo Rápido

```bash
# 1. Instalar Node.js (se não tiver)
node --version

# 2. Instalar dependências
cd afterpay-mvp/backend && npm install
cd ../frontend && npm install

# 3. Executar (2 terminais)
# Terminal 1:
cd backend && npm start

# Terminal 2:
cd frontend && npm run dev

# 4. Acessar
# http://localhost:3000
```

---

## ✅ Checklist de Instalação

- [ ] Node.js instalado (v18+)
- [ ] Pasta afterpay-mvp baixada
- [ ] Dependências do backend instaladas (`npm install`)
- [ ] Dependências do frontend instaladas (`npm install`)
- [ ] Backend rodando (porta 3001)
- [ ] Frontend rodando (porta 3000)
- [ ] Navegador aberto em http://localhost:3000
- [ ] Teste de compra realizado
- [ ] Dashboard acessado e testado

---

**Pronto! Agora você tem sua própria plataforma AfterPay funcionando! 🚀🎉**

Se tiver dúvidas, consulte a documentação completa em `README.md` e `FEATURES.md`.
