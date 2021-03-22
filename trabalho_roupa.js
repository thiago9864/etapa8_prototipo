

// Menu principal
const btnMenuFuncionario = document.getElementById('btn_func');
const btnMenuCaixa = document.getElementById('btn_caixa');
const btnMenuVenda = document.getElementById('btn_venda');

const telaCadastroFunc = document.getElementById('cadastro_funcionario');
const telaCaixa = document.getElementById('caixa');
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


//Inicialização das telas
telaCadastroFunc.style = 'display: block';
telaCaixa.style = 'display: none';
telaCadastroVenda.style = 'display: none';

//Inicialização do banco de dados
console.log('Iniciando a conexão com o banco de dados...');
window.getPGClient().connect()
.then(res => {
  console.log(res);
  carregaCaixasFormFuncionario();
})
.catch(err => {
  console.error(err);
})

// window.getPGClient().connect((erro) => {
//   console.log(erro);
//     if(erro === null){
//         console.log('Banco conectado');
//         carregaCaixasFormFuncionario();
//     }
//   //
// })
//carregaCaixasFormFuncionario();

// Eventos da interface
btnMenuFuncionario.addEventListener('click', () => {
    telaCadastroFunc.style = 'display: block';
    telaCaixa.style = 'display: none';
    telaCadastroVenda.style = 'display: none';
});

btnMenuCaixa.addEventListener('click', () => {
    telaCadastroFunc.style = 'display: none';
    telaCaixa.style = 'display: block';
    telaCadastroVenda.style = 'display: none';
});

btnMenuVenda.addEventListener('click', () => {
    telaCadastroFunc.style = 'display: none';
    telaCaixa.style = 'display: none';
    telaCadastroVenda.style = 'display: block';
});


//////////////////////// Tela de cadastro de funcionários ////////////////////////

// Carrega dados do caixa
function carregaCaixasFormFuncionario(){
    query = "SELECT * FROM trabalho_roupa.caixa;";
    window.getPGClient()
        .query(query)
        .then(res => {
            console.log(res);
        })
        .catch(err => {
            console.error(err);
        })
        .finally(() => {
            client.end();
        });
}

btnCadastrar.addEventListener('click', () => {
    erros = "";
    if(txtNome.value == ""){
        erros = "Digite o seu nome";
    }
    if(txtCpf.value == "" && erros == ""){
        erros = "Digite o seu CPF";
    }
    if(txtEmail.value == "" && erros == ""){
        erros = "Digite o seu E-mail";
    }
    if(txtSenha.value == "" && erros == ""){
        erros = "Digite a sua senha";
    }
    if(txtSalario.value == "" && erros == ""){
        erros = "Digite o valor do salário";
    }

    if(erros === ""){
        //posso enviar pro banco
        console.log('fazer o insert no banco')
    } else {
        //mostra o erro
        window.alertErro(erros);
    }
});