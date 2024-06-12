CREATE TABLE loja01.users( 
	id SERIAL,
 	name VARCHAR(50),
 	gems DEC (10),
 	PRIMARY KEY (id)
);

INSERT INTO loja01.users (name, gems) VALUES ('David', 1000); 
INSERT INTO loja01.users (name, gems) VALUES ('John', 1000); 

SELECT * FROM loja01.users;

-- atualizar valores 
--(caso prescisar voltar o dado com o valor anterior da transação antes do comiit basta -> ROLLBACK)
-- via psql 
-- começando a transação
--BEGIN TRANSACTION;
--UPDATE loja01.users SET gems = gems - 100 WHERE id=2;
-- confirmando a transação
--COMMIT

-- SAVEPOINT <nome_save_point>
