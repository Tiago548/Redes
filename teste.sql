-- Criar a base de dados
CREATE DATABASE IF NOT EXISTS rede_social;
USE rede_social;

-- 1. Utilizador
CREATE TABLE Utilizador (
    id_utilizador INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    senha VARCHAR(100) NOT NULL,
    data_registo DATE NOT NULL,
    bio TEXT,
    foto_perfil VARCHAR(255)
);

-- 2. Grupo
CREATE TABLE Grupo (
    id_grupo INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    descricao TEXT,
    id_admin INT NOT NULL,
    data_criacao DATE NOT NULL,
    FOREIGN KEY (id_admin) REFERENCES Utilizador(id_utilizador)
);

-- 3. Post
CREATE TABLE Post (
    id_post INT AUTO_INCREMENT PRIMARY KEY,
    conteudo TEXT NOT NULL,
    data_criacao DATETIME NOT NULL,
    id_utilizador INT NOT NULL,
    id_grupo INT,
    FOREIGN KEY (id_utilizador) REFERENCES Utilizador(id_utilizador),
    FOREIGN KEY (id_grupo) REFERENCES Grupo(id_grupo)
);

-- 4. Comentario
CREATE TABLE Comentario (
    id_comentario INT AUTO_INCREMENT PRIMARY KEY,
    conteudo TEXT NOT NULL,
    data_comentario DATETIME NOT NULL,
    id_post INT NOT NULL,
    id_utilizador INT NOT NULL,
    FOREIGN KEY (id_post) REFERENCES Post(id_post),
    FOREIGN KEY (id_utilizador) REFERENCES Utilizador(id_utilizador)
);

-- 5. Notificacao
CREATE TABLE Notificacao (
    id_notificacao INT AUTO_INCREMENT PRIMARY KEY,
    mensagem TEXT NOT NULL,
    data_envio DATETIME NOT NULL,
    id_utilizador INT NOT NULL,
    tipo ENUM('amigo','comentario','post','grupo','outro') DEFAULT 'outro',
    FOREIGN KEY (id_utilizador) REFERENCES Utilizador(id_utilizador)
);

-- 6. Participa (associação N:N entre Utilizador e Grupo)
CREATE TABLE Participa (
    id_utilizador INT NOT NULL,
    id_grupo INT NOT NULL,
    data_entrada DATE NOT NULL,
    PRIMARY KEY (id_utilizador, id_grupo),
    FOREIGN KEY (id_utilizador) REFERENCES Utilizador(id_utilizador),
    FOREIGN KEY (id_grupo) REFERENCES Grupo(id_grupo)
);

-- 7. Curtida
CREATE TABLE Curtida (
    id_utilizador INT NOT NULL,
    id_post INT NOT NULL,
    data_curtida DATETIME NOT NULL,
    PRIMARY KEY (id_utilizador, id_post),
    FOREIGN KEY (id_utilizador) REFERENCES Utilizador(id_utilizador),
    FOREIGN KEY (id_post) REFERENCES Post(id_post)
);

-- 8. Seguidor
CREATE TABLE Seguidor (
    id_seguidor INT NOT NULL,
    id_seguido INT NOT NULL,
    data_seguindo DATE NOT NULL,
    PRIMARY KEY (id_seguidor, id_seguido),
    FOREIGN KEY (id_seguidor) REFERENCES Utilizador(id_utilizador),
    FOREIGN KEY (id_seguido) REFERENCES Utilizador(id_utilizador)
);

-- 9. Mensagem
CREATE TABLE Mensagem (
    id_mensagem INT AUTO_INCREMENT PRIMARY KEY,
    id_remetente INT NOT NULL,
    id_destinatario INT NOT NULL,
    conteudo TEXT NOT NULL,
    data_envio DATETIME NOT NULL,
    lida BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (id_remetente) REFERENCES Utilizador(id_utilizador),
    FOREIGN KEY (id_destinatario) REFERENCES Utilizador(id_utilizador)
);

-- 10. Tag
CREATE TABLE Tag (
    id_tag INT AUTO_INCREMENT PRIMARY KEY,
    nome_tag VARCHAR(50) NOT NULL UNIQUE
);

-- 11. Post_Tag
CREATE TABLE Post_Tag (
    id_post INT NOT NULL,
    id_tag INT NOT NULL,
    PRIMARY KEY (id_post, id_tag),
    FOREIGN KEY (id_post) REFERENCES Post(id_post),
    FOREIGN KEY (id_tag) REFERENCES Tag(id_tag)
);

-- 12. Notificacao_Lida
CREATE TABLE Notificacao_Lida (
    id_notificacao INT NOT NULL,
    id_utilizador INT NOT NULL,
    data_lida DATETIME,
    PRIMARY KEY (id_notificacao, id_utilizador),
    FOREIGN KEY (id_notificacao) REFERENCES Notificacao(id_notificacao),
    FOREIGN KEY (id_utilizador) REFERENCES Utilizador(id_utilizador)
);
