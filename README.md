# Tea Subscription

This project is an API for a company that has tea subscriptions for customers. The company offers 3 different subscriptions: **Single Tea**, **Tea Lover** and **Tea Fiend**. The company has 12 different teas available (taken from the [Tea API](https://tea-api-vic-lo.herokuapp.com/). For this project I opted to use a rake task to hit the API and just store the tea data directly into the database. A customer can create a subscription with a certain number of teas on it, they can deactivate a subscription or activate it. The API also allows you to get all subscriptions for a particular customer and can opt to filter it by active and inactive subscriptions. 

## Schema

<img width="1087" alt="Screen Shot 2022-08-02 at 8 46 23 PM" src="https://user-images.githubusercontent.com/96309924/182739532-a35d66a0-4bcb-424d-a924-d05e2a31ac7f.png">



## Setup

To use this API on your local computer follow these instructions in your terminal: 

1. Clone this repository
2. `cd` into repository
3. Run `bundle install` 
4. Run `rails db:{create,migrate,seed}`
5. Run `rake load_teas`
6. Run `rails s`
7. Open Postman


## Gems Used
* Faker
* Factory Bot
* Faraday
* Shoulda-Matchers
* RSpec-Rails

## Endpoints

1. Create a new subscription 
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
        ```

