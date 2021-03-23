// Importação da biblioteca de conexão do Postgre
const { Client } = require('pg');
const path = require("path");
//var electron = require("electron");
//const { dialog } = require('electron')

window.alertErro = function (mensagem) {
    console.log(mensagem)
    //electron.remote.dialog.showErrorBox('Trabalho Roupa', mensagem);
}

const pgClient = new Client({
    user: 'postgres',
    host: 'localhost',
    database: 'turma2020_03',
    password: '12345678',
    port: 5432,
});

//Inicialização do banco de dados

console.log('Iniciando a conexão com o banco de dados...');
let isConnected = false;
let callbackConexao = null;
pgClient.connect(err => {
    if (err) {
        console.error('connection error', err.stack);
    } else {
        console.log('connected');
        isConnected = true;
        if (callbackConexao) {
            callbackConexao();
        }
    }
})

window.callbackConexao = function (funcao) {
    callbackConexao = funcao;
}
window.estaConectado = function () {
    return isConnected;
}
window.getPGClient = function () {
    return pgClient;
}
/*
window.executaQuery = function (query, success, error) {
    console.log('executaQuery',query);
    const pgClient = new Client({
        user: 'postgres',
        host: 'localhost',
        database: 'turma2020_03',
        password: '12345678',
        port: 5432,
    });
    pgClient.connect(err => {
        if (err) {
            console.error('connection error', err.stack);
        } else {
            console.log('connected');
            pgClient
                .query(query)
                .then(success)
                .catch(error)
                .finally(() => {
                    pgClient.end();
                });
        }
    });
}
*/
/*
window.addEventListener('DOMContentLoaded', () => {
    const replaceText = (selector, text) => {
      const element = document.getElementById(selector)
      if (element) element.innerText = text
    }

    for (const type of ['chrome', 'node', 'electron']) {
      replaceText(`${type}-version`, process.versions[type])
    }
})
*/