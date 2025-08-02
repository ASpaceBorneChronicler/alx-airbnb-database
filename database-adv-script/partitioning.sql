-- Objective: Implement table partitioning on the Booking table by start_date to optimize query performance.
--
-- This script demonstrates how to partition a large Booking table based on date ranges.
-- The partitioning strategy will significantly improve the performance of queries that
-- filter bookings by date, as the database will only scan the relevant partition(s).

-- ====================================================================
-- 1. Create the Master Partitioned Table
-- ====================================================================

-- First, create the main "Booking" table, which is a partitioned table.
-- It does not store any data itself but acts as a parent for the partitions.
-- The PARTITION BY clause specifies the column and method for partitioning.

CREATE TABLE Booking (
    booking_id   UUID PRIMARY KEY,
    property_id  UUID NOT NULL,
    user_id      UUID NOT NULL,
    start_date   DATE NOT NULL,
    end_date     DATE NOT NULL,
    total_price  DECIMAL(10, 2) NOT NULL,
    status       ENUM('pending', 'confirmed', 'canceled') NOT NULL,
    created_at   TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (property_id) REFERENCES Property(property_id),
    FOREIGN KEY (user_id) REFERENCES User(user_id)
) PARTITION BY RANGE (start_date);


-- ====================================================================
-- 2. Create Partitions for Specific Date Ranges
-- ====================================================================

-- Create individual partitions (child tables) for different years.
-- Each partition is a separate table that stores data for a specific date range.

CREATE TABLE booking_q1_2024 PARTITION OF Booking
    FOR VALUES FROM ('2024-01-01') TO ('2024-04-01');

CREATE TABLE booking_q2_2024 PARTITION OF Booking
    FOR VALUES FROM ('2024-04-01') TO ('2024-07-01');

CREATE TABLE booking_q3_2024 PARTITION OF Booking
    FOR VALUES FROM ('2024-07-01') TO ('2024-10-01');

CREATE TABLE booking_q4_2024 PARTITION OF Booking
    FOR VALUES FROM ('2024-10-01') TO ('2025-01-01');


-- ====================================================================
-- 3. Create a Default Partition (Important)
-- ====================================================================

-- The DEFAULT partition catches all data that does not fit into the
-- predefined ranges. This is crucial to avoid errors when inserting
-- bookings with dates outside the specified quarters.

CREATE TABLE booking_future_or_past PARTITION OF Booking DEFAULT;
