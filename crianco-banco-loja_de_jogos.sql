/*Criando banco / schema Loja de jogos*/
create database loja_de_jogos CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_ci';

/*selecionar e usar esse esquema para criarmos os objetos*/
use loja_de_jogos;

/*Criando tabela cargos dos funcionarios onde fica os salarios*/
create table cargo_funcionarios(
    cargo_id int not null unique ,
    nome_cargo varchar(30) not null ,
    salario double not null check ( salario > 0 ),
    constraint pk_cargo primary key (cargo_id)
);

/*Criando a tabela funcionario convenção : nomes de tabelas no plural e nome d ecolunas no singular*/
create table funcionarios(
    /*funcionario_id int , SUBSTITUIR COD FUNCIONARIO POR FUNCIONARIO ID?*/
    funcionario_id  int not null unique,
    cpf varchar(14) not null,
    nome varchar(50) not null,
    matricula int,
    bairro varchar(20),
    rua varchar(30),
    numero int,
    supervisor int,
    cargo_id int,/*sera a chave estrangeira funcionario-cargo*/
    /*criando uma constraint chave primaria da tabela funcionario que se chama pk_funcionario*/
    constraint pk_funcionario primary key (funcionario_id )
);

/*Adicionado a chave primaria cargo em */
alter table funcionarios add constraint fk_cargo foreign key (cargo_id) references cargo_funcionarios(cargo_id);

/*adicionar a referencia funcionario - funcionario supervisionar*/
alter table funcionarios add constraint fk_supervisor foreign key (supervisor) references funcionarios(funcionario_id);

/*Criando a tabela jogos*/
create table jogos(
    jogo_id int not null unique,
    nome varchar(50) not null ,
    categoria varchar(20),
    descricao varchar(100),
    valor double,
    classificacao_indicativa varchar(10),
    quantidade_em_estoque int,
    funcionario_id int,  /*sera a chave estrangeira funcionario-jogo*/
    constraint pk_jogo primary key (jogo_id) /*chave primaria do jogo*/
);

/*adicionar a referencia funcionario - jogo */
alter table jogos add constraint fk_funcionario_jogo foreign key (funcionario_id) references funcionarios(funcionario_id);

/*Criando a tabela genero-jogo*/
create table generos(
    genero_id int not null,
    jogo_id int, /*chave estrangeira referente a jogo e também parte da chave primaria*/
    genero varchar(50),
    constraint pk_genero primary key (genero_id,jogo_id) /*chave primaria do genero*/
);

/*adicionar a referencia jogo-genero*/
alter table generos add constraint fk_jogo_genero foreign key (jogo_id) references jogos(jogo_id);

/*Criando a tabela tipo de clientes*/
create table tipo_clientes(
    tipo_id int not null unique ,
    nome varchar(50),
    desconto int,
    constraint pk_tipo_clientes primary key (tipo_id)
);

/*Criando a tabela clientes*/
create table clientes(
    cliente_id int not null unique ,
    cpf varchar(14) not null,
    nome varchar(50) not null ,
    email varchar(50),
    data_de_nascimento date,
    bairro varchar(20),
    rua varchar(30),
    numero int,
    tipo_id int,/*sera a chave estrangeira tipo-cliente*/
    constraint pk_cliente primary key (cliente_id)
);
/*adicionando a chave estrangeira tipo-cliente*/
alter table clientes add constraint fk_cliente_tipo foreign key (tipo_id) references tipo_clientes(tipo_id);

/*Criando tabela compra*/
create table compras(
    compra_id int not null unique ,
    total_gasto double,
    data_compra date, /* ano/mes/dia */
    cliente_id int, /*sera a chave estrangeira cliente-compra*/
    constraint pk_compra primary key (compra_id) /*chave primaria do compra*/
);
/*adicionando a referencia cliente compra */
alter table compras add  constraint  fk_cliente_compra foreign key (cliente_id ) references clientes(cliente_id);

/*Criando tabela jogo-compras*/
create table jogo_compras(
    compra_id int, /*chave estrangeira referente a compra e também parte da chave primaria*/
    jogo_id int ,  /*chave estrangeira referente a jogo e também parte da chave primaria*/
    constraint  pk_jogo_compra primary key (compra_id,jogo_id)
);
alter table jogo_compras add  constraint  fk_jogo_compra_compras foreign key (compra_id ) references compras(compra_id);
alter table jogo_compras add constraint  fk_jogo_compras foreign key (jogo_id) references jogos(jogo_id);


/*criando a procedure de procurar clientes que compraram jogo de determinada classificacao:*/   
delimiter //

drop procedure if exists compradores_por_classificação;

create procedure compradores_por_classificação (idade int)
begin
	select cli.cliente_id, cli.nome as nome_do_cliente, jogo.nome as nome_do_jogo, jogo.classificacao_indicativa from 
    (select cliente_id, nome from clientes ) cli,  
    (select compra_id, cliente_id from compras ) com, 
    (select compra_id, jogo_id from jogo_compras) jogoC, 
    (select jogo_id, nome, classificacao_indicativa from jogos) jogo 
    where cli.cliente_id = com.cliente_id and jogoC.compra_id = com.compra_id and jogoC.jogo_id = jogo.jogo_id
	and jogo.classificacao_indicativa = idade;

end //

delimiter ;



/*criando gatilho para coluna total de gastos da tabela compra atualizando após o insert*/ 
delimiter $$

drop trigger if exists total_de_gastos;

create trigger total_de_gastos after insert on jogo_compras
for each row begin 
declare colun double; 
	
set colun = (select sum(jogos.valor) from compras 
inner join jogo_compras on compras.compra_id = jogo_compras.compra_id 
inner join jogos on jogos.jogo_id = jogo_compras.jogo_id
where compras.compra_id = new.compra_id 
group by compras.compra_id);	

update compras set total_gasto = colun where compra_id = new.compra_id;    

end $$

delimiter ;


/*trigger para atualizar após o delete*/

delimiter $$

drop trigger if exists delete_total_de_gastos;

create trigger delete_total_de_gastos after delete on jogo_compras
for each row begin 
declare colun double; 
	
set colun = (select sum(jogos.valor) from compras 
inner join jogo_compras on compras.compra_id = jogo_compras.compra_id 
inner join jogos on jogos.jogo_id = jogo_compras.jogo_id
where compras.compra_id = old.compra_id 
group by compras.compra_id);	

update compras set total_gasto = colun where compra_id = old.compra_id;    

end $$

delimiter ;