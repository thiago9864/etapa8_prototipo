-- Função “func_atualiza_estoque” e trigger “trigger_atualiza_estoque”

CREATE OR REPLACE FUNCTION func_atualiza_estoque()
  RETURNS TRIGGER 
  LANGUAGE PLPGSQL
  AS
$$
DECLARE
qtd_estoque_atual integer;
qtd_anterior integer;
qtd_vendido integer;
qtd_estoque_novo integer;
BEGIN
	IF (TG_OP='UPDATE') THEN
		-- No update existe o old
		qtd_anterior = OLD.quantidade;
	ELSE
		-- No insert não existe, portanto a quantidade anterior é zero
		qtd_anterior = 0;
	END IF;
	
	--Obtém a quantidade de produtos em estoque
	SELECT prod.quantidadeestoque INTO qtd_estoque_atual FROM trabalho_roupa.produto prod WHERE prod.codigo_prod=NEW.codigo_prod;
	
	-- Quantidade do item de venda. Durante uma atualização da quantidade, qtd_vendido é positivo se são adicionados produtos e negativo se são retirados produtos.
	qtd_vendido = NEW.quantidade - qtd_anterior;
	
	-- Calcula a quantidade de itens no estoque do produto
	qtd_estoque_novo = qtd_estoque_atual - qtd_vendido;

	IF qtd_estoque_novo < 5 THEN
		-- Vai violar a restrição
		RAISE EXCEPTION 'Não há estoque disponível para adicionar o produto de código % à venda.', NEW.codigo_prod;
	ELSE
		-- Atualiza a quantidade em estoque do produto indicado
		UPDATE trabalho_roupa.produto prod 
		SET quantidadeestoque = qtd_estoque_novo
		WHERE prod.codigo_prod=NEW.codigo_prod;
	END IF;
	
	RETURN NEW;
END;
$$

CREATE TRIGGER trigger_atualiza_estoque
  BEFORE INSERT OR UPDATE
  ON trabalho_roupa.itemvenda
  FOR EACH ROW
  EXECUTE PROCEDURE func_atualiza_estoque();


-- Função “func_desvincular_caixa” e trigger “trigger_desvincular_caixa”

CREATE OR REPLACE FUNCTION func_desvincular_caixa()
 RETURNS TRIGGER
 LANGUAGE plpgsql
 AS
 $$
 BEGIN
--  os dois status que irei precisar retirar o vínculo com o caixa são 'inativo' e 'desligado', passando o id_caixa para null
-- ocorre apenas quando se atualiza o status do vendedor
 	if NEW.status = 'inativo' then
		UPDATE trabalho_roupa.vendedor vend
		SET id_caixa= null
		where vend.id_vendedor=new.id_func;
		
	elsif new.status = 'desligado' then
		UPDATE trabalho_roupa.vendedor vend
		SET id_caixa=null
		where vend.id_vendedor=new.id_func;
	end if;
	RETURN NEW;
 END;
 $$

CREATE TRIGGER trigger_desvincular_caixa
AFTER UPDATE
ON trabalho_roupa.funcionario
FOR EACH ROW
EXECUTE PROCEDURE func_desvincular_caixa();
  
 -- Teste do trigger
 

 -- Função “func_set_preco_item” e trigger “trigger_set_preco_item”

 CREATE OR REPLACE FUNCTION trabalho_roupa.func_set_preco_item()
  RETURNS TRIGGER 
  LANGUAGE PLPGSQL
  AS
$$
DECLARE
preco_prod numeric(6,2);
BEGIN

	preco_prod = (SELECT prod.preco FROM trabalho_roupa.produto prod WHERE prod.codigo_prod = NEW.codigo_prod);
	
	NEW.preco = preco_prod;
	
	RETURN NEW;
END;
$$


CREATE TRIGGER trigger_set_preco_item
  BEFORE INSERT
  ON trabalho_roupa.itemvenda
  FOR EACH ROW
  EXECUTE PROCEDURE trabalho_roupa.func_set_preco_item();


-- Função “func_valida_cupom” e trigger “trigger_valida_cupom”

CREATE OR REPLACE FUNCTION trabalho_roupa.func_valida_cupom()
  RETURNS TRIGGER 
  LANGUAGE PLPGSQL
  AS
$$
DECLARE
data_val timestamp;
BEGIN
		
	data_val = (SELECT cup.dataValidade FROM trabalho_roupa.cupom cup WHERE cup.id_cupom = NEW.id_cupom);

	IF (data_val < CURRENT_TIMESTAMP) THEN
		RAISE EXCEPTION 'O cupom passou da data de validade.';
	ELSE
		RAISE NOTICE 'O cupom é válido.';
	END IF;

	RETURN NEW;
END;
$$

CREATE TRIGGER trigger_valida_cupom
  BEFORE INSERT OR UPDATE OF id_cupom
  ON trabalho_roupa.venda
  FOR EACH ROW
  WHEN ((NEW.id_cupom IS NOT NULL))
  EXECUTE PROCEDURE trabalho_roupa.func_valida_cupom();


-- Função “func_atualiza_total_itens” e trigger “trigger_atualiza_total_itens”

CREATE OR REPLACE FUNCTION trabalho_roupa.func_atualiza_total_itens()
  RETURNS TRIGGER 
  LANGUAGE PLPGSQL
  AS
