require 'nokogiri'
require 'open-uri'

require_relative './course.rb'

class Scraper

  def get_page
      html = open("http://learn-co-curriculum.github.io/site-for-scraping/courses")
      doc = Nokogiri::HTML(html)
  end
  def get_courses
    self.get_page.css("article.post")
  end
  def make_courses
    self.get_courses.each{ |a|
      course = Course.new
      course.title = a.css("h2").text
      course.schedule = a.css("em.date").text
      course.description = a.css("p").text
      course
    }
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
