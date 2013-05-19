


Shoes.app :title => "Clipboard History", :width => 700, :height => 700, :resizable => false do
  background dimgray
  #border white, :strokewidth => 5
  
  @index = 0
  @elements = clipboard() ? [clipboard()] : [0]

    
  
  stack :height => 32, :width => "100%" do
    background darkblue
    border gainsboro, :strokewidth => 3
    @title = para "Clipboard entry %03d" % (@index + 1), :size => 16, 
    :stroke => white, :align => "center", :weight => 900
  end

  stack :width => 350, :margin => 5 do
    #background gray
    #border dimgray, :strokewidth => 2
    flow :left => 100 do #:left => 100, :right => 100
      @prev = button "Prev", :width => "33%"
      @next = button "Next", :width => "33%"
      @copy = button "Copy to clipboard", :width => "34%"
    end
    #self.move(5,32)
  end
  
  stack :width => 700 do
    background silver
    border gainsboro, :strokewidth => 10
    @clipboard = para "#{@elements[@index]}", :stroke => black, :size => 10, :left => 85, :top => 20
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

  animate(3) do
    if clipboard() != @elements.last
      @elements << clipboard()
      @index = @elements.length - 1
      @clipboard.text = @elements[@index]
      @title.text = "Clipboard entry %03d" % (@index + 1)
    end
  end
end