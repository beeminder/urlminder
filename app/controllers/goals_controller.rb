class GoalsController < ApplicationController

  def create
    redirect_to root_url and return unless bee = current_user.beeminder_client
    goal = Goal.new
    goal.user = current_user
    goal.rate = params[:goal][:rate]
    goal.slug = params[:goal][:slug]
    goal.title = params[:goal][:title]
    params[:goal].select { |k, v| k.match(/^url/) }.each { |k, v| goal.urls << v }
    goal.save

    bee.create_goal({
      :title => goal.title,
      :slug  => goal.slug,
      :rate  => goal.rate,
      :goal_type => "biker",
      :initval => goal.count_words, 
      :goaldate => (Time.now + 1.year).to_i
      })

    redirect_to root_url
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