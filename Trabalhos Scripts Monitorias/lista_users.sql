-- Esse grupo pode apenas visualizar informações (apenas comandos SELECT)

CREATE USER Estagiario WITH PASSWORD '3579'; 

-- Esse grupo possui permissão de modificar registros, mas não pode 
-- acessar nenhuma rotina, não pode criar base de dados e não pode criar tabelas

CREATE USER Analista WITH PASSWORD '2468';

--  implementando as políticas de acesso:
GRANT SELECT, INSERT, UPDATE, DELETE ON tabela_exemplo TO Analista;

-- negar a capacidade de criar bancos de dados e tabelas:

REVOKE CREATE DATABASE, CREATE TABLE FROM Analista;

-- negar o acesso a rotinas:

REVOKE EXECUTE ON ALL FUNCTIONS IN SCHEMA public FROM Analista;

-- Esse grupo de usuário tem a permissão de modificar todos os registros de 
-- todas as tabelas, além de utilizar as rotinas (stored procedures), além de 
-- poder dar direitos aos outros usuários

CREATE USER Gerente WITH PASSWORD '123456';

--  implementando as políticas de acesso:
GRANT SELECT, INSERT, UPDATE, DELETE ON tabela_exemplo TO Gerente;

-- conceder permissão para modificar todos os registros de todas as tabelas e usar rotinas

GRANT USAGE ON SCHEMA public TO Gerente;
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO Gerente;
GRANT EXECUTE ON ALL FUNCTIONS IN SCHEMA public TO Gerente;

-- permitir que o usuário conceda direitos a outros usuários

GRANT CREATE ON SCHEMA public TO usuario_exemplo;


