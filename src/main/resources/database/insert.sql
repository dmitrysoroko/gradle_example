use jobs;

INSERT INTO diplom.role VALUES (0,'ROLE_ADMIN','Админ');
INSERT INTO diplom.role VALUES (0,'ROLE_EMPLOYEE','Соискатель');
INSERT INTO diplom.role VALUES (0,'ROLE_EMPLOYER','Работодатель');

INSERT INTO diplom.user VALUES (0,1,NULL,'dima','1234');
INSERT INTO diplom.user VALUES (0,2,NULL,'nikita','1111');
INSERT INTO diplom.user VALUES (0,3,NULL,'andrey','1111');

INSERT INTO diplom.employee VALUES (0,2,'Никита', 'Александрович', 'Сороко');

INSERT INTO diplom.employer VALUES (0,3,'Intel','bla');