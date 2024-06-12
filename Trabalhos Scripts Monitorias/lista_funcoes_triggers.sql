Create or Replace FUNCTION public.fn_cont_cidades_total_e_mg() 
RETURNS VARCHAR AS 
$$
DECLARE
    total_de_cidades INT;
    cidades_mg INT;
BEGIN
    SELECT COUNT(*) INTO total_de_cidades FROM localidades;
    SELECT COUNT(*) INTO cidades_mg FROM localidades WHERE estado = 'MG';
    
    RETURN 'Total de cidades: ' || total_de_cidades || ', Cidades em MG: ' || cidades_mg;
END;
$$
LANGUAGE plpgsql;

Select public.fn_cont_cidades_total_e_mg();

Create or Replace FUNCTION public.fn_cidades_MG() 
RETURNS TABLE (cidade VARCHAR) AS 
$$
BEGIN
    RETURN QUERY SELECT localidade FROM localidades WHERE estado = 'MG';
END;
$$
LANGUAGE plpgsql;

Select public.fn_cidades_mg();

Select * from logradouros;

Create or Replace FUNCTION public.fn_ruas_uberlandia() 
RETURNS Table(ruas Varchar, cep Varchar) AS 
$$
DECLARE
    codigo_uberlandia INT;
BEGIN
    SELECT codigo INTO codigo_uberlandia FROM localidades where localidades.localidade='Uberlândia';
    RETURN Query Select logradouros.logradouro,logradouros.cep from logradouros Where logradouros.localidade=codigo_uberlandia;
END;
$$
LANGUAGE plpgsql;
Select public.fn_ruas_uberlandia();

Drop FUNCTION public.fn_ruas_uberlandia();

Create or Replace FUNCTION public.fn_IAR_localidades(loc Varchar, est Varchar, opcao Char,localter Varchar,estalter Varchar)
Returns VOID AS
$$
BEGIN
	
	IF opcao='I' then
		Insert into localidades(localidade, estado)
		VALUES
		(loc,est);
	Elsif opcao='D' THEN
		Delete from localidades where localidades.localidade=loc;
		
	Elsif opcao='A' then
		Update localidades set estado=estalter,localidade=localter
		where localidade= loc;
	End if;
End
$$
LANGUAGE plpgsql;

Select public.fn_IAR_localidades('Acrelândia', 'AC','A','Acreondia','AC');
Select * from localidades where localidades.localidade='Acrelândia';

Create table public.localidades_audit(
	operacao char Not null,
	usuario Varchar Not null, 
	dt_hr TIMESTAMP	NOT NULL,
	cidade Varchar Not null, 
	estado char(2) Not null);
drop table localidades_audit;

CREATE OR REPLACE FUNCTION public.fn_localidades_auditoria()
RETURNS trigger AS
$$
BEGIN
    IF (TG_OP = 'DELETE') THEN
        INSERT INTO public.localidades_audit (operacao, usuario, dt_hr, cidade, estado)
        VALUES ('E', session_user, current_timestamp, OLD.localidade, OLD.estado);
        RETURN OLD;
    ELSIF (TG_OP = 'UPDATE') THEN
        INSERT INTO public.localidades_audit (operacao, usuario, dt_hr, cidade, estado)
        VALUES ('A', session_user, current_timestamp, NEW.localidade, NEW.estado);
        RETURN NEW;
    ELSIF (TG_OP = 'INSERT') THEN
        INSERT INTO public.localidades_audit (operacao, usuario, dt_hr, cidade, estado)
        VALUES ('I', session_user, current_timestamp, NEW.localidade, NEW.estado);
        RETURN NEW;
    END IF;
    RETURN NULL;
END;
$$
LANGUAGE plpgsql;

CREATE TRIGGER tg_localidades_auditoria
AFTER INSERT OR UPDATE OR DELETE ON public.localidades
FOR EACH ROW EXECUTE PROCEDURE public.fn_localidades_auditoria();

Drop FUNCTION public.fn_localidades_auditoria();

Drop TRIGGER tg_localidades_auditoria on public.localidades;

Select * from localidades_audit;