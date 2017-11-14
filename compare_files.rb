require 'digest/md5'

class CompareFiles
  def initialize(path)
    @dir = path
    @result = []
  end

  def result
    Dir.chdir("#{@dir}/") do
      each_file
    end
    @result
  end

  private

  def each_file
    Dir['*'].each do |f|
      h = create_hash(f)
      compare_hashes(h)
    end
  end

  def create_hash(f)
    { filename: f, hash: md5_hash(f), count: 1 }
  end

  def compare_hashes(h)
    @result.each do |el|
      if el[:hash] == h[:hash]
        el[:count] += 1
        h[:count] += 1
      end
    end
    @result << h
  end

  def md5_hash(file)
    Digest::MD5.hexdigest(File.read(file))
  end
end
