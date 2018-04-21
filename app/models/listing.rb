class Listing < ApplicationRecord
  belongs_to :user

  filterrific(
    default_filter_params: { sorted_by: 'created_at_desc' },
    available_filters: [
      :sorted_by,
      :with_num_bed,
      :with_country,
      :search_query
    ]
  )

  def self.options_for_select
    order('LOWER(country)').map { |e| [e.country] }.uniq
  end

  scope :with_country, lambda { |countries|
        where(country: [*countries])
  }

  def self.options_for_select_bed
    order('LOWER(num_beds)').map { |e| [e.num_beds] }.uniq
  end

  scope :with_num_bed, lambda { |beds|
  	 where(num_beds: [*beds])
  }
  
  def self.options_for_sorted_by
    [
      ['Num beds (a-z)', 'num_beds_asc'],
      ['Num beds (z-a)', 'num_beds_desc'],
      ['Num bath (a-z)', 'num_bath_asc'],
      ['Num bath (z-a)', 'num_bath_desc'],
      ['Created at (Newest first)', 'created_at_desc'],
      ['Created at (Oldest first)', 'created_at_asc']
    ]
  end

  scope :sorted_by, lambda { |sort_option|
  # extract the sort direction from the param value.
  direction = (sort_option =~ /desc$/) ? 'desc' : 'asc'
  case sort_option.to_s
  when /^created_at_/
    # Simple sort on the created_at column.
    # Make sure to include the table name to avoid ambiguous column names.
    # Joining on other tables is quite common in Filterrific, and almost
    # every ActiveRecord table has a 'created_at' column.
    order("listings.created_at #{ direction }")
  when /^num_beds_/
    order("LOWER(listings.num_beds) #{ direction }")
  when /^num_bath_/
    order("LOWER(listings.num_bath) #{ direction }")
  else
    raise(ArgumentError, "Invalid sort option: #{ sort_option.inspect }")
  end
  }

  scope :search_query, lambda { |query|
  # Searches the students table on the 'first_name' and 'last_name' columns.
  # Matches using LIKE, automatically appends '%' to each term.
  # LIKE is case INsensitive with MySQL, however it is case
  # sensitive with PostGreSQL. To make it work in both worlds,
  # we downcase everything.
  return nil  if query.blank?

  # condition query, parse into individual keywords
  terms = query.downcase.split(/\s+/)

  # replace "*" with "%" for wildcard searches,
  # append '%', remove duplicate '%'s
  terms = terms.map { |e|
    (e.gsub('*', '%') + '%').gsub(/%+/, '%')
  }
  # configure number of OR conditions for provision
  # of interpolation arguments. Adjust this if you
  # change the number of OR conditions.
  num_or_conds = 1
  where(
    terms.map { |term|
      "(LOWER(listings.title) LIKE ? )"
    }.join(' AND '),
    *terms.map { |e| [e] * num_or_conds}.flatten
  )
}

  scope :search_name, lambda { |query|
  # Searches the students table on the 'first_name' and 'last_name' columns.
  # Matches using LIKE, automatically appends '%' to each term.
  # LIKE is case INsensitive with MySQL, however it is case
  # sensitive with PostGreSQL. To make it work in both worlds,
  # we downcase everything.
  return nil  if query.blank?

  # condition query, parse into individual keywords
  terms = query.downcase.split(/\s+/)

  # replace "*" with "%" for wildcard searches,
  # append '%', remove duplicate '%'s
  terms = terms.map { |e|
    (e.gsub('*', '%') + '%').gsub(/%+/, '%')
  }
  # configure number of OR conditions for provision
  # of interpolation arguments. Adjust this if you
  # change the number of OR conditions.
  num_or_conds = 1
  where(
    terms.map { |term|
      "(LOWER(users.name) LIKE ? )"
    }.join(' AND '),
    *terms.map { |e| [e] * num_or_conds}.flatten
  )
}

end
