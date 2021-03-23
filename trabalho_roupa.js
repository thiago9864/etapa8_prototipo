

// Menu principal
const btnMenuFuncionario = document.getElementById('btn_func');
const btnMenuCaixa = document.getElementById('btn_caixa');
const btnMenuRelatorio = document.getElementById('btn_relatorio_vendas');
const btnMenuVenda = document.getElementById('btn_venda');

const telaCadastroFunc = document.getElementById('cadastro_funcionario');
const telaCaixa = document.getElementById('caixa');
const telaRelatorioVendas = document.getElementById('relatorio_vendas');
const telaCadastroVenda = document.getElementById('cadastro_venda');

// Cadastro de Funcionários
const txtNome = document.getElementById('func_nome');
const txtEmail = document.getElementById('func_email');
const txtSalario = document.getElementById('func_salario');
const selectStatus = document.getElementById('func_status');
const selectCaixa = document.getElementById('func_caixa');
const btnCadastrar = document.getElementById('btn_cadastrar');
const txtCpf = document.getElementById('func_cpf');
const txtSenha = document.getElementById('func_senha');
const txtTelefone = document.getElementById('func_telefone');
const selectTipoFuncionario = document.getElementById('func_tipo_funcionario');
const func_div_caixa = document.getElementById('func_div_caixa');

// Lista de caixas 
const tbCaixas = document.getElementById('tabela_caixa');

// Lista do relatorio de vendas 
const tbRelatorioVendas = document.getElementById('tabela_relatorio_vendas');
const selectRelFiltro = document.getElementById('rel_filtro');

// Cadastro de venda
const vend_cliente = document.getElementById('vend_cliente');
const vend_vendedor = document.getElementById('vend_vendedor');
const btn_abrir_venda = document.getElementById('btn_abrir_venda');
const vend_pagamento = document.getElementById('vend_pagamento');
const vend_lista_itens = document.getElementById('vend_lista_itens');
const vend_busca = document.getElementById('vend_busca');
const btn_vend_busca = document.getElementById('btn_vend_busca');
const resultado_busca_prod = document.getElementById('resultado_busca_prod');
const vend_add_produto = document.getElementById('vend_add_produto');
const vend_cod_cupom = document.getElementById('vend_cod_cupom');
const btn_confirma_cupom = document.getElementById('btn_confirma_cupom');
const vend_total = document.getElementById('vend_total');
const vend_impostos = document.getElementById('vend_impostos');

//Inicialização das telas
telaCadastroFunc.style = 'display: block';
telaCaixa.style = 'display: none';
telaRelatorioVendas.style = 'display: none';
telaCadastroVenda.style = 'display: none';

if (window.estaConectado()) {
    console.log('já estava conectado');
    carregaCaixasFormFuncionario();
    carregaListaCaixas();
    carregaClientes();
    carregaVendedores();
    carregaListaRelatorioVendas();
} else {
    window.callbackConexao(() => {
        console.log('chamou o callback');
        carregaCaixasFormFuncionario();
        carregaListaCaixas();
        carregaClientes();
        carregaVendedores();
        carregaListaRelatorioVendas();
    });
}

// Eventos da interface
btnMenuFuncionario.addEventListener('click', () => {
    telaCadastroFunc.style = 'display: block';
    telaCaixa.style = 'display: none';
    telaRelatorioVendas.style = 'display: none';
    telaCadastroVenda.style = 'display: none';
});

btnMenuCaixa.addEventListener('click', () => {
    telaCadastroFunc.style = 'display: none';
    telaCaixa.style = 'display: block';
    telaRelatorioVendas.style = 'display: none';
    telaCadastroVenda.style = 'display: none';
    if (window.estaConectado()) {
        carregaListaCaixas();
    }
});

btnMenuRelatorio.addEventListener('click', () => {
    telaCadastroFunc.style = 'display: none';
    telaCaixa.style = 'display: none';
    telaRelatorioVendas.style = 'display: block';
    telaCadastroVenda.style = 'display: none';
    if (window.estaConectado()) {
        carregaListaRelatorioVendas();
    }
});

