require 'active_support/all'

namespace :generate do
  
  desc "Generate FontAwesome icon config"
  task :fa do
    css = read_css('fa.css')
    # ?v=4.0.1
    data = {
      'name'    => "FontAwesome",
      'version' =>  "4.0.1",
      'icons'   => {},
      'fonts'   => {
        "eot"   =>  "//netdna.bootstrapcdn.com/font-awesome/4.0.1/fonts/fontawesome-webfont.eot?v=4.0.1",
        "eot2"  =>  "//netdna.bootstrapcdn.com/font-awesome/4.0.1/fonts/fontawesome-webfont.eot?#iefix&v=4.0.1",
        "ttf"   =>  "//netdna.bootstrapcdn.com/font-awesome/4.0.1/fonts/fontawesome-webfont.ttf?v=4.0.1",
        "woff"  =>  "//netdna.bootstrapcdn.com/font-awesome/4.0.1/fonts/fontawesome-webfont.woff?v=4.0.1",
        "svg"   =>  "//netdna.bootstrapcdn.com/font-awesome/4.0.1/fonts/fontawesome-webfont.svg?v=4.0.1#fontawesomeregular"
      }
    }
    css.to_s.scan(/\.fa\-(\S+)\:before\s?.*\s+content.*\\([a-z0-9]{4,})/).each do |matches|
      name, content = matches
      data["icons"].merge!(name.underscore => %Q{#{content}})
    end
    File.open( File.join(base_dir, 'font-awesome.yml'), 'w+') do |file| 
      file.write(YAML.dump(data))
    end
  end
  
  def base_dir
    File.expand_path('../', __FILE__)
  end
  
  def read_css(file)
    File.read File.join( base_dir, 'css', file)
  end
end