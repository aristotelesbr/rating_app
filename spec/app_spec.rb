# frozen_string_literal: true

require 'sqlite3'

::RSpec.describe('RatingApp') do
  describe 'requests' do
    context 'GET /' do
      before do
        @database = SQLite3::Database.new('db/teachers_test.db')
        @database.execute('INSERT INTO teachers (name) VALUES ("Sócrates"), ("Aristóteles"), ("Epicteto"), ("João")')
      end

      after do
        @database.execute('DELETE FROM ratings')

        @database.close
      end

      it 'returns 200' do
        get '/'
        expect(last_response).to be_ok
      end

      it 'returns the index page' do
        get '/'
        expect(last_response.body).to include('Avalie o professor')
      end
    end

    context 'POST /ratings' do
      before do
        @database = SQLite3::Database.new('db/teachers_test.db')
        @database.execute('INSERT INTO teachers (name) VALUES ("Sócrates"), ("Aristóteles"), ("Epicteto"), ("João")')
      end

      after do
        @database.execute('DELETE FROM ratings')

        @database.close
      end

      it 'returns 301' do
        params = { 'ratings' => { '1' => { 'teacher_id' => '1', 'rating' => '5' } } }

        post '/ratings', params

        expect(last_response).to be_redirect
        expect(last_response['Location']).to eq('/thank_you')
      end
    end

    context 'GET /thank_you' do
      it 'returns 200' do
        get '/thank_you'
        expect(last_response).to be_ok
      end

      it 'returns the thank you page' do
        get '/thank_you'
        expect(last_response.body).to include('Obrigado por responder nossa pesquisa! 🥳')
      end
    end

    context 'GET /report' do
      it 'returns 200' do
        get '/relatorio'
        expect(last_response).to be_ok
      end

      it 'returns the report page' do
        get '/relatorio'
        expect(last_response.body).to include('Relatório de avaliações dos professores')
      end
    end

    context 'GET /not_found' do
      it 'returns 404' do
        get '/not_found'
        expect(last_response.status).to eq(404)
      end
    end
  end
end
