class Docmake < Formula
  desc "Automated builder from DocBook/XML to output formats (XHTML5, PDF)"
  homepage "http://www.shlomifish.org/open-source/projects/docmake/"
  url "https://cpan.metacpan.org/authors/id/S/SH/SHLOMIF/App-XML-DocBook-Builder-0.1101.tar.gz"
  sha256 "a1af02db83ac6de68d74b22cb12cff287dcc345af45ae409ebb828bf28719aa4"
  license "MIT"
  version "0.1101"
  revision 4

  depends_on "perl"
  depends_on "docbook-xsl"  # Required for xsltproc to find DocBook XSL stylesheets
  depends_on "libxslt"      # Required for xsltproc

  # Module::Build for Build.PL based modules
  resource "Module::Build" do
    url "https://cpan.metacpan.org/authors/id/L/LE/LEONT/Module-Build-0.4234.tar.gz"
    sha256 "66aeac6127418be5e471ead3744648c766bd01482825c5b66652675f2bc86a8f"
  end

  # XS-based accessor generator for Perl
  resource "Class::XSAccessor" do
    url "https://cpan.metacpan.org/authors/id/S/SM/SMUELLER/Class-XSAccessor-1.19.tar.gz"
    sha256 "99c56b395f1239af19901f2feeb125d9ecb4e351a0d80daa9529211a4700a6f2"
  end

  # File update checker
  resource "File::ShouldUpdate" do
    url "https://cpan.metacpan.org/authors/id/S/SH/SHLOMIF/File-ShouldUpdate-0.2.1.tar.gz"
    sha256 "af593598d06f1c21badd3ae741bf0b4506ce265ec89950c60a3f3e7106deb3e2"
  end

  # Data::Dump - dependency of Test::Trap
  resource "Data::Dump" do
    url "https://cpan.metacpan.org/authors/id/G/GA/GARU/Data-Dump-1.25.tar.gz"
    sha256 "a4aa6e0ddbf39d5ad49bddfe0f89d9da864e3bc00f627125d1bc580472f53fbd"
  end

  # Test::Trap - required by App::XML::DocBook::Docmake
  resource "Test::Trap" do
    url "https://cpan.metacpan.org/authors/id/E/EB/EBHANSSEN/Test-Trap-v0.3.5.tar.gz"
    sha256 "54f99016562b5b1d72110100f1f2be437178cdf84376f495ffd0376f1d7ecb9a"
  end

  # Path::Tiny - required by fortune-mod's fortmod_gen_manpage.pl for man page generation
  resource "Path::Tiny" do
    url "https://cpan.metacpan.org/authors/id/D/DA/DAGOLDEN/Path-Tiny-0.146.tar.gz"
    sha256 "861ef09bca68254e9ab24337bb6ec9d58593a792e9d68a27ee6bec2150f06741"
  end

  def install
    ENV.prepend_create_path "PERL5LIB", libexec/"lib/perl5"
    ENV.prepend_path "PERL5LIB", libexec/"lib"

    # Install Module::Build first (it uses Makefile.PL)
    resource("Module::Build").stage do
      system "perl", "Makefile.PL", "INSTALL_BASE=#{libexec}"
      system "make"
      system "make", "install"
    end

    # Install other Perl dependencies
    # Note: We need to handle Build.PL modules carefully due to macOS sandbox
    # issues where pwd returns "Operation not permitted". Setting PWD explicitly
    # and using --destdir helps Module::Build track the correct working directory.
    %w[Class::XSAccessor File::ShouldUpdate Data::Dump Test::Trap Path::Tiny].each do |res_name|
      resource(res_name).stage do |staging|
        # Get the absolute path of the staging directory
        stage_dir = Dir.pwd

        if File.exist?("Makefile.PL")
          system "perl", "Makefile.PL", "INSTALL_BASE=#{libexec}"
          system "make"
          system "make", "install"
        elsif File.exist?("Build.PL")
          # Set PWD explicitly to work around macOS sandbox pwd issues
          # Module::Build uses pwd to track the original directory, and the
          # Homebrew sandbox can cause pwd to fail with "Operation not permitted"
          ENV["PWD"] = stage_dir
          system "perl", "Build.PL", "--install_base=#{libexec}"
          system "perl", "./Build"
          system "perl", "./Build", "install", "--destdir", "/"
        end
      end
    end

    # Install docmake itself
    system "perl", "Makefile.PL", "INSTALL_BASE=#{libexec}"
    system "make"
    system "make", "install"

    # Create wrapper script that sets up PERL5LIB and XML_CATALOG_FILES
    (bin/"docmake").write <<~EOS
      #!/bin/bash
      export PERL5LIB="#{libexec}/lib/perl5:#{libexec}/lib"
      export XML_CATALOG_FILES="#{HOMEBREW_PREFIX}/etc/xml/catalog"
      exec "#{libexec}/bin/docmake" "$@"
    EOS
  end

  def caveats
    <<~EOS
      docmake requires DocBook XSL stylesheets and an XSLT processor to function.
      These are installed as dependencies.

      For PDF output, you'll also need an FO processor like Apache FOP:

        brew install fop
    EOS
  end

  test do
    # Test that docmake runs and shows help
    assert_match "docmake", shell_output("#{bin}/docmake --help 2>&1", 0)
  end
end
