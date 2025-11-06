-- use creates and shitfs to given database
use college_db;
db.createCollection("Student")
db.Student.insertMany( [ { Roll_No: 'T101', Name: 'A', class: 'TE', dept: 'CS', aggregate_marks: 420 }, { Roll_No: 'T102', Name: 'B', class: 'TE', dept: 'IT', aggregate_marks: 380 }, { Roll_No: 'S201', Name: 'C', class: 'SE', dept: 'CS', aggregate_marks: 450 }, { Roll_No: 'B301', Name: 'D', class: 'BE', dept: 'CS', aggregate_marks: 510 }, { Roll_No: 'B302', Name: 'E', class: 'BE', dept: 'IT', aggregate_marks: 490 } ] ) ;

-- 1. total marks of TE class department-wise
-- var stores a function, map1 is the name of the map function variable
-- this refers to the current document being processed, emit(key, value) produces a key-value pair
var map1 = function() { 
      if(this.class === 'TE') emit(this.dept, this.aggregate_marks); 
};
-- Array.sum(values) sums up all marks for that department.
var reduceSum = function(k, vals){ 
      return Array.sum(vals); 
};
print("Total marks of TE class department-wise")
-- map1 is map function &  reduceSum is reduce function
-- out: { inline: 1 } tells MongoDB to return the results directly instead of writing to a collection.
db.Student.mapReduce(map1, reduceSum, { out: { inline: 1 } });

-- 2. highest marks of SE class department-wise
var map2 = function(){ 
      if(this.class === 'SE') emit(this.dept, this.aggregate_marks);
};
var reduceMax = function(k, vals){ 
      return Math.max.apply(null, values); 
};
print("Highest marks of SE class department-wise")
db.Student.mapReduce(map2, reduceMax, { out: { inline: 1 } });

-- 3. average marks of BE class department-wise
-- map3 extract marks & count students of BE and automatically groups all emitted values by key
-- ex o/p CS: [{sum: 510, count:1}, {sum: 480, count:1}]
var map3 = function(){ 
      if(this.class === 'BE') emit(this.dept, {sum: this.aggregate_marks, count: 1});
};
-- reduceAvg runs once per key
-- ex o/p { sum: totalMarksOfBEStudents, count: numberOfBEStudents }
  -- initialize accumulator
  -- forEach iterate through all values
  -- res.sum adds the individual student marks & res.count adds 1 for each student
var reduceAvg = function(k, vals) {
  var res = { sum: 0, count: 0 };
  vals.forEach(function(v){ res.sum += v.sum; res.count += v.count; });
  return res;
};
var finalizeAvg = function(k, v){ return v.sum / v.count; };
-- v is returned by reduceAvg { sum, count }
-- finalize: finalizeAvg applies the finalize function after reduction
db.Student.mapReduce(map3, reduceAvg, { out: { inline: 1 }, finalize: finalizeAvg });