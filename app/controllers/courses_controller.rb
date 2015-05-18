class CoursesController < ApplicationController

  def show
    @course = Course.find(params[:id])
  end

  def new
    @course = Course.new
  end

  def create
    @course = Course.new(course_params)
    if @course.save
      flash[:success] = "New course created!"
      redirect_to @course
    else
      render 'new'
    end
  end

  def edit
    @course = Course.find(params[:id])
  end

  def update
    @course = Course.find(params[:id])
    if @course.update_attributes(course_params)
      flash[:success] = "Changes saved!"
      redirect_to @course
    else
      render 'edit'
    end
  end

  def index
    @courses = Course.all
  end

  private

    def course_params
      params.require(:course).permit(:name, :summary)
    end
end
