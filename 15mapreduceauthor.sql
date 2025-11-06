use library_db;
db.createCollection("Book")
db.Book.insertMany([{ Title: 'MongoDB Basics', Author_name: 'John Doe', Borrowed_status: true, price: 450 }, { Title: 'JS Guide', Author_name: 'Jane Roe', Borrowed_status: false, price: 250 }, { Title: 'Advanced DB', Author_name: 'John Doe', Borrowed_status: true, price: 350 },{ Title: 'Networks', Author_name: 'Zack Lee', Borrowed_status: false, price: 320 }]);

-- 1 Author wise list of books
-- Emits a key-value pair where key = author, value = book title
var mapA = function() { 
  emit(this.Author_name, this.Title); 
};
-- Returns an array of all titles for that author.
var reduceA = function(k, vals) { 
  return vals; 
};
db.Book.mapReduce(mapA, reduceA, { out: { inline: 1 } });

-- 2  Author wise list of books having Borrowed status as “True”
var mapB = function() { 
  if(this.Borrowed_status === true) 
    emit(this.Author_name, this.Title); 
};
db.Book.mapReduce(mapB, reduceA, { out: { inline: 1 } });

-- 3 Author wise list of books having price greater than 300
var mapC = function() { 
  if(this.price > 300) 
    emit(this.Author_name, this.Title); 
};
db.Book.mapReduce(mapC, reduceA, { out: { inline: 1 } });

-- whats there to sort from
-- [
--  { "_id" : "John Doe", "value" : ["MongoDB Basics", "Advanced DB"] },
--  { "_id" : "Jane Roe", "value" : ["JS Guide", "Python 101"] },
--  { "_id" : "Zack Lee", "value" : ["Networks"] }
-- ]