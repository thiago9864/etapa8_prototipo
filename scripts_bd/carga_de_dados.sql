--Funcionarios
INSERT INTO trabalho_roupa.funcionario (id_func, nome, cpf, email, senha, salario, status) 
VALUES (0,'José',54887753071,'jose@teste.com',1234,1200.0,'ativo');

INSERT INTO trabalho_roupa.funcionario (id_func, nome, cpf, email, senha, salario, status) 
VALUES (1,'Maria',64284561090,'maria@teste.com',5678,1300.0,'ativo');

INSERT INTO trabalho_roupa.funcionario (id_func, nome, cpf, email, senha, salario, status) 
VALUES (2,'João',51583739068,'joao@teste.com',1357,2200.0,'ativo');

INSERT INTO trabalho_roupa.funcionario (id_func, nome, cpf, email, senha, salario, status) 
VALUES (3,'Ana',81753489091,'ana@teste.com',1234,1200.0,'inativo');

INSERT INTO trabalho_roupa.funcionario (id_func, nome, cpf, email, senha, salario, status) 
VALUES (4,'Antônio',26177664032,'antonio@teste.com',1234,1300.0,'ativo');

INSERT INTO trabalho_roupa.funcionario (id_func, nome, cpf, email, senha, salario, status) 
VALUES (5,'Francisca',90534337082,'francisca@teste.com',9876,2200.0,'inativo');

INSERT INTO trabalho_roupa.funcionario (id_func, nome, cpf, email, senha, salario, status) 
VALUES (6,'Mario','09363029093','mario@teste.com',1928,2000.0,'desligado');


--Caixa
INSERT INTO trabalho_roupa.caixa (id_caixa, numero, saldo) 
VALUES (0, 1, 0.0);

INSERT INTO trabalho_roupa.caixa (id_caixa, numero, saldo) 
VALUES (1, 3, 125.59);

INSERT INTO trabalho_roupa.caixa (id_caixa, numero, saldo) 
VALUES (2, 4, 1560.36);

--Especializacoes de Funcionarios
INSERT INTO trabalho_roupa.administrador (id_admin) VALUES (0);
INSERT INTO trabalho_roupa.administrador (id_admin) VALUES (1);
INSERT INTO trabalho_roupa.vendedor (id_vendedor, id_caixa) VALUES (2, 1);
INSERT INTO trabalho_roupa.vendedor (id_vendedor, id_caixa) VALUES (3, 2);
INSERT INTO trabalho_roupa.vendedor (id_vendedor) VALUES (6);
INSERT INTO trabalho_roupa.auxiliar (id_auxiliar) VALUES (4);
INSERT INTO trabalho_roupa.auxiliar (id_auxiliar) VALUES (5);

--Clientes
INSERT INTO trabalho_roupa.cliente (id_cliente, nome, cpf) 
VALUES (0, 'Francisco', 80638000017);

INSERT INTO trabalho_roupa.cliente (id_cliente, nome, cpf) 
VALUES (1, 'Antônia', 41335337040);

INSERT INTO trabalho_roupa.cliente (id_cliente, nome, cpf) 
VALUES (2, 'Carlos', 42867379008);

INSERT INTO trabalho_roupa.cliente (id_cliente, nome, cpf) 
VALUES (3, 'Adriana', 67583800099);

--Fornecedores
INSERT INTO trabalho_roupa.fornecedor (id_fornecedor, nome, cnpj) 
VALUES (0, 'Lojão do Zé', 20659258000101);

INSERT INTO trabalho_roupa.fornecedor (id_fornecedor, nome, cnpj) 
VALUES (1, 'Atacadão da Roupa', 04854743000180);

INSERT INTO trabalho_roupa.fornecedor (id_fornecedor, nome, cnpj) 
VALUES (2, 'JF Atacado', 14340451000182);

--Marcas
INSERT INTO trabalho_roupa.marca (id_marca, nome) VALUES (0, 'Nikei');
INSERT INTO trabalho_roupa.marca (id_marca, nome) VALUES (1, 'Jacaré Outfits');
INSERT INTO trabalho_roupa.marca (id_marca, nome) VALUES (2, 'CAP');

--Categorias
INSERT INTO trabalho_roupa.categoria (id_cat, nome) VALUES (0, 'Masculina');
INSERT INTO trabalho_roupa.categoria (id_cat, nome) VALUES (1, 'Infantil');
INSERT INTO trabalho_roupa.categoria (id_cat, nome) VALUES (2, 'Feminina');

--Produtos
INSERT INTO trabalho_roupa.produto (codigo_prod, nome, preco, quantidadeEstoque, id_marca, id_cat) 
VALUES (0, 'Camisa Manga Longa Masculina Estampada Uv G', 13.73, 50, 1, 0);

INSERT INTO trabalho_roupa.produto (codigo_prod, nome, preco, quantidadeEstoque, id_marca, id_cat) 
VALUES (1, 'Calça Jeans Lipo Com Cinta Modeladora Slim 36@44', 90.99, 50, 0, 0);

INSERT INTO trabalho_roupa.produto (codigo_prod, nome, preco, quantidadeEstoque, id_marca, id_cat) 
VALUES (2, 'Batinha Bebê com Calçinha 6 a 10 Meses', 9.07, 50, 1, 1);

