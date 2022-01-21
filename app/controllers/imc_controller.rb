class ImcController < ApplicationController
  require 'json'
  ALGORITHM = 'HS256'
  HMAC_SECRET = Rails.application.credentials.secret_key_base

  def index
  end

  def result
  end

  def calculate
    if params[:imc].present?
      file = File.read(params[:imc][:file].tempfile.path, exp: (Time.now + 2.weeks).to_i)
      data_hash = JSON.parse(file)

      @height = data_hash["height"]
      @weight = data_hash["weight"]

      @imc = (@weight.to_f/(@height * @height)).round(2)
    end

    if @imc.present? && athentication_token(data_hash)
      classification_return @imc
    end

    byebug
    render json: JSON.pretty_generate(:imc => @imc, :classification => @classification_message, :obesity => @obesity)
  end

  def athentication_token data_hash
    token = JWT.encode(
      data_hash,
      HMAC_SECRET,
      ALGORITHM
    )

    decoded_token = JWT.decode(token, HMAC_SECRET, false, :ALGORITHM => ALGORITHM)
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
