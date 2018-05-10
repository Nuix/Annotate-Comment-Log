# Menu Title: Annotate Comment Log
# Needs Case: true
# Needs Selected Items: false

# Attempts to locate comment entries in content text, scrape them out using a regular expression
# and then record them as a comment log in a custom metadata field

# Copyright 2018 Nuix
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#     http://www.apache.org/licenses/LICENSE-2.0
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# Custom metadata field name
custom_field = "Comment Log"
# Query to find power point items which should have comments present
query = "properties:\"Contains Comments:true\" AND name:( ppt OR pptx )"

# Regex to parse out comments from content text
# Ex:
#     Smith, Bob [ABCD] (XYZ) @ Jun 02, 2010 11:31:41 PM: Icons are not aligned properly, font is inconsistent.
#     Doe, Jane [ABCD] (XYZ) @ Jun 02, 2010 11:59:01 PM: Aligned icons, fixed fonts to be consisten with style guide.
regex = /^(.*, .*) \[[^\]]+\] \([^\)]+\) @ ([a-z]{3} [012][0-9], [0-9]{4} [0-9]{2}:[0-9]{2}:[0-9]{2} [AP]M): (.*)$/i

# Get items which should be scanned
items = $current_case.search(query)

annotater = $utilities.getBulkAnnotater
last_progress = Time.now

items.each_with_index do |item,item_index|
	puts "="*20
	puts "Item Name: #{item.getLocalisedName}"
	puts "GUID: #{item.getGuid}"

	item_text = item.getTextObject.toString
	match_data = item_text.scan(regex)

	pieces = []

	match_data.each do |match|
		comment_author = match[0].strip
		comment_date = match[1].strip
		comment_message = match[2].strip

		piece = "#{comment_author} @ #{comment_date}: #{comment_message}"
		pieces << piece
	end

	comment_log = pieces.join("\n")
	puts comment_log

	annotater.putCustomMetadata(custom_field,comment_log,[item],"text","user",nil,nil)

	if (Time.now - last_progress) > 1 || (item_index + 1) == items.size
		puts "#{item_index + 1}/#{items.size}"
	end
end

puts "Completed"