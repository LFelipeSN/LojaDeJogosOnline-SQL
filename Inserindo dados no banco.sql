select * from cargo_funcionarios;
select * from clientes;
select * from compras;
select * from funcionarios;
select * from generos;
select * from jogos;
select * from tipo_clientes;
select * from jogo_compras;


/* inserindo na tabela cargo_funcionario*/
insert into cargo_funcionarios (cargo_id, nome_cargo, salario)
values (1, "empregado", 1200.00),
(2,"supervisor", 2200.00);

/*inserindo na tabela tipo_clientes*/
insert into tipo_clientes values (1, "Universitario", 8),
(2, "Patrocinador", 12),
(3, "funcionario", 4),
(4, "recorrente" , 3),
(5, "influencer" , 3.5);


/* inserindo na tabela cliente*/
insert into clientes values(1, "064.002.750-45", "Carolina Laura", "carolina-fogaca83@evolink.com.br", '2010-05-11', "Cidade Universitária", "rua do pinhares", 557, null),
(2, "715.682.710-34", "Benedito Noah", "benedito_peixoto@fingrs.com.br", '1990-09-11', "Plano Diretor Norte", "Rua dos Orixás", 175, 5),
(3, "414.237.350-13", "Bernardo Breno", "bernardo_daluz@centrovias.com.br", '2001-07-14',"Sol e Mar" , "Rua Vinte e Quatro" , 674 , 5),
(4, "303.059.360-69", "Julia Silvana", "julia.silvana.daconceicao@usa.com", '1988-06-18', "Conjunto Ouricurí", "Rua Avestruz", 921, 2),
(5, "508.161.310-07", "Priscila Mariah", "priscilamariahvieira@retrosfessa.com.br", '2004-04-19', "Coqueiro", "Travessa F", 525, 4);


/* inserindo na tabela compra*/
insert into compras values(1, 90.00, '2022-02-10',3),/* soma dos jogos tem que dar esse valor*/
(2, 200.00, '2021-07-20', 2),
(3, 140.00, '2022-12-25', 5),
(4, 150.00, '2022-09-15', 1),
(5, 50.00, '2022-11-02', 4),
(6, 20.00, '2021-12-27', 3);/* tem que botar no relacionamento jogo-compra*/

/*inserindo na tabela funcionarios*/
insert into funcionarios values (1, "001.162.519-80", "Tiago Tomás", 14852, "Guará I", "Quadra QI 10 Bloco E" , 801, null, null),
(2, "300.648.158-54", "Isabelly Evelyn", 87841, "Piranema", "Rua Jordelina Meireles", 307, null, null),
(3, "407.204.443-14", "Eduardo Manoel", 64528, "Rota do Sol", "Avenida Machadinho", 535, null, null),
(4, "109.840.902-74", "Ana Bruna", 96745, "Conjunto José Abrão", "Rua Ernesto de Fiori", 445, null, null),
(5, "981.822.335-77", "Augusto Guilherme", 13548, "Jardim Universitária", "Rua Bancário Antônio Macau",573, null, null);

/*inserindo supervisor e cargo*/
update funcionarios set supervisor = 4, cargo_id = 1 where not funcionario_id = 4 ;
update funcionarios set cargo_id = 2 where funcionario_id = 4;


/*inserindo na tabela jogos*/
insert into jogos values (1, "The simlaber", "Um jogador","Curta o poder de criar e controlar pessoas num mundo virtual", 50.00, "12", 30, 4),
(2, "STrain - simulador de train", "Um jogador", "Domine locomotivas icônicas em serviços de alta velocidade", 100.00, "Livre", 11, 3),
(3, "Dia x", "CO-OP", "Um mundo pós-apocalíptico,Uma terra arrasada por zumbis infectados", 90.00, "18", 52, 4),
(4, "A floresta", "um jogador", "Você se encontra em uma floresta misteriosa lutando para se manter vivo contra canibais", 200.00, "18", 23, 2),
(5, "Cs Out : a ofensiva","multijogador", "É um jogo online de tiro em primeira pessoa que proporciona uma experiencia real", 20.00, "16", 68, 4);


/*inserindo na tabela generos*/   
insert into generos values (1,4,"Terror"),
(1,3,"Terror"),
(2,4,"RPG"),
(3,3,"Sobrevivencia"),
(4,4,"Estratégia"),
(5,1,"Simulação"),
(5,2,"Simulação"),
(6,5,"FPS");


/*inserindo na tabela jogo_compras*/
insert into jogo_compras values(4,2),(6,5),(2,4),(4,1),
(3,3),(5,1),(3,1),(1,3);