$$
DECLARE
calculo_total_itens numeric(6,2);
aux_total numeric(6,2);
idv integer;
BEGIN
	
	IF (TG_OP = 'DELETE') THEN
		aux_total = (SELECT total_itens FROM trabalho_roupa.venda WHERE id_venda = OLD.id_venda);
		calculo_total_itens = aux_total - (OLD.quantidade * OLD.preco);
		
		idv = OLD.id_venda;
	ELSE
		SELECT INTO calculo_total_itens sum(item.quantidade * item.preco)
		FROM trabalho_roupa.itemVenda item, trabalho_roupa.venda vend
		WHERE vend.id_venda = item.id_venda AND vend.id_venda = NEW.id_venda;
		
		idv = NEW.id_venda;
	END IF;
	
	UPDATE trabalho_roupa.venda venda 
	SET total_itens = calculo_total_itens
	WHERE venda.id_venda = idv;
	RETURN NEW;
END;
$$


CREATE TRIGGER trigger_atualiza_total_itens
  AFTER INSERT OR UPDATE OR DELETE
  ON trabalho_roupa.itemvenda
  FOR EACH ROW
  EXECUTE PROCEDURE trabalho_roupa.func_atualiza_total_itens();


-- Função “func_atualiza_total_itens” e trigger “trigger_atualiza_total_itens”


CREATE OR REPLACE FUNCTION trabalho_roupa.func_atualiza_total_itens()
  RETURNS TRIGGER 
  LANGUAGE PLPGSQL
  AS
$$
DECLARE
calculo_total_itens numeric(6,2);
aux_total numeric(6,2);
idv integer;
BEGIN
	
	IF (TG_OP = 'DELETE') THEN
		aux_total = (SELECT total_itens FROM trabalho_roupa.venda WHERE id_venda = OLD.id_venda);
		calculo_total_itens = aux_total - (OLD.quantidade * OLD.preco);
		
		idv = OLD.id_venda;
	ELSE
		SELECT INTO calculo_total_itens sum(item.quantidade * item.preco)
		FROM trabalho_roupa.itemVenda item, trabalho_roupa.venda vend
		WHERE vend.id_venda = item.id_venda AND vend.id_venda = NEW.id_venda;
		
		idv = NEW.id_venda;
	END IF;
	
	UPDATE trabalho_roupa.venda venda 
	SET total_itens = calculo_total_itens
	WHERE venda.id_venda = idv;
	RETURN NEW;
END;
$$


CREATE TRIGGER trigger_atualiza_total_itens
  AFTER INSERT OR UPDATE OR DELETE
  ON trabalho_roupa.itemvenda
  FOR EACH ROW
  EXECUTE PROCEDURE trabalho_roupa.func_atualiza_total_itens();


-- Função “func_atualiza_total_venda” e triggers “trigger_atualiza_total_venda_cup” e “trigger_atualiza_total_venda_it”

CREATE OR REPLACE FUNCTION trabalho_roupa.func_atualiza_total_venda()
  RETURNS TRIGGER 
  LANGUAGE PLPGSQL
  AS
$$
DECLARE
calculo_total_venda numeric(6,2);
valor_pis numeric(6,2);
valor_cofins numeric(6,2);
valor_irpj numeric(6,2);
valor_csll numeric(6,2);
valor_impostos numeric(6,2);
desconto_cupom integer;
BEGIN

	calculo_total_venda = NEW.total_itens;
	
	SELECT INTO desconto_cupom cup.porcentagemDesconto
	FROM trabalho_roupa.venda vend, trabalho_roupa.cupom cup
	WHERE vend.id_cupom = cup.id_cupom AND vend.id_venda = NEW.id_venda;
	
	IF(desconto_cupom IS NOT NULL) THEN	
		calculo_total_venda = calculo_total_venda - (calculo_total_venda * (desconto_cupom/100.0));
	END IF;	
	
	-- PIS (1,65% sobre o total)
	valor_pis = calculo_total_venda * 0.0165;
	-- COFINS (7,6% sobre o total)
	valor_cofins = calculo_total_venda * 0.076;
	-- IRPJ (15% sobre o total)
	valor_irpj = calculo_total_venda * 0.15;
	-- CSLL (9% sobre o total)
	valor_csll = calculo_total_venda * 0.09;

	valor_impostos = valor_pis + valor_cofins + valor_irpj + valor_csll;
	
	UPDATE trabalho_roupa.venda vend 
	SET total_venda = calculo_total_venda, impostoTotal = valor_impostos
	WHERE vend.id_venda = NEW.id_venda;
	RETURN NEW;
END;
$$
  
CREATE TRIGGER trigger_atualiza_total_venda_cup
  AFTER UPDATE OF id_cupom
  ON trabalho_roupa.venda
  FOR EACH ROW
  EXECUTE PROCEDURE trabalho_roupa.func_atualiza_total_venda();

CREATE TRIGGER trigger_atualiza_total_venda_it
  AFTER UPDATE OF total_itens
  ON trabalho_roupa.venda
  FOR EACH ROW
  EXECUTE PROCEDURE trabalho_roupa.func_atualiza_total_venda();


-- Função “func_atualiza_saldo” e trigger “trigger_atualiza_saldo”

CREATE OR REPLACE FUNCTION trabalho_roupa.func_atualiza_saldo()
  RETURNS TRIGGER 
  LANGUAGE PLPGSQL
  AS
$$
DECLARE
total numeric(6,2);
BEGIN
	
	total = NEW.total_venda - OLD.total_venda;

	UPDATE trabalho_roupa.caixa caixa
	SET saldo = saldo + total
	WHERE caixa.id_caixa = (SELECT vend.id_caixa FROM trabalho_roupa.vendedor vend WHERE vend.id_vendedor = NEW.id_vendedor);

	RETURN NEW;
END;
$$

CREATE TRIGGER trigger_atualiza_saldo
  BEFORE UPDATE OF total_venda
  ON trabalho_roupa.venda
  FOR EACH ROW
  EXECUTE PROCEDURE trabalho_roupa.func_atualiza_saldo();
