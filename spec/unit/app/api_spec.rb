require_relative '../../../app/api'

module ExpenseTracker
  RSpec.describe API do
    describe 'POST /expenses' do
      context 'when expense is succesfully recorded' do
        it 'returns the expense id'
        it 'responds with 200 (OK)'
      end

      context 'when the expense fails validation' do
        it 'returns an error message'
        it 'returns with a 422 (Unprocessable Entry)'
      end
    end
  end
end