-- Função para contar o total de cidades e o total de cidades em MG
CREATE OR REPLACE FUNCTION public.fn_cont_cidades_total_e_mg() 
RETURNS VARCHAR AS 
$$
DECLARE
    total INT;
    mg_cidades INT;
BEGIN
    SELECT COUNT(*) INTO total FROM localidades;
    SELECT COUNT(*) INTO mg_cidades FROM localidades WHERE estado = 'MG';
    
    RETURN 'Total de cidades: ' || total || ', Cidades em MG: ' || mg_cidades;
END;
$$
LANGUAGE plpgsql;

-- Chamada da função para exibir o resultado
SELECT public.fn_cont_cidades_total_e_mg();

-- Função para retornar as cidades de MG
CREATE OR REPLACE FUNCTION public.fn_cidades_MG() 
RETURNS TABLE (cidade VARCHAR) AS 
$$
BEGIN
    RETURN QUERY SELECT localidade FROM localidades WHERE estado = 'MG';
END;
$$
LANGUAGE plpgsql;

-- Chamada da função para exibir as cidades de MG
SELECT public.fn_cidades_MG();

-- Seleção de todos os logradouros
SELECT * FROM logradouros;

-- Função para retornar as ruas de Uberlândia com seus CEPs
CREATE OR REPLACE FUNCTION public.fn_ruas_uberlandia() 
RETURNS TABLE (ruas VARCHAR, cep VARCHAR) AS 
$$
DECLARE
    uberlandia_code INT;
BEGIN
    SELECT codigo INTO uberlandia_code FROM localidades WHERE localidades.localidade='Uberlândia';
    RETURN QUERY SELECT logradouros.logradouro, logradouros.cep FROM logradouros WHERE logradouros.localidade=uberlandia_code;
END;
$$
LANGUAGE plpgsql;

-- Chamada da função para exibir as ruas de Uberlândia
SELECT public.fn_ruas_uberlandia();

-- Exclui a função fn_ruas_uberlandia
DROP FUNCTION public.fn_ruas_uberlandia();

-- Função para inserir, atualizar ou excluir localidades
CREATE OR REPLACE FUNCTION public.fn_IAR_localidades(loc VARCHAR, est VARCHAR, opcao CHAR, localter VARCHAR, estalter VARCHAR)
RETURNS VOID AS
$$
BEGIN
	
	IF opcao='I' THEN
		INSERT INTO localidades(localidade, estado)
		VALUES
		(loc, est);
	ELSIF opcao='D' THEN
		DELETE FROM localidades WHERE localidades.localidade=loc;
		
	ELSIF opcao='A' THEN
		UPDATE localidades SET estado=estalter, localidade=localter
		WHERE localidade= loc;
	END IF;
END;
$$
LANGUAGE plpgsql;

-- Chamada da função para inserir, atualizar ou excluir localidades
SELECT public.fn_IAR_localidades('Acrelândia', 'AC','A','Acreondia','AC');

-- Seleção da localidade inserida para verificar se a função fn_IAR_localidades funcionou corretamente
SELECT * FROM localidades WHERE localidades.localidade='Acrelândia';

-- Criação da tabela para auditoria de localidades
CREATE TABLE public.localidades_audit(
	operation CHAR NOT NULL,
	user_name VARCHAR NOT NULL, 
	datetime TIMESTAMP NOT NULL,
	city VARCHAR NOT NULL, 
	state CHAR(2) NOT NULL);

-- Exclui a tabela localidades_audit
DROP TABLE localidades_audit;

-- Função para auditoria de localidades
CREATE OR REPLACE FUNCTION public.fn_localidades_auditoria()
RETURNS TRIGGER AS
$$
BEGIN
    IF (TG_OP = 'DELETE') THEN
        INSERT INTO public.localidades_audit (operation, user_name, datetime, city, state)
        VALUES ('E', session_user, current_timestamp, OLD.localidade, OLD.estado);
        RETURN OLD;
    ELSIF (TG_OP = 'UPDATE') THEN
        INSERT INTO public.localidades_audit (operation, user_name, datetime, city, state)
        VALUES ('A', session_user, current_timestamp, NEW.localidade, NEW.estado);
        RETURN NEW;
    ELSIF (TG_OP = 'INSERT') THEN
        INSERT INTO public.localidades_audit (operation, user_name, datetime, city, state)
        VALUES ('I', session_user, current_timestamp, NEW.localidade, NEW.estado);
        RETURN NEW;
    END IF;
    RETURN NULL;
END;
$$
LANGUAGE plpgsql;

-- Criação do gatilho para auditoria de localidades
CREATE TRIGGER tg_localidades_auditoria
AFTER INSERT OR UPDATE OR DELETE ON public.localidades
FOR EACH ROW EXECUTE FUNCTION public.fn_localidades_auditoria();

-- Exclui a função fn_localidades_auditoria
DROP FUNCTION public.fn_localidades_auditoria();

-- Exclui o gatilho tg_localidades_auditoria na tabela localidades
DROP TRIGGER tg_localidades_auditoria ON public.localidades;

-- Seleciona todas as entradas na tabela de auditoria de localidades
SELECT * FROM localidades_audit;