btnMenuVenda.addEventListener('click', () => {
    telaCadastroFunc.style = 'display: none';
    telaCaixa.style = 'display: none';
    telaRelatorioVendas.style = 'display: none';
    telaCadastroVenda.style = 'display: block';
});


//////////////////////// Tela de cadastro de funcionários ////////////////////////

// Carrega dados do caixa

function carregaCaixasFormFuncionario() {
    let itensListaCaixa = '';
    console.log('carregaCaixasFormFuncionario')
    client = window.getPGClient()
    query = "SELECT id_caixa, numero FROM trabalho_roupa.caixa;";

    client
        .query(query)
        .then(res => {
            console.log('rows', res.rows);
            for (let i = 0; i < res.rows.length; i++) {
                console.log('row', res.rows[i]);
                itensListaCaixa += `<option value="${res.rows[i].id_caixa}">Número ${res.rows[i].numero}</option>`;
            }
            selectCaixa.innerHTML = itensListaCaixa;
        })
        .catch(err => {
            console.error(err);
        })
        .finally(() => {
            //client.end();
        });

}

btnCadastrar.addEventListener('click', () => {
    erros = "";
    if (txtNome.value == "") {
        erros = "Digite o seu nome";
    }
    if (txtCpf.value == "" && erros == "") {
        erros = "Digite o seu CPF";
    }
    if (txtEmail.value == "" && erros == "") {
        erros = "Digite o seu E-mail";
    }
    if (txtSenha.value == "" && erros == "") {
        erros = "Digite a sua senha";
    }
    if (txtSalario.value == "" && erros == "") {
        erros = "Digite o valor do salário";
    }

    if (erros === "") {
        //posso enviar pro banco
        console.log('fazer o insert no banco')
        console.log('selectCaixa', selectCaixa.value);
        insertFuncionario();
    } else {
        //mostra o erro
        window.alertErro(erros);
    }
});

function onChangeTipoFunc(){
    console.log('Mudou o tipo de funcionario')
    if(selectTipoFuncionario.value === 'vendedor'){
        func_div_caixa.style='display: flex;'
    } else {
        func_div_caixa.style='display: none;'
    }
}

function insertFuncionario() {
    client = window.getPGClient()
    salario = String(txtSalario.value).replace(',', '.');
    query = `INSERT INTO trabalho_roupa.funcionario (nome, cpf, email, senha, salario, telefone, status) 
    VALUES ('${txtNome.value}',${txtCpf.value},'${txtEmail.value}',${txtSenha.value},${salario},'${txtTelefone.value}','${selectStatus.value}');`;
    console.log(query);
    client
        .query(query)
        .then(res => {
            console.log('res', res);
            if (res.rowCount > 0) {
                console.log('Funcionario inserido');
                insereEspecializacao()
            }
        })
        .catch(err => {
            console.error(err);
        })
        .finally(() => {
            //client.end();
        });
}

function insereEspecializacao() {
    client = window.getPGClient();

    if (selectTipoFuncionario.value === 'vendedor') {
        aux = `INSERT INTO trabalho_roupa.vendedor (id_vendedor, id_caixa) VALUES (aux_id_func, ${selectCaixa.value});`;
    }
    if (selectTipoFuncionario.value === 'administrador') {
        aux = `INSERT INTO trabalho_roupa.administrador (id_admin) VALUES (aux_id_func);`;
    }
    if (selectTipoFuncionario.value === 'auxiliar') {
        aux = `INSERT INTO trabalho_roupa.auxiliar (id_auxiliar) VALUES (aux_id_func);`;
    }

    query = `DO $$
    DECLARE aux_id_func integer;
    BEGIN
    SELECT id_func INTO aux_id_func FROM trabalho_roupa.funcionario ORDER BY id_func DESC LIMIT 1;
    ${aux}
    END $$;`;

    client
        .query(query)
        .then(res => {
            console.log('res', res);
            if (res.rowCount > 0) {
                console.log('Especialização do funcionario inserida');
            }
        })
        .catch(err => {
            console.error(err);
        })
        .finally(() => {
            //client.end();
        });
}


//////////////////////// Tela de listagem do caixa ////////////////////////


