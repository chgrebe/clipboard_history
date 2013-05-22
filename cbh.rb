$: << File.dirname(__FILE__)

require 'tk'
require 'tkextlib/tile'
require 'clipboard'
require "methods.rb"


#Clipboard.copy '42'
#puts Clipboard.paste


root = TkRoot.new {title "Clipboard History"}

$initial_entry = "Initial Clipboard entry"
$currentCB = TkVariable.new("0")
$cblist = ["Initial clipboard entry"]


title_frame = Tk::Tile::Frame.new(root) {height 200; width 200}.grid
button_frame = Tk::Tile::Frame.new(root) {}.grid
clipboard_frame = Tk::Tile::Frame.new(root) {}.grid

Tk::Tile::Label.new(title_frame) {text "Clipboard entry "}.grid(:column => 1, :row => 1)
title = Tk::Tile::Label.new(title_frame) {textvariable $currentCB}.grid(:column => 2, :row => 1)
b_prev = Tk::Tile::Button.new(button_frame) {text "Previous"; command {prev_clicked}}.grid(:column => 1, :row => 1)
b_next = Tk::Tile::Button.new(button_frame) {text "Next"; command {next_clicked}}.grid(:column => 2, :row => 1)
b_copy = Tk::Tile::Button.new(button_frame) {text "Copy to Clipboard"; command {copy_clicked}}.grid(:column => 3, :row => 1)
cb_view = Tk::Tile::Label.new(clipboard_frame) {text $cblist[$currentCB]}.grid


cb_view.bind("Control-c") {update_cblist}

def update_cblist
  if $cblist[$currentCB] != $cblist.last
    $cblist << Clipboard.paste
    $currentCB = $cblist.length - 1
  end
end




content = Tk::Tile::Frame.new(root) {padding "3 3 12 12"}.grid( :sticky => '')
TkGrid.columnconfigure root, 0, :weight => 1; TkGrid.rowconfigure root, 0, :weight => 1

$feet = TkVariable.new; $meters = TkVariable.new
f = Tk::Tile::Entry.new(content) {width 7; textvariable $feet}.grid( :column => 2, :row => 1, :sticky => 'we' )
Tk::Tile::Label.new(content) {textvariable $meters}.grid( :column => 2, :row => 2, :sticky => 'we');
Tk::Tile::Button.new(content) {text 'Calculate'; command {calculate}}.grid( :column => 3, :row => 3, :sticky => 'se')

Tk::Tile::Label.new(content) {text 'feet'}.grid( :column => 3, :row => 1, :sticky => 'w')
Tk::Tile::Label.new(content) {text 'is equivalent to'}.grid( :column => 1, :row => 2, :sticky => 'e')
Tk::Tile::Label.new(content) {text 'meters'}.grid( :column => 3, :row => 2, :sticky => 'w')

TkWinfo.children(content).each {|w| TkGrid.configure w, :padx => 5, :pady => 5}
f.focus
root.bind("Return") {calculate}



def calculate
  begin
    $meters.value = (0.3048*$feet*10000.0).round()/10000.0
  rescue
    $meters.value = ''
  end
end


def prev_clicked
  $currentCB.value = ($currentCB.value.to_i - 1).to_s if $currentCB > 0
end

def next_clicked
   $currentCB.value = ($currentCB.value.to_i + 1).to_s if $currentCB < 19 #$cblist[$currentCB + 1]
end

def copy_clicked
  Clipboard.copy $cblist[$currentCB]
end





Tk.mainloop
