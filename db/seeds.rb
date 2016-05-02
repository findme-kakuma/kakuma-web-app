unless Country.any?
  [
    { id: 1, en: 'South Sudan', sw: 'Sudan Kusini' },
    { id: 2, en: 'Sudan',       sw: 'Sudan' },
    { id: 3, en: 'Somalia',     sw: 'Somalia' },
    { id: 4, en: 'Ethiopia',    sw: 'Ethiopia' },
    { id: 5, en: 'D.R. Congo',  sw: 'J.K. Kongo' },
    { id: 6, en: 'Burundi',     sw: 'Burundi' },
    { id: 7, en: 'Rwanda',      sw: 'Rwanda' },
    { id: 8, en: 'Eritrea',     sw: 'Eritrea' },
    { id: 9, en: 'Uganda',      sw: 'Uganda' },
    { id: 10, en: 'other',      sw: 'mengine' }
  ].each do |country|
    c = Country.new(
      id: country[:id],
      name: country[:en]
    )
    c.update_attributes(
      name: country[:sw],
      locale: :sw
    )
  end
end

unless Resident.any?
  require 'csv'

  csv_text = File.read('tmp/residents.csv')
  csv = CSV.parse(csv_text, headers: true)
  csv.each do |row|
    h = row.to_hash
    country_name = if %w(
      South Sudan
      Sudan
      Somalia
      Ethiopia
      D.R. Congo
      Burundi
      Rwanda
      Eritrea
      Uganda
    ).include? h['country_name']
                     h['country_name']
                   else
                     'other'
                   end
    h.delete 'country_name'
    country = Country.where(name: country_name).first
    h['place'] = nil if h['place'] == 'NULL'
    begin
      r = country.residents.build(h)
      r.register
      r.save validate: false
    rescue Exception => e
      puts e.message
      puts "row: #{h}"
    end
  end
end
