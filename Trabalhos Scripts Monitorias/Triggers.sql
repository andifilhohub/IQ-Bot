CREATE TABLE matriz.TB_VENDAS ( --select * from matriz.tb_vendas
	ID 			INTEGER,
	USUARIO 	VARCHAR(50) 	NOT NULL,
	PRODUTO 	VARCHAR(120) 	NOT NULL,
	VALOR 		DECIMAL(12,2) 	NOT NULL,
	CONSTRAINT PK_ID_VENDAS PRIMARY KEY(ID)
)
;
DELETE FROM matriz.TB_VENDAS;
--
CREATE TABLE matriz.TB_ESTOQUE ( --select * from matriz.tb_estoque
	ID 			INTEGER,
	USUARIO 	VARCHAR(50) 	NOT NULL,
	PRODUTO 	VARCHAR(120) 	NOT NULL,
	VALOR 		DECIMAL(12,2) 	NOT NULL,
	CONSTRAINT PK_ID_ESTOQUE PRIMARY KEY(ID)
)
;
DELETE FROM matriz.TB_ESTOQUE;

--CRIAÇÃO DE UMA SEQUENCE----------------------------------------------------------------------------
CREATE SEQUENCE matriz.AUDIT_ID_SEQUENCE START WITH 1 INCREMENT BY 1; --select * from matriz.AUDIT_ID_SEQUENCE a

--CRIAÇÃO DAS TABELAS TEMPORÁRIAS----------------------------------------------------------------------------
CREATE TEMPORARY TABLE TB_VENDAS_AUDITORIA ( --select * from TB_VENDAS_AUDITORIA a
    AUDIT_ID 		INTEGER,
    TABELA 			VARCHAR(50) 	NOT NULL,
    OPERACAO 		VARCHAR(10) 	NOT NULL,
    USUARIO 		VARCHAR(50),
    DATA_HORA 		TIMESTAMP 		NOT NULL,
    VALOR_ANTIGO 	VARCHAR(250),
    VALOR_NOVO 		VARCHAR(250),
    CONSTRAINT PK_ID_VENDAS_AUDITORIA PRIMARY KEY(AUDIT_ID)
);
--
CREATE TEMPORARY TABLE TB_ESTOQUE_AUDITORIA (
    AUDIT_ID 		INTEGER,
    TABELA 			VARCHAR(50) 	NOT NULL,
    OPERACAO 		VARCHAR(10) 	NOT NULL,
    USUARIO 		VARCHAR(50),
    DATA_HORA 		TIMESTAMP 		NOT NULL,
    VALOR_ANTIGO 	VARCHAR(250),
    VALOR_NOVO 		VARCHAR(250),
    CONSTRAINT PK_ID_ESTOQUE_AUDITORIA PRIMARY KEY(AUDIT_ID)
);

--CRIAÇÃO DAS FUNÇÕES----------------------------------------------------------------------------
CREATE OR REPLACE FUNCTION matriz.FN_AUDIT_VENDAS_INSERT() 
RETURNS TRIGGER AS $$
DECLARE
    LAST_AUDIT_ID INTEGER;
BEGIN
    LAST_AUDIT_ID := NEXTVAL('matriz.AUDIT_ID_SEQUENCE');
    
    INSERT INTO TB_VENDAS_AUDITORIA (
          AUDIT_ID 
        , TABELA
        , OPERACAO
        , USUARIO
        , DATA_HORA
        , VALOR_NOVO
    )
    VALUES (
          LAST_AUDIT_ID
        , 'VENDAS'
        , 'INSERT'
        , CURRENT_USER
        , NOW()
        , NEW.VALOR
    );
    
    RETURN NEW;
END;
--$$ LANGUAGE plpgsql;
--
CREATE OR REPLACE FUNCTION matriz.FN_AUDIT_VENDAS_UPDATE() 
RETURNS TRIGGER AS $$
DECLARE
    LAST_AUDIT_ID INTEGER;
BEGIN
    LAST_AUDIT_ID := NEXTVAL('matriz.AUDIT_ID_SEQUENCE');
    
    INSERT INTO TB_VENDAS_AUDITORIA (
          AUDIT_ID 
        , TABELA
        , OPERACAO
        , USUARIO
        , DATA_HORA
        , VALOR_ANTIGO
        , VALOR_NOVO
    )
    VALUES (
          LAST_AUDIT_ID
        , 'VENDAS'
        , 'UPDATE'
        , CURRENT_USER
        , NOW()
        , OLD.VALOR
        , NEW.VALOR
    );
    
    RETURN NEW;
