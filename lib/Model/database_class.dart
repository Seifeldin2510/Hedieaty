import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseClass{
  static Database? _MyDataBase;
  int Version = 1;

  Future<Database?>get MyDataBase async{
    if(_MyDataBase==null)
      {
        _MyDataBase=await initialize();
        return _MyDataBase;
      }
    else{
      return _MyDataBase;
    }

  }

  initialize()async{
    
    String myPath = await getDatabasesPath();
    String path = join(myPath,'myDataBase.db');
    Database mydb = await openDatabase(path,version:Version,
    onCreate: (db,Version)async{
      db.execute('''
      Drop DATABASE myDataBase;
      
      Create Table If Not Exists 'Users'(
      'ID' Integer Not null Primary Key AutoIncrement,
      'Firstname' Text not null,
      'Lastname' Text not null,
      'age' int not null,
      'Email' Text not null,
      'UserName' Text not null,
      'Password' Text not null,
      'Image' Text not null,
      );
      Insert into Users (Firstname,Lastname,age,Email,UsreName,Password,Image)
      values 
      ('Emily','Johnson','28','emily.johnson@x.dummyjson.com','emilys','emilyspass','https://dummyjson.com/icon/emilys/128'),
      ('Michael','Williams','35','michael.williams@x.dummyjson.com','michaelw','michaelwpass','https://dummyjson.com/icon/michaelw/128'),
      ('Sophia', 'Brown', 42, 'sophia.brown@x.dummyjson.com', 'sophiab', 'sophiabpass', 'https://dummyjson.com/icon/sophiab/128'),
      ('James', 'Davis', 45, 'james.davis@x.dummyjson.com', 'jamesd', 'jamesdpass', 'https://dummyjson.com/icon/jamesd/128'),
      ('Emma', 'Miller', 30, 'emma.miller@x.dummyjson.com', 'emmaj', 'emmajpass', 'https://dummyjson.com/icon/emmaj/128'),
      ('Olivia', 'Wilson', 22, 'olivia.wilson@x.dummyjson.com', 'oliviaw', 'oliviawpass', 'https://dummyjson.com/icon/oliviaw/128'),
      ('Alexander', 'Jones', 38, 'alexander.jones@x.dummyjson.com', 'alexanderj', 'alexanderjpass', 'https://dummyjson.com/icon/alexanderj/128'),
      ('Ava', 'Taylor', 27, 'ava.taylor@x.dummyjson.com', 'avat', 'avatpass', 'https://dummyjson.com/icon/avat/128'),
      ('Ethan', 'Martinez', 33, 'ethan.martinez@x.dummyjson.com', 'ethanm', 'ethanmpass', 'https://dummyjson.com/icon/ethanm/128'),
      ('Isabella', 'Anderson', 31, 'isabella.anderson@x.dummyjson.com', 'isabellad', 'isabelladpass', 'https://dummyjson.com/icon/isabellad/128'),
      ('Liam', 'Garcia', 29, 'liam.garcia@x.dummyjson.com', 'liamg', 'liamgpass', 'https://dummyjson.com/icon/liamg/128'),
      ('Mia', 'Rodriguez', 24, 'mia.rodriguez@x.dummyjson.com', 'miar', 'miarpass', 'https://dummyjson.com/icon/miar/128'),
      ('Noah', 'Hernandez', 40, 'noah.hernandez@x.dummyjson.com', 'noahh', 'noahhpass', 'https://dummyjson.com/icon/noahh/128'),
      ('Charlotte', 'Lopez', 36, 'charlotte.lopez@x.dummyjson.com', 'charlottem', 'charlottempass', 'https://dummyjson.com/icon/charlottem/128'),
      ('William', 'Gonzalez', 32, 'william.gonzalez@x.dummyjson.com', 'williamg', 'williamgpass', 'https://dummyjson.com/icon/williamg/128'),
      ('Avery', 'Perez', 25, 'avery.perez@x.dummyjson.com', 'averyp', 'averyppass', 'https://dummyjson.com/icon/averyp/128'),
      ('Evelyn', 'Sanchez', 37, 'evelyn.sanchez@x.dummyjson.com', 'evelyns', 'evelynspass', 'https://dummyjson.com/icon/evelyns/128'),
      ('Logan', 'Torres', 31, 'logan.torres@x.dummyjson.com', 'logant', 'logantpass', 'https://dummyjson.com/icon/logant/128'),
      ('Abigail', 'Rivera', 28, 'abigail.rivera@x.dummyjson.com', 'abigailr', 'abigailrpass', 'https://dummyjson.com/icon/abigailr/128'),
      ('Jackson', 'Evans', 34, 'jackson.evans@x.dummyjson.com', 'jacksone', 'jacksonepass', 'https://dummyjson.com/icon/jacksone/128'),
      ('Madison', 'Collins', 26, 'madison.collins@x.dummyjson.com', 'madisonc', 'madisoncpass', 'https://dummyjson.com/icon/madisonc/128'),
      ('Elijah', 'Stewart', 33, 'elijah.stewart@x.dummyjson.com', 'elijahs', 'elijahspass', 'https://dummyjson.com/icon/elijahs/128'),
      ('Chloe', 'Morales', 39, 'chloe.morales@x.dummyjson.com', 'chloem', 'chloempass', 'https://dummyjson.com/icon/chloem/128'),
      ('Mateo', 'Nguyen', 30, 'mateo.nguyen@x.dummyjson.com', 'mateon', 'mateonpass', 'https://dummyjson.com/icon/mateon/128'),
      ('Harper', 'Kelly', 27, 'harper.kelly@x.dummyjson.com', 'harpere', 'harperepass', 'https://dummyjson.com/icon/harpere/128'),
      ('Evelyn', 'Gonzalez', 35, 'evelyn.gonzalez@x.dummyjson.com', 'evelyng', 'evelyngpass', 'https://dummyjson.com/icon/evelyng/128'),
      ('Daniel', 'Cook', 41, 'daniel.cook@x.dummyjson.com', 'danielc', 'danielcpass', 'https://dummyjson.com/icon/danielc/128'),
      ('Lily', 'Lee', 29, 'lily.lee@x.dummyjson.com', 'lilyb', 'lilybpass', 'https://dummyjson.com/icon/lilyb/128'),
      ('Henry', 'Hill', 38, 'henry.hill@x.dummyjson.com', 'henryh', 'henryhpass', 'https://dummyjson.com/icon/henryh/128'),
      ('Addison', 'Wright', 32, 'addison.wright@x.dummyjson.com', 'addisonw', 'addisonwpass', 'https://dummyjson.com/icon/addisonw/128');
      
      Create Table If not exists 'Events'(
      'ID' Integer not null Primary key autoincrement,
      'Name' Text not null,
      'Description' Text not null,
      'Date' Text not null,
      'Location' Text not null,
      'UserID' Integer not null,
      Foreign key (UserID) reference Users (ID) on delete no action on update no action,
      );
      INSERT INTO Events (Name, Description, Date, Location, UserID)
      VALUES  
      ('Met Gala', 'An exclusive fashion event where attendees often bring appreciation gifts for the host.', '2025-05-05', 'New York', '1'),  
      ('Met Gala', 'An exclusive fashion event where attendees often bring appreciation gifts for the host.', '2024-12-01', 'New York', '1'),  
      ('Royal Ascot Gala', 'A prestigious horse racing event where gifts are traditionally presented to hosts.', '2025-06-18', 'Ascot', '2'),  
      ('Royal Ascot Gala', 'A prestigious horse racing event where gifts are traditionally presented to hosts.', '2025-06-19', 'Ascot', '2'),  
      ('Charity Gala Dinner', 'A high-profile charity event where attendees often gift organizers and philanthropists.', '2025-01-15', 'London', '3'),  
      ('Wedding Anniversary Celebration', 'A luxurious anniversary celebration where guests present personalized gifts.', '2025-03-22', 'Los Angeles', '4'),  
      ('Wedding Anniversary Celebration', 'A luxurious anniversary celebration where guests present personalized gifts.', '2025-09-05', 'Miami', '4'),  
      ('Hollywood Walk of Fame Star Unveiling', 'A celebrity event where gifts are commonly given to honor the recipient.', '2025-07-10', 'Hollywood', '5'),  
      ('Hollywood Walk of Fame Star Unveiling', 'A celebrity event where gifts are commonly given to honor the recipient.', '2025-12-15', 'Hollywood', '5'),  
      ('Corporate Awards Night', 'An event celebrating corporate achievements where gifts are given to organizers and speakers.', '2025-01-20', 'San Francisco', '6'),  
      ('National Book Awards', 'A literary awards ceremony where gifts are given to the organizers and nominees.', '2025-11-15', 'New York', '7'),  
      ('Golden Globe Awards', 'A prestigious awards night where gifts and appreciation tokens are exchanged.', '2025-01-12', 'Beverly Hills', '8'),  
      ('Golden Globe Awards', 'A prestigious awards night where gifts and appreciation tokens are exchanged.', '2025-03-01', 'Beverly Hills', '8'),  
      ('Cultural Heritage Festival', 'A celebration of culture where attendees often present traditional gifts to the hosts.', '2025-09-05', 'Tokyo', '9'),  
      ('Cultural Heritage Festival', 'A celebration of culture where attendees often present traditional gifts to the hosts.', '2025-09-06', 'Kyoto', '9'),  
      ('Philanthropy Recognition Gala', 'An event honoring philanthropists where gifts are often exchanged.', '2025-04-20', 'Dubai', '10'),  
      ('Philanthropy Recognition Gala', 'An event honoring philanthropists where gifts are often exchanged.', '2025-11-20', 'Abu Dhabi', '10'),  
      ('Nobel Prize Ceremony', 'The Nobel ceremony where appreciation gifts are sometimes presented to organizers.', '2025-12-10', 'Stockholm', '11'),  
      ('Graduation Party', 'A celebratory event where attendees present gifts to the graduates and hosts.', '2025-06-30', 'Chicago', '12'),  
      ('Graduation Party', 'A celebratory event where attendees present gifts to the graduates and hosts.', '2025-07-01', 'New York', '12'),  
      ('Luxury Bridal Shower', 'A high-end bridal shower where attendees bring gifts for the bride and organizer.', '2025-03-14', 'Paris', '13'),  
      ('Luxury Bridal Shower', 'A high-end bridal shower where attendees bring gifts for the bride and organizer.', '2025-04-20', 'Paris', '13'),  
      ('Charity Auction Gala', 'A fundraising gala where gifts are given to organizers and donors.', '2025-02-25', 'Monaco', '14'),  
      ('Bar/Bat Mitzvah Celebration', 'A religious milestone event where attendees often present gifts to the hosts.', '2025-11-12', 'Jerusalem', '15'),  
      ('50th Birthday Celebration', 'A milestone birthday party where guests bring gifts for the host.', '2025-04-18', 'Miami', '16'),  
      ('50th Birthday Celebration', 'A milestone birthday party where guests bring gifts for the host.', '2025-07-10', 'Los Angeles', '16'),  
      ('Engagement Party', 'A lavish engagement celebration where guests bring gifts for the couple.', '2025-07-09', 'New York', '17'),  
      ('Christmas Gala Night', 'A holiday-themed gala where gifts are exchanged as a gesture of appreciation.', '2025-12-22', 'Vienna', '18'),  
      ('Diwali Celebration Gala', 'A cultural event where gifts are exchanged during the festival of lights.', '2024-12-15', 'Mumbai', '19'),  
      ('Lunar New Year Gala Dinner', 'A celebration of the Lunar New Year with traditional gifts exchanged.', '2025-02-10', 'Shanghai', '20'),  
      ('Oscar After-Party', 'A star-studded after-party where gifts are given to the hosts and organizers.', '2025-03-25', 'Los Angeles', '21'),  
      ('Oscar After-Party', 'A star-studded after-party where gifts are given to the hosts and organizers.', '2025-04-01', 'Beverly Hills', '21'),  
      ('Luxury Yacht Party', 'An exclusive yacht event where personalized gifts are presented to the hosts.', '2025-07-18', 'Monaco', '22'),  
      ('Luxury Yacht Party', 'An exclusive yacht event where personalized gifts are presented to the hosts.', '2025-08-10', 'Monaco', '22');  
      
      Create Table If not exists 'Gifts'(
      'ID' Integer not null Primary key autoincrement,
      'Title' Text not null,
      'Description' Text not null,
      'Thumbnail' Text not null,
      'Brand' Text not null,
      'Category' Text not null,
      'Price' Double not null,
      'Pledge' Boolean not null,
      'EventId' Integer not null,
      Foreign key (EventId) reference Events (id) on delete no action on update no action,
      );
      INSERT INTO Gifts (Title, Description, Thumbnail, Brand, Category, Price, Pledge, EventId)  
      VALUES  
      ('Essence Mascara Lash Princess', 'The Essence Mascara Lash Princess is a popular mascara known for its volumizing and lengthening effects. Achieve dramatic lashes with this long-lasting and cruelty-free formula.', 'https://cdn.dummyjson.com/products/images/beauty/Essence%20Mascara%20Lash%20Princess/thumbnail.png', 'Essence', 'beauty', '9.99', 'true', '1'),  
      ('Eyeshadow Palette with Mirror', 'The Eyeshadow Palette with Mirror offers a versatile range of eyeshadow shades for creating stunning eye looks. With a built-in mirror, it''s convenient for on-the-go makeup application.', 'https://cdn.dummyjson.com/products/images/beauty/Eyeshadow%20Palette%20with%20Mirror/thumbnail.png', 'Glamour Beauty', 'beauty', '19.99', 'false', '1'),  
      ('Powder Canister', 'The Powder Canister is a finely milled setting powder designed to set makeup and control shine. With a lightweight and translucent formula, it provides a smooth and matte finish.', 'https://cdn.dummyjson.com/products/images/beauty/Powder%20Canister/thumbnail.png', 'Velvet Touch', 'beauty', '14.99', 'true', '1'),  
      ('Red Lipstick', 'The Red Lipstick is a classic and bold choice for adding a pop of color to your lips. With a creamy and pigmented formula, it provides a vibrant and long-lasting finish.', 'https://cdn.dummyjson.com/products/images/beauty/Red%20Lipstick/thumbnail.png', 'Chic Cosmetics', 'beauty', '12.99', 'false', '1'),  
      ('Red Nail Polish', 'The Red Nail Polish offers a rich and glossy red hue for vibrant and polished nails. With a quick-drying formula, it provides a salon-quality finish at home.', 'https://cdn.dummyjson.com/products/images/beauty/Red%20Nail%20Polish/thumbnail.png', 'Nail Couture', 'beauty', '8.99', 'true', '1'),  
      ('Calvin Klein CK One', 'CK One by Calvin Klein is a classic unisex fragrance, known for its fresh and clean scent. It''s a versatile fragrance suitable for everyday wear.', 'https://cdn.dummyjson.com/products/images/fragrances/Calvin%20Klein%20CK%20One/thumbnail.png', 'Calvin Klein', 'fragrances', '49.99', 'true', '1'),  
      ('Chanel Coco Noir Eau De', 'Coco Noir by Chanel is an elegant and mysterious fragrance, featuring notes of grapefruit, rose, and sandalwood. Perfect for evening occasions.', 'https://cdn.dummyjson.com/products/images/fragrances/Chanel%20Coco%20Noir%20Eau%20De/thumbnail.png', 'Chanel', 'fragrances', '129.99', 'false', '1'),  
      ('Dior J''adore', 'J''adore by Dior is a luxurious and floral fragrance, known for its blend of ylang-ylang, rose, and jasmine. It embodies femininity and sophistication.', 'https://cdn.dummyjson.com/products/images/fragrances/Dior%20J\'adore/thumbnail.png', 'Dior', 'fragrances', '89.99', 'true', '1'),  
      ('Dolce Shine Eau de', 'Dolce Shine by Dolce & Gabbana is a vibrant and fruity fragrance, featuring notes of mango, jasmine, and blonde woods. It''s a joyful and youthful scent.', 'https://cdn.dummyjson.com/products/images/fragrances/Dolce%20Shine%20Eau%20de/thumbnail.png', 'Dolce & Gabbana', 'fragrances', '69.99', 'false', '1'),  
      ('Gucci Bloom Eau de', 'Gucci Bloom by Gucci is a floral and captivating fragrance, with notes of tuberose, jasmine, and Rangoon creeper. It''s a modern and romantic scent.', 'https://cdn.dummyjson.com/products/images/fragrances/Gucci%20Bloom%20Eau%20de/thumbnail.png', 'Gucci', 'fragrances', '79.99', 'true', '1'),  
      ('Annibale Colombo Bed', 'The Annibale Colombo Bed is a luxurious and elegant bed frame, crafted with high-quality materials for a comfortable and stylish bedroom.', 'https://cdn.dummyjson.com/products/images/furniture/Annibale%20Colombo%20Bed/thumbnail.png', 'Annibale Colombo', 'furniture', '1899.99', 'true', '1'),  
      ('Annibale Colombo Sofa', 'The Annibale Colombo Sofa is a sophisticated and comfortable seating option, featuring exquisite design and premium upholstery for your living room.', 'https://cdn.dummyjson.com/products/images/furniture/Annibale%20Colombo%20Sofa/thumbnail.png', 'Annibale Colombo', 'furniture', '2499.99', 'false', '1'),  
      ('Bedside Table African Cherry', 'The Bedside Table in African Cherry is a stylish and functional addition to your bedroom, providing convenient storage space and a touch of elegance.', 'https://cdn.dummyjson.com/products/images/furniture/Bedside%20Table%20African%20Cherry/thumbnail.png', 'Furniture Co.', 'furniture', '299.99', 'true', '1'),  
      ('Knoll Saarinen Executive Conference Chair', 'The Knoll Saarinen Executive Conference Chair is a modern and ergonomic chair, perfect for your office or conference room with its timeless design.', 'https://cdn.dummyjson.com/products/images/furniture/Knoll%20Saarinen%20Executive%20Conference%20Chair/thumbnail.png', 'Knoll', 'furniture', '499.99', 'false', '1'),  
      ('Wooden Bathroom Sink With Mirror', 'The Wooden Bathroom Sink with Mirror is a unique and stylish addition to your bathroom, featuring a wooden sink countertop and a matching mirror.', 'https://cdn.dummyjson.com/products/images/furniture/Wooden%20Bathroom%20Sink%20With%20Mirror/thumbnail.png', 'Bath Trends', 'furniture', '799.99', 'true', '1');  
      
      Create Table If not exists 'Friends'(
      'UserId' Integer Refrences Users(ID) not null ,
      'FriendId' Integer Refrences Users(ID) not null ,
      Primary key (UserId,FriendId),
      );
      INSERT INTO Friends (UserId,FriendId)  
      VALUES  
      ('1', '2'),  
      ('1', '3'),  
      ('1', '4'),  
      ('1', '5'),  
      ('2', '3'),  
      ('2', '4'),  
      ('2', '6'),  
      ('2', '7'),  
      ('3', '4'),  
      ('3', '5'),  
      ('3', '6'),  
      ('3', '7'),  
      ('4', '5'),  
      ('4', '6'),  
      ('4', '8'),  
      ('5', '6'),  
      ('5', '7'),  
      ('5', '9'),  
      ('6', '7'),  
      ('6', '8'),  
      ('6', '9'),  
      ('7', '8'),  
      ('7', '9'),  
      ('7', '10'),  
      ('8', '9'),  
      ('8', '10'),  
      ('8', '11'),  
      ('9', '10'),  
      ('9', '11'),  
      ('9', '12'),  
      ('10', '11'),  
      ('10', '12'),  
      ('10', '13'),  
      ('11', '12'),  
      ('11', '13'),  
      ('11', '14'),  
      ('12', '13'),  
      ('12', '14'),  
      ('12', '15'),  
      ('13', '14'),  
      ('13', '15'),  
      ('13', '16'),  
      ('14', '15'),  
      ('14', '16'),  
      ('14', '17'),  
      ('15', '16'),  
      ('15', '17'),  
      ('15', '18'),  
      ('16', '17'),  
      ('16', '18'),  
      ('16', '19'),  
      ('17', '18'),  
      ('17', '19'),  
      ('17', '20'),  
      ('18', '19'),  
      ('18', '20'),  
      ('18', '21'),  
      ('19', '20'),  
      ('19', '21'),  
      ('19', '22'),  
      ('20', '21'),  
      ('20', '22'),  
      ('20', '23'),  
      ('21', '22'),  
      ('21', '23'),  
      ('21', '24'),  
      ('22', '23'),  
      ('22', '24'),  
      ('22', '25'),  
      ('23', '24'),  
      ('23', '25'),  
      ('23', '26'),  
      ('24', '25'),  
      ('24', '26'),  
      ('24', '27'),  
      ('25', '26'),  
      ('25', '27'),  
      ('25', '28'),  
      ('26', '27'),  
      ('26', '28'),  
      ('26', '29'),  
      ('27', '28'),  
      ('27', '29'),  
      ('28', '29');  
    
      ''');
      print("DATABASE HAS BEEN CREATED ........");
    });
    return mydb;

  }

  readData(String SQL)async{
    Database? mydata = await MyDataBase;
    var response = await mydata!.rawQuery(SQL);
    return response;
  }

  insertData(String SQL)async{
    Database? mydata = await MyDataBase;
    int response = await mydata!.rawInsert(SQL);
    return response;

  }


  deleteData(String SQL)async{
    Database? mydata = await MyDataBase;
    int response = await mydata!.rawDelete(SQL);
    return response;

  }

  updateData(String SQL)async{
    Database? mydata = await MyDataBase;
    int response = await mydata!.rawUpdate(SQL);
    return response;

  }


}