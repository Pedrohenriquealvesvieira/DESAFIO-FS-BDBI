
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


