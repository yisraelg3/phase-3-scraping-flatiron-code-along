require 'nokogiri'
require 'open-uri'
require 'pry'

require_relative './course.rb'

class Scraper
  
  def get_page
    doc = Nokogiri::HTML(URI.open("http://learn-co-curriculum.github.io/site-for-scraping/courses")) 

    # 

    # binding.pry
  end

  def get_courses
   self.get_page.search('.post')
  end

  def make_courses
    self.get_courses.map do |post|
        course = Course.new
        course.title = post.search('h2').text
        course.schedule = post.search('.date').text
        course.description = post.search('p').text
      end
  end

  def print_courses
    self.make_courses
    Course.all.each do |course|
      if course.title && course.title != ""
        puts "Title: #{course.title}"
        puts "  Schedule: #{course.schedule}"
        puts "  Description: #{course.description}"
      end
    end
  end
  
end

Scraper.new.print_courses

