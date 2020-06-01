class FortunePlus < Formula
  desc "Infamous electronic fortune-cookie generator"
  homepage "https://www.ibiblio.org/pub/linux/games/amusements/fortune/!INDEX.html"
  url "https://www.ibiblio.org/pub/linux/games/amusements/fortune/fortune-mod-9708.tar.gz"
  mirror "https://src.fedoraproject.org/repo/pkgs/fortune-mod/fortune-mod-9708.tar.gz/81a87a44f9d94b0809dfc2b7b140a379/fortune-mod-9708.tar.gz"
  sha256 "1a98a6fd42ef23c8aec9e4a368afb40b6b0ddfb67b5b383ad82a7b78d8e0602a"

  option "with-offensive",
         "Include fortune files containing potentionally offensive cookies"
  option "with-fortune-it",
         "Include fortune files in Italian language"
  option "with-fortune-woody-allen-it",
         "Include fortune files of Woody Allen quotes in Italian language"


  if build.with? "fortune-woody-allen-it"
    resource "fortune-woody-allen-it" do
      url "https://raw.githubusercontent.com/daviderestivo/homebrew-fortune-plus/master/files/fortune-mod-woody-allen-it-0.2.tgz"
      sha256 "c54d8a25d63a47de075317ad031f09a9537cc6ced25ad7f6faf090e9a68664c6"
    end
  end

  if build.with? "fortune-it"
    resource "fortune-it" do
      url "http://www.fortune-it.net/download/fortune-it-1.99.tar.gz"
      sha256 "f282626904701671d814411665e42edcd3257df8b6f1244993cc014424fa7e6c"
    end
  end

  def rot13(filename)
    # Open the source file in read mode and read it ...
    file = File.open(filename, "r")
    content = file.read()
    # ... rot13 the file ...
    rot13 = content.tr("a-z", "n-za-m")
    # ... re-open file in write mode and write to it.
    file = File.open(filename, "w")
    file.write(rot13)
    file.close()
  end

  def install
    # Initialize fortunes install paths
    fortunes_install_dir = share/"games/fortunes"
    fortunes_offensive_install_dir = share/"games/fortunes/off"

    ENV.deparallelize

    inreplace "Makefile" do |s|
      # Use our selected compiler
      s.change_make_var! "CC", ENV.cc

      # Change these first two folders to the correct location in /usr/local...
      s.change_make_var! "FORTDIR", "/usr/local/bin"
      s.gsub! "/usr/local/man", "/usr/local/share/man"
      # Now change all /usr/local at once to the prefix
      s.gsub! "/usr/local", prefix

      # macOS only supports POSIX regexes
      s.change_make_var! "REGEXDEFS", "-DHAVE_REGEX_H -DPOSIX_REGEX"

      # Do we want to install the offensive files? (0 no, 1 yes)
      if build.without? "offensive"
        s.gsub! "OFFENSIVE=1", "OFFENSIVE=0"
      end
    end

    system "make", "install"

    # fortune-woody-allen-it
    if build.with? "fortune-woody-allen-it"
      fortunes_files = "files/*"
      resource("fortune-woody-allen-it").stage do
        fortunes_install_dir.install Dir[fortunes_files]
      end
    end

    # fortune-it
    if build.with? "fortune-it"
      fortunes_files = "testi/*"
      resource("fortune-it").stage do
        if build.with? "offensive" # Install both offensive and not
          Dir[fortunes_files].grep(/(-o)$/) do |filename|
            # rot13 all offensive fortunes before installing them
            rot13(filename)
          end
          fortunes_install_dir.install Dir[fortunes_files].grep(/^((?!-o).)*$/)
          fortunes_offensive_install_dir.install Dir[fortunes_files].grep(/(-o)$/)
        else # Install only not offensive
          fortunes_install_dir.install Dir[fortunes_files].grep(/^((?!-o).)*$/)
        end
      end
    end
  end

  def post_install
    # Initialize fortunes install paths
    fortunes_install_dir = share/"games/fortunes"
    fortunes_offensive_install_dir = share/"games/fortunes/off"

    Dir.each_child(fortunes_install_dir) do |filename|
      if (not filename.end_with? ".dat") and (filename != "off")
        system("strfile", fortunes_install_dir + filename)
      end
    end
    if build.with? "offensive"
      Dir.each_child(fortunes_offensive_install_dir) do |filename|
        if not filename.end_with? ".dat"
          system("strfile", "-x", fortunes_offensive_install_dir + filename)
        end
      end
    end
  end

  test do
    system "#{bin}/fortune"
  end
end
