# coding: utf-8
class Note < ActiveRecord::Base
  validates_presence_of :title, :message => "Należy podać tytuł!"
  validates_presence_of :description, :message => "Należy podać treść!"
end
