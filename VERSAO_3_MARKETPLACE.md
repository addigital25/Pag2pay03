# 🚀 AfterPay V3.0 - Marketplace de Afiliados e Produtores

## 🎯 O que é esta versão?

A versão 3.0 transforma completamente o AfterPay em uma **plataforma de marketplace** para produtores digitais e afiliados, similar ao ev.braip.com. Agora é possível:

- ✅ Criar e vender produtos digitais
- ✅ Criar programas de afiliados
- ✅ Divulgar produtos e ganhar comissões
- ✅ Gerenciar pedidos com múltiplas formas de pagamento
- ✅ Rastrear envios e pagamentos
- ✅ Calcular e visualizar comissões automaticamente

---

## 🔐 Tipos de Usuário

### 1. Administrador Master
- **Email:** admin@afterpay.com
- **Senha:** admin123
- **Acesso:** Total à plataforma
- **Funções:** Visualizar todas as vendas, produtos e comissões

### 2. Produtor
- **Email:** produtor@afterpay.com
- **Senha:** produtor123
- **Taxa de Comissão:** 70% das vendas
- **Funções:**
  - Criar e gerenciar produtos
  - Habilitar programa de afiliados
  - Definir % de comissão para afiliados
  - Escolher formas de pagamento aceitas
  - Gerenciar pedidos dos seus produtos
  - Adicionar códigos de rastreio

### 3. Afiliado
- **Email:** afiliado@afterpay.com
- **Senha:** afiliado123
- **Taxa de Comissão:** 30% das vendas (configurável por produto)
- **Funções:**
  - Navegar pela vitrine de produtos
  - Se afiliar a produtos
  - Promover produtos
  - Receber comissões automáticas

---

## 📊 Estrutura do Sistema

### Dashboard
- **Métricas em Tempo Real:**
  - Total de pedidos
  - Pedidos pendentes
  - Pedidos enviados
  - Pedidos pagos
  - Receita total
  - Receita pendente
  - Comissões ganhas (produtor/afiliado)
  - Comissões pendentes

### Produtos (Meus Produtos)
Produtores podem:
- ✅ Criar novos produtos
- ✅ Definir preço e estoque
- ✅ Escolher categoria
- ✅ Habilitar/desabilitar programa de afiliados
- ✅ Definir % de comissão para afiliados (0-100%)
- ✅ Selecionar formas de pagamento:
  - PIX
  - Boleto Bancário
  - Cartão de Crédito
  - Receba e Pague (AfterPay)
- ✅ Adicionar imagem e descrição

### Produtos (Minhas Afiliações)
Afiliados podem:
- ✅ Ver produtos que estão afiliados
- ✅ Visualizar comissão por venda
- ✅ Obter link de afiliado
- ✅ Acompanhar vendas geradas

### Vitrine de Afiliação
- **Busca por nome/descrição**
- **Filtros por categoria**
- **Visualização de:**
  - % de comissão
  - Preço do produto
  - Valor da comissão por venda
  - Formas de pagamento aceitas
  - Produtor responsável
- **Afiliação com 1 clique**

### Pedidos
Sistema completo de gerenciamento:

**Filtros:**
- Busca por cliente, produto ou ID
- Status do pedido (Pendente, Enviado, Entregue, Pago)
- Status do pagamento
- Forma de pagamento

**Informações exibidas:**
- Dados completos do cliente (nome, email, telefone, endereço)
- Produto e quantidade
- Valor total
- Comissões (produtor e afiliado)
- Forma de pagamento escolhida
- Código de rastreio
- Informações de envio (transportadora, previsão)

**Ações disponíveis:**
- Adicionar código de rastreio
- Atualizar transportadora
- Definir previsão de entrega
- Marcar como pago
- Ver histórico completo

### Checkout com Múltiplas Formas de Pagamento
Sistema de checkout moderno:

**Seletor de Quantidade:**
- Aumentar/diminuir quantidade
- Limite baseado no estoque

**Formas de Pagamento:**
1. **PIX**
   - Pagamento instantâneo
   - Código visual

2. **Boleto Bancário**
   - Vencimento em 3 dias úteis
   - Código de barras

3. **Cartão de Crédito**
   - Parcelamento disponível
   - Processamento seguro

