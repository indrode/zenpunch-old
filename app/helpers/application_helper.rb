# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  
  # deprecated; may be replaced in future
  def remote_link_to(text, link, options={})
    html_class = "remote #{options.delete(:class)}".strip
    link_to(text, link, options.merge({:class => html_class}))
  end

  def format_user_text(input)
  output = "#{input.strip}"

  # do some formatting
  output.gsub!(/\r\n/, "\n")       # remove CRLFs
  output.gsub!(/^$\s*/m, "\n")     # remove blank lins
  output.gsub!(/\n{3,}/, "\n\n")   # replace \n\n\n... with \n\n
  output.gsub!(/\n\n/, '</p><p>')  # embed stuff in paragraphs
  output.gsub!(/\n/, '<br/>')      # nl2br
  
  sanitize_fu output
  end

# Adapted from http://ideoplex.com/id/1138/sanitize-html-in-ruby
def sanitize_fu(html, okTags = 'a href, b, br, p, i, em')
  # no closing tag necessary for these
  soloTags = ["br","hr"]

  # Build hash of allowed tags with allowed attributes
  tags = okTags.downcase().split(',').collect!{ |s| s.split(' ') }
  allowed = Hash.new
  tags.each do |s|
    key = s.shift
    allowed[key] = s
  end

  # Analyze all <> elements
  stack = Array.new
  result = html.gsub( /(<.*?>)/m ) do | element |
    if element =~ /\A<\/(\w+)/ then
      # </tag>
      tag = $1.downcase
      if allowed.include?(tag) && stack.include?(tag) then
        # If allowed and on the stack
        # Then pop down the stack
        top = stack.pop
        out = "</#{top}>"
        until top == tag do
          top = stack.pop
          out << "</#{top}>"
        end
        out
      end
    elsif element =~ /\A<(\w+)\s*\/>/
      # <tag />
      tag = $1.downcase
      if allowed.include?(tag) then
        "<#{tag} />"
      end
    elsif element =~ /\A<(\w+)/ then
      # <tag ...>
      tag = $1.downcase
      if allowed.include?(tag) then
        if ! soloTags.include?(tag) then
          stack.push(tag)
        end
        if allowed[tag].length == 0 then
          # no allowed attributes
          "<#{tag}>"
        else
          # allowed attributes?
          out = "<#{tag}"
          while ( $' =~ /(\w+)=("[^"]+")/ )
            attr = $1.downcase
            valu = $2
            if allowed[tag].include?(attr) then
              out << " #{attr}=#{valu}"
            end
          end
          out << ">"
        end
      end
    end
  end

  # eat up unmatched leading >
  while result.sub!(/\A([^<]*)>/m) { $1 } do end

  # eat up unmatched trailing <
  while result.sub!(/<([^>]*)\Z/m) { $1 } do end

  # clean up the stack
  if stack.length > 0 then
    result << "</#{stack.reverse.join('></')}>"
  end

  result
end

end
