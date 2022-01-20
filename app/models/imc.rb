class Imc < ApplicationRecord

  validates_numericality_of :height, greater_than: 0
  validates_numericality_of :weight, greater_than: 0

end
