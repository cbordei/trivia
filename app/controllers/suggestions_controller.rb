class SuggestionsController < AdminController
  before_action :authenticate_user!, only: :index

  def index
    @suggestions = Suggestion.paginate(:page => params[:page], :per_page => 12)
  end

  def new
    @suggestion = Suggestion.new
  end

  def create
    @suggestion = Suggestion.new(suggestion_params)
    respond_to do |format|
      if verify_recaptcha(:model => @suggestion, :message => "Eroare la reCAPTCHA! ESTI GABOR?") && @suggestion.save
        format.html { redirect_to root_path, notice: 'Am notat sugestia ta. Multumim' }
        format.json { render :show, status: :created, location: @suggestion }
      else
        format.html { render :new }
        format.json { render json: @suggestion.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def suggestion_params
    params.require(:suggestion).permit(:suggestion, :email)
  end
end
