create table if not exists asia (
	a text,
	p real
);

insert into asia values ('yes', 0.01);
insert into asia values ('no', 0.99);

create table if not exists tub_asia (
	t text,
	a text,
	p real
);

insert into tub_asia values ('yes', 'yes', 0.05);
insert into tub_asia values ('yes', 'no', 0.01);
insert into tub_asia values ('no', 'yes', 0.95);
insert into tub_asia values ('no', 'no', 0.99);

create table if not exists smoking (
	s text,
	p real
);

insert into smoking values ('yes', 0.33);
insert into smoking values ('no', 0.66);

create table if not exists lung_cancer_smoking (
	l text,
	s text,
	p real
);

insert into lung_cancer_smoking values ('yes', 'yes', 0.10);
insert into lung_cancer_smoking values ('yes', 'no', 0.01);
insert into lung_cancer_smoking values ('no', 'yes', 0.90);
insert into lung_cancer_smoking values ('no', 'no', 0.99);

create table if not exists bronchitis_smoking (
	b text,
	s text,
	p real
);

insert into bronchitis_smoking values ('yes', 'yes', 0.60);
insert into bronchitis_smoking values ('yes', 'no', 0.30);
insert into bronchitis_smoking values ('no', 'yes', 0.40);
insert into bronchitis_smoking values ('no', 'no', 0.70);

create table if not exists either_tub_or_lung_cancer (
	e text,
	l text,
	t text,
	p real
);

insert into either_tub_or_lung_cancer values ('yes', 'yes', 'yes', 1.00);
insert into either_tub_or_lung_cancer values ('yes', 'yes', 'no', 1.00);
insert into either_tub_or_lung_cancer values ('yes', 'no', 'yes', 1.00);
insert into either_tub_or_lung_cancer values ('yes', 'no', 'no', 0);
insert into either_tub_or_lung_cancer values ('no', 'no', 'no', 1.00);
insert into either_tub_or_lung_cancer values ('no', 'no', 'yes', 0.00);
insert into either_tub_or_lung_cancer values ('no', 'yes', 'no', 0.00);
insert into either_tub_or_lung_cancer values ('no', 'yes', 'yes', 0.00);


create table if not exists pos_x_ray (
	x text,
	e text,
	p real
);


insert into pos_x_ray values ('yes', 'yes', 0.98);
insert into pos_x_ray values ('yes', 'no', 0.05);
insert into pos_x_ray values ('no', 'yes', 0.02);
insert into pos_x_ray values ('no', 'no', 0.95);


create table if not exists dyspnoea (
	d text,
	e text,
	b text,
	p real
);

insert into dyspnoea values ('yes', 'yes', 'yes', 0.90);
insert into dyspnoea values ('yes', 'yes', 'no', 0.70);
insert into dyspnoea values ('yes', 'no', 'yes', 0.80);
insert into dyspnoea values ('yes', 'no', 'no', 0.10);
insert into dyspnoea values ('no', 'no', 'no', 0.90);
insert into dyspnoea values ('no', 'no', 'yes', 0.20);
insert into dyspnoea values ('no', 'yes', 'no', 0.30);
insert into dyspnoea values ('no', 'yes', 'yes', 0.10);

-- Explanation : 
-- If you observe the network, you'll notice that calculating the prob of any of the 3 diseases requires information from the whole network. This is unlike the NYU example, where the whole network doesn't need to be involved. This is clear if you think about it. When you take conditional prob into account, you have gotta join that condition with the parent node (this won't appear as a condition in the parent obviously). Anytime you see a conditional table, you have to join on that condition with the parent. In fact, the network gets its shape because of the probability tables and the conditional probability tables. This is according to bayes rule too e.g., P(A, B) = P(A | B) P(B) Now, the questions asked in HW6 only require you to change the observations to yes or no. And you must basically do this for all the three diseases (i.e., change select and group conditions for tub_asia.t, bronchitis_smoking.b and lung_cancer_smoking.l each, in addition to toggling the observations). Thats it! I totally understand bayesian networks, so if you're reading this in the future, think deeply about it, look at the NYU example, watch lectures in wk8 folder, 7-7, 7-8 and 7-9.

-- select tub_asia.t, sum(asia.p * tub_asia.p * either_tub_or_lung_cancer.p * dyspnoea.p * pos_x_ray.p * bronchitis_smoking.p * lung_cancer_smoking.p * smoking.p) from asia, tub_asia, bronchitis_smoking, either_tub_or_lung_cancer, pos_x_ray, dyspnoea, lung_cancer_smoking, smoking where dyspnoea.d='yes' and pos_x_ray.x = 'yes' and tub_asia.a = asia.a and either_tub_or_lung_cancer.l = lung_cancer_smoking.l and either_tub_or_lung_cancer.t = tub_asia.t and bronchitis_smoking.s = smoking.s and lung_cancer_smoking.s = smoking.s and pos_x_ray.e = either_tub_or_lung_cancer.e and dyspnoea.e = either_tub_or_lung_cancer.e and dyspnoea.b = bronchitis_smoking.b group by tub_asia.t;

-- select bronchitis_smoking.b, sum(asia.p * tub_asia.p * either_tub_or_lung_cancer.p * dyspnoea.p * pos_x_ray.p * bronchitis_smoking.p * lung_cancer_smoking.p * smoking.p) from asia, tub_asia, bronchitis_smoking, either_tub_or_lung_cancer, pos_x_ray, dyspnoea, lung_cancer_smoking, smoking where dyspnoea.d='yes' and pos_x_ray.x = 'yes' and tub_asia.a = asia.a and either_tub_or_lung_cancer.l = lung_cancer_smoking.l and either_tub_or_lung_cancer.t = tub_asia.t and bronchitis_smoking.s = smoking.s and lung_cancer_smoking.s = smoking.s and pos_x_ray.e = either_tub_or_lung_cancer.e and dyspnoea.e = either_tub_or_lung_cancer.e and dyspnoea.b = bronchitis_smoking.b group by bronchitis_smoking.b;

-- select lung_cancer_smoking.l, sum(asia.p * tub_asia.p * either_tub_or_lung_cancer.p * dyspnoea.p * pos_x_ray.p * bronchitis_smoking.p * lung_cancer_smoking.p * smoking.p) from asia, tub_asia, bronchitis_smoking, either_tub_or_lung_cancer, pos_x_ray, dyspnoea, lung_cancer_smoking, smoking where dyspnoea.d='yes' and pos_x_ray.x = 'yes' and tub_asia.a = asia.a and either_tub_or_lung_cancer.l = lung_cancer_smoking.l and either_tub_or_lung_cancer.t = tub_asia.t and bronchitis_smoking.s = smoking.s and lung_cancer_smoking.s = smoking.s and pos_x_ray.e = either_tub_or_lung_cancer.e and dyspnoea.e = either_tub_or_lung_cancer.e and dyspnoea.b = bronchitis_smoking.b group by lung_cancer_smoking.l;