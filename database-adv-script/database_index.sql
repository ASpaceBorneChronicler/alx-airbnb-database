-- Objective: Create indexes to improve query performance on high-usage columns.
--
-- This script contains CREATE INDEX statements for columns that are frequently
-- used in JOIN, WHERE, and ORDER BY clauses, as identified in the project's
-- SQL queries.

-- ====================================================================
-- Indexes for 'User' Table
-- ====================================================================

-- Index for the 'email' column to enforce uniqueness and speed up logins.
-- This is already included in your DDL but is good practice to explicitly
-- mention for a comprehensive index file.
CREATE INDEX idx_user_email ON User(email);


-- ====================================================================
-- Indexes for 'Property' Table
-- ====================================================================

-- Index for the 'host_id' foreign key. This is critical for quickly
-- retrieving all properties owned by a specific host.
CREATE INDEX idx_property_host_id ON Property(host_id);


-- ====================================================================
-- Indexes for 'Booking' Table
-- ====================================================================

-- Index for the 'user_id' foreign key. This improves performance for queries
-- that join the Booking and User tables, such as finding all bookings made by a user.
CREATE INDEX idx_booking_user_id ON Booking(user_id);

-- Index for the 'property_id' foreign key. This improves performance for queries
-- that join the Booking and Property tables, such as finding all bookings for a property.
-- This is already included in your DDL.
CREATE INDEX idx_booking_property_id ON Booking(property_id);


-- ====================================================================
-- Indexes for 'Review' Table
-- ====================================================================

-- Index for the 'property_id' foreign key. This is crucial for efficiently
-- retrieving all reviews for a specific property.
-- This is already included in your DDL.
CREATE INDEX idx_review_property_id ON Review(property_id);


-- ====================================================================
-- Indexes for 'Payment' Table
-- ====================================================================

-- Index for the 'booking_id' foreign key. This improves performance when
-- querying payments for a specific booking.
-- This is already included in your DDL.
CREATE INDEX idx_payment_booking_id ON Payment(booking_id);

