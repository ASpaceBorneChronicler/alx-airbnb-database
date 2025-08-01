# Normalization
I found the current setup to be sufficiently normalized.
-  Each table has a single, clear purpose. For example, all user data is in the `User` table, and all booking data is in the `Booking` table.
    
-   All attributes are directly dependent on the primary key. For instance, in the `Property` table, `name`, `description`, and `location` are attributes of that specific `property_id`.
    
-   Foreign keys are used correctly to link related tables (`host_id`, `property_id`, `user_id`, etc.) without duplicating data.

The only thing I would change is to add Longitude and latitude properties to the  `Property` table if the functionality to link with maps is required later on.