END;
--$$ LANGUAGE plpgsql;
--
CREATE OR REPLACE FUNCTION matriz.FN_AUDIT_ESTOQUE_INSERT() 
RETURNS TRIGGER AS $$
DECLARE
    LAST_AUDIT_ID INTEGER;
BEGIN
    LAST_AUDIT_ID := NEXTVAL('matriz.AUDIT_ID_SEQUENCE');
    
    INSERT INTO TB_ESTOQUE_AUDITORIA (
          AUDIT_ID 
        , TABELA
        , OPERACAO
        , USUARIO
        , DATA_HORA
        , VALOR_NOVO
    )
    VALUES (
          LAST_AUDIT_ID
        , 'ESTOQUE'
        , 'INSERT'
        , CURRENT_USER
        , NOW()
        , NEW.VALOR
    );
    
    RETURN NEW;
END;
--$$ LANGUAGE plpgsql;
--
CREATE OR REPLACE FUNCTION matriz.FN_AUDIT_ESTOQUE_UPDATE() 
RETURNS TRIGGER AS $$
DECLARE
    LAST_AUDIT_ID INTEGER;
BEGIN
    LAST_AUDIT_ID := NEXTVAL('matriz.AUDIT_ID_SEQUENCE');
    
    INSERT INTO TB_ESTOQUE_AUDITORIA (
          AUDIT_ID 
        , TABELA
        , OPERACAO
        , USUARIO
        , DATA_HORA
        , VALOR_ANTIGO
        , VALOR_NOVO
    )
    VALUES (
          LAST_AUDIT_ID
        , 'ESTOQUE'
        , 'UPDATE'
        , CURRENT_USER
        , NOW()
        , OLD.VALOR
        , NEW.VALOR
    );
    
    RETURN NEW;
END;
--$$ LANGUAGE plpgsql;

--CRIAÇÃO DO TRIGGER----------------------------------------------------------------------------
CREATE TRIGGER TG_AUDIT_VENDAS_INSERT
BEFORE INSERT ON matriz.TB_VENDAS
FOR EACH ROW
EXECUTE PROCEDURE matriz.FN_AUDIT_VENDAS_INSERT()
;
--
CREATE TRIGGER TG_AUDIT_VENDAS_UPDATE
BEFORE UPDATE ON matriz.TB_VENDAS
FOR EACH ROW
EXECUTE PROCEDURE matriz.FN_AUDIT_VENDAS_UPDATE()
;
--
CREATE TRIGGER TG_AUDIT_ESTOQUE_INSERT
BEFORE INSERT ON matriz.TB_ESTOQUE
FOR EACH ROW
EXECUTE PROCEDURE matriz.FN_AUDIT_ESTOQUE_INSERT()
;
--
CREATE TRIGGER TG_AUDIT_ESTOQUE_UPDATE
BEFORE UPDATE ON matriz.TB_ESTOQUE
FOR EACH ROW
EXECUTE PROCEDURE matriz.FN_AUDIT_ESTOQUE_UPDATE()

--TESTE DO INSERT----------------------------------------------------------------------------
DELETE FROM matriz.TB_VENDAS;
DELETE FROM matriz.TB_ESTOQUE;

INSERT INTO matriz.TB_VENDAS (ID, USUARIO, PRODUTO, VALOR) VALUES (1, 'fulano', 'produto 1', 10.00);
INSERT INTO matriz.TB_ESTOQUE (ID, USUARIO, PRODUTO, VALOR) VALUES (1, 'fulano', 'produto 1', 10.00);

UPDATE TB_VENDAS SET PRODUTO = 'produto 2', VALOR = 20.00 WHERE id = 1;
UPDATE TB_ESTOQUE SET PRODUTO = 'produto 2', VALOR = 20.00 WHERE id = 1;

select * from matriz.tb_vendas;
select * from matriz.tb_ESTOQUE;

select * from TB_VENDAS_AUDITORIA a;
select * from TB_ESTOQUE_AUDITORIA a;
