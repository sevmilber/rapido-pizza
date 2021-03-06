class FoodsController < ApplicationController
  before_action :set_food, only: [:show, :edit, :update, :destroy]

  def index
	@foods = Food.order(:title)
  end 

  def show
  end

  def new
    @food = Food.new
  end

  def edit
  end

  def create
    @food = Food.new(food_params)

    respond_to do |format|
      if @food.save
        format.html { redirect_to root_url }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @food.update(food_params)
        format.html { redirect_to root_url }
        
        @foods = Food.all
        ActionCable.server.broadcast 'foods',
          html: render_to_string('welcome/index', layout: false)
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @food.destroy
    respond_to do |format|
      format.html { redirect_to root_url }
    end
  end

  def who_bought
    @food = Food.find(params[:id])
    @latest_order = @food.orders.order(:updated_at).last
      if stale?(@latest_order)
        respond_to do |format|
        format.atom
      end
    end
  end

  private

    def set_category 
      @category = Category.find(params[:category_id])
    end 

    def set_food
      @food = Food.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def food_params
      params.require(:food).permit(:title, :description, :price, :image, :category_id)
    end
end
