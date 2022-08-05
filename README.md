# Tea Subscription

This project is an API build on Ruby on Rails with a Postgres database for a company that has tea subscriptions for customers. The company offers 3 different subscriptions: **Single Tea**, **Tea Lover** and **Tea Fiend**. The company has 12 different teas available (taken from the [Tea API](https://tea-api-vic-lo.herokuapp.com/). For this project I opted to use a rake task to hit the API and just store the tea data directly into the database. A customer can create a subscription with a certain number of teas on it by chosen by name, they can deactivate a subscription or activate it. It will not allow a customer to add more teas than their chosen subscription allows and it will not allow a customer to update a customer_subscription that does not belong to them. The API also allows you to get all subscriptions for a particular customer and can opt to filter it by active and inactive subscriptions. 

## Schema

<img width="1087" alt="Screen Shot 2022-08-02 at 8 46 23 PM" src="https://user-images.githubusercontent.com/96309924/182739532-a35d66a0-4bcb-424d-a924-d05e2a31ac7f.png">



## Setup

To use this API on your local computer follow these instructions in your terminal: 

1. Clone this repository
2. `cd` into repository
3. Run `bundle install` 
4. Run `rails db:{create,migrate}`
5. Run `rake load_teas`
6. Run `rails db:seed`
7. Run `rails s`
8. [![Run in Postman](https://run.pstmn.io/button.svg)](https://app.getpostman.com/run-collection/c0c82824346657c05d6a?action=collection%2Fimport)


## Endpoints

### Available Data after Seeding
  - Customer Ids: 1, 2
  - Customber Subscription Ids: 
    1. `Customer 1 => [1, 2, 3]`
    2. `Customer 2 => [4, 5, 6, 7]`
  - Subscription ids: 
    1. `Single Tea => id: 1, tea_limit: 1` 
    2. `Tea Lover => id: 2, tea_limit: 3` 
    3. `Tea Fiend => id: 3, tea_limit: 5`
  - Fequency options: `["weekly", "monthly", "every 3 months", "yearly"]`

### **Create a new subscription** 
  * `post http://localhost:3000/api/v1/customers/{customer_id}/subscriptions`
  * With headers `Content-Type = application/value`
  * Body 
    ```ruby
    {
    "subscription_id": "2",
    "frequency": "weekly",
    "tea": ["green", "black"]
    }
    ```
    
  * Expected Response
    ```ruby
    {
    "data": {
        "id": 1,
        "name": "Harry Potter",
        "address": {
            "street": "Grimmauld Place",
            "city": "London",
            "state": "UK",
            "zip_code": "12345"
        },
        "subscription": {
            "name": "Tea Lover",
            "active": true,
            "price": 20,
            "frequency": "weekly",
            "teas": [
                {
                    "name": "green"
                },
                {
                    "name": "black"
                }
               ]
              }
             }
            }
  * If you try to create a customer subscription with more teas allowed on the subscription
  * Body 
    ```ruby
    {
    "subscription_id": "2",
    "frequency": "weekly",
    "tea": ["green", "black", "jasmine", "white"]
    }
    ```
    
  * Expected Response
    ```ruby 
     {
    "errors": "Tea limit This subscription has a limit of 3 teas."
     }
     ```
### **Updating a new subscription**
  * `patch http://localhost:3000/api/v1/customers/{customer_id}/subscriptions/{customer_subscription_id}`
  * With headers `Content-Type = application/value`
  * Body
    ```ruby
    {
    "update": "active status"
    }
    ```
  * Expected Response 
    ```ruby
    {
    "data": {
        "id": 5,
        "name": "Jon Snow",
        "subscription": {
            "name": "Single Tea",
            "active": false
        }
      }
    }
    ```
   * **Note** This endpoint changes active status from true to false and also from false to true
  
### **Getting all the subscriptions of a customer**
   * `get http://localhost:3000/api/v1/customers/{customer_id}/subscriptions`
   * Expected Response
     ```ruby
     {
      "data": {
        "customer": {
            "id": 1,
            "name": "Harry Potter"
        },
        "subscriptions": [
            {
                "name": "Single Tea",
                "frequency": "monthly",
                "price": 10,
                "active": false
            },
            {
                "name": "Tea Lover",
                "frequency": "yearly",
                "price": 20,
                "active": false
            },
             ..., 
            {
                "name": "Tea Fiend",
                "frequency": "weekly",
                "price": 30,
                "active": true
            }
           ]
         }
       }
       ``` 
   * If you want only the `active` or `inactive` subscriptions this end point accepts query params and the response format will be the same
     - `get http://localhost:3000/api/v1/customers/{customer_id}/subscriptions?status=active`
     - `get http://localhost:3000/api/v1/customers/{customer_id}/subscriptions?status=inactive`
     

## Gems Used
* Faker
* Factory Bot
* Faraday
* Shoulda-Matchers
* RSpec-Rails
      
