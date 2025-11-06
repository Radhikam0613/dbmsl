import com.mongodb.*;
import java.util.Scanner;
public class MongoJavaSimple {
    public static void main(String[] args) {
        try {
            MongoClient mongoClient = new MongoClient("localhost", 27017);
            DB db = mongoClient.getDB("Institute");
            DBCollection coll = db.getCollection("Students");
            Scanner sc = new Scanner(System.in);
            int choice;
            do {
                System.out.println("\nChoose an operation:");
                System.out.println("1. Insert Student");
                System.out.println("2. Display All Students");
                System.out.println("3. Exit");
                System.out.print("Enter your choice: ");
                choice = sc.nextInt();
                switch (choice) {
                    case 1:
                        insertDoc(coll, sc);
                        break;
                    case 2:
                        displayAll(coll);
                        break;
                    case 3:
                        System.out.println("Exiting program...");
                        break;
                    default:
                        System.out.println("Invalid choice! Try again.");
                }
            } while (choice != 3);
            mongoClient.close();
            sc.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public static void insertDoc(DBCollection coll, Scanner sc) {
        System.out.println("\nInserting new student record...");
        System.out.print("Enter Roll No: ");
        int roll = sc.nextInt();
        System.out.print("Enter Name: ");
        String name = sc.next();
        System.out.print("Enter Class: ");
        String sclass = sc.next();
        System.out.print("Enter Marks: ");
        int marks = sc.nextInt();
        BasicDBObject document = new BasicDBObject("Roll_No", roll)
                .append("Name", name)
                .append("Class", sclass)
                .append("Marks", marks);

        coll.insert(document);
        System.out.println("✅ Document inserted successfully!");
    }
    // Function to display all documents
    public static void displayAll(DBCollection coll) {
        System.out.println("\n📋 Displaying all student records:");
        DBCursor cursor = coll.find();
        if (!cursor.hasNext()) {
            System.out.println("(No records found.)");
        }
        while (cursor.hasNext()) {
            System.out.println(cursor.next());
        }
    }
}