# Documentation: https://docs.brew.sh/Formula-Cookbook
#                https://rubydoc.brew.sh/Formula
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!
class AwscliLocal < Formula
  include Language::Python::Virtualenv


  desc "Thin wrapper around the \"aws\" command line interface for use with LocalStack"
  homepage "https://github.com/localstack/awscli-local"
  url "https://files.pythonhosted.org/packages/d4/24/d22c30b56b7468d3369e4b1f0d8ac05ee771d169c376e8acb2009eb32a42/awscli-local-0.4.tar.gz"
  sha256 "a6a34cc7dd6774194cf43e67a6b93006fb4b395ac0dd5c9245da1b365c8ef767"
  head "https://github.com/localstack/awscli-local.git"

  # depends_on "cmake" => :build
  depends_on "python"
  
  resource "awscli" do
  	url "https://files.pythonhosted.org/packages/c4/ad/ecfe20aed0da5c29d5624bd47aa8514a927e267c8632604806a513b8ea40/awscli-1.16.265.tar.gz"
  	sha256 "bad41bc49c73c5b4af1f115b418fdb201b7b2f56b3025961d6fd6cdcbbcc03b0"
  end

  resource "six" do
    url "https://files.pythonhosted.org/packages/dd/bf/4138e7bfb757de47d1f4b6994648ec67a51efe58fa907c1e11e350cddfca/six-1.12.0.tar.gz"
    sha256 "d16a0141ec1a18405cd4ce8b4613101da75da0e9a7aec5bdd4fa804d0e0eba73"
  end

  resource "localstack-client" do
  	url "https://files.pythonhosted.org/packages/45/7e/006c062f390d99975efe7eae31dbe56b3de9e29898b6f3597350f724fe02/localstack-client-0.14.tar.gz"
  	sha256 "6931316dfb5f9a051cf4b678554a6c23344bd450805078141c09cfedec9bac38"
  end

  def install
  	virtualenv_install_with_resources
    # ENV.deparallelize  # if your formula fails when building in parallel
    # Remove unrecognized options if warned by configure
    # system "./configure", "--disable-debug",
    #                       "--disable-dependency-tracking",
    #                       "--disable-silent-rules",
    #                       "--prefix=#{prefix}"
    # system "cmake", ".", *std_cmake_args
  end

  def caveats; <<~EOS
  	Make sure you have localstack running somewhere on you machine.

  	This tool is meant to point to it!
  EOS
  end

  test do
    # `test do` will create, run in and delete a temporary directory.
    #
    # This test will fail and we won't accept that! For Homebrew/homebrew-core
    # this will need to be a test that verifies the functionality of the
    # software. Run the test with `brew test awscli-local`. Options passed
    # to `brew install` such as `--HEAD` also need to be provided to `brew test`.
    #
    # The installed folder is not in the path, so use the entire path to any
    # executables being tested: `system "#{bin}/program", "do", "something"`.
    output = shell_output("awslocal --version")
    assert_match "aws-cli", output
  end
end
