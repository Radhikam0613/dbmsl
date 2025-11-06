use movies_db;

db.Movies_Data.insertMany([
  { Movie_ID: 1, Movie_Name: "Skyfall", Director: "Sam Mendes", Genre: "Action", BoxOfficeCollection: 110000000 },
  { Movie_ID: 2, Movie_Name: "Inception", Director: "Christopher Nolan", Genre: "Sci-Fi", BoxOfficeCollection: 830000000 },
  { Movie_ID: 3, Movie_Name: "Dunkirk", Director: "Christopher Nolan", Genre: "War", BoxOfficeCollection: 525000000 },
  { Movie_ID: 4, Movie_Name: "Top Gun", Director: "Tony Scott", Genre: "Action", BoxOfficeCollection: 350000000 }
]);

-- 1. count of movies per director
-- $sum literally means “add up values.”
-- { $sum: 1 } → adds 1 for each document → counts documents.
-- { $sum: "$field" } → adds up numeric field values.
db.Movies_Data.aggregate([
  { $group: { _id: "$Director", count: { $sum: 1 } } }
]);

-- 2. highest BoxOfficeCollection per Genre (movie doc)
-- -1 for descending order
-- $first: "$$ROOT" picks the first document from each sorted group.
db.Movies_Data.aggregate([
  { $sort: { BoxOfficeCollection: -1 } },
  { $group: { _id: "$Genre", topMovie: { $first: "$$ROOT" } } }
]);

-- 3. highest BoxOfficeCollection per Genre, then ascending order of that top number
-- new field top
-- top 1 means ascending order for top field
db.Movies_Data.aggregate([
  { $group: { _id: "$Genre", top: { $max: "$BoxOfficeCollection" } } },
  { $sort: { top: 1 } }
]);

-- 4. create index Movie_ID
db.Movies_Data.createIndex({ Movie_ID: 1 });

-- 5. compound index Movie_Name + Director
db.Movies_Data.createIndex({ Movie_Name: 1, Director: 1 });

-- 6. drop index by key spec
db.Movies_Data.dropIndex({ Movie_ID: 1 });

-- 7. drop compound index
db.Movies_Data.dropIndex({ Movie_Name: 1, Director: 1 });