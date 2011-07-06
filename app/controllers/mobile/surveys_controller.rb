class Mobile::SurveysController < Mobile::ApplicationController
  
  def new
    @survey=Meta::Survey.new_fillable_survey(params[:metum_id])
  end

end