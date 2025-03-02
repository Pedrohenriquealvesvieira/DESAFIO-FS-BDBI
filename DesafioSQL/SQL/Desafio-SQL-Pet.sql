create database petshop;
use petshop;

CREATE TABLE clientes (
    id_cliente INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    cpf VARCHAR(14) UNIQUE NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    sexo ENUM('M', 'F', 'Outro') NOT NULL,
    data_nascimento DATE NOT NULL,
    endereco VARCHAR(255) NOT NULL
) ENGINE=InnoDB;

CREATE TABLE vendedor (
    id_vendedor INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    sexo ENUM('M', 'F', 'Outro') NOT NULL,
    cpf VARCHAR(14) UNIQUE NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    telefone VARCHAR(15) NOT NULL,
    data_nascimento DATE NOT NULL,
    endereco VARCHAR(255) NOT NULL
) ENGINE=InnoDB;

CREATE TABLE pagamento (
    id_pagamento INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    forma_pagamento ENUM('Dinheiro', 'Cartão Crédito', 'Cartão Débito', 'PIX', 'Boleto') NOT NULL,
    valor DECIMAL(10,2) NOT NULL,
    data_pagamento DATETIME NOT NULL,
    status_pagamento ENUM('Pendente', 'Pago', 'Cancelado') NOT NULL
) ENGINE=InnoDB;

CREATE TABLE produtos (
    id_produto INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    categoria VARCHAR(50) NOT NULL,
    custo_unitario DECIMAL(10,2) NOT NULL,
    preco_venda DECIMAL(10,2) NOT NULL,
    status_produto ENUM('Disponível', 'Esgotado') NOT NULL
) ENGINE=InnoDB;

CREATE TABLE fornecedor (
    id_fornecedor INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    cnpj VARCHAR(18) UNIQUE NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    telefone VARCHAR(15) NOT NULL
) ENGINE=InnoDB;


CREATE TABLE estoque (
    id_estoque INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    id_produto INT NOT NULL,
    id_fornecedor INT NOT NULL,
    quantidade INT NOT NULL CHECK (quantidade >= 0),
    data_entrada DATE NOT NULL,
    data_validade DATE,
    data_reabastecimento DATE,
    FOREIGN KEY (id_produto) REFERENCES produtos(id_produto) ON DELETE CASCADE,
    FOREIGN KEY (id_fornecedor) REFERENCES fornecedor(id_fornecedor) ON DELETE CASCADE
) ENGINE=InnoDB;

CREATE TABLE animais (
    id_animal INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    id_cliente INT NOT NULL,
    nome VARCHAR(100) NOT NULL,
    tipo VARCHAR(50) NOT NULL,
    raca VARCHAR(50) NOT NULL,
    hora_chegada DATETIME NOT NULL,
    hora_saida DATETIME NOT NULL,
    FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente) ON DELETE CASCADE
) ENGINE=InnoDB;

CREATE TABLE pedidos (
    id_pedido INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    id_cliente INT NOT NULL,
    id_produto INT NOT NULL,
    id_pagamento INT NOT NULL,
    valor DECIMAL(10,2) NOT NULL,
    status ENUM('Pendente', 'Pago', 'Cancelado') NOT NULL,
    data_pedido DATETIME NOT NULL,
    FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente),
    FOREIGN KEY (id_produto) REFERENCES produtos(id_produto),
    FOREIGN KEY (id_pagamento) REFERENCES pagamento(id_pagamento)
);

