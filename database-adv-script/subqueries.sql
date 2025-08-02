-- Objective: Write both correlated and non-correlated subqueries.
--
-- This file contains SQL queries that demonstrate the use of subqueries
-- to solve more complex data retrieval problems.

-- ====================================================================
-- 1. Non-Correlated Subquery
-- ====================================================================

-- This query finds all properties where the average rating is greater than 4.0.
-- The inner subquery (in parentheses) is executed first to calculate the average
-- rating for each property that has at least one review.
-- The outer query then uses the results of this subquery to filter and select
-- properties whose average rating exceeds 4.0.
-- This is a non-correlated subquery because the inner query does not depend on
-- the outer query for its execution.

SELECT
    p.property_id,
    p.name
FROM
    Property AS p
WHERE
    p.property_id IN (
        SELECT
            property_id
        FROM
            Review
        GROUP BY
            property_id
        HAVING
            AVG(rating) > 4.0
    );


-- ====================================================================
-- 2. Correlated Subquery
-- ====================================================================

-- This query finds all users who have made more than 3 bookings.
-- This is a correlated subquery because the inner query depends on the outer
-- query for its value (specifically, `u.user_id`).
-- For each user selected in the outer query's `FROM User AS u` clause,
-- the inner query is executed to count the bookings made by that specific user.
-- The `WHERE` clause then filters for users where the count is greater than 3.

SELECT
    u.user_id,
    u.first_name,
    u.last_name
FROM
    User AS u
WHERE
    (
        SELECT
            COUNT(*)
        FROM
            Booking AS b
        WHERE
            b.user_id = u.user_id
    ) > 3;

