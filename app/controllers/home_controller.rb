# coding: utf-8
class HomeController < ApplicationController
  
  def index
    @title = "Twój organizer notatek"
    @notes = Note.order('updated_at DESC').limit(3)
    @count = Note.count
  end

  def about
    @title = "O projekcie"
  end

end
