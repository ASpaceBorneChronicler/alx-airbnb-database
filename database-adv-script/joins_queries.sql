--
-- Objective: Master SQL joins by writing complex queries.
--
-- Table Schemas from DDL:
-- User (user_id, first_name, last_name)
-- Booking (booking_id, user_id, property_id, start_date, end_date)
-- Property (property_id, name)
-- Review (review_id, property_id, user_id, rating, comment)
--

-- ====================================================================
-- 1. INNER JOIN Query
-- ====================================================================

-- This query uses an INNER JOIN to retrieve all bookings and the details
-- of the users who made those bookings.

SELECT
    b.booking_id,
    b.start_date,
    b.end_date,
    u.user_id,
    u.first_name,
    u.last_name
FROM
    Booking AS b
INNER JOIN
    User AS u ON b.user_id = u.user_id;


-- ====================================================================
-- 2. LEFT JOIN Query
-- ====================================================================

-- This query uses a LEFT JOIN to retrieve all properties and their reviews.
-- For properties without reviews, the review-related columns (r.review_id, r.rating, etc.)
-- will have a value of NULL.

SELECT
    p.property_id,
    p.name AS property_name,
    r.review_id,
    r.rating,
    r.comment
FROM
    Property AS p
LEFT JOIN
    Review AS r ON p.property_id = r.property_id
ORDER BY
    p.property_id;


-- ====================================================================
-- 3. FULL OUTER JOIN Query
-- ====================================================================

-- This query uses a FULL OUTER JOIN to retrieve all users and all bookings.
-- It returns a combined result that includes:
--   - Users who have made bookings.
--   - Users who have not made any bookings (booking columns will be NULL).
--   - Bookings that are not linked to a user (user columns will be NULL).
-- Note: Not all SQL databases support FULL OUTER JOIN.
--

SELECT
    u.user_id,
    u.first_name,
    u.last_name,
    b.booking_id,
    b.start_date
FROM
    User AS u
FULL OUTER JOIN
    Booking AS b ON u.user_id = b.user_id;

