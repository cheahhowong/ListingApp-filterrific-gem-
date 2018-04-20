### Implement Filterrific gem

This repo contains scaffold of Users and Listings, where User has many Listings.

### Instructions to start
1. Clone this repo.
2. Run `bundle install`
3. Run `rails db:create && db:migrate && db:seed`
4. Run `rails s`

### Instructions to implement
1. Implement [Filterrific](https://github.com/jhund/filterrific) gem into `Listings#index`. Refer to documentation on how it works.
2. Filter features:
    * Search by Listing title.
    * Select (dropdown) by Listing country.
    * Select (dropdown) by Listing num_beds.
    * Sorted by num_baths and num_beds.
    * [BONUS] Search by User name.
