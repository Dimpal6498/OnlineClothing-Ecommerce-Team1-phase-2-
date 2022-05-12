create table users(userid serial primary key, user_email varchar(30),first_name varchar(20), last_name varchar(20), user_role varchar(10) ); 

create table contact(userid int, user_address varchar(100), mobile_no varchar(20),foreign key (userid)references users(userid)); 

CREATE EXTENSION pgcrypto; 
  
create table login_details(userid int, password varchar(300),foreign key (userid) references users(userid));  
 

create table categories(categoryid serial primary key, category_gender varchar(10), category_type varchar(10), category_name varchar(20) ); 

create table brands(brandid serial primary key, brand_name varchar(20)); 
 
create table products(productid serial primary key, categoryid int, brandid int, product_name varchar (30), size_quantity json, price int, color varchar (10), discount int default 0, product_image varchar(100), foreign key (categoryid) references  categories(categoryid),foreign key (brandid) references brands(brandid) ); 
 
create table discount( discountid serial primary key, categoryid int, start_date date, start_time time, end_date date, end_time time, discount_percent int, status varchar(10), foreign key (categoryid) references  categories(categoryid)); 
 
create table orders( orderid serial primary key, userid int, date_of_order date, time_of_order time, total_payment int , addressid int, foreign key(addressid) references deliveryaddress(addressid), foreign key (userid)references users (userid)); 
    
create table orderline(orderlineid serial primary key, orderid int, productid int, size char(1),quantity int, price int, foreign key(orderid)references orders (orderid), foreign key (productid)references products(productid)); 

create table deliveryaddress(addressid serial primary key,  addressline varchar(50), street varchar(20), city varchar(20), pincode varchar(10), country varchar(30)); 
 
create table reviews(reviewid serial primary key, userid int, orderid int, productid int, rating int, review varchar(300),  foreign key (userid)references users (userid),foreign key(orderid)references orders (orderid), foreign key (productid)references products(productid)); 

insert into users (user_email,first_name, last_name, user_role)  
values ('dimpalpatil6498@gmail.com','Dimpal','Patil','admin'); 
  
insert into users (user_email,first_name, last_name, user_role)  
values ('nehagprabhu1@gmail.com','Neha','Prabhu','user'); 
  
insert into users (user_email,first_name, last_name, user_role)  
values ('rachelsumner1999@gmail.com','Rachel','Sumner','user'); 
  
select * from users; 
 
insert into contact(userid, user_address, mobile_no)  
values(1,'Yogeshwar Nagar, jalgaon, India','7543789342'), 
(2, 'L. T Road, Mumbai, India','2345678545'), 
(3, 'Wellington Street,Leeds,UK' ,'33443565762' ); 
  
select * from contact 
 
insert into login_details(userid, password) 
values (1, crypt('dimpal', gen_salt('md5'))), 
(2, crypt('neha', gen_salt('md5'))), 
(3, crypt('rachel', gen_salt('md5'))); 
 
 
 
 
INSERT INTO categories 
VALUES (1, 'Men', 'Topwear', 'Shirt'), 
   (2, 'Men', 'Topwear', 'Tshirt'), 
   (3, 'Men', 'Bottomwear', 'Pants'), 
   (4, 'Men', 'Bottomwear', 'Shorts'), 
   (5, 'Women', 'Topwear', 'Shirt'), 
   (6, 'Women', 'Topwear', 'Tshirt'), 
   (7, 'Women', 'Bottomwear', 'Pants'), 
   (8, 'Women', 'Bottomwear', 'Shorts'); 
    
INSERT INTO brands 
VALUES (1, 'ABC'), 
   (2, 'PQR'), 
   (3, 'XYZ'); 
 
  
INSERT INTO products 
VALUES (1, 2, 1, 'Men blue polo shirt', '{"s":10, "m":20, "l":15, "xl":0}', 500, 'blue', 20, 'assets/images/products/img1.jpg'), 
   (2, 5, 2, 'Women formal shirt', '{"s":10, "m":20, "l":10, "xl":10}', 1000, 'white', 0, 'assets/images/products/img4.jpg'), 
