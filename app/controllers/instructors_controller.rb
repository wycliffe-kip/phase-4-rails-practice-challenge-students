class InstructorsController < ApplicationController
    def index 
        render json: Instructor.all
    end 

    def show 
        instructor = Instructor.find(params[:id])
        render json: instructor
    end 

    def create 
        instructor = Instructor.create(instructor_params)
        render json: instructor, status: :created
    end 

    def update 
        instructor = Instructor.find(params[:id])
        instructor.update(instructor_params)
        render json: instructor, status: :updated
    end 

    def destroy 
        instructor = Instructor.find(params[:id])
        instructor.destroy
        status :no_content
    end 

    private 
    def instructor_params 
        params.permit(:name)
    end 
end
