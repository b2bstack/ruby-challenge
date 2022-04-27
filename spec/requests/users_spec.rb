require 'rails_helper'

RSpec.describe "Users", type: :request do
  describe "GET /users" do
    subject(:json) { JSON.parse(response.body) }
    let(:headers) {
      {
        "Content-Type": "application/json",
        "Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjozLCJleHAiOjE2NTEwNTgxNDJ9.Tu_2DrJGXKmgF-UqlmeNT7fs3OKjtlqUS0zN9iv4oRs"
      }
    }

    context "when the user is not logged in" do
      let(:res) {
        {
          "users" => [],
          "pagination" => {
            "total_pages" => 0,
            "limit_per_page" => 10,
            "current_page" => 1,
            "count_items" => 0
          }
        }
      }

      it "expected status" do
        get "/api/v1/users", headers: headers

        expect(response).to have_http_status(200)
        expect(json).to eq(res)
      end
    end
  end
end
