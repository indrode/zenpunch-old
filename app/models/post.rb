class Post < ActiveRecord::Base
  validates_presence_of :body
  has_many  :logcomments
  
  
  def self.search(query, page)

    cond = ""
    arrQuery = Array.new 
      if query
        arrQuery = query.gsub(/[^a-zA-Z 0-9]/, "").split(' ')
        arrQuery.length.times do |i|
          cond += " AND" if i>0
          cond += " body like '%"+arrQuery[i].to_s+"%'"
        end
      end    
    
    paginate :per_page => 20, :page => page,
             :conditions => cond, 
             :order => 'created_at DESC'

  end

end
