RubyUnits.configure do |config|
  config.separator = false
end

Unit.redefine!('ohm') do |ohm|
  ohm.aliases = %w[Ohm ohm ohms Ω]
  ohm.display_name = 'Ω'
end
