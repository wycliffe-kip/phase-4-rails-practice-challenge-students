class StudentsController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
    rescue_from ActiveRecord::RecordInvalid, with: :render_invalid_response

    def index 
        render json: Student.all
    end 

    def show 
        student = Student.find(params[:id]) 
        render json: student
    end 

    # create action accepts an "instructor_id" parameter to 
    # associate the student with a specific instructor
    def create 
        instructor = Instructor.find(params[:instructor_id])
        student = instructor.students.create(student_params)
        render json: student, status: :created
    end 

    def update 
        student = Student.find(params[:id])
        student.update(student_params)
        render json: student, status: :ok
    end 

    def destroy 
        student = Student.find(params[:id])
        student.destroy
        head :no_content
    end 

    private 

    def student_params 
        params.permit(:name, :major, :age)
    end 

    def render_not_found_response
        render json: { error: "Student not found"}, status: :not_found
    end 

    def render_invalid_response(exception)
        render json: { error: exception.record.errors.full_messages }, status: :unprocessable_entity
    end
end
