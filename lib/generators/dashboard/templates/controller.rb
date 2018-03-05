class <%= "#{options[:namespace].camelize}::#{controller_class_name}" %>Controller < <%= options[:namespace].camelize %>Controller
  before_action :set_<%= singular_table_name %>, only: [:show, :edit, :update, :destroy]

  # GET <%= route_url %>
  def index
    @<%= plural_table_name %> = <%= orm_class.all(class_name) %>.order(updated_at: :desc)
    authorize [:<%= options[:namespace] %>, @<%= plural_table_name %>]
  end

  # GET <%= route_url %>/1
  def show
  end

  # GET <%= route_url %>/new
  def new
    @<%= singular_table_name %> = <%= orm_class.build(class_name) %>
    authorize [:<%= options[:namespace] %>, @<%= singular_table_name %>]
  end

  # GET <%= route_url %>/1/edit
  def edit
  end

  # POST <%= route_url %>
  def create
    @<%= singular_table_name %> = <%= orm_class.build(class_name, "#{singular_table_name}_params") %>
    authorize [:<%= options[:namespace] %>, @<%= singular_table_name %>]

    if @<%= orm_instance.save %>
      flash[:success] = "建立成功。"
      redirect_to [:<%= options[:namespace] %>, @<%= singular_table_name %>]
    else
      render :new
    end
  end

  # PATCH/PUT <%= route_url %>/1
  def update
    if @<%= orm_instance.update("#{singular_table_name}_params") %>
      flash[:success] = "更新成功。"
      redirect_to [:<%= options[:namespace] %>, @<%= singular_table_name %>]
    else
      render :edit
    end
  end

  # DELETE <%= route_url %>/1
  def destroy
    @<%= orm_instance.destroy %>
    flash[:success] = "刪除成功。"
    redirect_to admin_<%= index_helper %>_url
  end

  private

    # Use callbacks to share common setup or constraints between actions.
    def set_<%= singular_table_name %>
      @<%= singular_table_name %> = <%= orm_class.find(class_name, "params[:id]") %>
    	authorize [:<%= options[:namespace] %>, @<%= singular_table_name %>]
    end

    # Only allow a trusted parameter "white list" through.
    def <%= "#{singular_table_name}_params" %>
      <%- if attributes_names.empty? -%>
      params.fetch(:<%= singular_table_name %>, {})
      <%- else -%>
      params.require(:<%= singular_table_name %>).permit(<%= attributes_names.map { |name| ":#{name}" }.join(', ') %>)
      <%- end -%>
    end
end