function carregaListaCaixas() {
    let itensListaCaixa = `
    <tr>
        <th>Número</th>
        <th>Saldo</th>
        <th>Nome do Vendedor</th>
    </tr>
    `;
    client = window.getPGClient()
    query = `SELECT  func.nome, cvend.numero as numero_caixa, cvend.saldo  
    FROM
             trabalho_roupa.funcionario func,
             (trabalho_roupa.caixa caixa RIGHT JOIN trabalho_roupa.vendedor vend on caixa.id_caixa = vend.id_caixa) as cvend
    WHERE  func.id_func = cvend.id_vendedor`;

    client
        .query(query)
        .then(res => {
            console.log('rows', res.rows);
            for (let i = 0; i < res.rows.length; i++) {
                console.log('row', res.rows[i]);

                num_caixa = 'Indisponível';
                if (res.rows[i].numero_caixa) {
                    num_caixa = String(res.rows[i].numero_caixa);
                }

                saldo_caixa = 'Indisponível';
                if (res.rows[i].saldo) {
                    saldo_caixa = `R$ ${String(res.rows[i].saldo).replace('.', ',')}`;
                }

                itensListaCaixa += `

                <tr>
                    <td>${num_caixa}</td>
                    <td>${saldo_caixa}</td>
                    <td>${res.rows[i].nome}</td>
                </tr>
                `;
            }
            tbCaixas.innerHTML = itensListaCaixa;
        })
        .catch(err => {
            console.error(err);
        })
        .finally(() => {
            //client.end();
        });

}

//////////////////////// Tela do relatorio de vendas ////////////////////////


function carregaListaRelatorioVendas(data_inicio='', data_fim='') {
    let itensListaVendas = `
    <tr>
        <th>Nome do Vendedor</th>
        <th>Data da Venda</th>
        <th>Forma de Pagamento</th>
        <th>Código da NF</th>
        <th>Total em impostos</th>
        <th>Total da Venda</th>
        <th>Código do Cupom</th>
    </tr>
    `;
    client = window.getPGClient()

    query_filtro = '';
    if(data_inicio != '' && data_fim !=''){
        query_filtro = `AND vend.datahora BETWEEN DATE('${data_inicio}') AND DATE('${data_fim}')`;
    }
    
    query = `
    SELECT vend.id_venda, func.nome, vend.datahora, vend.formapagamento, vend.codigonf, vend.impostototal, vend.total_venda, vend.id_cupom 
    FROM trabalho_roupa.venda vend, trabalho_roupa.funcionario func
    WHERE func.id_func=vend.id_vendedor ${query_filtro} ORDER BY vend.datahora DESC;
    `;

    console.log(query);

    client
        .query(query)
        .then(res => {
            console.log('rows', res.rows);
            for (let i = 0; i < res.rows.length; i++) {
                //console.log('row', res.rows[i]);

                cod_cupom = 'Indisponível';
                if (res.rows[i].id_cupom) {
                    cod_cupom = String(res.rows[i].id_cupom);
                }

                total_impostos = `R$ ${String(res.rows[i].impostototal).replace('.', ',')}`;
                total_venda = `R$ ${String(res.rows[i].total_venda).replace('.', ',')}`;

                itensListaVendas += `
                <tr>
                    <td>${res.rows[i].nome}</td>
                    <td>${formatarData(res.rows[i].datahora)}</td>
                    <td>${res.rows[i].formapagamento}</td>
                    <td>${res.rows[i].codigonf}</td>
                    <td>${total_impostos}</td>
                    <td>${total_venda}</td>
                    <td>${cod_cupom}</td>
                </tr>
                `;
            }
            tbRelatorioVendas.innerHTML = itensListaVendas;
        })
        .catch(err => {
            console.error(err);
        })

}
function formatarData(data_entrada) {
    var data = new Date(data_entrada),
        dia = data.getDate().toString().padStart(2, '0'),
        mes = (data.getMonth() + 1).toString().padStart(2, '0'), //+1 pois no getMonth Janeiro começa com zero.
        ano = data.getFullYear(),
        hora = data.getHours().toString().padStart(2, '0'),
        minuto = data.getMinutes().toString().padStart(2, '0'),
        segundo = data.getSeconds().toString().padStart(2, '0');
    return `${dia}/${mes}/${ano} ${hora}:${minuto}:${segundo}`;
}
function mudarFiltroRelatorio(){
    let data_ini='';
    let data_fim='';

    var data = new Date(),
    dia = data.getDate().toString().padStart(2, '0'),
    mes = (data.getMonth() + 1).toString().padStart(2, '0'), //+1 pois no getMonth Janeiro começa com zero.
    ano = data.getFullYear();

    if(selectRelFiltro.value === 'ultimo_ano'){
        data_ini = `${ano-1}-${mes}-${dia} 00:00:00`;
        data_fim = `${ano}-${mes}-${dia} 23:59:59`;
    } else if(selectRelFiltro.value === 'ultimos_30_dias'){
        data_ini = formatarData(subtraiDiasDataAtual(30)).substr(0,10) + ' 00:00:00';
        data_fim = dataAtualFormatada().substr(0,10) + ' 23:59:59';
    } else if(selectRelFiltro.value === 'ultima_semana'){
        data_ini = formatarData(subtraiDiasDataAtual(7)).substr(0,10)  + ' 00:00:00';
        data_fim = dataAtualFormatada().substr(0,10) + ' 23:59:59';
    }

    carregaListaRelatorioVendas(data_ini, data_fim);
}
function subtraiDiasDataAtual(dias){
    var dateOffset = (24*60*60*1000) * dias;
    var myDate = new Date();
    myDate.setTime(myDate.getTime() - dateOffset);
    return myDate;
}

