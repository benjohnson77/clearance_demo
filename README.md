# Problem

We need to clearance inventory from time to time.  Certain items don't sell through to our clients, so every month, we collect certain unsold items and sell them to a third party vendor for a portion of their wholesale price.

# Vocabulary

_Items_ refer to individual pieces of clothing.  So, if we have two of the exact same type of jeans, we have two items.  Items are grouped by _style_, so
the two aforementioned items would have the same style.

Important data about an item is:

* size
* color
* status - sellable, not sellable, sold, clearanced
* price sold
* date sold

A style's important data is:

* wholesale price
* retail price
* type - pants, shirts, dresses, skirts, other
* name

# Requirements

This application currently handles the clearance task in a very basic way. A spreadsheet containing a list of item ids is uploaded and those items are clearanced as a batch. Items can only be sold if their status is 'sellable' and the sold price is 75% of the wholesale price.

Some improvements are required for this app, specifically:

- All items must be sold, but the minimum price for pants and dresses is $5. For all other items the minimum price is $2.
- A report should be available for each batch to give to the vendor information about what they just bought
- Users should be able to see the status of items grouped by status and also by batch
- Items need also to be clearanced one at a time in the app (entered manually), but still grouped by batch

Tech Specs:

- Rails 4.1
- Ruby 2.1
- SQLite preferred, Postgres OK
- Anything can be changed if you think it's needed, including database schema, Rails config, whatever

# Some other guidance
* DO NOT HESITATE TO REFACTOR where appropriate

_____________________________________

# Feedback

This was a fun challenge and I appreciate the opportunity. 

1. I set up the app in a few minutes. I wanted to kind of pimp the dev env with a few things I like to add to my projects. So the Gemfile go a once over with some guard treatment in preperation for the visual aspects. 

2. I didn't notice the pricing 

