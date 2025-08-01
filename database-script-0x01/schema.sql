-- DDL for the 'User' table
CREATE TABLE User (
    user_id       UUID PRIMARY KEY,
    first_name    VARCHAR(255) NOT NULL,
    last_name     VARCHAR(255) NOT NULL,
    email         VARCHAR(255) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    phone_number  VARCHAR(20),
    role          ENUM('guest', 'host', 'admin') NOT NULL,
    created_at    TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- DDL for the 'Property' table
CREATE TABLE Property (
    property_id   UUID PRIMARY KEY,
    host_id       UUID NOT NULL,
    name          VARCHAR(255) NOT NULL,
    description   TEXT NOT NULL,
    location      VARCHAR(255) NOT NULL,
    pricepernight DECIMAL(10, 2) NOT NULL,
    created_at    TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at    TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (host_id) REFERENCES User(user_id)
);

-- DDL for the 'Booking' table
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
);

-- DDL for the 'Payment' table
CREATE TABLE Payment (
    payment_id      UUID PRIMARY KEY,
    booking_id      UUID NOT NULL,
    amount          DECIMAL(10, 2) NOT NULL,
    payment_date    TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    payment_method  ENUM('credit_card', 'paypal', 'stripe') NOT NULL,
    FOREIGN KEY (booking_id) REFERENCES Booking(booking_id)
);

-- DDL for the 'Review' table
CREATE TABLE Review (
    review_id   UUID PRIMARY KEY,
    property_id UUID NOT NULL,
    user_id     UUID NOT NULL,
    rating      INTEGER NOT NULL CHECK (rating >= 1 AND rating <= 5),
    comment     TEXT NOT NULL,
    created_at  TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (property_id) REFERENCES Property(property_id),
    FOREIGN KEY (user_id) REFERENCES User(user_id)
);

-- DDL for the 'Message' table
CREATE TABLE Message (
    message_id      UUID PRIMARY KEY,
    sender_id       UUID NOT NULL,
    recipient_id    UUID NOT NULL,
    message_body    TEXT NOT NULL,
    sent_at         TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (sender_id) REFERENCES User(user_id),
    FOREIGN KEY (recipient_id) REFERENCES User(user_id)
);

-- Indexes for optimal performance
-- Automatically indexed:
-- User(user_id)
-- Property(property_id)
-- Booking(booking_id)
-- Payment(payment_id)
-- Review(review_id)
-- Message(message_id)

CREATE INDEX idx_user_email ON User(email);
CREATE INDEX idx_booking_property_id ON Booking(property_id);
CREATE INDEX idx_review_property_id ON Review(property_id);
CREATE INDEX idx_payment_booking_id ON Payment(booking_id);