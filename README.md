# Action Plan - The Wanderlust Group Code Exercise

## Requirements Questions

In working on this project there were several assumptions and decisions to be made. The requirements do not specify certain behaviors of
the endpoints, and so I made a few decisions to maintain data integrity and prevent duplicates. When creating a new customer, either via `POST /customers` or `POST /customers/bulk` I check if a matching customer already exists in the database. If a matching existing customer is found,
a duplicate is not created, and the endpoint returns an error. 

There were several places that I tried to build in future contingencies despite the requirements not specifying to do so. For example, when converting 
keys when rendering a customer as json, I designed it to convert any and all attribute keys rather than specifying a hardcoded list. This allows for more flexibility as the class adds attributes and relations.

## Future Concerns

There are several concerns I would have for the future of this api. Ideally, this api would be versioned and properly separated into its own module,
allowing for endpoints to be expanded and updated without breaking compatibility. This would be a mismatch with the requirements of this task, as it 
would change some of the expected endpoint paths to be more akin to `/api/v1/customers/`, contradicting the specified paths in the requirements. However this is the proper way to handle a rails api and should be considered when building any real-world api. 

If the API traffic were to increase, there would be several considerations to take. Indexing some of the customer data would be important, and more
steps to sanitize the input should be considered. Currently, the requirements have almost no data validation (other than `vehicle_length` being >0 and `vehicle_type` matching an enum value), but the system would benefit from at least some level of validation on the names and email. I added them to my version, but only validating presence at this time. 

One of the biggest changes I would work on going forward is to remove the camelCase attribute names from data ingress and egress. The mismatch of these
keys adds additional processing that while slight, can add up over thousands or millions of requests. It may not be possible to alter the legacy data from CSVs, but minimizing where this processing needs to be done would benefit performance. I would also tweak a couple edge cases to help simplify code. For example, when sorting the list of customers from `GET /customers`, I would update the `type` option to be `vehicleType` so that it would match the database field name, allowing it to match the other two options (`firstName` and `lastName`) and follow the same generic sorting logic they use rather than requiring a separate check.

Another point that would be beneficial in the future would be to move `vehicle_type` from an enum to its own model with a relation to `Customer` so that more vehicle types could be easily added and validated against. At that time, there could even be steps to add a new `vehicle_type` if one is provided during customer creation that does not match an existing value in the database.
