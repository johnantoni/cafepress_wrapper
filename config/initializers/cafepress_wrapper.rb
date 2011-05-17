# Copyright 2010 Benjamin Lee Smith <benjamin.lee.smith@gmail.com>
#
# This file is part of CafePress Wrapper.
# CafePress Wrapper is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# CafePress Wrapper is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with CafePress Wrapper.  If not, see <http://www.gnu.org/licenses/>.

begin
  ::CAFEPRESS_CONFIG = YAML.load_file("#{::Rails.root.to_s}/config/cafepress_wrapper.yml")[::Rails.env]
rescue
  ::CAFEPRESS_CONFIG = {
    'google_analytics' => ENV['cpw_google_analytics'],
    'title' => ENV['cpw_title'],
    'description' => ENV['cpw_description']
  }
end

require 'rails/generators'

class InstallGenerator < Rails::Generators::Base
  def copy_config_file
    source = File.join(File.dirname(__FILE__), '..', '..', 'config')
    destination = File.join(Rails.root, 'config', 'cafepress_wrapper.yml')
    
    InstallGenerator.source_root(source)
    
    copy_file 'cafepress_wrapper.yml', destination
  end
  
  def copy_images
    source = File.join(File.dirname(__FILE__), '..', '..', 'public', 'images')
    destination = File.join(Rails.root, 'public', 'images')
    copy_files(source, destination)
  end
  
  def copy_javascripts
    source = File.join(File.dirname(__FILE__), '..', '..', 'public', 'javascripts')
    destination = File.join(Rails.root, 'public', 'javascripts')
    copy_files(source, destination)
  end
  
  def copy_stylesheets
    source = File.join(File.dirname(__FILE__), '..', '..', 'public', 'stylesheets')
    destination = File.join(Rails.root, 'public', 'stylesheets')
    copy_files(source, destination)
  end
  
  private
    def copy_files(source, destination)
      InstallGenerator.source_root(source)
      (Dir.entries(source) - ['.', '..']).each do |f|
        copy_file f, File.join(destination, f)
      end
    end
end