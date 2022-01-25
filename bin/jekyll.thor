require "stringex"
require 'fileutils'
# require 'pathname'

class Jekyll < Thor
  desc "new", "create a new post"
  method_option :editor, :default => "subl"
  def new(*title)
    # TO USE: thor jekyll:new Name Of The Blog
    title = title.join(" ")
    date = Time.now
    filename = "../_posts/#{date.strftime('%Y-%m-%d')}-#{title.to_url}.md"

    if File.exist?(filename)
      abort("#{filename} already exists!")
    end

    puts "Creating new post: #{filename}"
    open(filename, 'w') do |post|
      post.puts "---"
      post.puts "title: \"#{title.gsub(/&/,'&amp;')}\""
      post.puts "layout: post"
      post.puts "date: #{date.strftime('%Y-%m-%d %H:%M:%S %z')}"
      post.puts "tags:"
      post.puts " -"
      post.puts "---"
      post.puts "\n\n\n"
      post.puts "-----"
      post.puts "## Footnotes"
      post.puts "[^1]: "
    end

    system(options[:editor], filename)
  end

  desc "cp_folder", "transfer folder"
  method_option :editor, :default => "subl"
  def cp_folder(source = nil, destination = nil)
    puts 'Removing files from "/var/www/blog"...'
    if FileUtils.rm_r('/var/www/blog', force: true)
      puts 'Adding files from "../_site" --> "/var/www/blog"'
      FileUtils.copy_entry('../_site', '/var/www/blog')
    end
    puts 'Completed!'
    # TO USE: thor jekyll:cp_folder '../_site' '/var/www/blog'
  end
end
