


Shoes.app :title => "Clipboard History", :width => 700, :resizable => true do
  background dimgray
  #border white, :strokewidth => 5
  
  @index = 0
  @elements = Array.new(1, "Just an intial placeholder.")

    
    
    
    
    
  
  stack :height => 32, :width => "100%" do
    background darkblue
    #border gainsboro, :strokewidth => 3
    @title = para "Clipboard entry %03d" % (@index + 1), :size => 16, 
    :stroke => white, :align => "center", :weight => 900
  end

  stack :width => 350, :margin => 5 do
    #background gray
    #border dimgray, :strokewidth => 2
    flow do#:left => 100 do #:left => 100, :right => 100
      @prev = button "Prev", :width => "33%"
      @next = button "Next", :width => "33%"
      @copy = button "Copy to clipboard", :width => "34%"
    end
    #self.move(5,32)
  end

  stack do  
    background cornsilk
    background gainsboro, :strokewidth => 3, :height => 6
    #background gainsboro, :strokewidth => 3, :width => 6
    #background gainsboro, :strokewidth => 3, :width => 6, :left => 688
    #border gainsboro, :strokewidth => 10
    @clipboard = para "#{@elements[@index]}", :weight => 600, :margin => 20,:stroke => black, :size => 10#, :left => 85, :top => 120
  end
  stack do
    background gainsboro, :strokewidth => 3, :height => 6
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

  animate(1) do
    cb = clipboard()
    if cb != @elements.last
      @elements << cb
      @index = @elements.length - 1
      @clipboard.text = @elements[@index]
      @title.text = "Clipboard entry %03d" % (@index + 1)
    end
  end
end