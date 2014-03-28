require 'optparse'

module CMaker
  class CMakerRunner
    def initialize(argv)
      @argv = argv
      parser.parse! @argv
    end
    
    def create_config
      if(File.exist? 'conf.yaml')
        puts "Already exist conf.yaml"
      else
        File.open('conf.yaml','w') do |f|
          str = "project_name: demo\n" +
                "include_dir: [lib]\n" +
                "library:\n" +
                "  [\n" +
                "    {name: geodemo,fold: [lib],link_lib_name: []}\n" +
                "  ]\n" +
                "executable:\n" +
                "  [\n" +
                "    {name: main,fold: [src],link_lib_name: [geodemo]}\n"+
                "  ]"
          f << str
        end
        puts "Create succefully"
      end
    end
    
    def read_source file_name
      str = ""
      m=/\.(cpp|c|cc|h|hpp)$/  
      Dir.foreach(file_name) do |f|
        if f == "." or f == ".."   
          next
        elsif File.directory?("#{file_name}/#{f}")
          str += read_source "#{file_name}/#{f}"
        elsif !(m.match(f).nil?)
          str += "\n${CMAKE_SOURCE_DIR}/#{file_name}/#{f} "
        end
      end
      str
    end
    
    def generate_cmakelists
      conf = YAML::load(File.open("conf.yaml"))
      
      File.open('CMakeLists.txt','w') do |f| 
        f<< "cmake_minimum_required(VERSION 2.8)"
        f<< "\n"
        f<< "project(#{conf["project_name"]})"
        f<< "\n"

        f<< 'message(STATUS "adding include directories")'
        f<< "\n"
        f<< 'include_directories('
        f<< "\n"

        include_dir = conf["include_dir"];
        include_dir.each do |fold|
          f<< '	${CMAKE_SOURCE_DIR}' + '/' + fold
          f<< "\n"
        end
        f<< ')'
        f<< "\n"
        2.times { f<< "\n" }


        libfiles = conf["library"]
        libfiles.each do |libfile|
          str_src = ""
          
          libfile["fold"].each do |fold|
            str_src += read_source fold
          end
          f<< 'add_library('+libfile["name"]
          f<< str_src
          f<< "\n"
          f<< ')'
          f<< "\n"
          
          f<< 'add_library('+libfile["name"] + '_i SHARED'
          f<< str_src
          f<< "\n"
          f<< ')'
          f<< "\n"
          f<< 'message(STATUS "added '+libfile["name"]+' library")'
          f<< "\n"
        end
        2.times { f<< "\n" }


        exefiles = conf["executable"]
        exefiles.each do |exe|
          f<< 'add_executable(' + exe["name"]
          exe["fold"].each do | fold|
            f<< ' ' + read_source(fold)
            f<< "\n"
          end
          f<< ')'
          f<< "\n"
          f<< 'target_link_libraries(' +  exe["name"] + ' ' + exe["link_lib_name"].join(' ') + ' ${EXTERNAL_LIBS})'
          f<< "\n"
          f<< "\n"
        end

        2.times { f<< "\n" }
         
        f<< 'set(CMAKE_BUILD_TYPE Release)'
        f<< "\n"
      end
      
      puts "CMakeLists.txt has been created."
    end
  
    def parser
     @parser ||= OptionParser.new do |opts|
        opts.banner = "Usage: cmaker [options]"
        opts.separator ""
        opts.separator "cmaker Version: #{CMaker::VERSION}"
        
        opts.separator ""
        opts.separator "Common options:"
        opts.on_tail("-c", "--config", "create an config file")                         { puts create_config; exit }
        opts.on_tail("-h", "--help", "Show this message")                               { puts opts; exit }
        opts.on_tail('-v', '--version', "Show version")                                 { puts CMaker::VERSION; exit }
      end
    end
    
    def run!
      if not(File.exist? 'conf.yaml')
        puts "Your must create an conf.yaml file before generating the cmakelists.txt"
        return
      end
      generate_cmakelists
    end
    
  end
end