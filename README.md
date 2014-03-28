# CMaker

This gem generate  source files needed for CMakeLists.txt

## Installation

Build and Install:
    
    $ git clone https://github.com/shiyj/cmaker.git
    $ cd cmaker
    $ gem build cmaker.gemspec
    $ gem install cmaker-x.x.x.gem

## Usage
  
    $ cd /path/to/your/project
    $ cmaker -c
    $ vi conf.yaml
    $ cmaker
  
you will get a cmakelists.txt /path/to/your/project.
** You Must Edit the `conf.yaml` file By Hand BEFORE you execute `cmaker` **

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
