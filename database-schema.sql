-- Schema PostgreSQL para Pag2Pay
-- Para usar com Supabase ou qualquer PostgreSQL

-- Extensão para UUID
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- Tabela de Usuários
CREATE TABLE users (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    email VARCHAR(255) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    name VARCHAR(255) NOT NULL,
    role VARCHAR(50) NOT NULL DEFAULT 'user', -- 'user' ou 'admin'
    commission_rate INTEGER DEFAULT 70,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- Tabela de Produtos
CREATE TABLE products (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    code VARCHAR(50) UNIQUE NOT NULL,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    price DECIMAL(10, 2) NOT NULL,
    image TEXT,
    producer_id UUID REFERENCES users(id),
    producer_name VARCHAR(255),
    affiliate_enabled BOOLEAN DEFAULT false,
    affiliate_commission INTEGER DEFAULT 0,
    payment_methods JSONB DEFAULT '{"pix": true, "boleto": true, "creditCard": true, "afterPay": false}'::jsonb,
    category VARCHAR(100),
    product_type VARCHAR(100),
    status VARCHAR(50) DEFAULT 'active',
    approval_status VARCHAR(50) DEFAULT 'PENDENTE',
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- Tabela de Afiliações
CREATE TABLE affiliations (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    product_id UUID REFERENCES products(id) ON DELETE CASCADE,
    affiliate_id UUID REFERENCES users(id) ON DELETE CASCADE,
    status VARCHAR(50) DEFAULT 'pending', -- 'pending', 'approved', 'rejected'
    commission_rate INTEGER,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    UNIQUE(product_id, affiliate_id)
);

-- Tabela de Pedidos
CREATE TABLE orders (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    product_id UUID REFERENCES products(id),
    customer_email VARCHAR(255),
    customer_name VARCHAR(255),
    amount DECIMAL(10, 2) NOT NULL,
    status VARCHAR(50) DEFAULT 'pending', -- 'pending', 'paid', 'cancelled'
    payment_method VARCHAR(50),
    affiliate_id UUID REFERENCES users(id),
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- Tabela de Vendas
CREATE TABLE sales (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    order_id UUID REFERENCES orders(id),
    product_id UUID REFERENCES products(id),
    producer_id UUID REFERENCES users(id),
    affiliate_id UUID REFERENCES users(id),
    amount DECIMAL(10, 2) NOT NULL,
    commission_amount DECIMAL(10, 2),
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- Índices para performance
CREATE INDEX idx_products_producer ON products(producer_id);
CREATE INDEX idx_products_status ON products(status);
CREATE INDEX idx_affiliations_product ON affiliations(product_id);
CREATE INDEX idx_affiliations_affiliate ON affiliations(affiliate_id);
CREATE INDEX idx_orders_customer ON orders(customer_email);
CREATE INDEX idx_orders_status ON orders(status);
CREATE INDEX idx_sales_producer ON sales(producer_id);
CREATE INDEX idx_sales_affiliate ON sales(affiliate_id);

-- Dados iniciais
INSERT INTO users (id, email, password, name, role, created_at) VALUES
    ('550e8400-e29b-41d4-a716-446655440001', 'admin@pag2pay.com', 'admin123', 'Administrador Master', 'admin', NOW()),
    ('550e8400-e29b-41d4-a716-446655440002', 'usuario@pag2pay.com', 'usuario123', 'Usuário Demo', 'user', NOW());

INSERT INTO products (id, code, name, description, price, image, producer_id, producer_name, affiliate_enabled, affiliate_commission, category, product_type, status, approval_status) VALUES
    ('650e8400-e29b-41d4-a716-446655440001', 'pro9yxgx', 'Curso de Marketing Digital', 'Aprenda estratégias avançadas de marketing', 497.00, 'https://via.placeholder.com/300x200/4F46E5/FFFFFF?text=Marketing+Digital', '550e8400-e29b-41d4-a716-446655440002', 'Usuário Demo', true, 30, 'Educação', 'Curso', 'active', 'APROVADO'),
    ('650e8400-e29b-41d4-a716-446655440002', 'proe78xe', 'E-book: Vendas Online', 'Guia completo para vender na internet', 97.00, 'https://via.placeholder.com/300x200/7C3AED/FFFFFF?text=E-book+Vendas', '550e8400-e29b-41d4-a716-446655440002', 'Usuário Demo', true, 40, 'Marketing', 'E-book', 'active', 'PENDENTE'),
    ('650e8400-e29b-41d4-a716-446655440003', 'prom4vgk', 'Mentoria Individual', 'Sessões personalizadas de consultoria', 997.00, 'https://via.placeholder.com/300x200/059669/FFFFFF?text=Mentoria', '550e8400-e29b-41d4-a716-446655440002', 'Usuário Demo', false, 0, 'Consultoria', 'Serviço', 'active', 'APROVADO');
