
drop schema trabalho_roupa;
create schema trabalho_roupa;

CREATE TABLE trabalho_roupa.funcionario(
    id_func serial NOT NULL,
    nome varchar(100) NOT NULL UNIQUE,
    cpf varchar(20) NOT NULL UNIQUE,
    telefone varchar(20),
    email varchar(30) NOT NULL,
    senha integer NOT NULL,
    salario numeric(6,2) NOT NULL,
    status varchar(10) DEFAULT 'ativo' NOT NULL
);
ALTER TABLE trabalho_roupa.funcionario ADD CONSTRAINT pk_func PRIMARY KEY(id_func);

CREATE TABLE trabalho_roupa.administrador(
    id_admin serial NOT NULL
);
ALTER TABLE trabalho_roupa.administrador ADD CONSTRAINT pk_admin PRIMARY KEY(id_admin);

CREATE TABLE trabalho_roupa.vendedor(
    id_vendedor serial NOT NULL,
    id_caixa integer
);
ALTER TABLE trabalho_roupa.vendedor ADD CONSTRAINT pk_vendedor PRIMARY KEY(id_vendedor);

CREATE TABLE trabalho_roupa.auxiliar(
    id_auxiliar serial NOT NULL 
);
ALTER TABLE trabalho_roupa.auxiliar ADD CONSTRAINT pk_auxiliar PRIMARY KEY(id_auxiliar);

CREATE TABLE trabalho_roupa.caixa (
    id_caixa serial NOT NULL,
    numero integer, 
    saldo numeric(6,2) DEFAULT 0.00 NOT NULL
);
ALTER TABLE trabalho_roupa.caixa ADD CONSTRAINT pk_caixa PRIMARY KEY(id_caixa);

CREATE TABLE trabalho_roupa.cliente (
    id_cliente serial NOT NULL,
    nome varchar(100),
    cpf varchar(20) NOT NULL UNIQUE
);
ALTER TABLE trabalho_roupa.cliente ADD CONSTRAINT pk_cliente PRIMARY KEY(id_cliente);

CREATE TABLE trabalho_roupa.itemVenda (
    codigo_prod serial NOT NULL,
    id_venda integer NOT NULL,
    quantidade integer NOT NULL, 
    preco numeric(6,2) DEFAULT 0.01 NOT NULL
);
ALTER TABLE trabalho_roupa.itemVenda ADD CONSTRAINT pk_itemVenda PRIMARY KEY(codigo_prod, id_venda);

CREATE TABLE trabalho_roupa.venda (
    id_venda serial NOT NULL,
    dataHora timestamp NOT NULL, 
    formaPagamento varchar(10) DEFAULT 'dinheiro' NOT NULL,
    codigoNF integer NOT NULL UNIQUE,
    impostoTotal numeric(6,2) DEFAULT 0.00 NOT NULL,
    id_cupom integer UNIQUE,
    id_vendedor integer NOT NULL,
    id_cliente integer NOT NULL,
    total_venda numeric(6,2) DEFAULT 0.00 NOT NULL,
    total_itens numeric(6,2) DEFAULT 0.00 NOT NULL
);
ALTER TABLE trabalho_roupa.venda ADD CONSTRAINT pk_venda PRIMARY KEY(id_venda);

CREATE TABLE trabalho_roupa.cupom(
    id_cupom serial NOT NULL,
    porcentagemDesconto integer NOT NULL, 
    dataValidade timestamp NOT NULL
);
ALTER TABLE trabalho_roupa.cupom ADD CONSTRAINT pk_cupom PRIMARY KEY(id_cupom);

CREATE TABLE trabalho_roupa.produto(
    codigo_prod serial NOT NULL, 
    nome varchar(100) NOT NULL, 
    descricao varchar(200), 
    preco numeric(6,2) NOT NULL, 
    quantidadeEstoque integer NOT NULL, 
    id_marca serial NOT NULL, 
    id_cat serial NOT NULL
);
ALTER TABLE trabalho_roupa.produto ADD CONSTRAINT pk_produto PRIMARY KEY(codigo_prod);

CREATE TABLE trabalho_roupa.marca (
    id_marca serial NOT NULL, 
    nome varchar(100) NOT NULL
);
ALTER TABLE trabalho_roupa.marca ADD CONSTRAINT pk_marca PRIMARY KEY(id_marca);

CREATE TABLE trabalho_roupa.categoria (
    id_cat serial NOT NULL, 
    nome varchar(100) NOT NULL
);
ALTER TABLE trabalho_roupa.categoria ADD CONSTRAINT pk_categoria PRIMARY KEY(id_cat);

CREATE TABLE trabalho_roupa.fornecedor(
    id_fornecedor serial NOT NULL, 
    nome varchar(100), 
    cnpj varchar(20) NOT NULL UNIQUE,
    telefone varchar(20)
);
ALTER TABLE trabalho_roupa.fornecedor ADD CONSTRAINT pk_fornecedor PRIMARY KEY(id_fornecedor);