//////////////////////// Tela de cadastro de vendas ////////////////////////


function carregaClientes() {
    let itensListaCliente = '';
    console.log('carregaClientes')
    client = window.getPGClient()
    query = "SELECT id_cliente, nome FROM trabalho_roupa.cliente;";

    client
        .query(query)
        .then(res => {
            console.log('rows', res.rows);
            for (let i = 0; i < res.rows.length; i++) {
                console.log('row', res.rows[i]);
                itensListaCliente += `<option value="${res.rows[i].id_cliente}">${res.rows[i].nome}</option>`;
            }
            vend_cliente.innerHTML = itensListaCliente;
        })
        .catch(err => {
            console.error(err);
        })
        .finally(() => {
            //client.end();
        });

}

function carregaVendedores() {
    let itensListaVendedores = '';
    console.log('carregaVendedores')
    client = window.getPGClient()
    query = `
    SELECT id_vendedor, nome
    FROM trabalho_roupa.vendedor vend, trabalho_roupa.funcionario func
    WHERE id_caixa IS NOT NULL AND func.id_func = vend.id_vendedor;
    `;

    client
        .query(query)
        .then(res => {
            console.log('rows', res.rows);
            for (let i = 0; i < res.rows.length; i++) {
                console.log('row', res.rows[i]);
                itensListaVendedores += `<option value="${res.rows[i].id_vendedor}">${res.rows[i].nome}</option>`;
            }
            vend_vendedor.innerHTML = itensListaVendedores;
        })
        .catch(err => {
            console.error(err);
        })
        .finally(() => {
            //client.end();
        });

}

function dataAtualFormatada() {
    var data = new Date(),
        dia = data.getDate().toString().padStart(2, '0'),
        mes = (data.getMonth() + 1).toString().padStart(2, '0'), //+1 pois no getMonth Janeiro começa com zero.
        ano = data.getFullYear();
    hora = data.getHours();
    minuto = data.getMinutes();
    segundo = data.getSeconds();
    return `${ano}-${mes}-${dia} ${hora}:${minuto}:${segundo}`;
}
let id_venda = -1;

