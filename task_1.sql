drop table if exists operations;
drop table if exists contracts;
drop table if exists clients;

Create table clients(
    CLIENT_ID int auto_increment,
    NAME varchar(30) not null default "",
    primary key (CLIENT_ID)
);
insert clients (NAME)
values
("ООО Рога и копыта"),
("ЗАО Ромашка"),
("ООО Василек");

Create table contracts(
    D_ID int auto_increment,
    CLIENT_ID INT not null,
    D_NUMBER varchar(30) not null default "",
    primary key (D_ID),
    INDEX (CLIENT_ID),
    FOREIGN KEY (CLIENT_ID) REFERENCES clients(CLIENT_ID)
);

insert contracts (CLIENT_ID, D_NUMBER)
values
(1, "216/789"),
(1, "2016/987"),
(1, "2016/1234"),
(2, "2005/11"),
(2, "205/555"),
(2, "2006/333"),
(3, "555/666"),
(3, "666/111"),
(3, "33/8889");

Create table operations(
    OP_ID int auto_increment,
    D_ID INT not null,
    DT DATE not null,
    SUMM varchar(30) not null default "",
    primary key (OP_ID),
    INDEX (D_ID),
    FOREIGN KEY (D_ID) REFERENCES contracts (D_ID)
);

insert operations (D_ID, DT, SUMM)
values
(1, "2016-08-31", 800),
(1, "2016-08-21", 50),
(2, "2016-05-25", 100),
(3, "2016-08-21", 200),
(6, "2016-06-12", 300),
(7, "2016-07-02", 400),
(7, "2016-06-02", 500),
(9, "2016-05-23", 600);


/*Задание 1.1*/

SELECT NAME, D_NUMBER, DT, SUMM FROM clients 
JOIN contracts ON clients.CLIENT_ID = contracts.CLIENT_ID
JOIN operations ON operations.D_ID = contracts. D_ID;

/*Задание 1.2*/

SELECT NAME, Date_format(DT, "%Y-%m-%d") as max_date FROM clients
JOIN contracts ON clients.CLIENT_ID = contracts.CLIENT_ID
JOIN operations ON operations.D_ID = contracts.D_ID
WHERE (select max(DT) from operations) = DT
GROUP BY NAME;

/*Задание 1.3*/

SELECT D_NUMBER FROM contracts
WHERE NOT EXISTS (SELECT D_ID FROM operations WHERE operations.D_ID = contracts.D_ID);