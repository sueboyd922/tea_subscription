task load_teas: :environment do
  Tea.destroy_all

  response = Faraday.new("https://tea-api-vic-lo.herokuapp.com").get("/tea")
  tea_info = JSON.parse(response.body, symbolize_names: true)

  tea_info.each do |tea|
    Tea.create!(
      name: tea[:name],
      description: tea[:description],
      brew_time: tea[:brew_time],
      temperature: tea[:temperature]
    )
  end

  puts "#{Tea.all.count} teas stored in database"
end
