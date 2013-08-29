-- check HW6 Helper : Bayesian Net Example in evernote

create table if not exists a (
	a text,
	p real
);

insert into a values ('yes', 0.30);
insert into a values ('no', 0.70);

create table if not exists b (
	b text,
	p real
);

insert into b values ('yes', 0.6);
insert into b values ('no', 0.4);

create table if not exists c_and_a (
	c text,
	a text,
	p real
);


insert into c_and_a values ('yes', 'yes', 0.80);
insert into c_and_a values ('yes', 'no', 0.40);
insert into c_and_a values ('no', 'yes', 0.20);
insert into c_and_a values ('no', 'no', 0.60);

create table if not exists d_and_a_and_b (
	d text,
	a text,
	b text,
	p real
);

insert into d_and_a_and_b values ('yes', 'yes', 'yes', 0.70);
insert into d_and_a_and_b values ('yes', 'yes', 'no', 0.80);
insert into d_and_a_and_b values ('yes', 'no', 'yes', 0.10);
insert into d_and_a_and_b values ('yes', 'no', 'no', 0.20);
insert into d_and_a_and_b values ('no', 'no', 'no', 0.80);
insert into d_and_a_and_b values ('no', 'no', 'yes', 0.90);
insert into d_and_a_and_b values ('no', 'yes', 'no', 0.20);
insert into d_and_a_and_b values ('no', 'yes', 'yes', 0.30);


create table if not exists e_and_c (
	e text,
	c text,
	p real
);


insert into e_and_c values ('yes', 'yes', 0.7);
insert into e_and_c values ('yes', 'no', 0.2);
insert into e_and_c values ('no', 'yes', 0.3);
insert into e_and_c values ('no', 'no', 0.8);

-- select d_and_a_and_b.d, sum(d_and_a_and_b.p * a.p * b.p) from d_and_a_and_b, a, b where d_and_a_and_b.a = a.a and d_and_a_and_b.b = b.b group by d_and_a_and_b.d;

-- select d_and_a_and_b.d, sum(a.p * b.p * c_and_a.p * d_and_a_and_b.p) from a, b, c_and_a, d_and_a_and_b where c_and_a.c = 'yes' and a.a = c_and_a.a and d_and_a_and_b.a = a.a and d_and_a_and_b.b = b.b group by d_and_a_and_b.d;

-- select a.a, sum(a.p * c_and_a.p) from a, c_and_a where c_and_a.c = 'yes' and a.a = c_and_a.a group by a.a;

-- select a.a, sum(a.p * b.p * d_and_a_and_b.p) from a, b, d_and_a_and_b where d_and_a_and_b.d = 'no' and d_and_a_and_b.a = a.a and d_and_a_and_b.b = b.b group by a.a;