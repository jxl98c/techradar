module Radars
  class BlipsController < ApplicationController
    def new
      @blip = radar.new_blip({})
      render "new", locals: { quadrants: quadrants, rings: rings, blip: blip, topics: topics }
    end

    def create
      @blip = radar.new_blip(blip_params)
      if blip.save
        redirect_to radar
      else
        render "new", locals: { quadrants: quadrants, rings: rings, blip: blip, topics: topics }
      end
    end

    def show
      render "show", locals: { quadrants: quadrants, rings: rings, blip: blip.decorate, topics: topics }
    end

    def edit
      render "edit", locals: { quadrants: quadrants, rings: rings, blip: blip, topics: topics }
    end

    def update
      if blip.update(blip_params)
        redirect_to radar, notice: "Blip updated"
      else
        render "edit", locals: { quadrants: quadrants, rings: rings, blip: blip, topics: topics }
      end
    end

    def destroy
      blip.destroy!
      redirect_to radar
    end

    private

    def blip_params
      params.require(:blip).permit(:topic_id, :quadrant, :ring, :notes)
    end

    def radar
      @radar ||= Radar.find(params[:radar_id])
    end

    def blip
      @blip ||= radar.find_blip(params[:id])
    end

    def quadrants
      Blip::QUADRANTS.each_with_object({}) do |item, result|
        result[item.titleize] = item
      end
    end

    def rings
      Blip::RINGS.each_with_object({}) do |item, result|
        result[item.titleize] = item
      end
    end

    def topics
      Topic.order(:name)
    end
  end
end
