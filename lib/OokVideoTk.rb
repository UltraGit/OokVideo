#!/usr/bin/env ruby
require 'tk'
require 'tkextlib/tile'
require 'Ookvideo'

#instance of TK
root = TkRoot.new { title 'OokVideo' }
#instace of OV
#setup AnOokVideo
#description  - TODO: unlock to prompt
$sFiledir = "c:/Users/Thomas/Downloads"

#setup OokVideoSrcList
ov = OokVideoSrcList.new($sFiledir, "avi")

#set global arrays  TODO: check for validity of globals
$ovlist  = ov.filearr
$ovtitles = ov.titlearr
$ovseries = ov.seriesarr
$ovepisodes = ov.episodearr
$ovresults = ov.resultsarr

#populate tk array variables
$fnames = TkVariable.new($ovlist)
$etitles = TkVariable.new($ovtitles)
$eseries = TkVariable.new($ovseries)
$eepisodes = TkVariable.new($ovepisodes)
$eresults = TkVariable.new($ovresults)

# Create and initialize the linked variables we'll need in the interface
$names = TkVariable.new ( $fnames )
$titles = TkVariable.new ( $etitles )
$series = TkVariable.new ( $eseries )
$episodes = TkVariable.new ( $eepisodes )
$results = TkVariable.new ( $eresults )

$filedir= TkVariable.new ($sFiledir)
$status = TkVariable.new ( "" )

# Create and grid the outer content frame
# root = TkRoot.new
content = Tk::Tile::Frame.new(root) {padding "3 3 12 12"}.grid :column => 0, :row => 0, :sticky => "nwes"
TkGrid.columnconfigure root, 0, :weight => 1
TkGrid.rowconfigure root, 0, :weight => 1

# Create the different widgets; note the variables that many
# of them are bound to, as well as the button callback.
$fnamelist = TkListbox.new(content) {listvariable $names; height 20}
$titlelist = TkListbox.new(content) {listvariable $titles; height 20}
$serieslist = TkListbox.new(content) {listvariable $series; height 20}
$episodelist = TkListbox.new(content) {listvariable $episodes; height 20}



sendlbl = Tk::Tile::Label.new(content) {text "::"}

ookaction = Tk::Tile::Button.new(content) {text "Ook"; command "doOok"; default "active"}
ookdirsel = Tk::Tile::Button.new(content) {text "..."; command "pickDir"; default "active"}
dirlbl = Tk::Tile::Label.new(content) {textvariable $filedir; anchor "w"}
statuslbl = Tk::Tile::Label.new(content) {textvariable $status; anchor "w"}

# Grid all the widgets
$fnamelist.grid :column => 0, :row => 2, :rowspan => 6, :sticky => 'nsew'
$titlelist.grid  :column => 1, :row => 2, :rowspan => 6, :sticky => 'nsew'
$serieslist.grid  :column => 2, :row => 2, :rowspan => 6, :sticky => 'nsew'
$episodelist.grid  :column => 3, :row => 2, :rowspan => 6, :sticky => 'nsew'

dirlbl.grid   :column => 0, :row => 0, :sticky => 'w'
ookdirsel.grid       :column => 1, :row => 0, :columnspan => 2, :sticky => 'w'
sendlbl.grid    :column => 4, :row => 7, :padx => 10, :pady => 5
ookaction.grid       :column => 4, :row => 9, :sticky => 'e'

statuslbl.grid  :column => 0, :row => 9, :columnspan => 2, :sticky => 'we'

TkGrid.columnconfigure content, 0, :weight => 1
TkGrid.rowconfigure content, 5, :weight => 1

# Set event bindings for when the selection in the listbox changes,
# when the user double clicks the list, and when they hit the Return key
$fnamelist.bind '<ListboxSelect>', proc{selectFilename}
$fnamelist.bind 'Double-1', proc{doOok}
 # #TODO: Split to show title, series, episode


root.bind 'Return', proc{doOok}

# Called when the selection in the listbox changes;
def selectFilename
  idx = $fnamelist.curselection
  if idx.length==1
    idx = idx[0]
    title = $ovtitles[idx]
    series = $ovseries[idx]
    episode = $ovepisodes[idx]

    clearListSelection

    $titlelist.itemconfigure(idx, :background => "#00ffff")
    $serieslist.itemconfigure(idx, :background => "#00ffff")
    $episodelist.itemconfigure(idx, :background => "#00ffff")


    $status.value = "Title: #{title}, Series: #{series} Episode: #{episode}"
  else
    $status.value = "Oook?"
  end

end

def clearListSelection  #(aList, aIdx)
  #set a highlight on a listbox item to emulate selection of items across multiple lists
  #Default everything to white
  [$titlelist,$serieslist,$episodelist].each do |obj|
    obj.size.times do |ix|
      obj.itemconfigure(ix, :background => "white")
    end
  end
end

def pickDir
  #user selects new directory location
  dirname = Tk::chooseDirectory
  dirname
end



# Called when the user double clicks an item in the listbox,  TODO: react to selection in EITHER listbox
def doOok
  idx = $fnamelist.curselection
  if idx.length==1
    idx = idx[0]
    $fnamelist.see idx

    $sent.value = "Ook!"
  end
end

$fnamelist.selection_set 0
selectFilename

Tk.mainloop