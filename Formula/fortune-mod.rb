class FortuneMod < Formula
  desc "Implementation of the Unix fortune command for displaying a random quotation, for Linux and other systems"
  homepage "https://github.com/shlomif/fortune-mod"
  url "https://www.shlomifish.org/open-source/projects/fortune-mod/arcs/fortune-mod-3.20.0.tar.xz"
  mirror "https://src.fedoraproject.org/lookaside/extras/fortune-mod/fortune-mod-3.20.0.tar.xz/sha512/4ce1111c73f087ed899e4796ac9c15f85fa7262e08f1a81162fcc37757d4ecd1f234d3c2c362a264c07ae45d68ec2299d4870c7b348cc0bbeb7db3b170ba0ded/fortune-mod-3.20.0.tar.xz"
  sha256 "3101be95fb89c4848d483e72930da8d03f6925737a23d78803d6b55c42fe2094"
  license "BSD-4-Clause"
  version "3.20.0"
  revision 1

  depends_on "cmake"      => :build
  depends_on "pkg-config" => :build
  depends_on "rinutils"
  depends_on "recode"

  option "with-offensive",
         "Include fortune files containing potentionally offensive cookies"
  option "with-fortune-it",
         "Include fortune files in Italian language"
  option "with-fortune-woody-allen-it",
         "Include fortune files of Woody Allen quotes in Italian language"


  if build.with? "fortune-woody-allen-it"
    resource "fortune-woody-allen-it" do
      url "https://github.com/daviderestivo/fortune-mod-woody-allen-it/archive/v0.2.tar.gz"
      sha256 "1f7ba6c0609a7d73f0fe77159ac41d45f9669ce14597def78e6512be4e61d0df"
    end
  end

  if build.with? "fortune-it"
    resource "fortune-it" do
      url "https://www.ibiblio.org/pub/Linux/games/amusements/fortune/fortune-it-1.99.tar.gz"
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
    fortunes_install_dir = prefix/"share/games/fortunes"
    fortunes_offensive_install_dir = prefix/"share/games/fortunes/off"

    args = std_cmake_args

    # Do we want to install the offensive files? (ON => no, OFF => yes)
    if build.without? "offensive"
      args << "-DNO_OFFENSIVE=ON"
    end

    mkdir "build" do
      system "cmake", "..", *args
      system "make"
      system "make", "install"

      bin.install_symlink prefix/"games/fortune"
    end

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
    fortunes_install_dir = prefix/"share/games/fortunes"
    fortunes_offensive_install_dir = prefix/"share/games/fortunes/off"

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
