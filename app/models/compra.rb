class Compra < ApplicationRecord
	has_many :compra_productos
	has_many :productos, through: :compra_productos
	has_many :compra_bebidas
	has_many :bebidas, through: :compra_bebidas
	after_create :save_comprados
	after_update :edit_comprados
	before_destroy :destroy_comprados
	belongs_to :cuentum
	#after_create :save_bebidas
	# validates :fecha, uniqueness: {message: "^Ya existe otra compra para esa fecha"}
	validates :save_comprados, presence: {message: "^Debe ingresar al menos 1 producto"}

	def productos=(value)
		@productos = value
	end
	def bebidas=(value)
		@bebidas = value
	end

	def save_comprados

		if @productos != nil
			@productos.each do |producto_id|
				CompraProducto.create(producto_id: producto_id, compra_id: self.id)
			end
		end
		if @bebidas != nil

			@bebidas.each do |bebida_id|
				CompraBebida.create(bebida_id: bebida_id, compra_id: self.id)
				mi_bebida = Stock.where(bebida_id: bebida_id)
				# esta sumando dos veces.... 
				mi_bebida.update(cant: mi_bebida.last.cant + 1)

			end
				

		end
	end

	def edit_comprados
		
		CompraProducto.where(compra_id: self.id).destroy_all
		
		@productos.each do |producto_id|
		
		CompraProducto.create(producto_id: producto_id, compra_id: self.id)
		
		end
		otra_bebida = CompraBebida.where(compra_id: self.id)
		CompraBebida.where(compra_id: self.id).destroy_all
		
		@bebidas.each do |bebida_id|
		
		CompraBebida.create(bebida_id: bebida_id, compra_id: self.id)
		mi_bebida = Stock.where(bebida_id: otra_bebida.last.bebida_id)
		mi_bebida.update(cant: mi_bebida.last.cant - 1)
		ult = Stock.where(bebida_id: bebida_id)
		ult.update(cant: ult.last.cant + 1 )
		end
	end

	def destroy_comprados
		CompraProducto.where(compra_id:self.id).destroy_all
		CompraBebida.where(compra_id:self.id).destroy_all
		# mi_bebida = Stock.where(bebida_id: bebida_id)
		# mi_bebida.update(cant: mi_bebida.last.cant - 1)
	end
end
