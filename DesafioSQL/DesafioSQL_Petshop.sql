create database petshop;

use petshop;

CREATE TABLE clientes (
    id_cliente INTEGER NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    cpf VARCHAR(14) UNIQUE NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    sexo ENUM('M', 'F', 'Outro') NOT NULL,
    data_nascimento DATE NOT NULL,
    endereco VARCHAR(255) NOT NULL
) ENGINE=InnoDB;

CREATE TABLE vendedor (
    id_vendedor INTEGER NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    sexo ENUM('M', 'F', 'Outro') NOT NULL,
    cpf VARCHAR(14) UNIQUE NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    telefone VARCHAR(15) NOT NULL,
    data_nascimento DATE NOT NULL,
    endereco VARCHAR(255) NOT NULL
) ENGINE=InnoDB;

CREATE TABLE pagamento (
    id_pagamento INTEGER NOT NULL AUTO_INCREMENT PRIMARY KEY,
    forma_pagamento ENUM('Dinheiro', 'Cartão Crédito', 'Cartão Débito', 'PIX') NOT NULL,
    valor DECIMAL(10,2) NOT NULL,
    data_pagamento DATETIME NOT NULL,
    status_pagamento ENUM('Pendente', 'Pago', 'Cancelado') NOT NULL
) ENGINE=InnoDB;

CREATE TABLE produtos (
    id_produto INTEGER NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    categoria VARCHAR(50) NOT NULL,
    custo_unitario DECIMAL(10,2) NOT NULL,
    preco_venda DECIMAL(10,2) NOT NULL,
    status_produto ENUM('Disponível', 'Esgotado') NOT NULL
) ENGINE=InnoDB;

CREATE TABLE fornecedor (
    id_fornecedor INTEGER NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    cnpj VARCHAR(18) UNIQUE NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    telefone VARCHAR(15) NOT NULL
) ENGINE=InnoDB;

CREATE TABLE estoque (
    id_estoque INTEGER NOT NULL AUTO_INCREMENT PRIMARY KEY,
    id_produto INTEGER NOT NULL,
    quantidade INTEGER NOT NULL CHECK (quantidade >= 0),
    data_entrada DATE NOT NULL,
    data_validade DATE,
    data_reabastecimento DATE,
    FOREIGN KEY (id_produto) REFERENCES produtos(id_produto) ON DELETE CASCADE
) ENGINE=InnoDB;

CREATE TABLE animais (
    id_animal INTEGER NOT NULL AUTO_INCREMENT PRIMARY KEY,
    id_cliente INTEGER NOT NULL,
    nome VARCHAR(100) NOT NULL,
    tipo VARCHAR(50) NOT NULL,
    raca VARCHAR(50) NOT NULL,
    hora_chegada DATETIME NOT NULL,
    hora_saida DATETIME NOT NULL,
    FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente) ON DELETE CASCADE
) ENGINE=InnoDB;

CREATE TABLE pedidos (
    id_pedido INTEGER PRIMARY KEY,
    id_cliente INTEGER,
    id_produto INTEGER,
    id_pagamento INTEGER,
    valor FLOAT,
    status VARCHAR(20),
    data_pedido DATETIME,
    FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente),
    FOREIGN KEY (id_produto) REFERENCES produtos(id_produto),
    FOREIGN KEY (id_pagamento) REFERENCES pagamento(id_pagamento)
);


INSERT INTO fornecedor (id_fornecedor, nome, cnpj, email, telefone) VALUES
(1, 'PetSupplies Ltda', 12345678000101, 'contato@petsupplies.com', 11987654321),
(2, 'AnimalCare Distribuidora', 23456789000102, 'suporte@animalcare.com', 11976543210),
(3, 'PetShop Master', 34567890000103, 'vendas@petshopmaster.com', 11965432109),
(4, 'Rações Premium', 45678900000104, 'info@racoespremium.com', 11954321098),
(5, 'Brinquedos Pet Feliz', 56789000000105, 'sac@petfeliz.com', 11943210987),
(6, 'Acessórios Vida Pet', 67890000000106, 'comercial@vidapet.com', 11932109876),
(7, 'Higiene Animal Top', 78900000000107, 'atendimento@animaltop.com', 11921098765),
(8, 'Mundo Pet', 89000000000108, 'faleconosco@mundopet.com', 11910987654),
(9, 'Alimentos NutriPet', 90000000000109, 'nutripet@nutripet.com', 11909876543),
(10, 'Casa dos Pets', 12312312300010, 'contato@casadospets.com', 11908765432);

