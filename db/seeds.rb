[
  { en: 'South Sudan', sw: 'Sudan Kusini' },
  { en: 'Sudan',       sw: 'Sudan' },
  { en: 'Somalia',     sw: 'Somalia' },
  { en: 'Ethiopia',    sw: 'Ethiopia' },
  { en: 'D.R. Congo',  sw: 'J.K. Kongo' },
  { en: 'Burundi',     sw: 'Burundi' },
  { en: 'Rwanda',      sw: 'Rwanda' },
  { en: 'Eritrea',     sw: 'Eritrea' },
  { en: 'Uganda',      sw: 'Uganda' },
  { en: 'other',       sw: 'mengine' }
].each do |country|
  c = Country.new(name: country[:en])
  c.update_attributes(
    name: country[:sw],
    locale: :sw
  )
end
