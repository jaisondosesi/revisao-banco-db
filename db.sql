CREATE DATABASE petshop_db;
USE petshop_db;

CREATE TABLE IF NOT EXISTS cliente (
  id INT AUTO_INCREMENT PRIMARY KEY,
  nome VARCHAR(120) NOT NULL,
  cpf CHAR(11) NOT NULL UNIQUE,
  telefone VARCHAR(20),
  email VARCHAR(120)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS pet (
  id INT AUTO_INCREMENT PRIMARY KEY,
  cliente_id INT NOT NULL,
  nome VARCHAR(80) NOT NULL,
  especie ENUM('cachorro','gato','ave','roedor','reptil','outro') NOT NULL,
  porte   ENUM('mini','pequeno','medio','grande','gigante') NOT NULL,
  nascimento DATE,
  FOREIGN KEY (cliente_id) REFERENCES cliente(id)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS servico (
  id INT AUTO_INCREMENT PRIMARY KEY,
  nome VARCHAR(80) NOT NULL UNIQUE,
  preco DECIMAL(10,2) NOT NULL,
  duracao_min INT NOT NULL,
  CHECK (preco >= 0),
  CHECK (duracao_min > 0)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS agendamento (
  id INT AUTO_INCREMENT PRIMARY KEY,
  pet_id INT NOT NULL,
  servico_id INT NOT NULL,
  data_hora DATETIME NOT NULL,
  status ENUM('agendado','concluido','cancelado') NOT NULL DEFAULT 'agendado',
  observacoes VARCHAR(255),
  FOREIGN KEY (pet_id) REFERENCES pet(id),
  FOREIGN KEY (servico_id) REFERENCES servico(id),
  INDEX idx_agendamento_data (data_hora)
) ENGINE=InnoDB;

INSERT INTO cliente (nome, cpf, telefone, email) VALUES
  ('Ana Paula Santos','11111111111','11988887777','ana.santos@example.com'),
  ('Bruno Oliveira','22222222222','11977776666','bruno.oliveira@example.com'),
  ('Carla Souza','33333333333','11966665555','carla.souza@example.com');

INSERT INTO pet (cliente_id, nome, especie, porte, nascimento) VALUES
  (1,'Thor','cachorro','grande','2018-04-10'),
  (1,'Mimi','gato','pequeno','2021-01-22'),
  (2,'Lola','cachorro','medio','2020-07-05');

INSERT INTO servico (nome, preco, duracao_min) VALUES
  ('Banho',60.00,60),
  ('Tosa',80.00,75),
  ('Vacina V10',120.00,20),
  ('Consulta',150.00,30);

INSERT INTO agendamento (pet_id, servico_id, data_hora, status, observacoes) VALUES
  (1, 1, '2030-01-10 10:00:00', 'agendado', 'Banho hipoalergênico'),
  (2, 3, '2030-01-11 14:30:00', 'agendado', 'Trazer carteira de vacinação'),
  (3, 2, '2030-01-12 09:00:00', 'agendado', 'Tosa padrão');
