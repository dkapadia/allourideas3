class Earl < ActiveRecord::Base
  validates_presence_of :question_id, :on => :create, :message => "can't be blank"
  validates_presence_of :name, :on => :create, :message => "can't be blank"
  has_friendly_id :name, :use_slug => true, :reserved => ["questions", "question", 'about', 'privacy', 'tour']

  has_attached_file :logo, :whiny_thumbnails => true, :styles => { :headersize => "250x50>" }
  
  def question
    Question.find(question_id)
  end
end
