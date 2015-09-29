require "Ookvideo/version"
require "text"
require "fileutils"

#for levenshtein matches http://www.rubydoc.info/gems/text/1.3.1
# parse downloaded filenames for series and episode names

Rx = /(^[A-Za-z0-9\.\-]+)S(\d\d)E?(\d\d)/

class AnOokVideo
# object type for files.
  def initialize(name, rx1)


=begin   #fail name throw
    if name.to_s.length <= 4
      # throw :noName   # TODO: exceptions not working?
      puts name + ' is not a valid filename'
      exit
    end
=end

    m = rx1.match(name)

    @title = m[1]
    @title.gsub! '.', ''  #  replace .
    @title.gsub! '-',''   #  replace -

    @series = m[2]

    @episode = m[3]
  end


  def title
    @title
  end

  def series
    @series
  end

  def episode
    @episode
  end

  def win(won)
  # to check sample test
    if(won)
      'I win!'
    else
      'I lose! :('
    end
  end
end

class OokVideoSrcList
  def initialize(dir, typ)
    @srcdir = dir
    @srctyp = typ
    @filearr = srclist(dir, typ)
    @titlearr = []
    @seriesarr = []
    @episodearr = []
    @resultsarr = []
    rxSrclist

  end
# def gets
  #
  def srcdir
    @srcdir
  end

  def srctyp
    @srctyp
  end

  def filearr
    @filearr
  end

  def seriesarr
    @seriesarr
  end

  def titlearr
    @titlearr
  end

  def episodearr
    @episodearr
  end

  def resultsarr
    @resultsarr
  end

  def srclist(dir, typ)
    aFilearr = Array.new
    #populates/repopulates @filarr, returns aFilearr
    Dir.chdir(dir)
    Dir.glob("*." + typ).each do |f|
      aFilearr << f
    end

    aFilearr


  end

  def rxSrclist
    #@filearr is populated

    @filearr.each do |fil|
      #for each file in list, recognise the title, the series and episode number
      #from the name, store in parallel dictionaries  (used lists)
      ov = AnOokVideo.new(fil, Rx)
      titlearr << ov.title
      seriesarr << ov.series
      episodearr << ov.episode
      resultsarr << (ov.title + ' Series:' + ov.series + ' Episode:' + ov.episode)
      ov = nil
    end
  end

  def LevDistance(a, b)

  Text::Levenshtein.distance(a, b) #, 6)

  end


def findAndScoreMatches
  #iterate all titles, and soundex match / levenshtein match similar titles,
  #and unify them where possible, removing illegal characters (will be dirs)

  @titlearr.each_slice(2) {|a| p a }
    #puts "distance(#{a}, #{b}) = #{LevDistance(a, b)}"
  #end

end


end








# for each title,
#     check a dir exists / create if not, for each title (remove illegal char)

# for each series of the same title,
#     check a dir exists / create if not, for each series (remove illegal char)
