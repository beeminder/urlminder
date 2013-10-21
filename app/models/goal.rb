class Goal
  include Mongoid::Document

  field :slug
  field :title
  field :rate
  field :urls, :type => Array, :default => []
  field :refreshed, :type => Time

  belongs_to :user

  def shortname
    user.username + "/" + slug
  end

  def count_words
    total_count = 0
    urls.each do |url|
      url = "http://" + url unless url.match(/^http/)
      count = 0
      begin
      count = HTTParty.get(url).body.split.size
      rescue Exception=>e
        # do something...
      end
      total_count += count
    end
    total_count
  end

  def refresh
    set(:refreshed => Time.now)
    bee = user.beeminder_client
    beegoal = bee.goal(slug)
    dp = Beeminder::Datapoint.new :value => count_words, :comment => "Auto-entered from URLminder"
    beegoal.add(dp)
  end

end