require_relative 'building'

class Simulation

	attr_reader :building, :floors, :elevators, :people

	def initialize(num_of_floors, num_of_elevators, num_of_people)
		@registered_objects = Array.new

		@building 	= Building.new
		register(@building)

		initialize_floors(num_of_floors)

		initialize_people(num_of_people)

		initialize_elevators(num_of_elevators)
	end

	def initialize_floors num_of_floors
		while num_of_floors > 0 do
			num_of_floors -= 1
			temp_floor = Floor.new({floor_number: num_of_floors.to_s})
			@building.floors.push(temp_floor)
			register(temp_floor)
		end
	end

	def initialize_people num_of_people
		while num_of_people > 0 do
			num_of_people -= 1
			temp_floor_1 = @building.floors.sample
			temp_person	 = Person.new({location: temp_floor_1, desired_floor: @building.floors.sample})
			temp_floor_1.persons.push(temp_person)
			register(temp_person)
		end
	end

	def initialize_elevators num_of_elevators
		while num_of_elevators > 0 do
			temp_elevator = Elevator.new({location: @building.floors.last, name: "Lift #{num_of_elevators}"})
			@building.elevators.unshift(temp_elevator)
			num_of_elevators -= 1
			register(temp_elevator)
		end
	end

	def register domain_model
		@registered_objects.unshift(domain_model)
	end

	def run n
		while n >= 0 do
			puts @building.to_s
			@registered_objects.each do |registered_object|
				registered_object.tick
			end
			n -= 1
		end
	end

end

sim = Simulation.new(6, 2, 50)
sim.run(20)