btn_abrir_venda.addEventListener('click', () => {
    client = window.getPGClient()
    numero_nf = parseInt(new Date().getTime() / 10000);
    query = `
    INSERT INTO trabalho_roupa.venda (dataHora, formaPagamento, codigoNF, id_vendedor, id_cliente) 
    VALUES ('${dataAtualFormatada()}','${vend_pagamento.value}',${numero_nf},${vend_vendedor.value},${vend_cliente.value});
    SELECT id_venda FROM trabalho_roupa.venda ORDER BY id_venda DESC LIMIT 1;
    `;

    console.log(query)

    client
        .query(query)
        .then(res => {
            console.log('res', res[1]);
            if (res[1].rows.length > 0) {
                id_venda = res[1].rows[0].id_venda;
                console.log('Venda criada com o id:', id_venda);
            }

        })
        .catch(err => {
            console.error(err);
        })
        .finally(() => {
            //client.end();
        });
});

let lista_produtos = [];
let codigo_prod_selecionado = -1;
btn_vend_busca.addEventListener('click', () => {
    client = window.getPGClient()
    numero_nf = parseInt(new Date().getTime() / 10000);
    query = `
    SELECT codigo_prod, nome FROM trabalho_roupa.produto WHERE LOWER(nome) LIKE '%${vend_busca.value}%';
    `;

    console.log(query)
    lista_produtos = [];
    client
        .query(query)
        .then(res => {
            console.log('rows', res.rows);
            for (let i = 0; i < res.rows.length; i++) {
                console.log('row', res.rows[i]);
                lista_produtos.push({
                    codigo_prod: res.rows[i].codigo_prod,
                    nome: res.rows[i].nome,
                    selecionado: i == 0
                });
            }
            codigo_prod_selecionado = lista_produtos[0].codigo_prod;
            atualizaListaNoHTML();
        })
        .catch(err => {
            console.error(err);
        })
});


function atualizaListaNoHTML() {
    let itensListaProdutos = '';
    for (let i = 0; i < lista_produtos.length; i++) {
        itensListaProdutos += `
        <div 
        class="item_busca_prod ${lista_produtos[i].selecionado ? 'item_sel' : ''}" 
        onclick="selecionaProd(${lista_produtos[i].codigo_prod});">${lista_produtos[i].nome}</div>
        `
    }
    resultado_busca_prod.innerHTML = itensListaProdutos;
}
atualizaListaNoHTML();

function selecionaProd(codigo_prod) {
    console.log('codigo_prod', codigo_prod);
    codigo_prod_selecionado = codigo_prod;
    for (let i = 0; i < lista_produtos.length; i++) {
        if (lista_produtos[i].codigo_prod === codigo_prod) {
            //Esse é o produto que foi clicado
            lista_produtos[i].selecionado = true;
        } else {
            lista_produtos[i].selecionado = false;
        }
    }
    atualizaListaNoHTML();
}

vend_add_produto.addEventListener('click', () => {
    if (codigo_prod_selecionado == -1) {
        console.log('Selecione um produto');
    } else if (id_venda == -1) {
        console.log('Primeiro você deve criar a venda');
    } else {
        client = window.getPGClient()
        query = `
        INSERT INTO trabalho_roupa.itemVenda (codigo_prod, id_venda, quantidade) VALUES (${codigo_prod_selecionado}, ${id_venda}, 1);
        `;
        console.log(query)
        client
            .query(query)
            .then(res => {
                if (res.rowCount > 0) {
                    console.log('ItemVenda inserido');
                    carregaItensVenda()
                }
            })
            .catch(err => {
                console.error(err);
            })
    }
});

