require 'rack'
require 'sqlite3'
require 'erb'
require 'json'

# Rack application
#
class RattingApp
  # Rack interface
  #
  def call(env)
    @request  = ::Rack::Request.new(env)
    @response = ::Rack::Response.new

    method = @request.request_method
    path   = @request.path_info

    case [method, path]
    in ['GET', '/']          then index
    in ['POST', '/ratings']  then create_rating
    in ['GET', '/relatorio'] then report
    in ['GET', '/thank_you'] then thank_you
    else not_found
    end
  end

  # ACTIONS
  #
  def index
    @title    = 'Avalie o professor'
    @teachers = select_teachers

    render(:index)
  end

  def create_rating
    if insert_in_batch!(rating_params)
      redirect_to('/thank_you')
    else
      @title = 'Avalie o professor'
      @error = 'Erro ao salvar avaliação'

      render(:index)
    end
  end

  def report
    @title           = 'Relatório de avaliações dos professores'
    @teacher_ratings = select_ratings

    render(:report)
  end

  def thank_you
    @title = 'Obrigado por responder nossa pesquisa! 🥳'

    render(:thank_you)
  end

  def not_found = [404, { 'content-type' => 'text/plain' }, ['Not Found']]

  private

  # "STRONG PARAMS"
  #
  def rating_params = @request.params['ratings'].values

  # TEMPLATE RENDER
  #
  def render(view)
    path     = ::File.join('views', "#{view}.html.erb")
    template = ::ERB.new(::File.read(path))
    content  = template.result(binding)

    @response.write(content)
    @response.finish
  end

  # DATABASE CONNECTION
  #
  def database = @database ||= SQLite3::Database.new('db/teachers.db')

  # SQL QUERIES
  #
  def insert_in_batch!(ratings)
    database.transaction

    sql = database.prepare('INSERT INTO ratings (rating, teacher_id) VALUES (?, ?)')

    ratings.each { sql.execute(_1['rating'], _1['teacher_id']) }

    database.commit

    true
  rescue SQLite3::SQLException => e
    puts "ERROR: #{e.message}"
    db.rollback

    database.rollback
  end

  Report = Data.define(:name, :rating1, :rating2, :rating3, :rating4, :rating5)
  def select_ratings
    query = <<-SQL
      SELECT#{' '}
          teachers.name,
          COUNT(CASE WHEN ratings.rating = 1 THEN 1 END) as rating1,
          COUNT(CASE WHEN ratings.rating = 2 THEN 1 END) as rating2,
          COUNT(CASE WHEN ratings.rating = 3 THEN 1 END) as rating3,
          COUNT(CASE WHEN ratings.rating = 4 THEN 1 END) as rating4,
          COUNT(CASE WHEN ratings.rating = 5 THEN 1 END) as rating5
      FROM#{' '}
          ratings
      JOIN#{' '}
          teachers ON teachers.id = ratings.teacher_id
      GROUP BY#{' '}
          teachers.name
    SQL

    database.execute(query).map do |(name, rating1, rating2, rating3, rating4, rating5)|
      Report.new(name:, rating1:, rating2:, rating3:, rating4:, rating5:)
    end
  rescue ::SQLite3::SQLException => e
    puts "ERROR: #{e.message}"
  end

  Teacher = Data.define(:id, :name)
  def select_teachers
    @teachers = database.execute('SELECT * FROM teachers').map { |(id, name)| Teacher.new(id:, name:) }
  end

  # Helper methods
  #
  def post?(env) = env['HTTP_REQUEST'] == 'POST'

  def redirect_to(path)
    @response['Location'] = path
    @response.status = 302
    @response.finish
  end
end
