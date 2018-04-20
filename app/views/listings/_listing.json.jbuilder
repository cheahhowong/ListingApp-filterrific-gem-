json.extract! listing, :id, :listings, :user_id, :title, :country, :num_beds, :num_bath, :price_per_night, :created_at, :updated_at
json.url listing_url(listing, format: :json)
