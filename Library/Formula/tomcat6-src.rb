require 'formula'

class Tomcat6Src <Formula
  url 'http://archive.apache.org/dist/tomcat/tomcat-6/v6.0.29/src/apache-tomcat-6.0.29-src.tar.gz'
  homepage 'http://tomcat.apache.org/'
  md5 '260de5ae62f415b9c085c5aeed4ef24c'

  def install
    rm_rf Dir['bin/*.{cmd,bat]}']

    if File.exist? "#{HOMEBREW_PREFIX}/etc/build.properties"
      cp Dir["#{HOMEBREW_PREFIX}/etc/build.properties"], Dir['build.properties']
    else
      cp 'build.properties.default', 'build.properties'

      inreplace 'build.properties', 
                  /^base\.path=.*$/, 
                  "base.path=./share/java"

      inreplace 'build.xml',
                  /^base\.path=.*$/, 
                  "base.path=./share/java"
    end

    system "ant", "download"

    system "fart"
  end
  
  def caveats
    <<-EOS.undent
      
      To start solr:
        $ solr path/to/solr/config/dir

      See the solr homepage for more setup information:
        $ brew home solr
    EOS
  end
end
