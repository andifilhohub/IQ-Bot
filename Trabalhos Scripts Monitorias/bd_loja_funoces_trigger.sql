-- Funções e Trigger
-- CREATE OR REPLACE se existir apenas atualiza
CREATE OR REPLACE FUNCTION loja01.fn_teste(real) RETURNS real AS
$$
  DECLARE 
  	v_subtotal ALIAS FOR $1;
  BEGIN
  	RETURN v_subtotal * 0.06;
  END
$$
LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION loja01.fn_teste2(real) RETURNS real AS
$$
  BEGIN
  	RETURN $1 * 0.06;
  END
$$
LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION loja01.fn_soma(pvar1 real,pvar2 real) RETURNS real AS
$$
  BEGIN
  	RETURN pvar1 + pvar2;
  END
$$
LANGUAGE plpgsql;
SELECT loja01.fn_soma(15.5, 20.5) AS SOMA;

CREATE OR REPLACE FUNCTION loja01.fn_soma2_ret_string(pvar1 real,pvar2 real) 
RETURNS varchar AS
$$
  DECLARE 
    pSoma real;
  BEGIN
    pSoma = pvar1 + pvar2;
  	RETURN 'O valor da soma -> ' || pSoma;
  END
$$
LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION loja01.fn_ret_nome_cliente(integer) RETURNS varchar AS
$$
	DECLARE 
       v_nome loja01.tb_cliente.nome%TYPE;
    
    BEGIN
       SELECT nome INTO v_nome FROM loja01.tb_cliente WHERE id_cliente = $1;
       RETURN 'Nome do cliente: ' ||v_nome;
    END
$$
LANGUAGE plpgsql;
SELECT loja01.fn_ret_nome_cliente(1);

CREATE OR REPLACE FUNCTION loja01.fn_ret_nome_cliente_tupla(integer) RETURNS varchar AS
$$
	DECLARE 
       v_tupla loja01.tb_cliente%ROWTYPE;    
    BEGIN
       SELECT * INTO v_tupla FROM loja01.tb_cliente WHERE id_cliente = $1;
       RETURN 'Tupla (linha): ' ||v_tupla;
    END
$$
LANGUAGE plpgsql;

SELECT loja01.fn_ret_nome_cliente_tupla(1);


CREATE OR REPLACE FUNCTION 
loja01.fn_ret_nome_cliente_record(loja01.tb_cliente.id_cliente%TYPE) 
RETURNS text AS
$$
	DECLARE 
       v_linha RECORD;    
    BEGIN
       SELECT * INTO v_linha FROM loja01.tb_cliente WHERE id_cliente = $1;
       IF NOT FOUND THEN
       	 RAISE EXCEPTION 'Cliente % não encontrado',$1;
       ELSE
       	 RETURN 'Cliente encontrado!!';
       END IF;
    END
$$
LANGUAGE plpgsql;

CREATE TABLE loja01.tb_log(
   nome			VARCHAR(30),
   data_hora 	TIMESTAMP
);

CREATE OR REPLACE FUNCTION loja01.fn_loop_basico() RETURNS void AS 
$$
	DECLARE 
       v_contador integer;
    BEGIN
       v_contador := 0;
       LOOP
          v_contador := v_contador + 1;
          RAISE NOTICE 'Contador: %',v_contador;          
          EXIT WHEN v_contador > 20;
       END LOOP;
       RETURN;
    END;
$$
LANGUAGE plpgsql;

SELECT loja01.fn_loop_basico();

CREATE SEQUENCE loja01.sq_categoria;
CREATE TABLE loja01.tb_categoria 
(
    id_categoria 	INTEGER,
    ds_categoria 	VARCHAR(40) NOT NULL,
    fg_ativo		INTEGER NOT NULL,
    PRIMARY KEY(id_categoria)
);

CREATE OR REPLACE FUNCTION loja01.fn_categoria(p_id_categoria integer,
                                        p_descricao varchar,
                                        p_flag integer,
                                        p_opcao char)
