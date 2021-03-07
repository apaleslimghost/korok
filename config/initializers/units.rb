RubyUnits.configure do |config|
  config.separator = false
end

Unit.redefine!('ohm') do |ohm|
  ohm.aliases = %w[Ohm ohm ohms Ω]
  ohm.display_name = 'Ω'
end

class String
  def to_unit_maybe
    to_unit
  rescue ArgumentError
    self
  end
end

module FixUnitSpaceship
  def <=>(other)
    super(other)
  rescue ArgumentError
    return 0
  end
end

class Unit
  prepend FixUnitSpaceship
end
