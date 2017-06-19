class ComprasController < ApplicationController
  before_action :set_compra, only: [:show, :edit, :update, :destroy]

  # GET /compras
  # GET /compras.json
  def index
    @compras = current_cuentum.compras
  end

  # GET /compras/1
  # GET /compras/1.json
  def show
    @tipos =Tipo.all
    @menus = Menu.all
    @menus.each do |menu|
      if menu.fecha.to_date == Time.now.to_date
        @productos = menu.productos.all
      end  
    end 
  end

  # GET /compras/new
  def new
    @compra = Compra.new
    @bebidas = Bebida.all
    
    @tipos = Tipo.all
    @menus = Menu.all
    @menus.each do |menu|
      if menu.fecha.to_date == Time.now.to_date
        @productos = menu.productos.all
      end  
    end 
    
    @tiene =TieneProducto.all
  end

  # GET /compras/1/edit
  def edit
    @tipos =Tipo.all
    @menus = Menu.all
    @bebidas =Bebida.all
    @menus.each do |menu|
      if menu.fecha.to_date == Time.now.to_date
        @productos = menu.productos.all
      end  
    end 
  end

  # POST /compras
  # POST /compras.json
  def create
    @bebidas = Bebida.all   
    @menus = Menu.all
    @menus.each do |menu|
      if menu.fecha.to_date == Time.now.to_date
        @productos = menu.productos.all
      end  
    end 

    @compra = current_cuentum.compras.build()
    @compra.fecha =Time.now
    @compra.productos = params[:productos]
    @compra.bebidas = params[:bebidas]
    
    respond_to do |format|
      if @compra.save
        format.html { redirect_to @compra, notice: 'Compra was successfully created.' }
        format.json { render :show, status: :created, location: @compra }
      else
        format.html { render :new }
        format.json { render json: @compra.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /compras/1
  # PATCH/PUT /compras/1.json
  def update
    @tipos =Tipo.all
    @menus = Menu.all
    @bebidas =Bebida.all
    @menus.each do |menu|
      if menu.fecha.to_date == Time.now.to_date
        @productos = menu.productos.all
      end  
    end 
    respond_to do |format|
      @compra.productos = params[:productos]
      @compra.bebidas = params[:bebidas]
      if @compra.update(compra_params)
        format.html { redirect_to @compra, notice: 'Compra was successfully updated.' }
        format.json { render :show, status: :ok, location: @compra }
      else
        format.html { render :edit }
        format.json { render json: @compra.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /compras/1
  # DELETE /compras/1.json
  def destroy
    @compra.destroy
    respond_to do |format|
      format.html { redirect_to compras_url, notice: 'Compra was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  
   private
    # Use callbacks to share common setup or constraints between actions.
    def set_compra
      @compra = Compra.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    # NO SE PQ DA ERROR....
    def compra_params
      params.require(:compra).permit(:fecha, :productos, :bebidas, :producto_id, :bebida_id)
    end

    def chequeadaProd(valor)    
      @productos.each do |prod|
          @compra.productos.each do |p|
            if p.id == valor 
              return true          
          end
      end
        return false    
    end

   def chequeadaBeb(valor2)    
    @bebidas.each do |beb|
        @compra.bebidas.each do |be|
          if be.id == valor2 
            return true          
        end 
    end
      return false    
   end
   
  end
end
end