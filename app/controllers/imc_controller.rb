class ImcController < ApplicationController
  require 'json'

  def index
  end

  def result
  end

  def calculate
    file = File.read(params[:imc][:file].tempfile.path)
    data_hash = JSON.parse(file, exp: (Time.now + 2.minutes).to_i)
    @height = data_hash["height"]
    @weight = data_hash["weight"]

    if @height.present? && @height.present?
      @imc = (@weight.to_f/(@height * @height)).round(2)
    end
    byebug
    token = JWT.encode(
      data_hash,
      Rails.application.credentials.secret_key_base,
      'HS256'
    )

    classification_return @imc
    render :json => { :imc => @imc, :classification_message => @classification_message, :obesity => @obesity}
  end

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
