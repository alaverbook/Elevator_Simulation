require_relative 'floor'

class Person
	attr_reader :desired_floor, :location

	def initialize(args={})
		@location		= args[:location]	|| default_location
		@desired_floor	= args[:desired_floor]	|| default_desired_floor
	end

	def default_location
		raise NotImplementedError
	end

	def default_desired_floor
		raise NotImplementedError
	end

	def update_location updated_location
		@location = updated_location
	end

	def desire
		if @location.is_a? Elevator
			current 	= @location.location.floor_number.to_i
			destination = @desired_floor.floor_number.to_i
			if current == destination
				return "stay"
			elsif current < destination
				return "up"
			else
				return "down"
			end
		else
			current 	= @location.floor_number.to_i
			destination = @desired_floor.floor_number.to_i
			if current == destination
				return "stay"
			elsif current < destination
				return "up"
			else
				return "down"
			end
		end
	end

	def to_s
		"\tPerson desires Floor #{desired_floor.floor_number}\n"
	end

	def tick
		
	end
end