class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy 
  has_many :tags, dependent: :destroy

  def self.tagged_with(name)
  	Tage.find_by!(name: name).posts
  end

  def all_tages(names)
  	self.tags = names.split(",").map do |name|
  		Tage.where(name: name ).frist_or_create!
  	end  		
  end

  def all_tags
  	tages.map(&:name).join(", ")
  end

  def delete_post
    DeletePost.perform_in(24.hours, id)
  end


  def as_json(options = {})
    super(options.merge(include: [:user, comments: {include: :user}]))
  end

end
