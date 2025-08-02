-- ====================================================================
--   SQL Aggregation and Window Functions
-- ====================================================================

-- This query finds the total number of bookings made by each user.
-- It uses an INNER JOIN to combine data from the User and Booking tables.
-- The COUNT() function is used to aggregate the number of bookings for each user,
-- and the results are grouped by the user's ID and name.

SELECT
    u.user_id,
    u.first_name,
    u.last_name,
    COUNT(b.booking_id) AS total_bookings
FROM
    User AS u
INNER JOIN
    Booking AS b ON u.user_id = b.user_id
GROUP BY
    u.user_id,
    u.first_name,
    u.last_name
ORDER BY
    total_bookings DESC;

-- This query ranks properties based on the total number of bookings they have received.
-- It uses a Common Table Expression (CTE) to first calculate the booking count for each property.
-- Then, a window function (RANK()) is applied to assign a rank to each property based on
-- its total bookings in descending order. This is useful for finding top-performing properties.

WITH PropertyBookingCounts AS (
    SELECT
        p.property_id,
        p.name,
        COUNT(b.booking_id) AS number_of_bookings
    FROM
        Property AS p
    LEFT JOIN
        Booking AS b ON p.property_id = b.property_id
    GROUP BY
        p.property_id,
        p.name
)
SELECT
    property_id,
    name,
    number_of_bookings,
    RANK() OVER (ORDER BY number_of_bookings DESC) AS booking_rank
FROM
    PropertyBookingCounts
ORDER BY
    booking_rank, number_of_bookings DESC;
