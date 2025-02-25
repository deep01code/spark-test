package sa.edu.ksubench;

import org.apache.spark.sql.Dataset;
import org.apache.spark.sql.Row;
import org.apache.spark.sql.SparkSession;
import org.apache.spark.sql.functions;

import java.util.Arrays;

public class Main {
    public static void main(String[] args) {

        //Usage: java -Dspark.master.name=<name> -Dspark.master.port=<port> -jar myapp.jar
        String sparkMasterName = System.getProperty("clusterName");
        String sparkMasterPort = System.getProperty("masterPort");

        // Validate required properties
        if (sparkMasterName == null || sparkMasterPort == null) {
           // System.err.println("ERROR: Missing required system properties!");
            //System.err.println("Usage: java -Dspark.master.name=<name> -Dspark.master.port=<port> -jar myapp.jar");
            System.exit(1);
        }

        String sparkMaster = "spark://"+sparkMasterName+":"+sparkMasterPort;

        // Initialize Spark session
        SparkSession spark = SparkSession.builder()
                .appName("Spark Docker Integration - Fancy Version")
                .master(sparkMaster)
                .getOrCreate();

        System.out.println("Connected to Spark Master: " + sparkMaster);

        // Example 1: Create a DataFrame from a List
        Dataset<Row> data = spark.createDataFrame(Arrays.asList(
                new Person("Alice", 30),
                new Person("Bob", 35),
                new Person("Charlie", 25),
                new Person("Diana", 40)
        ), Person.class);

        System.out.println("DataFrame created from a List:");
        data.show();

        // Example 2: Perform transformations
        Dataset<Row> filteredData = data.filter(functions.col("age").gt(30));
        System.out.println("Filtered Data (age > 30):");
        filteredData.show();

        // Example 3: Perform aggregations
        Dataset<Row> averageAge = data.agg(functions.avg("age").alias("Average Age"));
        System.out.println("Average Age:");
        averageAge.show();

        // Stop the Spark session
        spark.stop();
        System.exit(0);
    }

    // Define a simple Person class for the DataFrame
    public static class Person implements java.io.Serializable {
        private String name;
        private int age;

        public Person() { }

        public Person(String name, int age) {
            this.name = name;
            this.age = age;
        }

        public String getName() {
            return name;
        }

        public void setName(String name) {
            this.name = name;
        }

        public int getAge() {
            return age;
        }

        public void setAge(int age) {
            this.age = age;
        }
    }
}

