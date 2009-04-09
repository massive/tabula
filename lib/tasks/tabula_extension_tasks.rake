namespace :radiant do
  namespace :extensions do
    namespace :tabula do
      
      desc "Runs the migration of the Tabula extension"
      task :migrate => :environment do
        require 'radiant/extension_migrator'
        if ENV["VERSION"]
          TabulaExtension.migrator.migrate(ENV["VERSION"].to_i)
        else
          TabulaExtension.migrator.migrate
        end
      end
      
      desc "Copies public assets of the Tabula to the instance public/ directory."
      task :update => :environment do
        is_svn_or_dir = proc {|path| path =~ /\.svn/ || File.directory?(path) }
        puts "Copying assets from TabulaExtension"
        Dir[TabulaExtension.root + "/public/**/*"].reject(&is_svn_or_dir).each do |file|
          path = file.sub(TabulaExtension.root, '')
          directory = File.dirname(path)
          mkdir_p RAILS_ROOT + directory
          cp file, RAILS_ROOT + path
        end
      end  
    end
  end
end
