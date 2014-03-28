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

**You Must Edit the `conf.yaml` file By Hand BEFORE you execute `cmaker`**

**You Must Edit the `CMakeLists.txt` file if you want to set other command options of cmake**

### conf.yaml

The `conf.yaml` is the config which was used to create the CMakeLists.txt.
But the default file created by `cmaker -c` is useless to your Project, so you must edit it yourself.

1. First, you should give the project a name after the key world `project_name: `,
2. Second, add the include header folders to `include_dir: ` array,
3. Third, add an subitem in `library: ` or `executable: ` array and each subitem must have three attribute: `name: `,`fold:`,`link_lib_name:  `

here is an examplye:
    
    project_name: demo
    include_dir: [lib]
    library:
      [
        {name: geodemo,fold: [lib],link_lib_name: []}
      ]
    executable:
      [
        {name: main,fold: [src],link_lib_name: [geodemo]}
      ]

This config tell cmaker that : 

1. I want to compile the source file in `lib` to a libary( a *.dll/*.lib or *.so/*.a),
and the source file in `src` to a executable program.
2. Besides, I named the library after 'geodemo' which will create a geodemo.dll or libgeodemo.so .
3. The executable program `main` will link the library geodemo.dll or libgeodemo.so.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
