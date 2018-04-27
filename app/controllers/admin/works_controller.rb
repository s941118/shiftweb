class Admin::WorksController < AdminController
  before_action :set_work, only: [:show, :edit, :update, :destroy, :publish, :draft]
  before_action :set_search
  layout 'edit_work', only: [:show, :edit, :update]

  # GET /works
  def index
    authorize [:admin, :work], :index?
    works = @q.result(distinct: true)
    @works = if params[:tag].present?
      works.tagged_with(params[:tag])
    else
      works
    end.order(work_date: :desc)
  end

  # GET /works/1
  def show
    @contents = Content.where(work_id: params[:id]).order(ordering: :asc).with_attached_image#.pluck(:html).join("")
  end

  # GET /works/new
  def new
    @work = Work.new
    authorize [:admin, @work]
  end

  # GET /works/1/edit
  def edit
  end

  # work /works
  def create
    @work = Work.new(work_params)
    authorize [:admin, @work]

    if @work.save
      @work.contents.create(ordering: 1, html: "<p/>")
      flash[:success] = "建立成功。 "
      redirect_to edit_admin_work_path(@work)
    else
      render :new
    end
  end

  # PATCH/PUT /works/1
  def update
    if @work.update(work_params)
      @work.update_tags!
      if ActiveModel::Type::Boolean.new.cast work_params[:remove_cover]
        @work.cover.purge_later
      end
      # @work.cover.variant(resize: "4096x4096").processed.service_url if @work.cover.attached?
      # if @work.contents.img.size > 0
      #   @work.contents.img.each do |content|
      #     content.image.variant(resize: "4096x4096").processed.service_url
      #   end
      # end
      # @work.touch # 因為 ordering 不再是相對加一，而是每次更新，所以好像不需要順過了？
      flash[:success] = "更新成功。 "
      redirect_to [:admin, @work]
    else
      render :edit
    end
  end

  # DELETE /works/1
  def destroy
    @work.destroy
    flash[:success] = "刪除成功。 "
    redirect_to admin_works_url
  end

  def publish
    @work.publish! if @work.draft?
    flash[:success] = "作品已公開。"
    redirect_to admin_works_url
  end

  def draft
    @work.draft! if @work.publish?
    flash[:success] = "作品已撤下轉為草稿。"
    redirect_to admin_works_url
  end

  private

    # Use callbacks to share common setup or constraints between actions.
    def set_work
      @work = Work.find(params[:id])
    	authorize [:admin, @work]
    end

    def set_search
      @q = Work.ransack(params[:q])
      @nav_search_symbol = :title_or_category_or_tags_name_or_contents_processed_html_cont
      @nav_search_placeholder = Work.model_name.human + Work.human_attribute_name("title") + "、" + Work.human_attribute_name("category") + "、" + Tag.model_name.human  + Tag.human_attribute_name("name") + "、" + Content.human_attribute_name("processed_html")
    end

    # Only allow a trusted parameter "white list" through.
    def work_params
      params.require(:work).permit(:title, :cover, :remove_cover, :category, :top_tags, :number, :work_date, contents_attributes: [ :id, :html, :ordering, :usage, :_destroy, :wrapper_klass ])
    end
end