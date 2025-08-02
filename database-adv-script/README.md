# ALX Airbnb SQL Joins

## Overview

This project focuses on mastering SQL joins, a fundamental skill for querying relational databases. The queries provided here demonstrate the use of `INNER JOIN`, `LEFT JOIN`, and `FULL OUTER JOIN` to retrieve data from a simplified Airbnb-style database schema.

The objective is to understand how different join types affect the result set, ensuring you can fetch related data accurately from multiple tables.

## The Database Schema

The queries are written to be compatible with the following database tables:

- \*\*`User`\*\*: Contains user profiles.

&nbsp;

- \*\*`Property`\*\*: Contains property listings, linked to a `User` as a host.

&nbsp;

-\*\*`Booking`\*\*: Records user reservations, linked to a `User` and a `Property`.

&nbsp;

- \*\*`Review`\*\*: Stores reviews for properties, linked to a `User` and a `Property`.

&nbsp;

## SQL Join Queries

The following queries are written based on your provided DDL and demonstrate practical applications of different join types.

### \*\*1. `INNER JOIN`\*\*

This query retrieves all bookings and the details of the users who made them. The `INNER JOIN` ensures that only bookings with a corresponding user are returned, and vice versa.

```

`sql`

SELECT

&nbsp;   b.booking\_id,

&nbsp;   b.start\_date,

&nbsp;   b.end\_date,

&nbsp;   u.user\_id,

&nbsp;   u.first\_name,

&nbsp;   u.last\_name

FROM

&nbsp;   Booking AS b

INNER JOIN

&nbsp;   User AS u ON b.user\_id = u.user\_id;

```

### \*\*2. `LEFT JOIN`\*\*

This query retrieves all properties and their reviews, including properties that do not have any reviews yet. The `LEFT JOIN` guarantees that every property from the "left" table (`Property`) is included in the result set. For properties without a review, the review-related columns will show `NULL`.

```

`sql`

SELECT

&nbsp;   p.property\_id,

&nbsp;   p.name AS property\_name,

&nbsp;   r.review\_id,

&nbsp;   r.rating,

&nbsp;   r.comment

FROM

&nbsp;   Property AS p

LEFT JOIN

&nbsp;   Review AS r ON p.property\_id = r.property\_id;

```

### \*\*3. `FULL OUTER JOIN`\*\*

This query retrieves all users and all bookings, even if a user has not made a booking or a booking is not linked to a user. The `FULL OUTER JOIN` combines the results of both tables, including all unmatched rows from both sides.

> \*\*Note:\*\* The `FULL OUTER JOIN` might not be supported by all SQL database systems.

'''

`sql`

SELECT

&nbsp;   u.user\_id,

&nbsp;   u.first\_name,

&nbsp;   u.last\_name,

&nbsp;   b.booking\_id,

&nbsp;   b.start\_date

FROM

&nbsp;   User AS u

FULL OUTER JOIN

&nbsp;   Booking AS b ON u.user\_id = b.user\_id;

```


## SQL Subqueries

These queries demonstrate how to use subqueries to solve more complex data retrieval problems.

### **1. Non-Correlated Subquery**

This query finds all properties where the average rating is greater than 4.0. The inner subquery calculates the average rating for each property first, and the outer query then filters properties based on that result. This is a non-correlated subquery because the inner query can be executed independently.

```

`sql`
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

```

### **2. Correlated Subquery**

This query finds all users who have made more than 3 bookings. This is a correlated subquery because the inner query depends on the outer query for its value. For each user selected in the outer query, the inner query is executed to count their specific bookings.

```

`sql`
SELECT
    u.user_id,
    u.first_name,
    u.last_name
FROM
    User AS u
WHERE
    (SELECT COUNT(*) FROM Booking AS b WHERE b.user_id = u.user_id) > 3;

```

## How to Use These Queries

You can run these SQL queries against a database to practice and verify the results. the database must of course have a similar schema.
