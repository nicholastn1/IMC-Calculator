class Imc < ApplicationRecord

  validates_numericality_of :height, greater_than: 0
  validates_numericality_of :weight, greater_than: 0



  def classification_return imc

    if @imc <= 18.5
      @classification_message = "Peso Baixo."
    elsif @imc > 18.5 && @imc <= 24.9
      @classification_message = "Peso Normal."
    elsif @imc >= 25.0 && @imc <= 29.9
      @classification_message = "Sobrepeso."
    else
      @classification_message = "Obesidade."

      if @imc >= 30.0 && @imc <= 34.9
        @obesity = "I"
      end
      if @imc >= 35.0 && @imc <= 39.9
        @obesity = "II"
      end
      if @imc >= 40.0
        @obesity = "III"
      end
    end
  end
end
