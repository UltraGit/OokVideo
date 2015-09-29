require 'rspec'
require 'Ookvideo'

#setup AnOokVideo
#description
sample='Stargate.SG-1.S01E01.iNT.DVDRip.XviD-LOCK.avi'
#sample='fake'
rx = /(^[A-Za-z0-9\.\-]+)S(\d\d)E?(\d\d)/

ov = AnOokVideo.new(sample, rx)

#setup OokVideoSrcList
ovsl = OokVideoSrcList.new("c:/Users/Thomas/Downloads", "avi")

describe "can RegEx a string for title / series / episode" do
  #ov = AnOokVideo.new(sample, rx)
  it 'returns a title' do
    expect(ov.title).to eq('StargateSG1')
  end
  it 'returns a series number' do
    expect(ov.series).to eq('01')
  end

  it 'returns an episode number' do
    expect(ov.episode).to eq('01')
  end

end

describe "can read a directory and get a list of filenames of a type" do

  it 'reads a directory' do
    expect(ovsl.srclist(ovsl.srcdir, ovsl.srctyp)).not_to be_empty
    expect(ovsl.filearr).not_to be_empty
    expect(ovsl.filearr).to be_kind_of Array

    #eq('Stargate.SG-1.S01E01.iNT.DVDRip.XviD-LOCK.avi')
  end

  it 'lists files of a set type' do
    expect(ovsl.filearr[0].to_s.index('avi')).not_to be_nil

  end
end

describe 'can derive 3 arrays - titles, series numbers, episode numbers - in parallel' do
  it 'sets a title' do
    expect(ovsl.titlearr).not_to be_empty
    expect(ovsl.titlearr).to be_kind_of Array
    expect(ovsl.titlearr[0].to_s.index('gate')).not_to be_nil
  end

  it 'sets a series' do
    expect(ovsl.seriesarr).not_to be_empty
    expect(ovsl.seriesarr).to be_kind_of Array
    expect(ovsl.seriesarr[0].to_s.index('01')).not_to be_nil
  end

  it 'sets an episode' do
    expect(ovsl.episodearr).not_to be_empty
    expect(ovsl.episodearr).to be_kind_of Array
    expect(ovsl.episodearr[0].to_s.index('01')).not_to be_nil

  end

end

describe ovsl.seriesarr.length do
    it {should eq(ovsl.filearr.length) } #'has arrays of equal length'


    #it expect(ovsl.filearr).should_have.to eq(25)
    #expect(ovsl.filearr.length.to_s).to eq(ovsl.seriesarr.length.to_s)
    #expect(ovsl.filearr.length.to_s).to eq(ovsl.episodearr.length.to_s) end

end

describe "can find near matched text in the titles" do
  it 'checks titles and finds non-perfect matches' do
    expect(ovsl.findAndScoreMatches).to be_kind_of Array
  end
end





#iterate all titles, and soundex match / levenshtein match similar titles,
#and unify them where possible, removing illegal characters (will be dirs)

# for each title,
#     check a dir exists / create if not, for each title (remove illegal char)

# for each series of the same title,
#     check a dir exists / create if not, for each series (remove illegal char)
