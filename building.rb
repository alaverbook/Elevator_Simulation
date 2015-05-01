require_relative 'floor'
require_relative 'elevator'

class Building
	attr_reader :elevators, :floors

	def initialize(args={})
		@elevators	= args[:elevators]	|| default_elevators
		@floors		= args[:floors]		|| default_floors
	end

	def default_elevators
		Array.new
	end

	def default_floors
		Array.new
	end

	def to_s
		result = "-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-\n"
		@floors.each do |floor|
			result += floor.to_s
			@elevators.each do |elevator|
				if elevator.location == floor
					result += elevator.to_s
				end
			end
		end
		result += "-----------------------------------------------\n\n"
		return result
	end

	def tick
		floors_with_people_going_up = Array.new
		floors_with_people_going_down = Array.new
		@floors.each do |floor|
			if floor.call_buttons["up"] == "pressed"
				floors_with_people_going_up.push(floor)
			end
			if floor.call_buttons["down"] == "pressed"
				floors_with_people_going_down.push(floor)
			end
		end
		@elevators.each do |elevator|
			if elevator.direction == "down"
				if elevator.location == @floors.last
					elevator.set_direction_still
				else
					elevator.set_location(@floors.at(@floors.index(elevator.location) + 1))
				end
			elsif elevator.direction == "up"
				if elevator.location == @floors.first
					elevator.set_direction_down
				else
					elevator.set_location(@floors.at(@floors.index(elevator.location) - 1))
				end
			else
				if !floors_with_people_going_down.empty? || !floors_with_people_going_up.empty?
					elevator.set_direction_up
					elevator.set_location(@floors.at(@floors.index(elevator.location) - 1))
				elsif !elevator.persons.empty?
					elevator.set_direction_up
					elevator.set_location(@floors.at(@floors.index(elevator.location) - 1))
				end
			end
		end
		# @elevators.each do |elevator|
		# 	if elevator.persons.empty?
		# 		if floors_with_people_going_down.empty? && floors_with_people_going_up.empty?
		# 			resting_floor = @floors.last
		# 			if elevator.location != resting_floor
		# 				elevator.set_direction_down
		# 				elevator.set_location(@floors.at(@floors.index(elevator.location) + 1))
		# 			else
		# 				elevator.set_direction_still
		# 			end
		# 		else
		# 			if elevator.direction == "up"
		# 				if !floors_with_people_going_up.include? elevator.location
		# 					if elevator.location != @floors.last
		# 						elevator.set_location(@floors.at(@floors.index(elevator.location) - 1))
		# 					else
		# 						elevator.set_direction_still
		# 					end
		# 				end
		# 			elsif elevator.direction == "down"
		# 				if !floors_with_people_going_down.include? elevator.location
		# 					if elevator.location != @floors.first
		# 						elevator.set_location(@floors.at(@floors.index(elevator.location) + 1))
		# 					else
		# 						elevator.set_direction_still
		# 					end
		# 				end
		# 			else
		# 				if !floors_with_people_going_down.empty?
		# 					if elevator.location.floor_number.to_i < floors_with_people_going_down.first.floor_number.to_i
		# 						elevator.set_direction_up
		# 						elevator.set_location(@floors.at(@floors.index(elevator.location) - 1))
		# 					elsif elevator.location != @floors.last
		# 						elevator.set_direction_down
		# 						elevator.set_location(@floors.at(@floors.index(elevator.location) + 1))
		# 					end
		# 				elsif !floors_with_people_going_up.empty?
		# 					if elevator.location.floor_number.to_i > floors_with_people_going_up.first.floor_number.to_i
		# 						elevator.set_direction_down
		# 						elevator.set_location(@floors.at(@floors.index(elevator.location) + 1))
		# 					elsif elevator.location != @floors.first
		# 						elevator.set_direction_down
		# 						elevator.set_location(@floors.at(@floors.index(elevator.location) - 1))
		# 					end
		# 				end
		# 			end
		# 		end
		# 	else
		# 		if elevator.direction == "up"
		# 			if elevator.location != @floors.last
		# 				elevator.set_location(@floors.at(@floors.index(elevator.location) - 1))
		# 			else
		# 				elevator.set_direction_still
		# 			end
		# 		elsif elevator.direction == "down"
		# 			if elevator.location != @floors.first
		# 				elevator.set_location(@floors.at(@floors.index(elevator.location) + 1))
		# 			else
		# 				elevator.set_direction_still
		# 			end
		# 		else
		# 			if elevator.persons.first.desire == "up"
		# 				elevator.set_direction_up
		# 				elevator.set_location(@floors.at(@floors.index(elevator.location) - 1))
		# 			elsif elevator.persons.first.desire == "down"
		# 				elevator.set_direction_down
		# 				elevator.set_location(@floors.at(@floors.index(elevator.location) + 1))
		# 			end
		# 		end
		# 	end

		# end
	end
end