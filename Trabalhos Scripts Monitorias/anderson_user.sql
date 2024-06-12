-- Esse grupo pode apenas visualizar informações (apenas comandos SELECT)
CREATE USER Visualizador WITH PASSWORD 'senha_visualizador'; 

-- Esse grupo possui permissão de modificar registros, mas não pode 
-- acessar nenhuma rotina, não pode criar base de dados e não pode criar tabelas
CREATE USER Modificador WITH PASSWORD 'senha_modificador';

-- Esse grupo de usuário tem a permissão de modificar todos os registros de 
-- todas as tabelas, além de utilizar as rotinas (stored procedures), além de 
-- poder dar direitos aos outros usuários
CREATE USER Administrador WITH PASSWORD 'senha_administrador';

-- Implementando as políticas de acesso:
GRANT SELECT, INSERT, UPDATE, DELETE ON tabela_exemplo TO Modificador;

-- Negar a capacidade de criar bancos de dados e tabelas:
REVOKE CREATE DATABASE, CREATE TABLE FROM Modificador;

-- Negar o acesso a rotinas:
REVOKE EXECUTE ON ALL FUNCTIONS IN SCHEMA public FROM Modificador;


-- Implementando as políticas de acesso:
GRANT SELECT, INSERT, UPDATE, DELETE ON tabela_exemplo TO Administrador;

-- Conceder permissão para modificar todos os registros de todas as tabelas e usar rotinas
GRANT USAGE ON SCHEMA public TO Administrador;
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO Administrador;
GRANT EXECUTE ON ALL FUNCTIONS IN SCHEMA public TO Administrador;

-- Permitir que o usuário conceda direitos a outros usuários
GRANT CREATE ON SCHEMA public TO usuario_exemplo;

