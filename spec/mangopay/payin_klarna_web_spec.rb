describe MangoPay::PayIn::Klarna::Web, type: :feature do
  include_context 'wallets'
  include_context 'payins'

  def check_type_and_status(payin)
    expect(payin['Type']).to eq('PAYIN')
    expect(payin['Nature']).to eq('REGULAR')
    expect(payin['PaymentType']).to eq('KLARNA')
    expect(payin['ExecutionType']).to eq('WEB')
    expect(payin['Status']).to eq('CREATED')
  end

  describe 'CREATE' do
    it 'creates a klarna web payin' do
      created = new_payin_klarna_web
      expect(created['Id']).not_to be_nil
      expect(created['ReturnURL']).not_to be_nil
      check_type_and_status(created)
    end
  end

  describe 'FETCH' do
    it 'fetches a payin' do
      created = new_payin_klarna_web
      fetched = MangoPay::PayIn.fetch(created['Id'])
      expect(fetched['Id']).to eq(created['Id'])
      check_type_and_status(created)
      check_type_and_status(fetched)
    end
  end
end