INSERT INTO fornecedor (nome, cnpj, email, telefone) VALUES
('Alimentos Brasil LTDA', '12.345.678/0001-01', 'contato@alimentosbrasil.com', '(11) 98765-4321'),
('Distribuidora São Paulo', '23.456.789/0001-02', 'vendas@distrisp.com', '(11) 99876-5432'),
('Indústria Tech S.A.', '34.567.890/0001-03', 'suporte@industriatech.com', '(21) 98547-3210'),
('ConstruCenter Ltda.', '45.678.901/0001-04', 'financeiro@construcenter.com', '(31) 99785-4123'),
('Móveis & Estilo LTDA', '56.789.012/0001-05', 'contato@moveisestilo.com', '(41) 97654-3289'),
('Auto Peças Nacional', '67.890.123/0001-06', 'sac@autopecasnacional.com', '(51) 98632-7410'),
('Farmácia Vida', '78.901.234/0001-07', 'atendimento@farmaciavida.com', '(61) 95478-3692'),
('Eletrônicos Premium', '89.012.345/0001-08', 'info@eletronicospremium.com', '(71) 96547-8521'),
('Roupas e Moda Ltda.', '90.123.456/0001-09', 'compras@roupasemoda.com', '(81) 94231-6578'),
('Agro Forte S.A.', '01.234.567/0001-10', 'sac@agroforte.com', '(91) 98745-2369');

INSERT INTO produtos (nome, categoria, custo_unitario, preco_venda, status_produto) VALUES
('Notebook Gamer X', 'Eletrônicos', 4500.00, 5999.99, 'Disponível'),
('Smartphone Ultra', 'Eletrônicos', 2000.00, 2799.90, 'Disponível'),
('Cadeira Ergonômica', 'Móveis', 350.00, 599.99, 'Disponível'),
('Mesa de Escritório', 'Móveis', 500.00, 899.90, 'Esgotado'),
('Headset Pro', 'Acessórios', 150.00, 299.99, 'Disponível'),
('Câmera de Segurança', 'Segurança', 250.00, 449.99, 'Disponível'),
('Monitor 27" Full HD', 'Eletrônicos', 700.00, 1099.99, 'Esgotado'),
('Furadeira Elétrica', 'Ferramentas', 120.00, 249.90, 'Disponível'),
('Tênis Esportivo', 'Moda', 200.00, 399.99, 'Disponível'),
('Mochila Impermeável', 'Acessórios', 80.00, 149.90, 'Esgotado');

INSERT INTO estoque (id_produto, id_fornecedor, quantidade, data_entrada, data_validade, data_reabastecimento) VALUES
(1, 3, 50, '2025-02-28', NULL, '2025-03-15'),
(2, 1, 30, '2025-02-25', '2026-02-25', '2025-04-10'),
(3, 2, 20, '2025-02-20', NULL, '2025-03-05'),
(4, 4, 15, '2025-02-18', NULL, '2025-03-20'),
(5, 5, 40, '2025-02-15', '2025-12-15', NULL),
(6, 1, 25, '2025-02-12', '2026-01-12', '2025-03-01'),
(7, 2, 10, '2025-02-10', NULL, NULL),
(8, 3, 35, '2025-02-05', '2025-11-05', '2025-03-15'),
(9, 4, 45, '2025-02-02', NULL, '2025-04-01'),
(10, 5, 60, '2025-02-01', '2026-06-01', NULL);

INSERT INTO clientes (nome, cpf, email, sexo, data_nascimento, endereco) VALUES
('Carlos Silva', '123.456.789-01', 'carlos.silva@email.com', 'M', '1990-05-15', 'Rua das Palmeiras, 123 - São Paulo, SP'),
('Mariana Souza', '234.567.890-12', 'mariana.souza@email.com', 'F', '1985-08-22', 'Av. Brasil, 456 - Rio de Janeiro, RJ'),
('João Oliveira', '345.678.901-23', 'joao.oliveira@email.com', 'M', '1993-02-10', 'Rua XV de Novembro, 789 - Curitiba, PR'),
('Ana Pereira', '456.789.012-34', 'ana.pereira@email.com', 'F', '2000-11-05', 'Rua Sete de Setembro, 321 - Porto Alegre, RS'),
('Lucas Fernandes', '567.890.123-45', 'lucas.fernandes@email.com', 'M', '1998-04-30', 'Av. Independência, 654 - Belo Horizonte, MG'),
('Beatriz Lima', '678.901.234-56', 'beatriz.lima@email.com', 'F', '1987-06-18', 'Rua São João, 987 - Salvador, BA'),
('Rafael Costa', '789.012.345-67', 'rafael.costa@email.com', 'M', '1995-09-12', 'Av. Paulista, 1111 - São Paulo, SP'),
('Gabriela Santos', '890.123.456-78', 'gabriela.santos@email.com', 'F', '2002-12-25', 'Rua da Harmonia, 222 - Recife, PE'),
('Alexandre Nogueira', '901.234.567-89', 'alexandre.nogueira@email.com', 'Outro', '1983-07-08', 'Rua das Laranjeiras, 333 - Florianópolis, SC'),
('Patrícia Almeida', '012.345.678-90', 'patricia.almeida@email.com', 'F', '1991-03-29', 'Av. Atlântica, 444 - Fortaleza, CE');

