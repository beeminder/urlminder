class GoalsController < ApplicationController

  def create
    redirect_to root_url and return unless current_user.has_token
    goal = Goal.new
    goal.user = current_user
    goal.rate = params[:goal][:rate]
    goal.slug = params[:goal][:slug]
    goal.title = params[:goal][:title]
    goal.refreshed = Time.now
    params[:goal].select { |k, v| k.match(/^url/) && v.present? }.each { |k, v| goal.urls << v }
    
    bee = current_user.beeminder_client
    begin
      bee.create_goal({
        :title => goal.title,
        :slug  => goal.slug,
        :rate  => goal.rate,
        :goal_type => "biker",
        :initval => goal.count_words, 
        :goaldate => (Time.now + 1.year).to_i
        })
      goal.save  
      redirect_to root_url, :flash => { :notice => "Beeminder goal created" }
    rescue Exception => e
      redirect_to root_url, :flash => { :error => "Could not create that goal on Beeminder" }
    end
  end

  def update
    
  end

  def refresh
    user = User.where(:username => params[:username]).first
    return unless user
    goal = user.goals.where(:slug => params[:slug]).first
    return unless goal
    goal.refresh
    redirect_to root_url
  end

end