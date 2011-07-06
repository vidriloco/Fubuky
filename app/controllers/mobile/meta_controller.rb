class Mobile::MetaController < Mobile::ApplicationController
  def index
    @m_surveys = Meta::Survey.all
  end
end