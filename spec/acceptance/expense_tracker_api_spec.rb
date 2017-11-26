require 'rack/test'
require 'json'
require_relative '../../app/api'

module ExpenseTracker
  RSpec.describe 'Expense Tracker API' do
    include Rack::Test::Methods

    def app
      ExpenseTracker::API.new
    end

    def post_expense(expense)
      post '/expenses', JSON.generate(expense)
      expect(last_response.status).to eql(200)

      parsed_response = JSON.parse(last_response.body)
      expect(parsed_response).to include('expense_id' => a_kind_of(Integer))
      expense.merge('id' => parsed_response['expense_id'])
    end

    it 'records submitted expenses' do
      pending 'needs to persist expenses'
      coffee = post_expense(
        'payee' => 'Starbucks', 
        'amount' => 5.75, 
        'date' => '2017-11-26'
      )

      zoo = post_expense(
        'payee' => 'Zoo',
        'amount' => 35.75,
        'date' => '2017-11-26'
      )

      groceries = post_expense(
        'payee' => 'Whole Foods',
        'amount' => 25.75,
        'date' => '2017-11-27'
      )

      get '/expenses/2017-11-26'
      expect(last_response.status).to eql(200)
      expenses = JSON.parse(last_response.body)
      expect(expenses).to contain_exactly(coffee, zoo)
    end
  end
end