4. **Receba e Pague (AfterPay)**
   - Cliente recebe primeiro
   - Paga após 7 dias da entrega
   - Sem risco para o comprador

**Dados coletados:**
- Nome completo
- Email e telefone
- Endereço completo com CEP
- Estado (dropdown)

**Link de Afiliado:**
- Suporta parâmetro `?ref=ID_AFILIADO`
- Comissões automáticas quando venda vem de afiliado

---

## 💰 Sistema de Comissões

### Como funciona:

1. **Venda Direta (sem afiliado):**
   - Produtor recebe 100% do valor

2. **Venda via Afiliado:**
   - Afiliado recebe X% (definido no produto)
   - Produtor recebe (100 - X)%
   - Comissão calculada automaticamente

### Exemplo:
Produto: Curso de Marketing - R$ 497,00
Comissão de afiliado: 30%

**Quando vendido via afiliado:**
- Afiliado ganha: R$ 149,10 (30%)
- Produtor ganha: R$ 347,90 (70%)
- Total: R$ 497,00 ✅

### Status de Comissão:
- **Pendente:** Pedido não pago ainda
- **Pago:** Comissão liberada

---

## 📦 Fluxo de Pedidos

### 1. Cliente finaliza compra
- Escolhe forma de pagamento
- Preenche dados de entrega
- Confirma pedido

### 2. Status: Pendente
- Aguardando pagamento (PIX, Boleto, Cartão)
- OU aguardando envio (AfterPay)

### 3. Produtor processa
- Adiciona código de rastreio
- Informa transportadora
- Define previsão de entrega
- **Status muda para: Enviado**

### 4. Cliente recebe
- **Status muda para: Entregue**

### 5. Pagamento confirmado
- **Status muda para: Pago**
- Comissões são liberadas

### Fluxo AfterPay (Especial):
1. Cliente compra sem pagar
2. Produtor envia o produto
3. Cliente recebe e confirma
4. Cliente realiza o pagamento
5. Comissões são liberadas

---

## 🎨 Formas de Pagamento - Configuração por Produto

Cada produto pode ter formas de pagamento específicas:

```javascript
Produto A: PIX + Cartão + AfterPay
Produto B: Apenas PIX + Boleto
Produto C: Todas as formas
```

O produtor decide no momento da criação/edição do produto.

---

## 🔗 Links de Afiliado

### Como gerar:
1. Afiliado se afilia ao produto na Vitrine
2. Obtém link personalizado
3. Compartilha com audiência

### Formato:
```
http://localhost:3000/checkout/PRODUTO_ID?ref=AFILIADO_ID
```

### Exemplo:
```
http://localhost:3000/checkout/1?ref=3
```

Quando alguém comprar através deste link, o afiliado #3 receberá a comissão automaticamente.

---

## 📱 Interface

### Menu Lateral (Sidebar):
1. **Dashboard** - Métricas e resumos
2. **Produtos** - Meus produtos e afiliações
3. **Vitrine** - Loja de afiliação
4. **Pedidos** - Gestão completa de vendas
5. **Relatórios** - Analytics (em desenvolvimento)
6. **Configurações** - Ajustes (em desenvolvimento)

### Sidebar Recolhível:
- Expandida: 256px de largura
- Recolhida: 80px (ícones apenas)
- Toggle no topo da sidebar

---

## 🚀 Como Usar

### Para Produtores:

1. **Login com conta de produtor**
2. **Criar Produto:**
   - Vá em "Produtos" → "Novo Produto"
   - Preencha informações
   - Configure comissão de afiliado (se desejar)
   - Selecione formas de pagamento aceitas
   - Clique em "Criar Produto"

3. **Gerenciar Pedidos:**
   - Vá em "Pedidos"
   - Use filtros para encontrar pedidos
   - Clique em "Detalhes" para ver pedido completo
   - Adicione código de rastreio quando enviar

4. **Visualizar Comissões:**
   - Dashboard mostra comissões ganhas
   - Pedidos pagos liberam comissão

### Para Afiliados:

1. **Login com conta de afiliado**
2. **Escolher Produtos:**
   - Vá em "Vitrine"
   - Use filtros para encontrar produtos
   - Veja % de comissão e valor por venda
   - Clique em "Quero me Afiliar"

