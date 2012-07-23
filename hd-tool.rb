#!/bin/ruby

require 'rubygems'
require 'find'
require 'image_size'
require 'RMagick'

puts 'Start'

Find.find(".") do |path|
  if path.match(/\.png\Z/)
    # Found an image	
    open(path, "rb") do |f|
      size = ImageSize.new(f.read).get_size
      extension = File.extname(path)
      filename = File.basename(path).chomp(extension)
      puts filename + " " + extension
      retinaModifier = filename[-3,3]

      puts "Modifier: " + retinaModifier
      if retinaModifier!="-hd"
	puts "Low def"
	newPath = path.chomp(extension)+"-hd"+extension
	if File.exists?(newPath)
	  puts 'Hd file exists, skipping ' + newPath
	else
	  # Create the hd named version of the file
	  File.rename(path,newPath)
	  path = newPath
	end
      else
	# This is an hd file, check for the low res version
	lowResFilename = filename
	lowResFilename[-3,3] = ''
	lowResPath = path.chomp(extension).chomp('-hd')+extension
	if File.exists?(lowResPath)
          puts 'Low res file already exists, skipping ' + path
        else
          puts 'Creating low res file for ' + filename + ' in path: ' + path
          # Resize and create the low res version
	  img = Magick::Image.read(path).first
	  puts 'Read image.'
	  width = size[0]/2
	  height = size[1]/2
	  puts 'Computed new size'
	  img = img.resize_to_fit(width,height)
	  puts 'Resized'
	  img.write(lowResPath)
	  puts 'Done writing to disk'
#          sourceImage = Magick::Image.read(newPath).first
#          width = size[0]/2
#          height = size[1]/2
#          image.change_geometry!(width+"x"+height) { |cols, rows, img|
#           newimg = img.resize(cols,rows)
#           newimg.write(lowResPath)
#          }
        end
      end
      #puts File.basename(path) + ',' + size[0].to_s + ',' + size[1].to_s 
    end
  end
end

puts 'End'
