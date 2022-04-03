# coding: utf-8
class FortuneMod < Formula
  desc "Implementation of the Unix fortune command for displaying a random quotation, for Linux and other systems"
  homepage "https://github.com/shlomif/fortune-mod"
  url "https://github.com/shlomif/fortune-mod/releases/download/fortune-mod-3.4.1/fortune-mod-3.4.1.tar.xz"
  mirror "https://www.shlomifish.org/open-source/projects/fortune-mod/arcs/fortune-mod-3.4.1.tar.xz"
  sha256 "e3ade5ff950564f34dad39e7956cd15e9a32d669917b18dcbab8e02a0671120a"

  depends_on "cmake"      => :build
  depends_on "pkg-config" => :build
  depends_on "rinutils"
  depends_on "recode"

  option "with-offensive",
         "Include fortune files containing potentionally offensive cookies"
  option "with-blag-fortune",
         "Include anarchist quotes for fortune (offensive)"
  option "with-fortunes-bg",
         "Include Bulgarian data files for fortune"
  option "with-fortunes-bofh-excuses",
         "Include BOFH excuses for fortune"
  option "with-fortunes-br",
         "Include Portuguese data files for fortune"
  option "with-fortunes-cs",
         "Include Czech and Slovak data files for fortune"
  option "with-fortunes-de",
         "Include German data files for fortune"
  option "with-fortunes-debian-hint",
         "Include Debian Hints for fortune"
  option "with-fortunes-eo",
         "Include Esperanto data files for fortune"
  option "with-fortunes-es",
         "Include Spanish data files for fortune"
  option "with-fortunes-fr",
         "Include French data files for fortune"
  option "with-fortunes-ga",
         "Include Irish (Gaelige) data files for fortune"
  option "with-fortune-it",
         "Include Italian data files for fortune"
  option "with-fortunes-mario",
         "Include Mario data files for fortune"
  option "with-fortunes-pl",
         "Include Polish data files for fortune"
  option "with-fortunes-ru",
         "Include Russian data files for fortune"
  option "with-fortunes-spam",
         "Include fortunes taken from SPAM messages"
  option "with-fortunes-ubuntu-server",
         "Include Ubuntu server tips for fortune"
  option "with-fortune-woody-allen-it",
         "Include Italian Woody Allen quotes for fortune"
  option "with-fortune-zh",
         "Include Chinese data files for fortune"


  if build.with? "blag-fortune"
    resource "blag-fortune" do
      url ""
      mirror "https://deb.sipwise.com/debian/pool/main/b/blag-fortune/blag-fortune_1.2.orig.tar.gz"
      sha256 "4b0829abe4c8bf761fb8451669a2bb150086f7d4ef49d9ad26c2c41aee8796be"
    end
  end

  if build.with? "fortunes-bg"
    resource "fortunes-bg" do
      mirror "http://ports.ubuntu.com/pool/universe/f/fortunes-bg/fortunes-bg_1.3.tar.gz"
      sha256 "696e20a84a8eefd09c807729e83d082f6d96db3c60e857490d5b630e156b7283"
    end
  end

  if build.with? "fortunes-bofh-excuses"
    resource "fortunes-bofh-excuses" do
      mirror "http://ports.ubuntu.com/pool/universe/f/fortunes-bofh-excuses/fortunes-bofh-excuses_1.2.orig.tar.gz"
      sha256 "aae18134c49574d3e0b53ab748d40e7ce40d7f68f22b4af1f63d70800596a316"
    end
  end

  if build.with? "fortunes-br"
    resource "fortunes-br" do
      mirror "http://ports.ubuntu.com/pool/universe/f/fortunes-br/fortunes-br_20160820.tar.gz"
      sha256 "c8e07036fcda00c87911b3f01997389d657db72fb5b4663829052b0cd654c09b"
    end
  end

  if build.with? "fortunes-cs"
    resource "fortunes-cs" do
      mirror "http://ports.ubuntu.com/pool/universe/f/fortunes-cs/fortunes-cs_2.0.9.orig.tar.gz"
      sha256 "1c38a95ca328d597ee842e1597580a77446a47d565a2a38693d9edfce5a4c791"
    end
  end

  if build.with? "fortunes-de"
    resource "fortunes-de" do
      mirror "http://ports.ubuntu.com/pool/universe/f/fortunes-de/fortunes-de_0.34.orig.tar.gz"
      sha256 "75eb4a326b35dbe755422c2cffc200bb017eba248b91ff368c721ca5b7763902"
    end
  end

  if build.with? "fortunes-debian-hints"
    resource "fortunes-debian-hints" do
      mirror "http://ports.ubuntu.com/pool/universe/f/fortunes-debian-hints/fortunes-debian-hints_2.01.2.tar.xz"
      sha256 "d66d8f87764129caf02c729c134a6ab0a513f7ce7c0feae098483205933dfa74"
    end
  end

  if build.with? "fortunes-eo"
    resource "fortunes-eo" do
      mirror "http://ports.ubuntu.com/pool/universe/f/fortunes-eo/fortunes-eo_20020729b.orig.tar.gz"
      sha256 "d01c085aefade9ef5a91fc25221060e177375daf321761867b41d176b3426ef1"
    end
  end

  if build.with? "fortunes-es"
    resource "fortunes-es" do
      mirror "http://ports.ubuntu.com/pool/universe/f/fortunes-es/fortunes-es_1.35.tar.xz"
      sha256 "664891c222c80f9ea50212e7d0ae8c7b33a867368e0502e12407327eb0de89c3"
    end
  end

  if build.with? "fortunes-fr"
    resource "fortunes-f" do
      mirror "http://ports.ubuntu.com/pool/universe/f/fortunes-fr/fortunes-fr_0.65+nmu2.tar.gz"
      sha256 "43896c80f27c3e48cafe583cb149e32cbe34b54d84eca45d6e166b63ab2b4622"
    end
  end

  if build.with? "fortunes-ga"
    resource "fortunes-ga" do
      mirror "http://ports.ubuntu.com/pool/universe/f/fortunes-ga/fortunes-ga_0.10.tar.xz"
      sha256 "d5010592cd4cd6dfdf1781cb91cb7db1f14d65020b28fdc3c7f9aa993f7377d8"
    end
  end

  if build.with? "fortune-it"
    resource "fortune-it" do
      mirror "http://www.fortune-it.net/download/fortune-it-1.99.tar.gz"
      sha256 "f282626904701671d814411665e42edcd3257df8b6f1244993cc014424fa7e6c"
    end
  end

  if build.with? "fortunes-mario"
    resource "fortunes-mario" do
      mirror "http://ports.ubuntu.com/pool/universe/f/fortunes-mario/fortunes-mario_0.21.orig.tar.gz"
      sha256 "39e5f57229f6cf865d7ca8728eb333973ad047e235071ab39551f021047a2566"
    end
  end

  if build.with? "fortunes-pl"
    resource "fortunes-pl" do
      mirror "http://ports.ubuntu.com/pool/universe/f/fortunes-pl/fortunes-pl_0.0.20130525.orig.tar.gz"
      sha256 "258c8d0f148d1e387884a889837d901d8e08d731631a86f3c51f9b15d847137c"
    end
  end

  if build.with? "fortunes-ru"
    resource "fortunes-ru" do
      mirror "http://ports.ubuntu.com/pool/universe/f/fortunes-ru/fortunes-ru_1.52-3.debian.tar.xz"
      sha256 "ad9b2f1187a1ddd76b1013c3405e090f434d8cbe4c6faacf3653a5f34d4c16d2"
    end
  end

  if build.with? "fortunes-spam"
    resource "fortunes-spam" do
      mirror "http://ports.ubuntu.com/pool/universe/f/fortunes-spam/fortunes-spam_1.8.orig.tar.gz"
      sha256 "466cc5f6776c0dfc1c453a8b79be3a4843fab81c884a0b610f977ad6cf779d0d"
    end
  end

  if build.with? "fortunes-ubuntu-server"
    resource "fortunes-ubuntu-server" do
      mirror "http://ports.ubuntu.com/pool/universe/f/fortunes-ubuntu-server/fortunes-ubuntu-server_0.5.tar.gz"
      sha256 "425eb8249c192873a2720417bb3d96d48371f1318b30202b2474977f72c48184"
    end
  end

  if build.with? "fortune-woody-allen-it"
    resource "fortune-woody-allen-it" do
      url "https://github.com/daviderestivo/fortune-mod-woody-allen-it/archive/v0.2.tar.gz"
      sha256 "1f7ba6c0609a7d73f0fe77159ac41d45f9669ce14597def78e6512be4e61d0df"
    end
  end

  if build.with? "fortune-zh"
    resource "fortune-zh" do
      mirror "http://ports.ubuntu.com/pool/universe/f/fortune-zh/fortune-zh_2.96.tar.xz"
      sha256 "eb092c7f2f288de418221153b06d72a5db419eec1e8a044f4aa1c1c1e778e770"
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
    fortunes_install_dir = prefix/"local/share/games/fortunes"
    fortunes_offensive_install_dir = prefix/"local/share/games/fortunes/off"

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

  if build.with? "blag-fortune"
    if build.with? "offensive"
      dest_dirname = "blag-fortune"
      fortunes_files = "people/*"
      resource("blag-fortune").stage do
        mkdir_p dest_dirname
        mv fortunes_files, dest_dirname
        fortunes_offensive_install_dir.install Dir[dest_dirname]
      end
    else
      odie "blag-fortune contains potentionally offensive quotes. Please specify '--with-offensive'"
    end
  end

    if build.with? "fortunes-bg"
      fortunes_files = "bg/*"
      resource("fortunes-bg").stage do
        fortunes_install_dir.install Dir[fortunes_files]
      end
    end

    if build.with? "fortunes-bofh-excuses"
      fortunes_files = "bofh-excuses"
      resource("fortunes-bofh-excuses").stage do
        fortunes_install_dir.install Dir[fortunes_files]
      end
    end

    if build.with? "fortunes-br"
      fortunes_files = "brasil"
      resource("fortunes-br").stage do
        fortunes_install_dir.install Dir[fortunes_files]
      end
    end

    if build.with? "fortunes-cs"
      fortunes_files = "src/cookies/*"
      resource("fortunes-cs").stage do
        fortunes_install_dir.install Dir[fortunes_files]
      end
    end

    # TODO: Verify subfolders behaviour
    if build.with? "fortunes-de"
      fortunes_files = "data/*"
      resource("fortunes-de").stage do
        fortunes_install_dir.install Dir[fortunes_files]
      end
    end

    if build.with? "fortunes-debian-hints"
      fortunes_files = "hints"
      resource("fortunes-debian-hints").stage do
        fortunes_install_dir.install Dir[fortunes_files]
      end
    end

    if build.with? "fortunes-eo"
      fortunes_files = "proverbaro"
      resource("fortunes-eo").stage do
        fortunes_install_dir.install Dir[fortunes_files]
      end
    end

    # TODO
    if build.with? "fortunes-es"
      fortunes_files = ""
      resource("fortunes-es").stage do
        fortunes_install_dir.install Dir[fortunes_files]
      end
    end

    # TODO
    if build.with? "fortunes-fr"
      fortunes_files = ""
      resource("fortunes-fr").stage do
        fortunes_install_dir.install Dir[fortunes_files]
      end
    end


    if build.with? "fortunes-ga"
      fortunes_files = "proverbs"
      resource("fortunes-ga").stage do
        fortunes_install_dir.install Dir[fortunes_files]
      end
    end

    if build.with? "fortunes-mario"
      fortunes_files = ["mario.anagrams", "mario.computadores",
                        "mario.gauchismos", "mario.geral", "mario.palindromos",
                        "mario.piadas"]
      resource("fortunes-mario").stage do
        fortunes_install_dir.install Dir[fortunes_files]
      end
    end

    if build.with? "fortune-woody-allen-it"
      fortunes_files = "files/*"
      resource("fortune-woody-allen-it").stage do
        fortunes_install_dir.install Dir[fortunes_files]
      end
    end

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
    fortunes_install_dir = prefix/"local/share/games/fortunes"
    fortunes_offensive_install_dir = prefix/"local/share/games/fortunes/off"

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
