use college_db;
db.createCollection("Student")
db.Student.insertMany([{ Student_ID: 1, Student_Name: 'Arya', Department: 'CS', Marks: 85 },{ Student_ID: 2, Student_Name: 'Boman', Department: 'IT', Marks: 78 },{ Student_ID: 3, Student_Name: 'Caira', Department: 'CS', Marks: 92 },  { Student_ID: 4, Student_Name: 'Dev', Department: 'ME', Marks: 70 }, { Student_ID: 5, Student_Name: 'Eve', Department: 'EC', Marks: 88 }, { Student_ID: 6, Student_Name: 'Frank', Department: 'CS', Marks: 95 }, { Student_ID: 7, Student_Name: 'Grace', Department: 'CS', Marks: 82 }]);

-- 1 avg marks per department
      -- pushes names into an array
      -- computes average
db.Student.aggregate([
  {$group: { _id: "$Department",  Students: { $push: "$Student_Name" }, 
                                  AvgMarks: { $avg: "$Marks" }
    }
  }
])
-- ans format
-- {
--    "_id": "CS",
--    "Students": ["Alice", "Charlie", "Frank"],
--    "AvgMarks": 90.66666666666667
--  }

-- 2 number of students per department
-- $sum: 1 counts the number of documents (students) per group
db.Student.aggregate([
  {$group: { _id: "$Department", Total_Students: { $sum: 1 }}}])

-- { "_id": "CS", "Total_Students": 3 },

-- 3 top student per department
-- student with highest marks in each department appears first in that department’s “bucket”
db.Student.aggregate( [
  {$sort: { Department: 1, Marks: -1 }},
  {$group: {_id: "$Department",
            Top_Student: { $first: "$Student_Name" },
            Marks: { $first: "$Marks" }
    }
  } , { $sort: { Marks: -1 } }
] )
-- | _id | Top_Student | Marks |
-- | CS  | Frank       | 95    |
-- | IT  | Bob         | 90    |
-- | EC  | Eve         | 88    |

-- 4 create index Student_ID
db.Student_Data.createIndex({ Student_ID: 1 });

-- 5 compound index Student_Name + Department
db.Student_Data.createIndex({ Student_Name: 1, Department: 1 });

-- 6-7 drop indexes
db.Student_Data.dropIndex("Student_ID_1");
db.Student_Data.dropIndex("Student_Name_1_Department_1");

-- default name is formed by concatenating the field names and their sort order 
-- (1 for ascending, -1 for descending), separated by underscores
-- ex this index will be named Student_ID_1
-- or specify name:-
-- db.Student_Data.createIndex(
--  { Student_Name: 1, Department: 1 },
--  { name: "Name_Department_Index" }
-- )