RETURNS integer AS
$$
	DECLARE 
    	v_id_categoria loja01.tb_categoria.id_categoria%TYPE;
    BEGIN
    	IF p_opcao = 'I' THEN
        	SELECT nextval('loja01.sq_categoria') INTO v_id_categoria;
            INSERT INTO loja01.tb_categoria(id_categoria,ds_categoria,
            fg_ativo) VALUES (v_id_categoria, p_descricao, p_flag);
            RETURN v_id_categoria;        
        ELSIF p_opcao = 'U' THEN
        	UPDATE loja01.tb_categoria SET ds_categoria = p_descricao 
            WHERE id_categoria = p_id_categoria;
        	RETURN v_id_categoria;
        ELSIF p_opcao = 'D' THEN
        	DELETE FROM loja01.tb_categoria 
            WHERE id_categoria = p_id_categoria;
            RETURN 0;
        ELSE
        	RETURN 100;
        END IF;
        EXCEPTION WHEN OTHERS THEN RETURN -1;
    END  
$$
LANGUAGE plpgsql;

SELECT loja01.fn_categoria(null, 'CATEGORIA 1', 1, 'I');
SELECT loja01.fn_categoria(1, 'CATEGORIA 1 - ALTERADA', 1, 'U');
SELECT loja01.fn_categoria(null, 'CATEGORIA 2', 1, 'I');
SELECT loja01.fn_categoria(null, 'CATEGORIA 3', 1, 'I');
SELECT * FROM loja01.tb_categoria;
SELECT loja01.fn_categoria(2, '', 1, 'F');

CREATE OR REPLACE FUNCTION loja01.fn_cliente_estado(pestado CHAR(2))
RETURNS SETOF loja01.tb_cliente AS
'
SELECT *
FROM loja01.tb_cliente
WHERE estado = pestado;
'
LANGUAGE sql;

UPDATE loja01.tb_cliente SET estado = 'MG' WHERE id_cliente=1;
SELECT loja01.fn_cliente_estado('SP');

======
CREATE TABLE loja01.tb_empregados (
nome	VARCHAR		NOT NULL,
salario	NUMERIC);

CREATE TABLE loja01.tb_empregados_auditoria (
operacao	CHAR 		NOT NULL,
usuario	    VARCHAR     NOT NULL,
dt_hr	    TIMESTAMP	NOT NULL,
nome	    VARCHAR	 	NOT NULL,
salario     NUMERIC);

CREATE OR REPLACE FUNCTION loja01.fn_empregado_auditoria()
RETURNS trigger AS
$$
	BEGIN
    	IF(tg_op = 'DELETE') THEN
           	INSERT INTO loja01.tb_empregados_auditoria
            SELECT 'E', user, now(),OLD.*;
            RETURN OLD;
    	ELSIF(tg_op = 'UPDATE') THEN
           	INSERT INTO loja01.tb_empregados_auditoria
            SELECT 'A', user, now(),NEW.*;
            RETURN NEW;
    	ELSIF(tg_op = 'INSERT') THEN
           	INSERT INTO loja01.tb_empregados_auditoria
            SELECT 'I', user, now(),NEW.*;
            RETURN NEW;
        END IF;
        RETURN NULL;                   
    END
$$
LANGUAGE plpgsql;

CREATE TRIGGER tg_empregado_auditoria
AFTER INSERT OR UPDATE OR DELETE ON loja01.tb_empregados
FOR EACH ROW EXECUTE PROCEDURE loja01.fn_empregado_auditoria();

INSERT INTO loja01.tb_empregados(nome,salario)
VALUES
('João',1500.98),
('Pedro',3452.76),
('Marta',3745.65)

SELECT * FROM loja01.tb_empregados_auditoria;

UPDATE loja01.tb_empregados SET nome = 'João Alterado' 
WHERE salario = 1500.98;
DELETE FROM loja01.tb_empregados WHERE nome = 'João Alterado';


