class CreaturesController < ApplicationController
	# display all creatures
	def index
		#gel all creatures from db and sav to instance variables
		@creatures = Creature.all
		#render the index view
		render :index
	end

	def new
		@creature = Creature.new
		render :new
	end

	def create
		#whitelist(designate what's acceptable) for the params of the new creatures
		creature_params = params.require(:creature).permit(:name, :description)
		#create the creature using the params variable
		creature = Creature.new(creature_params)
		if creature.save
			redirect_to creatures_path(creature) #aka redirect to "/creatures#{creature.id}"
		end
	end

	#display a selected creature
	def show
		#get the selected creature
		creature_id = params[:id]

		#fid said creature and save it
		@creature = Creature.find_by_id(creature_id)
		render :show
	end

	def edit
		creature_id = params[:id]
		@creature = Creature.find_by_id(creature_id)
		render :edit
	end

	def update
		creature_id = params[:id]
		creature = Creature.find_by_id(creature_id)
		creature_params = params.require(:creature).permit(:name, :description)
		creature.update_attributes(creature_params)
		redirect_to creature_path(creature)
	end

	def destroy
		creature_id = params[:id]
		creature = Creature.find_by_id(creature_id)
		creature.destroy
		redirect_to creatures_path
	end


end
