require 'Ookvideo'
require 'tk'

#instace of OV
#setup AnOokVideo
#description  - TODO: unlock to prompts

#ov = AnOokVideo.new(sample, rx)

#setup OokVideoSrcList
ovsl = OokVideoSrcList.new("c:/Users/Thomas/Downloads", "avi")

$asvar = Array[]

$asvar = ovsl.filearr
$lenafvar = ovsl.filearr.length
$lenatvar = ovsl.titlearr.length
$lenasvar = ovsl.seriesarr.length
$lenaevar = ovsl.episodearr.length
$lenarvar = ovsl.resultsarr.length


puts 'putting...'

puts $asvar[0].to_s.length

puts $asvar[1].to_s.length
puts 'filearr.length   ' + $lenafvar.to_s
puts 'titlearr.length  ' + $lenatvar.to_s
puts 'seriesarr.length ' + $lenasvar.to_s
puts 'episodearr.length ' + $lenaevar.to_s
puts 'resultsarr.length ' + $lenaevar.to_s


puts 'Tk.windowingsystem:  ' + Tk.windowingsystem.to_s

ovsl.findAndScoreMatches