(3, 1, 3, 'Men dress shirt', '{"s":12, "m":18, "l":15, "xl":10}', 1000, 'white', 0, 'assets/images/products/img2.jpg'), 
       (4, 3, 1, 'Men blue jeans', '{"s":15, "m":25, "l":10, "xl":10}', 2500, 'blue', 15, 'assets/images/products/img3.jpg'), 
   (5, 4, 3, 'Men black shorts', '{"s":15, "m":15, "l":20, "xl":6}', 1000, 'black', 10, 'assets/images/products/img5.jpg'), 
   (6, 6, 2, 'Women purple tshirt', '{"s":20, "m":10, "l":10, "xl":15}', 900, 'purple', 0, 'assets/images/products/img6.jpg'), 
   (7, 7, 2, 'Women smart trousers', '{"s":25, "m":10, "l":16, "xl":15}', 2000, 'brown', 0, 'assets/images/products/img7.jpg'), 
   (8, 8, 2, 'Women denim shorts', '{"s":10, "m":15, "l":20, "xl":0}', 1500, 'blue', 0, 'assets/images/products/img8.jpg'), 
   (9, 1, 1, 'Men flannel shirt', '{"s":5, "m":10, "l":20, "xl":25}', 800, 'red', 0, 'assets/images/products/img9.jpg'), 
   (10, 6, 2, 'Women cropped tshirt', '{"s":15, "m":20, "l":15, "xl":10}', 500, 'yellow', 0, 'assets/images/products/img10.jpg'); 
 
 
 
insert into orders(userid, date_of_order, time_of_order,total_payment,addressid) 
values (2, DATE'2022-02-16',TIME'12:00:00',2000,1); 
  
insert into orders(userid, date_of_order, time_of_order,total_payment,addressid) 
values (3, DATE'2022-02-23',TIME'11:00:00',400,2); 
  
select * from orders; 
 
 
insert into orderline(orderid, productid,size,quantity,price) 
values(1,2,'s',1,1000); 
  
insert into orderline(orderid, productid,size,quantity,price) 
values(1,1,'m',1,500); 
  
insert into orderline(orderid, productid,size,quantity,price) 
values(1,1,'l',1,500); 
  
insert into orderline(orderid, productid,size,quantity,price) 
values(2,1,'s',1,400); 
 
insert into discount(categoryid,start_date,start_time,end_date, end_time, discount_percent) 
values(1, DATE'2022-02-23',TIME'10:00:00',DATE'2022-02-24',TIME'9:59:59',20), 
 (2, DATE'2022-02-15', TIME'08:00:00', DATE'2022-02-15', TIME'22:00:00', 15), 
(3, DATE'2022-02-27', TIME'10:00:00', DATE'2022-02-27', TIME'22:00:00',10) ;
  
select * from discount; 
 
 
insert into reviews(userid, orderid, productid, rating, review) 
values(1,1,2,4,'The material is of Good quality. Stitching could be better, overall good fit.'), 
(1,1,1,5,'Good Product'); 
 
insert into deliveryaddress 
values(1,'Room No 40','old mumbai road ','Thane','400500','India'), 
 (2,'Room No 55','Nashik road ','Nashik','425001','India'); 
 
 select * from users
 
 alter table products 
 alter column product_image type varchar(1000)

INSERT INTO products 
VALUES (11, 2, 1, 'Men crew neck tshirt', '{"s":10, "m":20, "l":15, "xl":10}', 800, 'yellow', 0, 'https://outoforder.in/wp-content/uploads/2020/03/mens-rich-yellow-t-shirt.jpg'), 
(12, 3, 2, 'Men casual trousers', '{"s":10, "m":20, "l":15, "xl":10}', 750, 'grey', 0, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRxjoZELbLgUhUxvD0Yw7V_hsfpy2DIx_Szfg&usqp=CAU'),
(13, 4, 2, 'Men jeans shorts', '{"s":10, "m":20, "l":15, "xl":10}', 900, 'blue', 0, 'https://images.sportsdirect.com/images/products/64518818_l.jpg'),
(14, 5, 3, 'Women casual shirt', '{"s":10, "m":20, "l":15, "xl":10}', 1000, 'green', 0, 'https://v2backend.v2kart.com/product/1121053983-SEA_GRN/665//1121053983-SEA_GRN_1.JPG'),
(15, 7, 1, 'Women palazzo pants', '{"s":10, "m":20, "l":15, "xl":10}', 500, 'red', 0, 'https://i.pinimg.com/736x/5a/3a/aa/5a3aaa382780457c78ad0efc5a5f8797.jpg'),
(16, 8, 2, 'Women yoga shorts', '{"s":10, "m":20, "l":15, "xl":10}', 750, 'purple', 0, 'https://cdn.shopify.com/s/files/1/1013/4120/products/purple-camo-shorts-natural-waist-back_800x.jpg?v=1591730038')

select * from products