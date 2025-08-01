-- This script assumes the tables have already been created using the schema.sql file.

-- Declaring UUIDs to ensure consistency when inserting related data

-- User UUIDs
SET @user_host_id = 'c1a1b1c1-d1e1-f1a1-b1c1-d1e1f1a1b1c1';
SET @user_guest_id = 'c2a2b2c2-d2e2-f2a2-b2c2-d2e2f2a2b2c2';
SET @user_admin_id = 'c3a3b3c3-d3e3-f3a3-b3c3-d3e3f3a3b3c3';

-- Property UUIDs
SET @property_1_id = 'p1a1b1c1-d1e1-f1a1-b1c1-d1e1f1a1b1c1';
SET @property_2_id = 'p2a2b2c2-d2e2-f2a2-b2c2-d2e2f2a2b2c2';

-- Booking UUID
SET @booking_1_id = 'b1a1b1c1-d1e1-f1a1-b1c1-d1e1f1a1b1c1';

-- Payment UUID
SET @payment_1_id = 'y1a1b1c1-d1e1-f1a1-b1c1-d1e1f1a1b1c1';

-- Review UUID
SET @review_1_id = 'r1a1b1c1-d1e1-f1a1-b1c1-d1e1f1a1b1c1';

-- Message UUID
SET @message_1_id = 'm1a1b1c1-d1e1-f1a1-b1c1-d1e1f1a1b1c1';

-- -----------------------------------------------------------------------------
-- INSERT DATA INTO 'User' TABLE
-- -----------------------------------------------------------------------------
INSERT INTO User (user_id, first_name, last_name, email, password_hash, phone_number, role) VALUES
(@user_host_id, 'Jane', 'Doe', 'jane.doe@example.com', 'hashed_password_1', '+254 7123 65498', 'host'),
(@user_guest_id, 'John', 'Smith', 'john.smith@example.com', 'hashed_password_2', '+254 7879 12546', 'guest'),
(@user_admin_id, 'Admin', 'User', 'admin@example.com', 'hashed_password_3', '+254 7456 19785', 'admin');

-- -----------------------------------------------------------------------------
-- INSERT DATA INTO 'Property' TABLE
-- -----------------------------------------------------------------------------
INSERT INTO Property (property_id, host_id, name, description, location, pricepernight) VALUES
(@property_1_id, @user_host_id, 'Cozy Apartment in the City', 'A beautiful, centrally located apartment with great amenities.', 'Nairobi, KE', 150.00),
(@property_2_id, @user_host_id, 'Secluded Lakeside Cabin', 'Escape to this quiet cabin by the lake for a relaxing getaway.', 'Lake Victoria, UG', 250.00);

-- -----------------------------------------------------------------------------
-- INSERT DATA INTO 'Booking' TABLE
-- -----------------------------------------------------------------------------
INSERT INTO Booking (booking_id, property_id, user_id, start_date, end_date, total_price, status) VALUES
(@booking_1_id, @property_1_id, @user_guest_id, '2024-08-10', '2024-08-15', 750.00, 'confirmed');

-- -----------------------------------------------------------------------------
-- INSERT DATA INTO 'Payment' TABLE
-- -----------------------------------------------------------------------------
INSERT INTO Payment (payment_id, booking_id, amount, payment_method) VALUES
(@payment_1_id, @booking_1_id, 750.00, 'credit_card');

-- -----------------------------------------------------------------------------
-- INSERT DATA INTO 'Review' TABLE
-- -----------------------------------------------------------------------------
INSERT INTO Review (review_id, property_id, user_id, rating, comment) VALUES
(@review_1_id, @property_1_id, @user_guest_id, 5, 'Absolutely loved the place! Clean, quiet, and perfect location.');

-- -----------------------------------------------------------------------------
-- INSERT DATA INTO 'Message' TABLE
-- -----------------------------------------------------------------------------
INSERT INTO Message (message_id, sender_id, recipient_id, message_body) VALUES
(@message_1_id, @user_guest_id, @user_host_id, 'Hello Jane, looking forward to my stay!');
