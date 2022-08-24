select * from cargo_funcionarios;
select * from clientes;
select * from compras;
select * from funcionarios;
select * from generos;
select * from jogo_compras;
select * from jogos;
select * from tipo_clientes;

/*5 Consultas de utilidade para o contexto*/

/* 1- Quais jogos foram adicionados pelo funcionário de id 4 usando a tabela de jogos e funcionarios*/
select j.jogo_id,j.nome,j.funcionario_id
from jogos j,funcionarios f
where j.funcionario_id = f.funcionario_id and f.funcionario_id = 4;

/* 2 -Quais clientes compraram jogos com classificação indicativa = 18
   usando as tabelas compras,jogos-compra,,clientes,jogos*/

call compradores_por_classificação (18);


/*                            script antigo:


select c.cliente_id,c.nome as nomeCliente,j.nome as nomeDoJogo,j.classificacao_indicativa
from clientes c,compras com,jogo_compras jc,jogos j
where c.cliente_id = com.cliente_id and jc.compra_id = com.compra_id and jc.jogo_id = j.jogo_id
and j.classificacao_indicativa = 18;*/




/*3 - Qual a quantidade de jogos de cada gênero inseridos usando a tabela de jogos e gêneros*/
select count(j.jogo_id) as quantidade,g.genero
from jogos j , generos g
where g.jogo_id = j.jogo_id
group by g.genero;

/*4 - Mostrar o nome dos clientes que realizaram mais de uma  (nome dos clientes,quantidades de compras)
  usando as tabelas clientes,compras*/

select c.nome as nomeCliente,count(comp.compra_id) as quantidadeDeCompras
from clientes c, compras comp
where comp.cliente_id = c.cliente_id
group by c.nome;

/*5 - Quantos funcionarios tem em cada cargo usando as tabelas funcionarios ,e cargos_funcionarios*/
select count(f.funcionario_id) as quantidadeDeFuncionarios,cf.nome_cargo as cargo
from funcionarios f,cargo_funcionarios cf
where cf.cargo_id = f.cargo_id
group by cf.nome_cargo;


/*Uma consulta de utilidade envolvendo o autorrelacionamento (identificada)*/

/* Funcionarios que tem como supervisor um funcionario com id igual a 4 e ordenados pelo nome usando a tabela funcionarios*/
select funcionario_id,nome,supervisor
from funcionarios
where supervisor = 4
order by nome;

/*5 Consultas com utilizando subconsultas de utilidade para o contexto trabalhado (identificada)*/


/* 1- Total arrecadado por cada jogo utilizando as tabelas jogo_compras e jogos*/
select sum(valor),nome
from (select compra_id,jogo_id from jogo_compras) s1,
     (select jogo_id,nome,valor from jogos) s2
where s1.jogo_id = s2.jogo_id group by s1.jogo_id;

/*2- Gastos dos clientes que são premium*/
select sum(total_gasto),s1.nome
from (select cliente_id, nome from clientes
      where tipo_id is not null) s1,(select compra_id, total_gasto, cliente_id from compras) s2
where s1.cliente_id = s2.cliente_id group by s1.cliente_id;

/*3 - Liste todos os jogos do genero terror usando as tabelas clientes, compras,jogos_compras,generos*/
select s2.nome , s1.genero
from (select jogo_id,genero from generos where genero = "terror") s1, (select jogo_id,nome from jogos) s2
where s1.jogo_id = s2.jogo_id;