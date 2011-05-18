# coding: utf-8
class NotesController < ApplicationController
  include ActionView::Helpers::TextHelper
  
  def index
    @notes = Note.all
    @count = Note.count
    @title = "Wszystkie notatki"
  end
  
  def search
    @notes = Note.where("title LIKE :text", :text => "%#{params['search_box']}%")
    
    @notes.each do |note|
      note.description = truncate(note.description, :length => 120)
    end
    
    render :json => @notes
  end
  
  def show
    @note = Note.find(params[:id]);
    @title = @note.title
  end
  
  def new
    @note = Note.new
    @title = "Nowa notatka"
  end

  def create
    @note = Note.new params[:note]
    if @note.save
      redirect_to spis_notatek_path, :notice => "Notatka została utworzona."
    else
      render :action => 'new'
    end
  end

  def edit
    @note = Note.find params[:id]
    @title = "Edytujesz: #{@note.title}"
  end

  def update
    @note = Note.find params[:id]
    if @note.update_attributes params[:note]
      redirect_to spis_notatek_path, :notice => "Zmiana została zapisana."
    else
      render :action => 'edit'
    end
  end

  def destroy
    Note.find(params[:id]).destroy
    redirect_to spis_notatek_path, :notice => "Usunięto pomyślnie."
  end

end
