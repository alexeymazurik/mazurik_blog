class SectionsController < ApplicationController
  before_action :set_section, only: %w(update destroy)
  add_breadcrumb 'Sections', :sections_path, only: %w(index)

  def index
    @section = Section.new
    @sections = Section.all.order(:id)
  end

  def create
    @section = Section.new(section_params)
    if @section.save
      redirect_to sections_path, notice: 'Section was successfully created.'
    else
      redirect_to sections_path, notice: 'Some errors occurred.'
    end
  end

  def update
    if @section.update(section_params)
      redirect_to sections_path, notice: 'Section was successfully updated.'
    else
      redirect_to sections_path, notice: 'Some errors occurred.'
    end
  end

  # DELETE /sections/1
  def destroy
    @section.destroy
    redirect_to sections_path, notice: 'Section was successfully destroyed.'
  end

  private
    def set_section
      @section = Section.find(params[:id])
    end

    def section_params
      params.require(:section).permit(:name)
    end
end
