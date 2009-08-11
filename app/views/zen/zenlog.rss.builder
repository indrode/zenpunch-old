xml.instruct! :xml, :version=>"1.0" 
xml.rss(:version=>"2.0"){
  xml.channel{
    xml.title("(zen punch)")
    xml.link("http://indrode.com/")
    xml.description("(zen punch) is the virtual playground of Indro De.")
    xml.language('en-us')
      for post in @posts
        xml.item do
          xml.title(post.id)
          xml.description(post.body)      
          xml.author("Indro De")               
          xml.pubDate(post.created_at.strftime("%a, %d %b %Y"))
        end
      end
  }
}