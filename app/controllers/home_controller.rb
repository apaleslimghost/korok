class HomeController < ApplicationController
  layout 'base'

  def index
    if current_user
      redirect_to projects_path
    end

    @project = Project.new(name: 'Atari Punk Console')
    @project.requirements.new(
      part: Part.new(
        part_type: 'Resistor',
        value: '1kohm',
        quantity: 1
      ),
      quantity: 2
    )
    @project.requirements.new(
      part: Part.new(
        part_type: 'Resistor',
        value: '10kohm',
        quantity: 1
      ),
      quantity: 1
    )
    @project.requirements.new(
      part: Part.new(
        part_type: 'Resistor',
        value: '15kohm',
        quantity: 1
      ),
      quantity: 1
    )
    @project.requirements.new(
      part: Part.new(
        part_type: 'Resistor',
        value: '4.7kohm',
        quantity: 1
      ),
      quantity: 1
    )
    @project.requirements.new(
      part: Part.new(
        part_type: 'Resistor',
        value: '100kohm',
        quantity: 3
      ),
      quantity: 1
    )
    @project.requirements.new(
      part: Part.new(
        part_type: 'IC',
        value: '555 Timer',
        quantity: 1
      ),
      quantity: 2
    )
    @project.requirements.new(
      part: Part.new(
        part_type: 'Electrolytic Capacitor',
        value: '10μF',
        quantity: 1
      ),
      quantity: 1
    )
    @project.requirements.new(
      part: Part.new(
        part_type: 'Ceramic Capacitor',
        value: '100nF',
        quantity: 1
      ),
      quantity: 1
    )
    @project.requirements.new(
      part: Part.new(
        part_type: 'Ceramic Capacitor',
        value: '10nF',
        quantity: 1
      ),
      quantity: 1
    )
    @project.requirements.new(
      part: Part.new(
        part_type: 'Potentiometer',
        value: '500kohm',
        quantity: 0
      ),
      quantity: 2
    )

    @ready_project = Project.new(name: 'Super Simple Oscillator')
    @ready_project.requirements.new(
      part: Part.new(
        part_type: 'doesnt matter',
        value: '',
        quantity: 1
      ),
      quantity: 1
    )
  end
end