function carregaItensVenda() {
    if (id_venda != -1) {
        client = window.getPGClient()
        query = `
        SELECT item.codigo_prod, prod.nome, item.quantidade, item.preco 
        FROM trabalho_roupa.itemVenda item, trabalho_roupa.produto prod
        WHERE prod.codigo_prod=item.codigo_prod AND item.id_venda=${id_venda};
        `;
        console.log(query)
        client
            .query(query)
            .then(res => {
                let itensVenda = '';
                console.log('rows', res.rows);
                for (let i = 0; i < res.rows.length; i++) {
                    let row = res.rows[i];
                    preco_unitario = `R$ ${String(res.rows[i].preco).replace('.', ',')}`;

                    itensVenda += `
                    <div class="item_venda">
                        <div style="flex-direction: column;">
                            <span style="font-weight: bold;">${row.nome}</span>
                            <div style="flex-direction: row;">
                                <span>Quantidade:</span>
                                <input id="item_qtd_${i}" type="text" class="item_venda_input" value="${row.quantidade}">
                                <button 
                                    type="button" 
                                    class="btn_atualizar inline_button" 
                                    onclick="atualizaQuantidade(${row.codigo_prod}, document.getElementById('item_qtd_${i}').value)">Atualizar</button>
                            </div>
                            <span>Preço unitário: ${preco_unitario}</span>
                        </div>
                        <button 
                            type="button" 
                            class="botao_apaga_item"
                            onclick="apagarItem(${row.codigo_prod})">X</button>
                    </div>
                    `
                }
                vend_lista_itens.innerHTML = itensVenda;
            })
            .catch(err => {
                console.error(err);
            })

        query = `
        SELECT total_venda, impostototal FROM trabalho_roupa.venda WHERE id_venda=${id_venda};
        `;
        console.log(query)
        client
            .query(query)
            .then(res => {
                console.log('rows', res.rows);
                if (res.rows.length > 0) {
                    vend_total.innerHTML = `R$ ${String(res.rows[0].total_venda).replace('.', ',')}`;
                    vend_impostos.innerHTML = `* Impostos: R$ ${String(res.rows[0].impostototal).replace('.', ',')}`;
                }
            })
            .catch(err => {
                console.error(err);
            })
    }
}
carregaItensVenda();

function atualizaQuantidade(codigo_prod, quantidade) {
    if(quantidade <= 0){
        console.error('A quantidade de produtos deve ser positiva e maior que zero');
    } else if (id_venda != -1) {
        client = window.getPGClient()
        console.log('Atualizar produto', codigo_prod, 'com a quantidade', quantidade);

        query = `
        UPDATE trabalho_roupa.itemVenda 
        SET quantidade=${quantidade}
        WHERE codigo_prod=${codigo_prod} AND id_venda=${id_venda};
        `;
        console.log(query)
        client
            .query(query)
            .then(res => {
                if (res.rowCount > 0) {
                    console.log('ItemVenda atualizado');
                    carregaItensVenda()
                } else {
                    console.log('Nada foi alterado');
                }
            })
            .catch(err => {
                console.error(err);
            });
    }

}

function apagarItem(codigo_prod){
    if (id_venda != -1) {
        client = window.getPGClient()
        console.log('Excluir produto', codigo_prod, 'da lista de itens');

        query = `
        DELETE FROM trabalho_roupa.itemVenda
        WHERE codigo_prod=${codigo_prod} AND id_venda=${id_venda};
        `;
        console.log(query);
        client
            .query(query)
            .then(res => {
                if (res.rowCount > 0) {
                    console.log('ItemVenda excluido');
                    carregaItensVenda()
                } else {
                    console.log('Nada foi excluido');
                }
            })
            .catch(err => {
                console.error(err);
            });
    }
}

btn_confirma_cupom.addEventListener('click', () => {
    let codigo_cupom = vend_cod_cupom.value;
    if (id_venda != -1) {
        client = window.getPGClient()
        console.log('Atualizar venda', id_venda, 'com o cupom', codigo_cupom);
        
        if(codigo_cupom === '' || codigo_cupom===undefined){
            codigo_cupom = 'null';
        }

        query = `
        UPDATE trabalho_roupa.venda 
        SET id_cupom=${codigo_cupom}
        WHERE id_venda=${id_venda};
        `;
        console.log(query)
        client
            .query(query)
            .then(res => {
                if (res.rowCount > 0) {
                    console.log('Cupom válido inserido na venda');
                    carregaItensVenda();
                } else {
                    console.log('Nada foi alterado');
                }
            })
            .catch(err => {
                console.error(err);
                if(String(err).indexOf('venda_id_cupom_key') > -1){
                    //violou a restrição 'venda_id_cupom_key'
                    console.log('Cupom já usado em outra venda.');
                }
                if(String(err).indexOf('O cupom passou da data de validade') > -1){
                    //violou a restrição 'venda_id_cupom_key'
                    console.log('O cupom passou da data de validade.');
                }
            });
    }
});
