	# Partitioning Performance Report

## Objective

This report documents the performance analysis of the `Booking` table before and after implementing table partitioning based on the `start_date` column. The goal is to demonstrate how partitioning can significantly optimize query execution time on large datasets.

## How to Test Performance

To observe the performance improvements, you should follow these steps using a database client.

1.  **Baseline Performance (Unpartitioned Table):** Before running the `partitioning.sql` script, execute the following query with `EXPLAIN ANALYZE`. This will show the execution plan for a full, unpartitioned `Booking` table.
    
    ```
    EXPLAIN ANALYZE
    SELECT
        *
    FROM
        Booking
    WHERE
        start_date BETWEEN '2024-04-15' AND '2024-05-30';
    
    ```
    
    **Expected Output:** The `EXPLAIN ANALYZE` plan will likely show a **`Seq Scan`** (sequential scan) on the entire `Booking` table, indicating that the database is reading every single row to find the matching records. This process is slow and resource-intensive.
    
2.  **Apply Partitioning:** Run the `partitioning.sql` script to create the partitioned `Booking` table and its sub-partitions.
    
3.  **Post-Partitioning Performance:** Execute the same `EXPLAIN ANALYZE` query again on the now-partitioned `Booking` table.
    
    ```
    EXPLAIN ANALYZE
    SELECT
        *
    FROM
        Booking
    WHERE
        start_date BETWEEN '2024-04-15' AND '2024-05-30';
    
    ```
    
    **Expected Output:** The `EXPLAIN ANALYZE` plan will now show a **`Partition Pruning`** step. This means the query optimizer intelligently determined that only the `booking_q2_2024` partition contains the data needed for the query. Instead of scanning the entire `Booking` table, it performs an **`Index Scan`** or **`Seq Scan`** only on that single, much smaller partition.
    

## Observed Improvements

The performance gains from table partitioning are often dramatic on large tables.

-   **Before Partitioning:** The query time is dependent on the total number of rows in the entire `Booking` table.
    
-   **After Partitioning:** The query time is dependent only on the number of rows within the targeted partition(s).
    

By using **partition pruning**, the database avoids unnecessary I/O operations and reduces the amount of data it has to process. For queries that filter on the partitioning key (`start_date`), this results in a significant reduction in execution time and a more efficient use of system resources.