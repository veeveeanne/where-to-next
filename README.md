# WhereToNext
WhereToNext is a travel planning site that helps a user track the places they
want to visit in the United States, and then helps them decide which of those
destinations they should travel to next. It integrates the Google Places API to
provide interactive information on the destinations that a user saves to their
travel list as well as the geolocation data. Through the integration of the
Amadeus Travel API, the application searches for flights to each of the
destinations a user has saved on their list. WhereToNext then evaluates the
average cost for flights to each destination, and returns a recommendation to
the user on where they should travel to based on the most economical flight cost.

Visit the deployed application [here](http://wheretonext-app.herokuapp.com/)

## Author
- Vivian Wang

## Built With
- [Ruby on Rails](https://guides.rubyonrails.org/v5.2/)
- [React.js](https://reactjs.org/docs/getting-started.html)
- [PostgreSQL](https://www.postgresql.org/docs/12/index.html)

### Getting started:
The setup steps expect the following tools/versions:
- Ruby 2.6.5
- Rails 5.2.4.2
- PostgreSQL 12

###### Checkout the repository
```
git clone https://github.com/veeveeanne/where-to-next
```

###### Create and setup the database
```
bundle exec rake db:setup
```

###### Run the test suite
```
bundle exec rspec
```

###### Start the Rails server and webpack-dev-server
```
bundle exec rails s
yarn run start
```
###### The application can be accessed via <http://localhost:3000>


[![Codeship Status for veeveeanne/where-to-next](https://app.codeship.com/projects/528ab420-664a-0138-203b-1ea491acffa0/status?branch=master)](https://app.codeship.com/projects/393674)
