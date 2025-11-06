use db;
db.createCollection("Student")
db.Student.insertMany( [ { Roll_No: "A01", Name: "Alice", Class: "TE", Marks: 78, Address: "Mumbai", Enrolled_Courses: ["DBMS","TOC","AI"] },{ Roll_No: "A02", Name: "Bob", Class: "SE", Marks: 45, Address: "Pune", Enrolled_Courses: ["DBMS","OS"] },{ Roll_No: "A03", Name: "Charlie", Class: "TE", Marks: 82, Address: "Delhi", Enrolled_Courses: ["TOC","DBMS"] },{ Roll_No: "A04", Name: "David", Class: "BE", Marks: 36, Address: "Chennai", Enrolled_Courses: ["AI","OS"] },{ Roll_No: "A05", Name: "Eve", Class: "TE", Marks: 91, Address: "Mumbai", Enrolled_Courses: ["DBMS","TOC","OS"] },{ Roll_No: "A06", Name: "Frank", Class: "SE", Marks: 55, Address: "Pune", Enrolled_Courses: ["TOC"] },{ Roll_No: "A07", Name: "Grace", Class: "TE", Marks: 29, Address: "Delhi", Enrolled_Courses: ["DBMS","AI"] },{ Roll_No: "A08", Name: "Hannah", Class: "BE", Marks: 65, Address: "Mumbai", Enrolled_Courses: ["DBMS","TOC"] },{ Roll_No: "A09", Name: "Ian", Class: "SE", Marks: 12, Address: "Chennai", Enrolled_Courses: ["OS"] },{ Roll_No: "A10", Name: "Jack", Class: "TE", Marks: 49, Address: "Pune", Enrolled_Courses: ["DBMS","AI","TOC"] } ] );

-- 1 List the names of students who have enrolled in the course “DBMS”, “TOC”
db.Student.find( 
      {Enrolled_Courses: {
            $in: ["DBMS","TOC"] } },
      { Name: 1, _id: 0 }
);

-- 2 List the Roll numbers and class of students who have marks more than 50 or class as TE
db.Student.find( 
      { $or:[    
            { Marks: { $gt: 50 } },
            { Class: "TE" } ] },
      { Roll_No: 1, Class: 1, _id: 0 }
);

-- 3. Update the entire record of roll_no A10
db.Student.updateOne(
  { Roll_No: "A10" },
  { $set: { Name: "Jackson", Class: "TE", Marks: 75, Address: "Mumbai", Enrolled_Courses: ["DBMS","AI"] } }
);

-- 4. Display the names of students having 3rd and 4th highest marks
 -- descending order for highest
  -- 1st and 2nd highest not needed
  -- 3rd and 4th req only
db.Student.find(
      {},
      { Name: 1, Marks: 1, _id: 0 })
.sort({ Marks: -1 })
.skip(2)
.limit(2); 

-- 5. Delete the records of students having marks less than 20
db.Student.deleteMany(
      { Marks:
            { $lt: 20 } } );

-- 6. Delete only first record from the collection
db.Student.deleteOne({});