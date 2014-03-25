drop table Borrower CASCADE CONSTRAINTS;
drop table BorrowerType CASCADE CONSTRAINTS;
drop table Book CASCADE CONSTRAINTS;
drop table HasAuthor;
drop table HasSubject;
drop table BookCopy CASCADE CONSTRAINTS;
drop table HoldRequest;
drop table Borrowing CASCADE CONSTRAINTS;
drop table Fine;

create table BorrowerType
   (type varchar(20) not null,
   bookTimeLimit varchar(20) not null,
   primary key (type));

create table Borrower 
   (bid char(11) not null,
   password char(16) not null, 
   name char(11) not null,
   address varchar(40) null,
   phone int null,
   emailAddress varchar(40) null,
   sinOrStNo char(9) not null,
   expiryDate date not null,
   type varchar(20) not null,
   primary key (bid),
   foreign key (type) references BorrowerType(type) ON DELETE CASCADE);
   
create table Book 
   (callNumber char(20) not null primary key,
   isbn  varchar(13) null,
   title varchar(30) null,
   mainAuthor varchar(40) null,
   publisher varchar(40) null,
   year int);

create table HasAuthor
   (callNumber char(20) not null,
   name varchar(40) not null,
   primary key (callNumber),
   foreign key (callNumber) references Book(callNumber) ON DELETE CASCADE);

create table HasSubject
   (callNumber char(20) not null,
   subject varchar(40) not null);

create table BookCopy
   (callNumber char(20) not null,
   copyNo char(20) not null,
   status varchar(7) null,
   primary key(callNumber, copyNo),
   foreign key (callNumber) references Book(callNumber) ON DELETE CASCADE);

create table HoldRequest
   (hid char(20) not null primary key,
   bid char(11) not null,
   callNumber char(20) not null,
   issuedDate date,
   foreign key (bid) references Borrower(bid) ON DELETE CASCADE,
   foreign key (callNumber) references Book(callNumber) ON DELETE CASCADE);
                         
create table Borrowing
   (borid char(20) not null primary key,
   bid char(11) not null,
   callNumber char(20) not null,
   copyNo char(20) not null,
   outDate date null,
   inDate date null,
   foreign key (bid) references Borrower(bid) ON DELETE CASCADE,
   foreign key (callNumber, copyNo) references BookCopy(callNumber, copyNo) ON DELETE CASCADE);
                       
create table Fine
   (fid char(20) not null primary key,
   amount float,
   issuedDate date,
   paidDate date,
   borid char(20) not null,
   foreign key (borid) references Borrowing(borid) ON DELETE CASCADE);

