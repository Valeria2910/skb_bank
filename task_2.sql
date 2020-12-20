DROP TABLE IF EXISTS Characteristics_of_buying_good;

DROP TABLE IF EXISTS Characteristics_of_clients_parameter;

CREATE TABLE Characteristics_of_clients_parameter (
    ID_CLIENT int auto_increment,
    AGE INT(3),
    GENDER VARCHAR (10),
    PRIMARY KEY (ID_CLIENT)
);

INSERT Characteristics_of_clients_parameter (AGE, GENDER)
VALUES
(20, "F"),
(25, "M"),
(30, "M"),
(42, "F");

CREATE TABLE Characteristics_of_buying_good (
    ID_CLIENT int,
    ID_GOODS int,
    TIME TIME DEFAULT "00:00",
    FOREIGN KEY (ID_CLIENT) REFERENCES Characteristics_of_clients_parameter(ID_CLIENT)
);

INSERT Characteristics_of_buying_good (ID_CLIENT, ID_GOODS, TIME)
VALUES
(1, 124, "14:51"),
(1, 126, "14:52"),
(1, 123, "14:53"),
(1, 126, "14:54"),
(1, 122, "14:55"),
(3, 651, "10:00");

/* Задание 2.1 */

SELECT GENDER, ID_GOODS FROM Characteristics_of_clients_parameter cl
JOIN Characteristics_of_buying_good g ON cl.ID_CLIENT = g.ID_CLIENT
GROUP BY ID_GOODS;

/* Задание 2.2 */

SELECT * FROM Characteristics_of_buying_good as t_1
WHERE (ID_CLIENT < 10 OR ID_CLIENT > 100) AND time > "15:00";

-- По поводу ошибки: ошибка была в очередности исполнения логических операторов — сначала выполняется 
-- оператор AND, затем OR. Чтобы не менять условие поставила скобки для приоритета оператора OR.

/* Задание 2.3 */

SELECT cl.ID_CLIENT, COUNT(g.ID_CLIENT) AS GOODS_NUMBER 
FROM characteristics_of_clients_parameter AS cl
LEFT JOIN Characteristics_of_buying_good AS g ON cl.ID_CLIENT = g.ID_CLIENT
GROUP BY cl.ID_CLIENT;