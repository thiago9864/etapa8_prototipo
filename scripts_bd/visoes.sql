-- Visão 1: “Administrador/ possibilitar a visualização das funções de cada funcionário”

create or replace view trabalho_roupa.adm_info_func(id_func,nome,status,administrador,
				     vendedor, caixa_responsavel, auxiliar)
as 
select func.id_func, func.nome, func.status,(CASE WHEN func.id_func = ad.id_admin THEN true ELSE false END)::boolean,
	   (CASE WHEN func.id_func = vend.id_vendedor THEN true ELSE false END)::boolean,
	   (CASE WHEN func.id_func = vend.id_vendedor THEN vend.id_caixa ELSE null END)::integer,
	   (CASE WHEN func.id_func = aux.id_auxiliar THEN true ELSE false END)::boolean
FROM trabalho_roupa.funcionario as func,
	 trabalho_roupa.administrador as ad,
	 trabalho_roupa.vendedor as vend,
	 trabalho_roupa.auxiliar as aux
where func.id_func=id_vendedor or func.id_func=ad.id_admin or func.id_func=aux.id_auxiliar
group by func.id_func,(CASE WHEN func.id_func = ad.id_admin THEN true ELSE false END)::boolean,
	   (CASE WHEN func.id_func = vend.id_vendedor THEN true ELSE false END)::boolean,
	   (CASE WHEN func.id_func = vend.id_vendedor THEN vend.id_caixa ELSE null END)::integer,
	   (CASE WHEN func.id_func = aux.id_auxiliar THEN true ELSE false END)::boolean
order by func.nome;

-- Visão 2: “Administrador/ possibilitar a visualização de quais caixas não têm responsáveis”

create or replace view trabalho_roupa.caixa_sem_responsavel(caixa_vazio)
as
select ca.numero
from trabalho_roupa.vendedor as vend,
	 trabalho_roupa.caixa as ca
where vend.id_caixa not in(ca.id_caixa)
group by ca.numero;


-- Visão 3: “Cliente/ lista de produtos”

create or replace view trabalho_roupa.lista_produtos(nome,descricao,preco,marca,categoria)
as 
select prod.nome,prod.descricao,prod.preco,ma.nome,cat.nome
from trabalho_roupa.produto as prod,
     trabalho_roupa.marca as ma,
     trabalho_roupa.categoria as cat
where prod.quantidadeEstoque>=5 and prod.id_marca=ma.id_marca and prod.id_cat=cat.id_cat;


-- Visão 4: “Administrador/ entrar em contato com fornecedor”
create or replace view trabalho_roupa.entrar_contato_forn(nome_produto,
														 quantidade_estoque,
														 categoria_prod,
														 marca_prod,
														 nome_fornecedor,
														 cnpj,telefone)
as
select prod.nome,prod.quantidadeEstoque,cat.nome,ma.nome,forn.nome,forn.cnpj,forn.telefone
from trabalho_roupa.produto prod,
	 trabalho_roupa.categoria cat,
	 trabalho_roupa.marca ma,
	 trabalho_roupa.fornecedor forn,
	 trabalho_roupa.fornecimento fornecimento
where prod.quantidadeEstoque<=5 and prod.id_marca=ma.id_marca and
	  prod.id_cat=cat.id_cat and prod.codigo_prod=fornecimento.codigo_prod
	  and fornecimento.id_fornecedor=forn.id_fornecedor
order by prod.nome;


-- Visão 5: “Administrador/ Caixas”

select ca.numero,ca.saldo, func.nome
from trabalho_roupa.caixa as ca,
	 trabalho_roupa.vendedor as vend,
	 trabalho_roupa.funcionario as func
where ca.id_caixa=vend.id_caixa and func.id_func=vend.id_vendedor
order by ca.numero;

select *
from trabalho_roupa.mostra_caixa;
