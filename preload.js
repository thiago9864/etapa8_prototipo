// Importação da biblioteca de conexão do Postgre
const { Client } = require('pg');
const path = require("path");
//var electron = require("electron");
//const { dialog } = require('electron')

window.alertErro = function (mensagem){
  console.log(mensagem)
  //electron.remote.dialog.showErrorBox('Trabalho Roupa', mensagem);
}

const pgClient = new Client({
  user: 'aluno@ufjf.br',
  host: '200.131.219.35',
  database: 'turma2020_03',
  password: 'aluno123',
  port: 58081,
});

// const pgClient = new Client({
//   user: 'thiago',
//   host: 'localhost',
//   database: 'trabalho_roupa',
//   password: '987654',
//   port: 3306,
// });

//teste
// var mysql      = require('mysql');
// var connection = mysql.createConnection({
//   host     : 'localhost',
//   user     : 'time',
//   password : '123456',
//   database : 'trabalho_roupa'
// });

window.getPGClient = function(){
  return pgClient;
}


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