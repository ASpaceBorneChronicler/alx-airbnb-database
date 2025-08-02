-- Objective: Retrieve comprehensive booking details for performance analysis.
--
-- This file contains an initial complex query and a refactored version
-- used for performance analysis and optimization.

-- ====================================================================
-- Initial Query with EXPLAIN ANALYZE
-- ====================================================================

-- This query joins the Booking, User, Property, and Payment tables to get
-- a complete view of each booking.
-- The EXPLAIN ANALYZE command is used to show the execution plan and
-- measure its performance.

EXPLAIN ANALYZE
SELECT
    b.booking_id,
    b.start_date,
    b.end_date,
    b.total_price,
    b.status AS booking_status,
    u.user_id AS guest_id,
    u.first_name AS guest_first_name,
    u.last_name AS guest_last_name,
    p.property_id,
    p.name AS property_name,
    pmt.payment_id,
    pmt.amount AS payment_amount,
    pmt.payment_date
FROM
    Booking AS b
INNER JOIN
    User AS u ON b.user_id = u.user_id
INNER JOIN
    Property AS p ON b.property_id = p.property_id
INNER JOIN
    Payment AS pmt ON b.booking_id = pmt.booking_id
ORDER BY
    b.booking_id DESC;


-- ====================================================================
-- Refactored Query
-- ====================================================================

-- The initial query is already well-structured. The most significant
-- performance gain comes from creating indexes on the foreign key columns
-- (b.user_id, b.property_id, pmt.booking_id).
-- This refactored version is presented for clarity and demonstrates
-- the same logic using explicit table aliases for improved readability.
-- This version also includes a WHERE clause to filter the results.
-- When the database has the appropriate indexes, both queries should
-- have similar, highly efficient execution plans.

SELECT
    b.booking_id,
    b.start_date,
    b.end_date,
    b.total_price,
    b.status AS booking_status,
    u.user_id AS guest_id,
    u.first_name AS guest_first_name,
    u.last_name AS guest_last_name,
    p.property_id,
    p.name AS property_name,
    pmt.payment_id,
    pmt.amount AS payment_amount,
    pmt.payment_date
FROM
    Booking AS b
INNER JOIN User AS u
    ON b.user_id = u.user_id
INNER JOIN Property AS p
    ON b.property_id = p.property_id
INNER JOIN Payment AS pmt
    ON b.booking_id = pmt.booking_id
WHERE
    b.total_price > 500.00 AND b.status = 'confirmed'
ORDER BY
    b.booking_id DESC;
