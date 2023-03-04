-- Tasarımını yaptığınız tabloları oluşturan sql ifadeleri buraya yazınız.
-- veri tiplerine, nullable olma durumuna, default değerine ve tablolar arası foreign key kullanımına dikkat.
create table urun(
	urunid int auto_increment primary key,
    isim varchar(50) not null,
    reyonid int not null,
    adet int default 20,
    fiyat float not null
);

create table indirim(
	id int primary key,
    oran float not null,
    indvarmı boolean default true
);

create table reyon(
	id int auto_increment primary key,
    isim varchar(50) not null unique key
);

create table tedarik(
	id int primary key,
    durumid int not null,
    tedarikciid int not null,
    miktar int not null,
    urunid int not null
);

create table durum(
	id int auto_increment primary key,
    durum varchar(50) not null unique key
);

create table tedarikci(
	id int auto_increment primary key,
    firma varchar(100) not null unique key,
    il varchar(50) not null,
    ilce varchar(50) not null
);

create table calisan(
	id int auto_increment primary key,
    isim varchar(30) not null,
    soyisim varchar(30) not null,
    reyonid int not null,
    bastarih datetime not null,
    maas int not null
);

create table ayinelemani(
	id int auto_increment primary key,
    yil year not null,
    ay varchar(20) not null,
    calisanid int not null
);

alter table indirim add foreign key (id) references urun(urunid)
on update cascade on delete cascade;
alter table urun add foreign key (reyonid) references reyon(id)
on update cascade on delete cascade;
alter table tedarik add foreign key (urunid) references urun(urunid)
on update cascade on delete cascade;
alter table tedarik add foreign key (durumid) references durum(id)
on update cascade on delete cascade;
alter table tedarik add foreign key (tedarikciid) references tedarikci(id)
on update cascade on delete cascade;
alter table calisan add foreign key (reyonid) references reyon(id)
on update cascade on delete cascade;
alter table ayinelemani add foreign key (calisanid) references calisan(id)
on update cascade on delete cascade;

insert into reyon (isim) values ("Kasap"), ("Kasa"), ("Sebze"), ("Temizlik");
select * from reyon;

insert into durum (durum) values ("Yolda"), ("Hazırlanıyor"), ("Kaza Oldu"), ("Tamamlandı");
select * from durum;

insert into tedarikci (firma, il, ilce) values 
("Karambar", "Manisa", "Akhisar"), ("Kasap Nuri", "İstanbul", "Fatih"), ("Kabzıman", "İstanbul", "Bayrampaşa");
select * from tedarikci;

insert into urun (isim, reyonid, adet, fiyat) values 
("Sut",1,152,14.99),
("Et",2,485,254.49),
("Helva",3,148,12.99);
insert into urun (isim, reyonid, fiyat) values ("Sut",1,14.99);
select * from urun;

insert into indirim (id,oran) values (3,14.0);
select * from indirim;

insert into tedarik (id,durumid,tedarikciid,miktar,urunid) values (147,1,1,150,1);
select * from tedarik;

select tk.id,d.durum,tc.firma,u.isim from tedarik as tk 
left join durum as d on tk.durumid=d.id 
left join tedarikci as tc on tk.tedarikciid=tc.id
left join urun as u on tk.urunid=u.urunid;

insert into calisan (isim, soyisim, reyonid, bastarih, maas) 
values ("Kenan","AKSOY",1,"9999-12-31 23:59:59",1331);
select * from calisan;

insert into ayinelemani (yil, ay, calisanid) 
values ("1998", "Şubat",1);
select * from ayinelemani;