INSERT INTO trabalho_roupa.produto (codigo_prod, nome, preco, quantidadeEstoque, id_marca, id_cat) 
VALUES (3, 'Conjuntos, Macacão e Body Bebê Masculino 3 a 7 meses', 9.49, 50, 2, 1);

INSERT INTO trabalho_roupa.produto (codigo_prod, nome, preco, quantidadeEstoque, id_marca, id_cat) 
VALUES (4, 'Cropped Fio Torcido Bicolor M', 12.60, 50, 0, 2);

INSERT INTO trabalho_roupa.produto (codigo_prod, nome, preco, quantidadeEstoque, id_marca, id_cat) 
VALUES (5, 'Camisa Gola Polo Algodão P/M/G', 16.94, 50, 1, 0);

INSERT INTO trabalho_roupa.produto (codigo_prod, nome, preco, quantidadeEstoque, id_marca, id_cat) 
VALUES (6, 'Short Jeans Cintura Alta Vários Modelos 36 ao 44', 22.21, 50, 1, 2);

INSERT INTO trabalho_roupa.produto (codigo_prod, nome, preco, quantidadeEstoque, id_marca, id_cat) 
VALUES (7, 'Saia Brim C/ Lycra Moda Evangélica M/G', 29.99, 50, 2, 2);

INSERT INTO trabalho_roupa.produto (codigo_prod, nome, preco, quantidadeEstoque, id_marca, id_cat) 
VALUES (8, 'Calça Moletom Masculina P/M/G', 33.31, 20, 1, 0);

--Fornecimento
INSERT INTO trabalho_roupa.fornecimento (codigo_prod, id_fornecedor) VALUES (0,0);
INSERT INTO trabalho_roupa.fornecimento (codigo_prod, id_fornecedor) VALUES (1,0);
INSERT INTO trabalho_roupa.fornecimento (codigo_prod, id_fornecedor) VALUES (2,0);
INSERT INTO trabalho_roupa.fornecimento (codigo_prod, id_fornecedor) VALUES (3,1);
INSERT INTO trabalho_roupa.fornecimento (codigo_prod, id_fornecedor) VALUES (4,1);
INSERT INTO trabalho_roupa.fornecimento (codigo_prod, id_fornecedor) VALUES (5,1);
INSERT INTO trabalho_roupa.fornecimento (codigo_prod, id_fornecedor) VALUES (6,2);
INSERT INTO trabalho_roupa.fornecimento (codigo_prod, id_fornecedor) VALUES (7,2);
INSERT INTO trabalho_roupa.fornecimento (codigo_prod, id_fornecedor) VALUES (8,2);

--Cupons
INSERT INTO trabalho_roupa.cupom (id_cupom, porcentagemDesconto, dataValidade) 
VALUES (0, 20, '2021-04-25 19:00:00');

INSERT INTO trabalho_roupa.cupom (id_cupom, porcentagemDesconto, dataValidade) 
VALUES (1, 20, '2021-05-25 23:59:00');

INSERT INTO trabalho_roupa.cupom (id_cupom, porcentagemDesconto, dataValidade) 
VALUES (2, 20, '2020-05-25 23:59:00');

INSERT INTO trabalho_roupa.cupom (id_cupom, porcentagemDesconto, dataValidade) 
VALUES (3, 10, '2021-04-20 23:59:00');

--Vendas
INSERT INTO trabalho_roupa.venda (id_venda, id_cupom, dataHora, formaPagamento, codigoNF,id_vendedor, id_cliente) 
VALUES (0,0,'2021-02-24 11:22:00','dinheiro',123,2,1);

INSERT INTO trabalho_roupa.venda (id_venda, dataHora, formaPagamento, codigoNF, id_vendedor, id_cliente) 
VALUES (1,'2021-02-24 09:53:00','cartao',456,3,1);

INSERT INTO trabalho_roupa.venda (id_venda, dataHora, formaPagamento, codigoNF, id_vendedor, id_cliente) 
VALUES (2,'2021-02-25 11:15:00','dinheiro',789,3,2);

--Itens de Venda
INSERT INTO trabalho_roupa.itemVenda (codigo_prod, id_venda, quantidade) VALUES (0, 0, 2);
INSERT INTO trabalho_roupa.itemVenda (codigo_prod, id_venda, quantidade) VALUES (1, 0, 1);
INSERT INTO trabalho_roupa.itemVenda (codigo_prod, id_venda, quantidade) VALUES (2, 1, 2);
INSERT INTO trabalho_roupa.itemVenda (codigo_prod, id_venda, quantidade) VALUES (3, 1, 1);
INSERT INTO trabalho_roupa.itemVenda (codigo_prod, id_venda, quantidade) VALUES (4, 0, 3);
INSERT INTO trabalho_roupa.itemVenda (codigo_prod, id_venda, quantidade) VALUES (1, 2, 1);
INSERT INTO trabalho_roupa.itemVenda (codigo_prod, id_venda, quantidade) VALUES (4, 2, 3);
INSERT INTO trabalho_roupa.itemVenda (codigo_prod, id_venda, quantidade) VALUES (2, 2, 2);

--Loja
INSERT INTO trabalho_roupa.loja (id_loja, cnpj, telefone, nome, logradouro, numero, bairro, CEP, cidade, estado) 
VALUES (0, 66323415000104, 2434567890, 'Legal Roupas','Rua Via Local', 15, 'São Pedro', 36036900, 'Juiz de Fora', 'Minas Gerais')
