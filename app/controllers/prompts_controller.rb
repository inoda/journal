class PromptsController < ApplicationController
  before_action :find_prompt, only: [:destroy]

  def index
    @prompts = Prompt.order(created_at: :desc).paginate(params[:page])
  end

  def create
    prompt = Prompt.new(content: params[:content])

    if prompt.save
      flash[:success] = "Prompt saved"
    else
      flash[:error] = prompt.errors.full_messages.join(", ")
    end

    redirect_to prompts_path
  end

  def destroy
    if @prompt.destroy
      flash[:success] = "Prompt deleted"
    else
      flash[:error] = "Issue deleting prompt"
    end

    redirect_to prompts_path
  end

  private

  def find_prompt
    @prompt = Prompt.find_by_id(params[:id])

    if !@prompt
      flash[:error] = "Prompt is missing"
      redirect_to prompts_path and return
    end
  end
end