INSERT INTO animais (id_cliente, nome, tipo, raca, hora_chegada, hora_saida) VALUES
(1, 'Rex', 'Cachorro', 'Labrador', '2025-03-01 08:00:00', '2025-03-01 12:00:00'),
(2, 'Mia', 'Gato', 'Siamês', '2025-03-01 09:15:00', '2025-03-01 13:30:00'),
(3, 'Thor', 'Cachorro', 'Pastor Alemão', '2025-03-01 10:00:00', '2025-03-01 14:00:00'),
(4, 'Nina', 'Gato', 'Persa', '2025-03-01 11:20:00', '2025-03-01 15:45:00'),
(5, 'Bobby', 'Cachorro', 'Golden Retriever', '2025-03-01 07:50:00', '2025-03-01 11:30:00'),
(6, 'Luna', 'Coelho', 'Angorá', '2025-03-01 08:45:00', '2025-03-01 12:15:00'),
(7, 'Max', 'Cachorro', 'Bulldog Francês', '2025-03-01 09:30:00', '2025-03-01 13:00:00'),
(8, 'Mel', 'Gato', 'Maine Coon', '2025-03-01 10:45:00', '2025-03-01 14:20:00'),
(9, 'Pingo', 'Pássaro', 'Calopsita', '2025-03-01 11:10:00', '2025-03-01 15:00:00'),
(10, 'Bolota', 'Cachorro', 'Pug', '2025-03-01 12:00:00', '2025-03-01 16:30:00');


INSERT INTO vendedor (nome, sexo, cpf, email, telefone, data_nascimento, endereco) VALUES
('Carlos Silva', 'M', '123.456.789-00', 'carlos.silva@email.com', '(11) 98765-4321', '1990-05-15', 'Rua das Flores, 123, São Paulo - SP'),
('Mariana Souza', 'F', '987.654.321-00', 'mariana.souza@email.com', '(21) 91234-5678', '1985-08-22', 'Av. Brasil, 456, Rio de Janeiro - RJ'),
('João Pereira', 'M', '111.222.333-44', 'joao.pereira@email.com', '(31) 93456-7890', '1995-03-10', 'Rua da Paz, 789, Belo Horizonte - MG'),
('Ana Oliveira', 'F', '222.333.444-55', 'ana.oliveira@email.com', '(41) 94567-8901', '1988-12-01', 'Rua Central, 321, Curitiba - PR'),
('Lucas Fernandes', 'M', '333.444.555-66', 'lucas.fernandes@email.com', '(51) 95678-9012', '1993-07-07', 'Rua Bela Vista, 654, Porto Alegre - RS'),
('Beatriz Lima', 'F', '444.555.666-77', 'beatriz.lima@email.com', '(61) 96789-0123', '1991-09-30', 'Av. das Palmeiras, 987, Brasília - DF'),
('Fernanda Costa', 'F', '555.666.777-88', 'fernanda.costa@email.com', '(71) 97890-1234', '1992-04-18', 'Rua do Comércio, 258, Salvador - BA'),
('Pedro Santos', 'M', '666.777.888-99', 'pedro.santos@email.com', '(81) 98901-2345', '1994-11-25', 'Rua do Porto, 852, Recife - PE'),
('Alex Martins', 'Outro', '777.888.999-00', 'alex.martins@email.com', '(91) 99012-3456', '1996-06-14', 'Av. Principal, 753, Belém - PA'),
('Gabriel Rocha', 'M', '888.999.000-11', 'gabriel.rocha@email.com', '(95) 90123-4567', '1987-02-05', 'Rua das Laranjeiras, 369, Manaus - AM');

