# Exemplos de Uso da API

## Base URL
```
http://localhost:3001/api
```

## 1. Produtos

### Listar todos os produtos
```bash
curl http://localhost:3001/api/products
```

**Resposta:**
```json
[
  {
    "id": "1",
    "name": "Curso de Marketing Digital",
    "description": "Aprenda estratégias avançadas de marketing",
    "price": 497.00,
    "image": "https://via.placeholder.com/300x200/4F46E5/FFFFFF?text=Marketing+Digital",
    "stock": 50
  },
  ...
]
```

### Obter produto específico
```bash
curl http://localhost:3001/api/products/1
```

## 2. Pedidos

### Criar novo pedido
```bash
curl -X POST http://localhost:3001/api/orders \
  -H "Content-Type: application/json" \
  -d '{
    "productId": "1",
    "customer": {
      "name": "João Silva",
      "email": "joao@example.com",
      "phone": "(11) 98765-4321",
      "address": "Rua das Flores, 123",
      "city": "São Paulo",
      "state": "SP",
      "zipCode": "01234-567"
    }
  }'
```

**Resposta:**
```json
{
  "id": "550e8400-e29b-41d4-a716-446655440000",
  "productId": "1",
  "productName": "Curso de Marketing Digital",
  "productPrice": 497.00,
  "customer": {
    "name": "João Silva",
    "email": "joao@example.com",
    "phone": "(11) 98765-4321",
    "address": "Rua das Flores, 123",
    "city": "São Paulo",
    "state": "SP",
    "zipCode": "01234-567"
  },
  "status": "pending",
  "createdAt": "2024-02-28T12:00:00.000Z",
  "updatedAt": "2024-02-28T12:00:00.000Z",
  "trackingCode": null,
  "paymentLink": null,
  "paidAt": null
}
```

### Listar todos os pedidos
```bash
curl http://localhost:3001/api/orders
```

### Obter pedido específico
```bash
curl http://localhost:3001/api/orders/550e8400-e29b-41d4-a716-446655440000
```

### Atualizar status do pedido para "Enviado"
```bash
curl -X PATCH http://localhost:3001/api/orders/550e8400-e29b-41d4-a716-446655440000 \
  -H "Content-Type: application/json" \
  -d '{
    "status": "shipped",
    "trackingCode": "BR123456789"
  }'
```

### Atualizar status para "Entregue"
```bash
curl -X PATCH http://localhost:3001/api/orders/550e8400-e29b-41d4-a716-446655440000 \
  -H "Content-Type: application/json" \
  -d '{
    "status": "delivered"
  }'
```

### Atualizar status para "Pago"
```bash
curl -X PATCH http://localhost:3001/api/orders/550e8400-e29b-41d4-a716-446655440000 \
  -H "Content-Type: application/json" \
  -d '{
    "status": "paid",
    "paymentLink": "https://payment.example.com/pay/abc123"
  }'
```

## 3. Dashboard

### Obter estatísticas
```bash
curl http://localhost:3001/api/dashboard/stats
```

**Resposta:**
```json
{
  "totalOrders": 10,
  "pendingOrders": 3,
  "shippedOrders": 2,
  "deliveredOrders": 2,
  "paidOrders": 3,
  "totalRevenue": 1491.00,
  "pendingRevenue": 2088.00
}
```

## 4. Fluxo Completo de Teste

### Passo 1: Criar um pedido
```bash
ORDER_ID=$(curl -s -X POST http://localhost:3001/api/orders \
  -H "Content-Type: application/json" \
  -d '{
    "productId": "2",
    "customer": {
      "name": "Maria Santos",
      "email": "maria@example.com",
      "phone": "(21) 99999-8888",
      "address": "Av. Principal, 456",
      "city": "Rio de Janeiro",
      "state": "RJ",
      "zipCode": "20000-000"
    }
  }' | jq -r '.id')

echo "Pedido criado: $ORDER_ID"
```

### Passo 2: Marcar como enviado
```bash
curl -X PATCH http://localhost:3001/api/orders/$ORDER_ID \
  -H "Content-Type: application/json" \
  -d '{
    "status": "shipped",
    "trackingCode": "BR987654321"
  }'
```

### Passo 3: Marcar como entregue
```bash
curl -X PATCH http://localhost:3001/api/orders/$ORDER_ID \
  -H "Content-Type: application/json" \
  -d '{
    "status": "delivered"
  }'
```

### Passo 4: Marcar como pago
```bash
curl -X PATCH http://localhost:3001/api/orders/$ORDER_ID \
  -H "Content-Type: application/json" \
  -d '{
    "status": "paid"
  }'
```

### Passo 5: Verificar estatísticas
```bash
curl http://localhost:3001/api/dashboard/stats | jq
```

## 5. Status dos Pedidos

| Status | Descrição | Próximo Status |
|--------|-----------|----------------|
| `pending` | Pedido criado, aguardando envio | `shipped` |
| `shipped` | Produto enviado para o cliente | `delivered` |
| `delivered` | Produto entregue ao cliente | `paid` |
| `paid` | Pagamento confirmado | - (final) |

## 6. Códigos de Erro

- `404` - Produto ou pedido não encontrado
- `500` - Erro interno do servidor

## 7. Testando com Postman/Insomnia

Importe esta coleção básica:

```json
{
  "name": "AfterPay API",
  "requests": [
    {
      "name": "Listar Produtos",
      "method": "GET",
      "url": "http://localhost:3001/api/products"
    },
    {
      "name": "Criar Pedido",
      "method": "POST",
      "url": "http://localhost:3001/api/orders",
      "body": {
        "productId": "1",
        "customer": {
          "name": "Teste",
          "email": "teste@example.com",
          "phone": "11999999999",
          "address": "Rua Teste, 123",
          "city": "São Paulo",
          "state": "SP",
          "zipCode": "01234-567"
        }
      }
    },
    {
      "name": "Dashboard Stats",
      "method": "GET",
      "url": "http://localhost:3001/api/dashboard/stats"
    }
  ]
}
```
