class ProductosController < ApplicationController
  skip_before_action:verify_authenticity_token
  before_action :set_producto, only: [:show, :edit, :update, :destroy]

  # GET /productos
  # GET /productos.json
  require "pp"
  include Servicios
  @@carrito=[];
  def index
    @productos = Producto.all
    @productosExt= @productos.map do |p|
      {
        "id"           => p.id,
        "nombre"       => p.nombre,
        "descripcion"  => p.descripcion,    
        "ref"          => p.ref,          
        "tipo"         => TraerValorParametro(p.idtipoproducto),
        "categoria"    => TraerValorParametro(p.idcategoriaproducto),
        "estado"       => TraerValorParametro(p.idestadoproducto),
        "precio"        => p.precio,
        "stock"        => p.stock,
        "imagen"       => p.imagen
       }
     end
  end
  def agregarCarrito
      #pp(params);
      @@carrito << params
      session[:numcar]= @@carrito.count()
      session[:carrito]=@@carrito

  end

  def mostrarCarrito
   @micarrito=session[:carrito]
    end
  # GET /productos/1
  # GET /productos/1.json
  def show
  end

  def eliminarDelCarrito
     indice=params[:in];
     micarrito=session[:carrito]
     micarrito.delete_at(indice.to_i)
     session[:numcar]=micarrito.count()
     session[:carrito]=micarrito
     redirect_to :action => "mostrarCarrito"
  end
  # GET /productos/new
  def new
    @producto = Producto.new
  end
  def listar
   @productos=Producto.all
  end
  # GET /productos/1/edit
  def edit
  end

  # POST /productos
  # POST /productos.json
  def create
    @producto = Producto.new(producto_params)

    respond_to do |format|
      if @producto.save
        format.html { redirect_to @producto, notice: 'Producto was successfully created.' }
        format.json { render :show, status: :created, location: @producto }
      else
        format.html { render :new }
        format.json { render json: @producto.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /productos/1
  # PATCH/PUT /productos/1.json
  def update
    respond_to do |format|
      if @producto.update(producto_params)
        format.html { redirect_to @producto, notice: 'Producto was successfully updated.' }
        format.json { render :show, status: :ok, location: @producto }
      else
        format.html { render :edit }
        format.json { render json: @producto.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /productos/1
  # DELETE /productos/1.json
  def destroy
    @producto.destroy
    respond_to do |format|
      format.html { redirect_to productos_url, notice: 'Producto was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_producto
      @producto = Producto.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def producto_params
      params.require(:producto).permit(:nombre, :descipcion, :ref, :precio, :idtipoproducto, :idcategoriaproducto, :idestadoproducto, :stock, :imagen, :eliminado)
    end
end
