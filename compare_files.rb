require 'digest/md5'

def md5_hash(file)
  Digest::MD5.hexdigest(File.read(file))
end

# change 'test' on your directory name
dir = 'test'

result = []

Dir.chdir("#{dir}/") do
  Dir['*'].each do |f|
    h = { filename: f, hash: md5_hash(f), count: 1 }
    result.each do |el|
      if el[:hash] == h[:hash]
        el[:count] += 1
        h[:count] += 1
      end
    end
    result << h
  end
end

puts result
