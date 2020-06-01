class Rinutils < Formula
  desc "C11 / gnu11 utilities C library by Shlomi Fish / Rindolf"
  homepage "https://github.com/shlomif/rinutils"
  url "https://github.com/shlomif/rinutils/releases/download/0.4.0/rinutils-0.4.0.tar.xz"
  sha256 "ccabff71b0ac7de73036cf9613406ffff760daf14e0c6f8443fd299154bfd38a"

  depends_on "cmake" => :build
  depends_on "cmocka" => :build
  depends_on "pkg-config" => :build
  
  def install
    args = std_cmake_args

    mkdir "build" do
      system "cmake", "..", *args
      system "make"
      system "make", "install"
    end
  end
end
