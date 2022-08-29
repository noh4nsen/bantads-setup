### Mapeamento das Requisições com seus respectivos payloads

============ Realizando o login
## /login
POST
Objeto enviado BODY: Usuario
{
    email: "teste@mail.com",
    senha: "blabla",
    tipoUsuario: null
}
Objeto recebido: Usuario 200 OK + token (admin) | null 401
{
    id: "uuid",
    email: "teste@mail.com",
    senha: "blabla",
    tipoUsuario: <Gerente | Admin | Cliente>
},
{ token: "uashiuasfiubafuis" }

================== Após login com sucesso o componente correspondente é carregado
================== Com isso outras requisições são disparadas

============ Primeiro disparo - para todos os logins
== Após login, o objeto completo associado com o usuário será buscado
= Todos seguem o mesmo padrão (gerentes retorna Gerente, admins Admin, etc)
## gerentes/getByUsuarioId/:id
GET
Header: token (gerente)
Objeto enviado ROUTE: id (string)
gerentes/getByUsuarioId/ajksdg790asd5
Objeto recebido: Gerente
{
    id: "uuid",
    nome: "",
    cpf: "",
    qtdClientes: 5,
    totalSaldoPositivo: "",
    totalSaldoNegativo: ""
}

============ Área de Admin
== Tela Inicial
## gerentes/getAll - HomeAdminComponent + ModalGerenteComponent (recebe obj Gerente do Home)
GET
Header: token (admin)
Objeto enviado BODY: null
{}
Objeto recebido: Gerente[] 200 OK (se não existir retornar lista vazia, sem erros)
[
    {
        usuario: {
            email: "teste@mail.com",
            senha: "blabla",
            tipoUsuario: Gerente
        },
        id: "uuid",
        nome: "",
        cpf: "",
        qtdClientes: 2,
        totalSaldoPositivo: "",
        totalSaldoNegativo: ""
    },
    {
        usuario: {
            email: "teste@mail.com",
            senha: "blabla",
            tipoUsuario: Gerente
        },
        id: 2,
        nome: "",
        cpf: "",
        qtdClientes: 1,
        totalSaldoPositivo: "",
        totalSaldoNegativo: ""
    }
]

## gerentes/getById/:id - InserirEditarGerenteComponent
GET
Header: token (admin)
Objeto enviado ROUTE: id (uuid)
gerentes/getById/dfs65fsd65fsddfs6
Objeto recebido: Gerente 200 OK | 404
{
    usuario: {
        email: "teste@mail.com",
        senha: "blabla",
        tipoUsuario: Gerente
    },
    id: "uuid",
    nome: "",
    cpf: "",
    qtdClientes: 1,
    totalSaldoPositivo: "",
    totalSaldoNegativo: ""
}

## gerentes/delete/:id - HomeAdminComponent
DELETE
Header: token (admin)
Objeto enviado ROUTE: id (uuid)
gerentes/delete/jksfhsdfj4k5h54
Objeto recebido: null 200 OK | <erro>

== Tela de Edição
## gerentes/update/:id - InserirEditarGerenteComponent
PUT
Header: token (admin)
Objeto enviado BODY: Gerente
{
    usuario: {
        email: "teste@mail.com",
        senha: "",                      // Se senha em branco, não altera
        tipoUsuario: Gerente
    },
    id: "uuid",
    nome: "",
    cpf: "",
    qtdClientes: 1,
    totalSaldoPositivo: "",
    totalSaldoNegativo: ""
}
Objeto recebido: null 200 OK | <erro>

== Tela de Cadastro
## gerentes/create/:id - InserirEditarGerenteComponent
POST
Header: token (admin)
Objeto enviado BODY: Gerente
{
    usuario: {
        email: "teste@mail.com",
        senha: "",
        tipoUsuario: Gerente
    },
    id: null,
    nome: "fulane",
    cpf: ""
}
Objeto recebido: null 200 OK | <erro>

============ Área de Gerente
== Tela Inicial
## clientes/getPendentes - HomeGerenteComponent
GET
Header: token (gerente)
Objeto enviado BODY: null
{}
Objeto recebido: Analise[] 200 OK (se não existir retornar lista vazia, sem erros)
[
    {
        id: "",
        aprovacao: 1,
        motivo: "",
        dataHora: "",
        cliente: { ... },
        gerente: { ... }
    },
    {
        id: "",
        aprovacao: 1,
        motivo: "",
        dataHora: "",
        cliente: { ... },
        gerente: { ... }
    }
]

## clientes/aprovar/:id - HomeGerenteComponent
// TODO rever esse método
PUT (para modificar cliente para aprovado) ==> API gateway/orquestrador já faz criação de conta em seguida, ou front irá mandar separado?
Header: token (gerente)
Objeto enviado ROUTE: idCliente (string)
clientes/aprovar/54d6as54sd
Objeto recebido: null 200 OK | erro

## clientes/reprovar - HomeGerenteComponent
// TODO rever esse método
PUT (para modificar cliente para reprovado) ==> faz algo em seguida?
Header: token (gerente)
Objeto enviado BODY: Analise
{
    id: "",
    aprovacao: 1,
    motivo: "",
    dataHora: "",
    cliente: { ... },
    gerente: { ... }
}
Objeto recebido: null 200 OK | erro

============ Área de Cliente
== Tela Inicial

## /autocadastro
Cliente

Header: token
Objeto enviado: 
{}
Objeto recebido: 