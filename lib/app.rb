require 'json'
path = File.join(File.dirname(__FILE__), '../data/products.json')
file = File.read(path)
products_hash = JSON.parse(file)

# Print today's date
date = Time.now
puts date
puts "                     _            _       "
puts "                    | |          | |      "
puts " _ __  _ __ ___   __| |_   _  ___| |_ ___ "
puts "| '_ \\| '__/ _ \\ / _` | | | |/ __| __/ __|"
puts "| |_) | | | (_) | (_| | |_| | (__| |_\\__ \\"
puts "| .__/|_|  \\___/ \\__,_|\\__,_|\\___|\\__|___/"
puts "| |                                       "
puts "|_|                                       "

items = products_hash['items']
# For each product in the data set:
sales = 0
items.each do |item|
	# Print the name of the toy
	puts "Item: #{item["title"]}"
	# Print the retail price of the toy
	puts "Price: #{item["full-price"]}"
	# Calculate and print the total number of purchases
	puts "Purchases: #{item["purchases"].length}"
	purchases = item["purchases"]
	purchases.each do |purchase|
		sales += purchase["price"]
	end
	item["Sales"] = sales
	# Calculate and print the total amount of sales
	puts "Sales: $#{sales}"
	average = sales/purchases.length
	# Calculate and print the average price the toy sold for
	puts "Average Price: $#{average}"
	discount = item["full-price"].to_f - average
	# Calculate and print the average discount (% or $) based off the average sales price
	puts "Average Discount: $#{discount}"
	sales = 0
	puts "\n"
end

puts " _                         _     "
puts "| |                       | |    "
puts "| |__  _ __ __ _ _ __   __| |___ "
puts "| '_ \\| '__/ _` | '_ \\ / _` / __|"
puts "| |_) | | | (_| | | | | (_| \\__ \\"
puts "|_.__/|_|  \\__,_|_| |_|\\__,_|___/"
puts

brands_data = Hash.new
items.each do |item|
	brand = item["brand"]
	item_price = item["full-price"].to_f
	if !brands_data.has_key?(brand)
		brands_data[brand] = Hash.new
		brands_data[brand]["count"] = 1
		brands_data[brand]["price"] = item_price
		brands_data[brand]["Sales"] = item["Sales"]
		brands_data[brand]["Stock"] = item["stock"]
		brands_data[brand]["purchases"] = item["purchases"].length
	else
		brands_data[brand]["count"] += 1
		brands_data[brand]["price"] += item_price
		brands_data[brand]["Sales"] += item["Sales"]
		brands_data[brand]["Stock"] += item["stock"]
		brands_data[brand]["purchases"] += item["purchases"].length
	end
end
# For each brand in the data set:
brands_data.each do |brand, value|
	average = value["Sales"] / value["purchases"]
	# Print the name of the brand
	puts brand
	# Count and print the number of the brand's toys we stock
	puts "Total Stock: #{value["Stock"]}"
	# Calculate and print the average price of the brand's toys
	puts "Avarage Price: $#{average.round(2)}"
	# Calculate and print the total revenue of all the brand's toy sales combined
	puts "Revenue: $#{value["Sales"].round(2)}"
	puts "\n"
end
