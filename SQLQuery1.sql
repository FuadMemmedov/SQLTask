create database BlogDB

use BlogDB


create table Categories(
Id int primary key identity,
Name nvarchar(50) not null unique



)

create table Tags(
Id int primary key identity,
Name nvarchar(50) not null unique

)

create table Users(
Id int primary key identity,
UserName nvarchar(50) not null unique,
FullName nvarchar(50) not null ,
Age int
Check(Age > 0 and Age < 150)



)





Create table Blogs(
Id int primary key identity,
Title nvarchar(50) not null,
[Description] nvarchar(50) not null,
IsDeleted bit default 0,
UsersId int foreign key references Users(Id),
CategoriesId int foreign key references Categories(Id)




)

Create table Comments(
Id int primary key identity,
Content nvarchar(250) not null,
UsersId int foreign key references Users(Id),
BlogId int foreign key references Blogs(Id)



)




Create table Blogs_Tags(
BlogId int foreign key references Blogs(Id),
TagId int foreign key references Tags(Id),
Primary key (BlogId,TagId)



)









Insert Into Categories (Name)
VALUES ('Texnologiya'), 
         ('Elmi')



Insert Into Users (UserName, FullName, Age)
VALUES ('user1', 'Fuad Memmedov', 19),
       ('user2', 'Zaman Safarov', 19),
       ('user3', 'Sirac Huseynov', 19);

Insert Into Tags (Name)
VALUES ('Programlasdırma'), 
         ('Uzay') 




Insert Into Blogs (Title, Description, UsersId, CategoriesId)
VALUES ('SQL Giris', 'SQL programlasmasının esaslarını oyrenin', 1, 1),
       ('Marsa Sefer', 'Qırmızı planeti araşdırma', 2, 2),
       ('Kodlasdırma ', 'Programlasdırma bacarıglarınızı inkisaf edin', 3, 1);

Insert Into Blogs (Title, Description, UsersId, CategoriesId)
VALUES ('SQL Giris', 'SQL programlasmasının esaslarını oyrenin', 1, 1)
       


Insert Into Blogs_Tags(BlogId, TagId)
VALUES(1,1),
      (2,2),
	  (3,1)


Insert Into Comments (Content, UsersId, BlogId)
VALUES ('Ela yazı!', 2, 1),
       ('Növbeti yazını gözleyirem!', 3, 1),
       ('Maraqlı movzu!', 1, 2);



Create view VW_GetInformation
as
Select B.Title,U.UserName,U.FullName from Blogs B
Join Users U
On B.UsersId = U.Id

Select * From VW_GetInformation



Create view VW_ShowInformation
as
Select B.Title,C.Name from Blogs B
Join Categories C
On B.CategoriesId = C.Id

Select * From VW_ShowInformation




Create proc SP_GetCommentsByUserId @userid int 
as
Begin
Select * from Comments
where @userid = UsersId

End

EXEC SP_GetCommentsByUserId 3

Create proc SP_GetBlogByUserId @userid int 
as
Begin
Select * from Blogs
where @userid = UsersId

End

EXEC SP_GetBlogByUserId 3

Create function UFN_GetBlogsAsTable(@userId int)
Returns Table
as
Return(

Select * from Blogs
Where Blogs.Id = @userId



);




Select* from dbo.UFN_GetBlogsAsTable(1)



Create trigger TRGR_IsDeleted 
on Blogs
Instead of Delete
as
Begin
Declare @id int;
Select @id = Id from deleted;
Update Blogs
Set IsDeleted = 1
where Id = @id
End

Delete from Blogs
where Blogs.Id = 1

Select * from Blogs
