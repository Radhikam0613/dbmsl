use social_db;

var docs = [
  { User_Id: 1, User_Name: 'alice', No_of_Posts: 150, No_of_Friends: 3, Friends_List: [2,3,4], Interests: ['coding','music'] },
  { User_Id: 2, User_Name: 'bob', No_of_Posts: 50, No_of_Friends: 2, Friends_List: [1,3], Interests: ['sports'] },
  { User_Id: 3, User_Name: 'carol', No_of_Posts: 250, No_of_Friends: 4, Friends_List: [1,2,4,5], Interests: ['coding','travel'] }
];

db.createCollection("Social_Media")
db.Social_Media.insertMany(docs);

-- 1 list all users nicely
db.Social_Media.find();

-- 2 users with posts > 100
db.Social_Media.find({ No_of_Posts: { $gt: 100 } }  );

-- 3 list the user names and friends_list
-- { User_Name:1, Friends_List:1, _id:0 } tells MongoDB which fields to include or exclude in the result
db.Social_Media.find({}, { User_Name:1, Friends_List:1, _id:0 });

-- 4 ids and friends for users with >5 friends
db.Social_Media.find(
  { $expr: { $gt: [ { $size: "$Friends_List" }, 5] } }, 
  { User_Id: 1, Friends_List: 1, _id: 0 }
);
-- 5 sort by posts desc (-1)
db.Social_Media.find().sort({ No_of_Posts: -1 });