CREATE TABLE trabalho_roupa.fornecimento(
    codigo_prod serial NOT NULL, 
    id_fornecedor serial NOT NULL
);
ALTER TABLE trabalho_roupa.fornecimento ADD CONSTRAINT pk_fornecimento PRIMARY KEY(codigo_prod, id_fornecedor);

CREATE TABLE trabalho_roupa.loja(
    id_loja serial NOT NULL, 
    cnpj varchar(20) NOT NULL UNIQUE, 
    telefone varchar(20), 
    nome varchar(100), 
    logradouro varchar(100), 
    numero integer, 
    bairro varchar(100), 
    cep integer, 
    cidade varchar(100), 
    estado varchar(100)
);
ALTER TABLE trabalho_roupa.loja ADD CONSTRAINT pk_loja PRIMARY KEY(id_loja);


ALTER TABLE trabalho_roupa.funcionario ADD CONSTRAINT ck_salario CHECK (salario >= 1100.00);
ALTER TABLE trabalho_roupa.funcionario ADD CONSTRAINT ck_status CHECK (status IN ('ativo', 'inativo', 'desligado'));
ALTER TABLE trabalho_roupa.administrador ADD FOREIGN KEY(id_admin) REFERENCES trabalho_roupa.funcionario(id_func) ON UPDATE CASCADE;
ALTER TABLE trabalho_roupa.vendedor ADD FOREIGN KEY(id_vendedor) REFERENCES trabalho_roupa.funcionario(id_func) ON UPDATE CASCADE;
ALTER TABLE trabalho_roupa.vendedor ADD FOREIGN KEY(id_caixa) REFERENCES trabalho_roupa.caixa(id_caixa) ON UPDATE CASCADE;
ALTER TABLE trabalho_roupa.auxiliar ADD FOREIGN KEY(id_auxiliar) REFERENCES trabalho_roupa.funcionario(id_func) ON UPDATE CASCADE;
ALTER TABLE trabalho_roupa.caixa ADD CONSTRAINT ck_saldo CHECK (saldo >= 0.00);
ALTER TABLE trabalho_roupa.itemVenda ADD FOREIGN KEY(codigo_prod) REFERENCES trabalho_roupa.produto(codigo_prod) ON UPDATE CASCADE;
ALTER TABLE trabalho_roupa.itemVenda ADD FOREIGN KEY(id_venda) REFERENCES trabalho_roupa.venda(id_venda) ON UPDATE CASCADE;
ALTER TABLE trabalho_roupa.itemVenda ADD CONSTRAINT ck_quantidade CHECK (quantidade >= 1 AND quantidade <= 10);
ALTER TABLE trabalho_roupa.itemVenda ADD CONSTRAINT ck_precoItem CHECK (preco > 0.00);
ALTER TABLE trabalho_roupa.venda ADD FOREIGN KEY(id_cupom) REFERENCES trabalho_roupa.cupom(id_cupom) ON UPDATE CASCADE;
ALTER TABLE trabalho_roupa.venda ADD FOREIGN KEY(id_vendedor) REFERENCES trabalho_roupa.vendedor(id_vendedor) ON UPDATE CASCADE;
ALTER TABLE trabalho_roupa.venda ADD FOREIGN KEY(id_cliente) REFERENCES trabalho_roupa.cliente(id_cliente) ON UPDATE CASCADE;
ALTER TABLE trabalho_roupa.venda ADD CONSTRAINT ck_formaPagamento CHECK (formaPagamento IN ('dinheiro', 'cartao'));
ALTER TABLE trabalho_roupa.venda ADD CONSTRAINT ck_imposto CHECK (impostoTotal >= 0.00);
ALTER TABLE trabalho_roupa.venda ADD CONSTRAINT ck_total CHECK (total_venda >= 0.00);
ALTER TABLE trabalho_roupa.venda ADD CONSTRAINT ck_totalitens CHECK (total_itens >= 0.00);
ALTER TABLE trabalho_roupa.cupom ADD CONSTRAINT ck_porcentagem CHECK (porcentagemDesconto >= 5 AND porcentagemDesconto <= 80);
ALTER TABLE trabalho_roupa.produto ADD FOREIGN KEY(id_marca) REFERENCES trabalho_roupa.marca(id_marca) ON UPDATE CASCADE;
ALTER TABLE trabalho_roupa.produto ADD FOREIGN KEY(id_cat) REFERENCES trabalho_roupa.categoria(id_cat) ON UPDATE CASCADE;
ALTER TABLE trabalho_roupa.produto ADD CONSTRAINT ck_preco CHECK (preco > 0.00);
ALTER TABLE trabalho_roupa.produto ADD CONSTRAINT ck_quantidadeEstoque CHECK (quantidadeEstoque >= 5);
ALTER TABLE trabalho_roupa.fornecimento ADD FOREIGN KEY(codigo_prod) REFERENCES trabalho_roupa.produto(codigo_prod) ON UPDATE CASCADE;
ALTER TABLE trabalho_roupa.fornecimento ADD FOREIGN KEY(id_fornecedor) REFERENCES trabalho_roupa.fornecedor(id_fornecedor) ON UPDATE CASCADE ON DELETE CASCADE;

