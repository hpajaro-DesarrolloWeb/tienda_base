class InicioController < BaseController
  def index
    
  end
  def admin
    render layout: "layout_admin"
  end
  def noacceso
  end
end