INSERT INTO produtos (id_produto, nome, categoria, custo_unitario, preco_venda, status_produto)
VALUES 
(1, 'Ração Premium', 'Alimentos', 10.00, 20.00, 'Ativo'),
(2, 'Brinquedo para Cachorro', 'Acessórios', 5.00, 15.00, 'Ativo'),
(3, 'Coleira Ajustável', 'Acessórios', 8.00, 18.00, 'Ativo'),
(4, 'Caixa de Areia', 'Higiene', 12.00, 25.00, 'Ativo'),
(5, 'Shampoo para Pets', 'Higiene', 7.00, 14.00, 'Ativo'),
(6, 'Comedouro Inox', 'Acessórios', 9.00, 19.00, 'Ativo'),
(7, 'Arranhador para Gatos', 'Acessórios', 20.00, 45.00, 'Ativo'),
(8, 'Tapete Higiênico', 'Higiene', 15.00, 30.00, 'Ativo'),
(9, 'Petiscos Naturais', 'Alimentos', 6.00, 13.00, 'Ativo'),
(10, 'Bolsa de Transporte', 'Acessórios', 25.00, 50.00, 'Ativo');

INSERT INTO estoque (id_estoque, id_produto, id_fornecedor, quantidade, data_entrada, data_validade, data_reabastecimento) VALUES
(1, 1, 1, 50, '2025-02-20', '2026-02-20', '2025-06-20'),
(2, 2, 2, 30, '2025-02-18', '2025-12-18', '2025-05-18'),
(3, 3, 3, 20, '2025-02-22', '2026-01-22', '2025-07-22'),
(4, 4, 1, 40, '2025-02-25', '2025-11-25', '2025-06-25'),
(5, 5, 2, 25, '2025-02-15', '2025-10-15', '2025-05-15'),
(6, 6, 3, 60, '2025-02-19', '2026-03-19', '2025-08-19'),
(7, 7, 1, 15, '2025-02-21', '2025-09-21', '2025-04-21'),
(8, 8, 2, 35, '2025-02-23', '2025-12-23', '2025-07-23'),
(9, 9, 3, 45, '2025-02-17', '2026-02-17', '2025-06-17'),
(10, 10, 1, 20, '2025-02-24', '2025-11-24', '2025-08-24');

INSERT INTO clientes (id_cliente, nome, cpf, email, sexo, data_nascimento, endereco) VALUES
(1, 'Carlos Silva', 12345678900, 'carlos@email.com', 'M', '1990-05-12', 'Rua A, 123'),
(2, 'Mariana Souza', 23456789100, 'mariana@email.com', 'F', '1985-08-25', 'Rua B, 456'),
(3, 'José Ferreira', 34567891200, 'jose@email.com', 'M', '1992-11-03', 'Rua C, 789'),
(4, 'Ana Oliveira', 45678912300, 'ana@email.com', 'F', '1988-02-14', 'Rua D, 321'),
(5, 'Rafael Costa', 56789123400, 'rafael@email.com', 'M', '1995-07-07', 'Rua E, 654'),
(6, 'Juliana Lima', 67891234500, 'juliana@email.com', 'F', '1993-06-18', 'Rua F, 987'),
(7, 'Fernando Rocha', 78912345600, 'fernando@email.com', 'M', '1987-09-30', 'Rua G, 741'),
(8, 'Camila Mendes', 89123456700, 'camila@email.com', 'F', '1996-04-22', 'Rua H, 852'),
(9, 'Lucas Martins', 91234567800, 'lucas@email.com', 'M', '1980-12-05', 'Rua I, 963'),
(10, 'Patricia Duarte', 10234567890, 'patricia@email.com', 'F', '1991-03-19', 'Rua J, 159');

