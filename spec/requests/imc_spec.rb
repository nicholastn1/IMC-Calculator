require 'rails_helper'

RSpec.describe "Imcs", type: :request do

  describe "GET /index" do
    it 'success return' do
      get imc_index_path
      expect(response).to have_http_status(200)
    end
  end

  describe "GET /result" do
    it 'success return' do
      get imc_result_path
      expect(response).to have_http_status(200)
    end
  end

  describe "POST /calculate" do
    it 'calculate the imc' do
      height = 1.7
      weight = 76

      imc = (weight/(height*height)).round(2)
      expect(imc).to eql(26.3)
    end

    it "responds with JSON" do
      @expected = JSON.pretty_generate(
        :imc => nil,
        :classification => nil,
        :obesity => nil
      )
      post imc_calculate_path
      expect(response.body).to eql(@expected)
    end
  end
end
