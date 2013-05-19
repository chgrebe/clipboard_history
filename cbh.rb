


Shoes.app :title => "Clipboard History" do
  @index = 0
  @elements = clipboard() ? [clipboard()] : [0]


  stack do
    background dimgray
    border gray, :strokewidth => 3
    @title = title "Clipboard entry %03d" % (@index + 1), :size => 16, 
    :stroke => blue, :align => "center", :weight => 900, :margin => 10
  end
  stack do
    background darkgray
    border gray, :strokewidth => 3
    @clipboard = para "#{@elements[@index]}", :stroke => blue
  end
  
  flow :left => 20 do
    @prev = button "Prev"#, :left => 25
    @next = button "Next"
    @copy = button "Copy to clipboard"
  end
  
  
  @prev.click do
    @index -= 1 if @index > 0
    @clipboard.text = @elements[@index]
    @title.text = "Clipboard entry %03d" % (@index + 1)
  end
  
  @next.click do
    @index +=1 if @elements[@index + 1] != nil
    @clipboard.text = @elements[@index]
    @title.text = "Clipboard entry %03d" % (@index + 1)
  end
  
  @copy.click do
    app.clipboard = @elements[@index]
  end

  animate 1 do
    @elements << clipboard() if clipboard() != @elements.last
    
  end

end