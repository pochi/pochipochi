class BookmarksController < ApplicationController
  helper_method :sort_column, :sort_direction
  before_filter :login_required

  def index
    @bookmarks = current_user.bookmarks.search(params[:search]).
                                        order(sort_column + " " + sort_direction).
                                        page(params[:page])

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @bookmarks }
      format.js   { render :json => @bookmarks.to_json }
      format.iphone # index.iphone.erb
    end
  end

  def show
    @bookmark = Bookmark.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @bookmark }
    end
  end

  def new
    @bookmark = Bookmark.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @bookmark }
    end
  end

  def edit
    @bookmark = Bookmark.find(params[:id])
  end

  def create
    @bookmark = current_user.bookmarks.build(params[:bookmark])

    respond_to do |format|
      if @bookmark.save
        format.html { redirect_to(@bookmark, :notice => 'Bookmark was successfully created.') }
        format.xml  { render :xml => @bookmark, :status => :created, :location => @bookmark }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @bookmark.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @bookmark = Bookmark.find(params[:id])

    respond_to do |format|
      if @bookmark.update_attributes(params[:bookmark])
        format.html { redirect_to(@bookmark, :notice => 'Bookmark was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @bookmark.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @bookmark = Bookmark.find(params[:id])
    @bookmark.destroy

    respond_to do |format|
      format.html { redirect_to(bookmarks_url) }
      format.xml  { head :ok }
    end
  end

  private
  def sort_column
    Bookmark.column_names.include?(params[:sort]) ? params[:sort] : "title"
  end

  def sort_direction
    %w(asc desc).include?(params[:direction]) ? params[:direction] : "asc"
  end
end