INSERT INTO pagamento (forma_pagamento, valor, data_pagamento, status_pagamento) VALUES
('Dinheiro', 150.00, '2025-02-28 14:30:00', 'Pago'),
('Cartão Crédito', 320.50, '2025-02-27 16:45:00', 'Pendente'),
('PIX', 75.99, '2025-02-26 10:15:00', 'Pago'),
('Boleto', 500.00, '2025-02-25 09:00:00', 'Cancelado'),
('Cartão Débito', 230.40, '2025-02-24 12:20:00', 'Pago'),
('PIX', 99.99, '2025-02-23 18:10:00', 'Pendente'),
('Dinheiro', 45.00, '2025-02-22 15:55:00', 'Pago'),
('Cartão Crédito', 800.75, '2025-02-21 11:30:00', 'Pago'),
('Boleto', 120.00, '2025-02-20 17:40:00', 'Pendente'),
('Cartão Débito', 670.25, '2025-02-19 13:05:00', 'Cancelado');


INSERT INTO pedidos (id_cliente, id_produto, id_pagamento, valor, status, data_pedido) VALUES
(1, 3, 5, 230.40, 'Pago', '2025-02-28 14:30:00'),
(2, 1, 2, 320.50, 'Pendente', '2025-02-27 16:45:00'),
(3, 5, 3, 75.99, 'Pago', '2025-02-26 10:15:00'),
(4, 2, 4, 500.00, 'Cancelado', '2025-02-25 09:00:00'),
(5, 7, 1, 150.00, 'Pago', '2025-02-24 12:20:00'),
(6, 4, 6, 99.99, 'Pendente', '2025-02-23 18:10:00'),
(7, 9, 7, 45.00, 'Pago', '2025-02-22 15:55:00'),
(8, 6, 8, 800.75, 'Pago', '2025-02-21 11:30:00'),
(9, 8, 9, 120.00, 'Pendente', '2025-02-20 17:40:00'),
(10, 10, 10, 670.25, 'Cancelado', '2025-02-19 13:05:00');

SELECT COUNT(id_fornecedor) AS total_fornecedores
FROM fornecedor;

SELECT categoria, AVG(preco_venda) AS preco_medio
FROM produtos
GROUP BY categoria;

SELECT p.nome, SUM(e.quantidade) AS total_estoque
FROM estoque e


JOIN produtos p ON e.id_produto = p.id_produto
GROUP BY p.nome;

SELECT sexo, COUNT(id_cliente) AS total_clientes
FROM clientes
GROUP BY sexo;

SELECT tipo, COUNT(id_animal) AS total_animais
FROM animais
GROUP BY tipo;

SELECT sexo, COUNT(id_vendedor) AS total_vendedores
FROM vendedor
GROUP BY sexo;

SELECT forma_pagamento, SUM(valor) AS total_pago
FROM pagamento
WHERE status_pagamento = 'Pago'
GROUP BY forma_pagamento;

SELECT status, COUNT(id_pedido) AS total_pedidos
FROM pedidos
GROUP BY status;

SELECT c.nome AS nome_cliente, p.id_pedido, pr.nome AS nome_produto, p.status AS status_pedido
FROM clientes c
JOIN pedidos p ON c.id_cliente = p.id_cliente
JOIN produtos pr ON p.id_produto = pr.id_produto;

SELECT f.nome AS nome_fornecedor, p.nome AS nome_produto, e.quantidade
FROM estoque e
JOIN fornecedor f ON e.id_fornecedor = f.id_fornecedor
JOIN produtos p ON e.id_produto = p.id_produto;


