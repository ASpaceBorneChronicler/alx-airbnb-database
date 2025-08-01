
### **Tables and their Attributes**

#### **`User`**

-   `user_id`: **Primary Key**, UUID, Indexed
    
-   `first_name`: VARCHAR, NOT NULL
    
-   `last_name`: VARCHAR, NOT NULL
    
-   `email`: VARCHAR, UNIQUE, NOT NULL
    
-   `password_hash`: VARCHAR, NOT NULL
    
-   `phone_number`: VARCHAR, NULL
    
-   `role`: ENUM (guest, host, admin), NOT NULL
    
-   `created_at`: TIMESTAMP, DEFAULT CURRENT_TIMESTAMP
    

#### **`Property`**

-   `property_id`: **Primary Key**, UUID, Indexed
    
-   `host_id`: **Foreign Key** (`User`), Indexed
    
-   `name`: VARCHAR, NOT NULL
    
-   `description`: TEXT, NOT NULL
    
-   `location`: VARCHAR, NOT NULL
    
-   `pricepernight`: DECIMAL, NOT NULL
    
-   `created_at`: TIMESTAMP, DEFAULT CURRENT_TIMESTAMP
    
-   `updated_at`: TIMESTAMP, ON UPDATE CURRENT_TIMESTAMP
    

#### **`Booking`**

-   `booking_id`: **Primary Key**, UUID, Indexed
    
-   `property_id`: **Foreign Key** (`Property`), Indexed
    
-   `user_id`: **Foreign Key** (`User`), Indexed
    
-   `start_date`: DATE, NOT NULL
    
-   `end_date`: DATE, NOT NULL
    
-   `total_price`: DECIMAL, NOT NULL
    
-   `status`: ENUM (pending, confirmed, canceled), NOT NULL
    
-   `created_at`: TIMESTAMP, DEFAULT CURRENT_TIMESTAMP
    

#### **`Payment`**

-   `payment_id`: **Primary Key**, UUID, Indexed
    
-   `booking_id`: **Foreign Key** (`Booking`), Indexed
    
-   `amount`: DECIMAL, NOT NULL
    
-   `payment_date`: TIMESTAMP, DEFAULT CURRENT_TIMESTAMP
    
-   `payment_method`: ENUM (credit_card, paypal, stripe), NOT NULL
    

#### **`Review`**

-   `review_id`: **Primary Key**, UUID, Indexed
    
-   `property_id`: **Foreign Key** (`Property`)
    
-   `user_id`: **Foreign Key** (`User`)
    
-   `rating`: INTEGER, NOT NULL (CHECK: 1-5)
    
-   `comment`: TEXT, NOT NULL
    
-   `created_at`: TIMESTAMP, DEFAULT CURRENT_TIMESTAMP
    

#### **`Message`**

-   `message_id`: **Primary Key**, UUID, Indexed
    
-   `sender_id`: **Foreign Key** (`User`)
    
-   `recipient_id`: **Foreign Key** (`User`)
    
-   `message_body`: TEXT, NOT NULL
    
-   `sent_at`: TIMESTAMP, DEFAULT CURRENT_TIMESTAMP
    

### **Relationships**

-   A `User` can **host** many `Property`s (One-to-Many).
    
-   A `User` can **book** many `Booking`s (One-to-Many).
    
-   A `Property` can **have** many `Booking`s (One-to-Many).
    
-   A `Booking`  **has** a `Payment` (One-to-Many).
    
-   A `User` can **write** many `Review`s (One-to-Many).
    
-   A `Property` can **receive** many `Review`s (One-to-Many for split payments).
    
-   A `User` can **send** and **receive** many `Message`s (One-to-Many for both directions).
