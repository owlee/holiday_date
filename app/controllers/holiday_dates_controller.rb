class HolidayDatesController < ApplicationController
  before_action :set_holiday_date, only: [:show, :edit, :update, :destroy]

  # GET /holiday_dates
  # GET /holiday_dates.json
  def index
    @calendar_dates = CalendarDate.all
    @countries = Country.all

    boy = Date.new(Date.today.year.to_i)
    eoy = boy.end_of_year
    c = Country.first.id

    if params[:set_country] && params[:set_year]
      c = params[:set_country]
      y = params[:set_year]
      boy = Date.new(y)
      eoy = boy.end_of_year
    end

    filter_cal = CalendarDate.where(date: boy..eoy)

    # Adding pagination so things will get parsed for display quickly. Will_paginate
    @holiday_dates = HolidayDate.where(country: c).where(calendar_date: filter_cal.first.id..filter_cal.last.id).paginate(page: params[:page], per_page: 8)
  end

  # GET /holiday_dates/1
  # GET /holiday_dates/1.json
  def show
  end

  # GET /holiday_dates/new
  def new
    @holiday_date = HolidayDate.new
  end

  # GET /holiday_dates/1/edit
  def edit
  end

  # POST /holiday_dates
  # POST /holiday_dates.json
  def create
    @holiday_date = HolidayDate.new(holiday_date_params)

    respond_to do |format|
      if @holiday_date.save
        format.html { redirect_to @holiday_date, notice: 'Holiday date was successfully created.' }
        format.json { render :show, status: :created, location: @holiday_date }
      else
        format.html { render :new }
        format.json { render json: @holiday_date.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /holiday_dates/1
  # PATCH/PUT /holiday_dates/1.json
  def update
    respond_to do |format|
      if @holiday_date.update(holiday_date_params)
        format.html { redirect_to @holiday_date, notice: 'Holiday date was successfully updated.' }
        format.json { render :show, status: :ok, location: @holiday_date }
      else
        format.html { render :edit }
        format.json { render json: @holiday_date.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /holiday_dates/1
  # DELETE /holiday_dates/1.json
  def destroy
    @holiday_date.destroy
    respond_to do |format|
      format.html { redirect_to holiday_dates_url, notice: 'Holiday date was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_holiday_date
      @holiday_date = HolidayDate.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def holiday_date_params
      params.require(:holiday_date).permit(:holiday_id, :calendar_date_id)
    end
end
