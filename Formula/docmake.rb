class Docmake < Formula
  desc "Automated builder from DocBook/XML to output formats (XHTML5, PDF)"
  homepage "http://www.shlomifish.org/open-source/projects/docmake/"
  url "https://cpan.metacpan.org/authors/id/S/SH/SHLOMIF/App-XML-DocBook-Builder-0.1101.tar.gz"
  sha256 "a1af02db83ac6de68d74b22cb12cff287dcc345af45ae409ebb828bf28719aa4"
  license "MIT"
  version "0.1101"
  revision 1

  depends_on "perl"

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

  def install
    ENV.prepend_create_path "PERL5LIB", libexec/"lib/perl5"
    ENV.prepend_path "PERL5LIB", libexec/"lib"

    # Install Perl dependencies
    resources.each do |r|
      r.stage do
        system "perl", "Makefile.PL", "INSTALL_BASE=#{libexec}"
        system "make"
        system "make", "install"
      end
    end

    # Install docmake itself
    system "perl", "Makefile.PL", "INSTALL_BASE=#{libexec}"
    system "make"
    system "make", "install"

    # Create wrapper script that sets up PERL5LIB
    (bin/"docmake").write <<~EOS
      #!/bin/bash
      export PERL5LIB="#{libexec}/lib/perl5:#{libexec}/lib"
      exec "#{libexec}/bin/docmake" "$@"
    EOS
  end

  def caveats
    <<~EOS
      docmake requires DocBook XSL stylesheets and an XSLT processor to function.
      You may need to install additional dependencies:

        brew install docbook-xsl libxslt

      For PDF output, you'll also need an FO processor like Apache FOP:

        brew install fop
    EOS
  end

  test do
    # Test that docmake runs and shows help
    assert_match "docmake", shell_output("#{bin}/docmake --help 2>&1", 0)
  end
end
