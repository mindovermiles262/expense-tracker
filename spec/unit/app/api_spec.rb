require_relative '../../../app/api'
require 'rack/test'

module ExpenseTracker
  RecordResult = Struct.new(:success?, :expense_id, :error_message)

  RSpec.describe API do
    include Rack::Test::Methods

    def app
      API.new(ledger: ledger)
    end

    let(:ledger) { instance_double('ExpenseTracker::Ledger') }

    describe 'POST /expenses' do
      context 'when expense is succesfully recorded' do
        it 'returns the expense id' do
          expense = { 'some' => 'data' }

          allow(ledger).to receive(:record)
            .with(expense)
            .and_return(RecordResult.new(true, 417, nil))

          post '/expenses', JSON.generate(expense)

          parsed = JSON.parse(last_response.body)
          expect(parsed).to include('expense_id' => 417)
        end
        it 'responds with 200 (OK)' do
          expense = { 'some' => 'data' }

          allow(ledger).to receive(:record)
            .with(expense)
            .and_return(RecordResult.new(true, 417, nil))

          post '/expenses', JSON.generate(expense)
          expect(last_response.status).to eql(200)
        end
      end

      context 'when the expense fails validation' do
        it 'returns an error message'
        it 'returns with a 422 (Unprocessable Entry)'
      end
    end
  end
end
