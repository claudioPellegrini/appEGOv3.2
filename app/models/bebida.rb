class Bebida < ApplicationRecord
	has_many :venta, dependent: :destroy
	validates :nombre, presence: {message: "^Debe ingresar un nombre"}
	validates :tipo, presence: {message: "^Debe ingresar un tipo"}
	validates :tamanio, presence: {message: "^Debe ingresar un tamaño"}
	validates :precio, presence: {message: "^Debe ingresar un precio"}
end
