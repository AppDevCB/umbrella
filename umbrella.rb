require "open-uri"
require "date"
require "json"

#user_location = gets.chomp

#p user_location


#https://maps.googleapis.com/maps/api/geocode/json?address=Merchandise%20Mart%20Chicago&key=AIzaSyAgRzRHJZf-uoevSnYDTf08or8QFS_fb3U

location = "Taj Mahal"


#gmapurl = "https://maps.googleapis.com/maps/api/geocode/json?address=" + location + "&key=AIzaSyAgRzRHJZf-uoevSnYDTf08or8QFS_fb3U"

#newlocation = "https://maps.googleapis.com/maps/api/geocode/json?address=PLACEHOLDER&key=AIzaSyAgRzRHJZf-uoevSnYDTf08or8QFS_fb3U".gsub("PLACEHOLDER, user_location")

gmapurl = "https://maps.googleapis.com/maps/api/geocode/json?address=#{location}&key=" + ENV.fetch("GMAPS_KEY")


x  = URI.open(gmapurl).read

GMJ = JSON.parse(x)
results_array = GMJ.fetch("results")

first_result = results_array.at(0)

geo = first_result.fetch("geometry")

loc = geo.fetch("location")


latitude = loc.fetch("lat")
longtitude =  loc.fetch("lng")

lat = latitude.to_s
lng = longtitude.to_s

print(lng)

# use latitude and longtitude to compose the correct
# endpoint in Dark Sky's API
# Print the current tempreature
# instruction in readme

darkskyapi = "https://api.darksky.net/forecast/26f63e92c5006b5c493906e7953da893/" + lat + "," + lng

dsapiSTR = URI.open(darkskyapi).read
DSA = JSON.parse(dsapiSTR)
currenttemp = DSA.fetch("currently")
curtemp = currenttemp.fetch("temperature")
p curtemp




require "twilio-ruby"





# Get your credentials from your Twilio dashboard, or from Canvas if you're using mine
twilio_sid = ENV.fetch("TWILIO_KEY")
twilio_token = "fad757a15068305da3fa1250ce6eb4d9"
twilio_sending_number = "+13126636198"

# Create an instance of the Twilio Client and authenticate with your API key
twilio_client = Twilio::REST::Client.new(twilio_sid, twilio_token)

# Craft your SMS as a Hash literal with three keys
sms_info = {
  :from => twilio_sending_number,
  :to => "+34666755378", # Put your own phone number here if you want to see it in action
  :body => "It's going to rain today — take an umbrella!"
}


# Send your SMS!
twilio_client.api.account.messages.create(sms_info)
