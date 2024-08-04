require 'rake'
require 'pg'
require 'sequel'

namespace :db do
  desc 'Создание нового пользователя, базы данных и миграций'
  task :setup do
    username = 'user_for_web_scraping_app'
    password = 'password123'
    database_name = 'web_scraping_db'

    conn = PG.connect(dbname: 'postgres', user: 'postgres')

    begin
      conn.exec("DROP DATABASE IF EXISTS #{database_name};")
      puts "База данных #{database_name} удалена."
    rescue PG::Error => e
      puts "Ошибка при удалении базы данных: #{e.message}"
    end

    begin
      conn.exec("DROP USER IF EXISTS #{username};")
      puts "Пользователь #{username} удален."
    rescue PG::Error => e
      puts "Ошибка при удалении пользователя: #{e.message}"
    end

    begin
      conn.exec("CREATE USER #{username} WITH PASSWORD '#{password}' CREATEDB;")
      puts "Пользователь #{username} создан."
    rescue PG::Error => e
      puts "Ошибка при создании пользователя: #{e.message}"
    end

    begin
      conn.exec("CREATE DATABASE #{database_name} OWNER #{username};")
      puts "База данных #{database_name} создана."
    rescue PG::Error => e
      puts "Ошибка при создании базы данных: #{e.message}"
    end

    conn.close

    DB = Sequel.connect("postgres://#{username}:#{password}@localhost/#{database_name}")

    migration_file = 'db/migrations/001_create_products.rb'
    system("sequel -m db/migrations postgres://#{username}:#{password}@localhost/#{database_name} -e 'run_migration(\"#{migration_file}\")'")

    puts "Миграция из файла #{migration_file} применена."
  end
end