3. **Obter Link:**
   - Vá em "Produtos" → "Minhas Afiliações"
   - Copie o link do produto
   - Adicione `?ref=SEU_ID` ao final

4. **Promover:**
   - Compartilhe o link
   - Ganhe comissão a cada venda

5. **Acompanhar Vendas:**
   - Dashboard mostra suas comissões
   - "Pedidos" mostra vendas via seu link

---

## 🛠️ Dados Técnicos

### Backend (Node.js + Express):
- **Porta:** 3001
- **Database:** JSON (database.json)
- **Rotas API:**
  - `/api/auth/login` - Login
  - `/api/auth/register` - Registro
  - `/api/products` - Produtos (GET, POST, PATCH)
  - `/api/products?type=my-products&userId=X` - Meus produtos
  - `/api/products?type=affiliate-store` - Vitrine
  - `/api/products?type=my-affiliations&userId=X` - Minhas afiliações
  - `/api/affiliations` - Criar afiliação
  - `/api/orders` - Pedidos (GET, POST, PATCH)
  - `/api/commissions` - Comissões
  - `/api/dashboard/stats` - Estatísticas

### Frontend (React + Vite):
- **Porta:** 3000
- **Framework:** React 18
- **Estilização:** TailwindCSS
- **Rotas:**
  - `/login` - Tela de login
  - `/admin` - Dashboard
  - `/admin/products` - Produtos
  - `/admin/affiliate-store` - Vitrine
  - `/admin/orders` - Pedidos
  - `/checkout/:productId` - Checkout
  - `/order-confirmation/:orderId` - Confirmação

### Estrutura de Dados:

**Usuario:**
```json
{
  "id": "uuid",
  "email": "email@example.com",
  "password": "senha",
  "name": "Nome Completo",
  "role": "admin|producer|affiliate",
  "commissionRate": 70,
  "createdAt": "2026-02-28T..."
}
```

**Produto:**
```json
{
  "id": "uuid",
  "name": "Nome do Produto",
  "description": "Descrição...",
  "price": 497.00,
  "image": "https://...",
  "stock": 50,
  "producerId": "uuid",
  "producerName": "Nome do Produtor",
  "affiliateEnabled": true,
  "affiliateCommission": 30,
  "paymentMethods": {
    "pix": true,
    "boleto": true,
    "creditCard": true,
    "afterPay": false
  },
  "category": "Cursos",
  "status": "active"
}
```

**Pedido:**
```json
{
  "id": "uuid",
  "productId": "uuid",
  "productName": "Nome",
  "productPrice": 497.00,
  "quantity": 1,
  "totalValue": 497.00,
  "producerId": "uuid",
  "producerName": "Nome",
  "affiliateId": "uuid",
  "affiliateName": "Nome",
  "producerCommission": 347.90,
  "affiliateCommission": 149.10,
  "customer": {
    "name": "Cliente",
    "email": "cliente@email.com",
    "phone": "(11) 99999-9999",
    "address": "Rua X, 123",
    "city": "São Paulo",
    "state": "SP",
    "zipCode": "01234-567"
  },
  "paymentMethod": "pix",
  "paymentStatus": "pending|paid",
  "status": "pending|shipped|delivered|paid",
  "trackingCode": "BR123456789",
  "shippingInfo": {
    "carrier": "Correios",
    "estimatedDelivery": "2026-03-05",
    "shippingStatus": "shipped",
    "shippingDate": "2026-02-28T..."
  },
  "createdAt": "2026-02-28T...",
  "updatedAt": "2026-02-28T...",
  "paidAt": null
}
```

**Comissão:**
```json
{
  "id": "uuid",
  "orderId": "uuid",
  "productId": "uuid",
  "producerId": "uuid",
  "affiliateId": "uuid",
  "producerCommission": 347.90,
  "affiliateCommission": 149.10,
  "totalValue": 497.00,
  "status": "pending|paid",
  "createdAt": "2026-02-28T...",
  "paidAt": null
}
```

---

## 🎯 Diferenças entre V2 e V3