INSERT INTO animais (id_animal, id_cliente, nome, tipo, raca, hora_chegada, hora_saida) VALUES
(1, 1, 'Rex', 'Cachorro', 'Labrador', '2025-02-20 10:30:00', '2025-02-20 15:00:00'),
(2, 2, 'Mia', 'Gato', 'Persa', '2025-02-21 11:00:00', '2025-02-21 14:30:00'),
(3, 3, 'Thor', 'Cachorro', 'Bulldog', '2025-02-22 09:45:00', '2025-02-22 13:20:00'),
(4, 4, 'Luna', 'Gato', 'Siamês', '2025-02-23 08:50:00', '2025-02-23 12:10:00'),
(5, 5, 'Bobby', 'Cachorro', 'Golden Retriever', '2025-02-24 14:00:00', '2025-02-24 18:30:00'),
(6, 6, 'Nina', 'Gato', 'Maine Coon', '2025-02-25 07:15:00', '2025-02-25 10:50:00'),
(7, 7, 'Max', 'Cachorro', 'Poodle', '2025-02-26 12:20:00', '2025-02-26 16:45:00'),
(8, 8, 'Simba', 'Gato', 'Bengal', '2025-02-27 10:10:00', '2025-02-27 13:40:00'),
(9, 9, 'Spike', 'Cachorro', 'Pitbull', '2025-02-28 15:30:00', '2025-02-28 19:00:00'),
(10, 10, 'Mel', 'Gato', 'Sphynx', '2025-02-28 11:30:00', '2025-02-28 14:45:00');

INSERT INTO vendedor (id_vendedor, nome, sexo, cpf, email, telefone, data_nascimento, endereco) VALUES
(1, 'Pedro Alves', 'M', 11122233344, 'pedro@email.com', 999888777, '1990-01-15', 'Rua K, 111'),
(2, 'Larissa Brito', 'F', 22233344455, 'larissa@email.com', 888777666, '1993-05-20', 'Rua L, 222'),
(3, 'Mateus Lima', 'M', 33344455566, 'mateus@email.com', 777666555, '1985-07-30', 'Rua M, 333'),
(4, 'Fernanda Souza', 'F', 44455566677, 'fernanda@email.com', 666555444, '1992-03-12', 'Rua N, 444'),
(5, 'Gustavo Rocha', 'M', 55566677788, 'gustavo@email.com', 555444333, '1989-11-25', 'Rua O, 555'),
(6, 'Beatriz Mendes', 'F', 66677788899, 'beatriz@email.com', 444333222, '1991-08-14', 'Rua P, 666'),
(7, 'Lucas Moreira', 'M', 77788899900, 'lucas@email.com', 333222111, '1994-12-09', 'Rua Q, 777'),
(8, 'Carolina Dias', 'F', 88899900011, 'carolina@email.com', 222111000, '1997-04-27', 'Rua R, 888'),
(9, 'André Silva', 'M', 99900011122, 'andre@email.com', 111000999, '1986-10-31', 'Rua S, 999'),
(10, 'Natália Ferreira', 'F', 10001112233, 'natalia@email.com', 000999888, '1995-06-21', 'Rua T, 1000');

INSERT INTO pagamento (id_pagamento, forma_pagamento, valor, data_pagamento, status_pagamento) VALUES
(1, 'Cartão', 150.00, '2025-02-20', 'Pago'),
(2, 'Pix', 80.50, '2025-02-21', 'Pendente'),
(3, 'Boleto', 200.75, '2025-02-22', 'Pago'),
(4, 'Cartão', 50.00, '2025-02-23', 'Cancelado'),
(5, 'Pix', 300.00, '2025-02-24', 'Pago'),
(6, 'Boleto', 120.00, '2025-02-25', 'Pendente'),
(7, 'Cartão', 70.00, '2025-02-26', 'Pago'),
(8, 'Pix', 220.00, '2025-02-27', 'Cancelado'),
(9, 'Boleto', 90.00, '2025-02-28', 'Pendente'),
(10, 'Cartão', 180.00, '2025-02-28', 'Pago');

INSERT INTO pedidos (id_pedido, id_cliente, id_produto, id_pagamento, valor, status, data_pedido) VALUES
(1, 1, 2, 3, 50.00, 'Pago', '2025-02-20 10:30:00'),
(2, 2, 4, 5, 100.00, 'Pendente', '2025-02-21 12:15:00'),
(3, 3, 6, 7, 30.00, 'Cancelado', '2025-02-22 15:00:00'),
(4, 4, 8, 9, 80.00, 'Pago', '2025-02-23 09:45:00'),
(5, 5, 10, 1, 120.00, 'Pendente', '2025-02-24 14:20:00'),
(6, 6, 1, 2, 60.00, 'Pago', '2025-02-25 17:30:00'),
(7, 7, 3, 4, 90.00, 'Cancelado', '2025-02-26 11:10:00'),
(8, 8, 5, 6, 40.00, 'Pago', '2025-02-27 16:55:00'),
(9, 9, 7, 8, 200.00, 'Pendente', '2025-02-28 18:45:00'),
(10, 10, 9, 10, 75.00, 'Pago', '2025-03-01 08:30:00');

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

























































