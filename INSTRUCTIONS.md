# The Wanderlust Group Code Exercise

## Instructions
Welcome to the code exercise for the Wanderlust Group! For this exercise you will be building an API for a fictional company.
The goal of this exercise is to allow you to demonstrate your ability to diagnose a set of problems and implement a good solution.
Feel free to bring in additional tools or libraries as you see fit, such as a testing library, however we would like to see a majority
of the implementation logic written and designed by you. Our goal is to get as reasonable of an understanding as possible of the following:

- how you break down a problem
- your ability to understand requirements
- how you implement and design your code
- your understanding of how a system might scale

The first step is to use this template to create a new repository on GitHub. This will become the repository you will share with us as
your submission. The repository contains a new [Rails API application](https://guides.rubyonrails.org/api_app.html). While
there is no included test framework, we do have an expectation that you will write tests using whichever framework you are
comfortable with, as well as documenting instructions on how to run your tests. [rspec](https://github.com/rspec/rspec-rails) 
is a popular test framework and one we use at TWG!

Below you are given a list of business requirements. Within a reasonable timeframe (try to spend no more than 2 hours!) we 
would like you to implement the requirements as you see fit. In addition to the requirements listed, please leave time 
to document any [requirements questions](#requirements-questions) and address any [future concerns](#future-concerns) you 
may think of. You are also encouraged to add sections of your own to a README, such as instructions on how to use the system or how to run your tests.

> __Before moving forward, complete the following steps:__
> 1. Rename this file (`README.md`) to `INSTRUCTIONS.md`
> 2. Create a new file `README.md`
> 3. Commit the change! The new empty README.md file will be where you will answer any questions as well as document your own project.

## Dependencies
This project depends on ruby version `3.1.2` being installed in the local environment.

To install gem dependencies, use the included bundler binstub, available in the project at `bin/bundle`. You can run `bin/bundle -h` to see options,
but either `bin/bundle` or `bin/bundle install` will install gem dependencies.

After installing ruby 3.1.2 and other gem dependencies, to ensure the project can run on your machine, run `bin/rails s` from your terminal and expect to see the following output:
```shell
=> Booting Puma
=> Rails 7.0.3.1 application starting in development
=> Run `bin/rails server --help` for more startup options
Puma starting in single mode...
* Puma version: 5.6.4 (ruby 3.1.2-p20) ("Birdie's Version")
*  Min threads: 5
*  Max threads: 5
*  Environment: development
*          PID: 28693
* Listening on http://127.0.0.1:3000
* Listening on http://[::1]:3000
Use Ctrl-C to stop
```

## Requirements

Your task is to design an API for a fictional company, Outdoorsy. The API will primarily be used to take in customer
data as well as retrieve customer data. In addition to the requirements listed below, the following system-wide requirements 
exist:

1. Data should persist between application restarts
2. The media type for APIs should be JSON
3. JSON keys should be camelCased (ingress and egress)
   >**NOTE**: Ruby and thus Rails convention is to use snake_case by default
4. Successful responses should return HTTP status code 200
5. Invalid requests should return HTTP status code 400

| Requirements                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
|:-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| As an API client, I want to be able to add a customer to the system via a `POST` request to `/customers`. This API should return the newly created customer. Customers are defined by the following required fields:<br><br>1. First Name <br>2. Last Name <br>3. Email Address <br>4. Vehicle Type - one of [`campervan`, `motorboat`, `bicycle`, `sailboat`] <br>5. Vehicle Name <br>6. Vehicle length in feet - must be greater than 0<br><br>Example input: ```{"firstName": "Ferdinand", "lastName": "Magellan", "emailAddress": "fmagellan@explore.gov.pt", "vehicleType": "sailboat", "vehicleName": "Victoria", "vehicleLength": 60}```                              |
| As an API client, I want to be able to view the data for an individual customer via a `GET` request to `/customers/{customerId}`                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             |
| As an API client, I want to be able to view a list of customers in the system via a `GET` request to `/customers`. By default the list should be sorted by the date the customer was uploaded. The response should be a JSON array containing the customers.                                                                                                                                                                                                                                                                                                                                                                                                                 |
| As an API client, I want to be able to sort the list of customers in the system by either vehicle type, customer first name, or customer last name. If a sort parameter is not provided, the sort should fall back to the default (date uploaded). The sort parameter will be passed via the `sort` query parameter and should support these values: [`type`, `firstName`, `lastName`]                                                                                                                                                                                                                                                                                       |
| As an API client, I want to be able to bulk upload a CSV file with a list of customers via a `POST` request to `/customers/bulk`. This particular request will be `multipart/form-data` and the parameter will be named `file`. Because the CSV is coming from external legacy sources, the following requirements exist:<br><br>1. The file will have no headers<br>2. The order of the data in each row will be as follows: `first name`, `last name`, `email address`, `vehicle type`, `vehicle name`, `vehicle length`<br> 3. Vehicle lengths are strings which could be in the following formats: `32'`, `32 feet`, `32 ft`, `32’`                                      |
| As an API client, I want to be able to delete a customer via a `DELETE` request to `/customers/{customerId}`                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 |


## Requirements Questions

Did you think of any questions around the requirements you were given from the business? Where could you use more clarity?
If you made any assumptions in your implementation, please also document them here.

## Future Concerns

Please document any future concerns you may have for this API. What would you change, if anything, if the API traffic were to increase?
Were there requirements you did not get to within the timeframe? Feel free to discuss those here as well.