| Funcionalidade | V2.0 | V3.0 |
|----------------|------|------|
| Sistema de login | ✅ | ✅ |
| Sidebar lateral | ✅ | ✅ |
| Dashboard | Básico | Completo com métricas |
| Produtos | Lista simples | Gestão completa + afiliação |
| Vitrine de Afiliados | ❌ | ✅ Completa |
| Múltiplas formas pagamento | ❌ | ✅ 4 opções |
| Sistema de comissões | ❌ | ✅ Automático |
| Gestão de Pedidos | Básica | ✅ Completa com filtros |
| Rastreamento | ❌ | ✅ Com transportadora |
| Links de afiliado | ❌ | ✅ Com ref parameter |
| Checkout avançado | Simples | ✅ Multi-pagamento |
| Seleção de quantidade | ❌ | ✅ |

---

## ⚙️ Como Executar

### Passo 1: Instalar Dependências

**Backend:**
```bash
cd afterpay-mvp/backend
npm install
```

**Frontend:**
```bash
cd afterpay-mvp/frontend
npm install
```

### Passo 2: Executar Servidores

**Terminal 1 - Backend:**
```bash
cd afterpay-mvp/backend
npm start
```

Você verá:
```
🚀 Servidor rodando na porta 3001
📊 API disponível em http://localhost:3001/api
```

**Terminal 2 - Frontend:**
```bash
cd afterpay-mvp/frontend
npm run dev
```

Você verá:
```
VITE v5.4.21  ready in 175 ms
➜  Local:   http://localhost:3000/
```

### Passo 3: Acessar

Abra seu navegador em: **http://localhost:3000**

---

## 🎓 Credenciais de Teste

### Administrador:
- **Email:** admin@afterpay.com
- **Senha:** admin123
- **Acesso:** Completo

### Produtor:
- **Email:** produtor@afterpay.com
- **Senha:** produtor123
- **Comissão:** 70%

### Afiliado:
- **Email:** afiliado@afterpay.com
- **Senha:** afiliado123
- **Comissão:** 30%

---

## ✨ Próximos Passos Sugeridos

### Funcionalidades Futuras:
- [ ] Área de Relatórios com gráficos
- [ ] Configurações de perfil do usuário
- [ ] Sistema de notificações
- [ ] Chat entre produtores e afiliados
- [ ] API para criação de múltiplos afiliados
- [ ] Dashboard para afiliados com métricas específicas
- [ ] Integração com gateways de pagamento reais
- [ ] Sistema de saques para comissões
- [ ] Calendário de pagamentos
- [ ] Exportação de relatórios em PDF/Excel
- [ ] Sistema de cupons de desconto
- [ ] Programa de fidelidade
- [ ] Modo escuro (dark mode)

---

## 🐛 Troubleshooting

### Erro: "Port 3000 already in use"
```bash
lsof -ti:3000 | xargs kill -9
```

### Erro: "Cannot find module"
```bash
cd frontend
rm -rf node_modules package-lock.json
npm install
```

### Database vazio ou corrompido:
```bash
cd backend
rm database.json
npm start
```
O banco será recriado automaticamente com dados demo.

### Frontend não carrega produtos:
1. Verifique se o backend está rodando (porta 3001)
2. Abra o console do navegador (F12)
3. Verifique erros de CORS ou conexão
4. Tente limpar o cache (Cmd/Ctrl + Shift + R)

---

## 📄 Arquivos Principais

```
afterpay-mvp/
├── backend/
│   ├── server.js              ← API completa
│   ├── database.json          ← Banco de dados
│   └── package.json
│
├── frontend/
│   ├── src/
│   │   ├── contexts/
│   │   │   └── AuthContext.jsx
│   │   ├── components/
│   │   │   └── AdminLayout.jsx  ← Sidebar
│   │   ├── pages/
│   │   │   ├── Login.jsx
│   │   │   ├── AdminDashboard.jsx
│   │   │   ├── Products.jsx      ← NOVO
│   │   │   ├── AffiliateStore.jsx ← NOVO
│   │   │   ├── Orders.jsx        ← NOVO
│   │   │   └── Checkout.jsx      ← ATUALIZADO
│   │   ├── App.jsx
│   │   └── main.jsx
│   └── package.json
│
├── VERSAO_3_MARKETPLACE.md    ← Esta documentação
├── NOVA_VERSAO.md             ← Docs V2.0
└── README.md
```

---

**Versão:** 3.0
**Data:** 28/02/2026
**Status:** ✅ Completo e Funcional

**AfterPay - Sua plataforma completa de vendas com afiliados!** 🚀💰
