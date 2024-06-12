-- 1) Recuperar os itens dos pedidos, descrição dos produtos e o valor de cada item
SELECT item_pedido.id_pedido, item_pedido.id_pedido, item_pedido.quantidade,  
item.ds_item, item.preco_venda, (item_pedido.quantidade * item.preco_venda) AS "TOTAL ITEM" 
FROM loja01.tb_item_pedido item_pedido, loja01.tb_item item 
WHERE item_pedido.id_item = item.id_item ORDER BY item_pedido.id_pedido;

-- 2) Recuperar o total do pedido
SELECT item_pedido.id_pedido, SUM(item_pedido.quantidade * item.preco_venda) 
AS "TOTAL ITEM" FROM loja01.tb_item_pedido item_pedido, loja01.tb_item item 
WHERE item_pedido.id_item = item.id_item
GROUP BY item_pedido.id_pedido ORDER BY item_pedido.id_pedido;

	
-- 3) Recuperar o total do pedido e o nome do cliente
SELECT pedido.id_pedido, pedido.id_cliente, cliente.nome,
(SELECT SUM(item_pedido.quantidade * item.preco_venda) 
AS "TOTAL ITEM" FROM loja01.tb_item_pedido item_pedido, loja01.tb_item item 
WHERE item_pedido.id_item = item.id_item AND pedido.id_pedido = item_pedido.id_pedido 
 GROUP BY item_pedido.id_pedido ORDER BY item_pedido.id_pedido)
FROM loja01.tb_pedido pedido, loja01.tb_cliente cliente 
WHERE pedido.id_cliente = cliente.id_cliente;

-- 4) Surpresa
SELECT * FROM loja01.tb_pedido pedido
UPDATE loja01.tb_pedido pedido SET valor = 0;

UPDATE loja01.tb_pedido pedido SET VALOR = (
	(SELECT SUM(item_pedido.quantidade * item.preco_venda) 
	AS "TOTAL ITEM" FROM loja01.tb_item_pedido item_pedido, loja01.tb_item item 
	WHERE item_pedido.id_item = item.id_item AND pedido.id_pedido = item_pedido.id_pedido 
 	GROUP BY item_pedido.id_pedido ORDER BY item_pedido.id_pedido)
)


