class DockerSquash < Formula
  include Language::Python::Virtualenv

  desc "Docker image squashing tool"
  homepage "https://github.com/goldmann/docker-squash"
  url "https://files.pythonhosted.org/packages/6c/0b/3684b7e34c46045dda03b34be50392c689b23fa8788a0c0f7daf98db35d8/docker-squash-1.1.0.tar.gz"
  sha256 "819a87bf44c575c76d8d8f15544363a7a81ca2b176d424b67b39cd2cd9acc89e"
  license "MIT"

  bottle do
    rebuild 2
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "cf0c62b8723354ec5dfad884e18e2b3cd7a3694b9fc62c9c2e2db4239b77863a"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "403c13d1e7f6a74fb3c9d92c55ee5d21c037ca135607e102204f3e01aa18105d"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "79e15a895d36531ac87ba617d2075f803d311ebd26f7a844d2f19c8ce3f3ebc6"
    sha256 cellar: :any_skip_relocation, ventura:        "ec799802efd9828bd21023fd3d89aab9bfd4ef3d8e07e6dc28f0da36aa3c2b55"
    sha256 cellar: :any_skip_relocation, monterey:       "37ad4f9d6671d0eab04868fc80621259df8106f8b2bf608bdc6e2e294d049bd8"
    sha256 cellar: :any_skip_relocation, big_sur:        "d1d526a45df27a046f9615f77bc19cd04a6e79b335425c8a164376e73e8598d3"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "928b047b8fcdbfadb7c28c1cff520c535cd92e660aade405ae80868dd08530c6"
  end

  depends_on "python@3.11"
  depends_on "six"

  resource "certifi" do
    url "https://files.pythonhosted.org/packages/93/71/752f7a4dd4c20d6b12341ed1732368546bc0ca9866139fe812f6009d9ac7/certifi-2023.5.7.tar.gz"
    sha256 "0f0d56dc5a6ad56fd4ba36484d6cc34451e1c6548c61daad8c320169f91eddc7"
  end

  resource "charset-normalizer" do
    url "https://files.pythonhosted.org/packages/ff/d7/8d757f8bd45be079d76309248845a04f09619a7b17d6dfc8c9ff6433cac2/charset-normalizer-3.1.0.tar.gz"
    sha256 "34e0a2f9c370eb95597aae63bf85eb5e96826d81e3dcf88b8886012906f509b5"
  end

  resource "docker" do
    url "https://files.pythonhosted.org/packages/af/24/4356f92e5f879ce60f78eb55d9d8c4369fd61242e7812700c60aa1d0e6e7/docker-6.1.1.tar.gz"
    sha256 "5ec18b9c49d48ee145a5b5824bb126dc32fc77931e18444783fc07a7724badc0"
  end

  resource "idna" do
    url "https://files.pythonhosted.org/packages/8b/e1/43beb3d38dba6cb420cefa297822eac205a277ab43e5ba5d5c46faf96438/idna-3.4.tar.gz"
    sha256 "814f528e8dead7d329833b91c5faa87d60bf71824cd12a7530b5526063d02cb4"
  end

  resource "packaging" do
    url "https://files.pythonhosted.org/packages/b9/6c/7c6658d258d7971c5eb0d9b69fa9265879ec9a9158031206d47800ae2213/packaging-23.1.tar.gz"
    sha256 "a392980d2b6cffa644431898be54b0045151319d1e7ec34f0cfed48767dd334f"
  end

  resource "requests" do
    url "https://files.pythonhosted.org/packages/e0/69/122171604bcef06825fa1c05bd9e9b1d43bc9feb8c6c0717c42c92cc6f3c/requests-2.30.0.tar.gz"
    sha256 "239d7d4458afcb28a692cdd298d87542235f4ca8d36d03a15bfc128a6559a2f4"
  end

  resource "urllib3" do
    url "https://files.pythonhosted.org/packages/fb/c0/1abba1a1233b81cf2e36f56e05194f5e8a0cec8c03c244cab56cc9dfb5bd/urllib3-2.0.2.tar.gz"
    sha256 "61717a1095d7e155cdb737ac7bb2f4324a858a1e2e6466f6d03ff630ca68d3cc"
  end

  resource "websocket-client" do
    url "https://files.pythonhosted.org/packages/8b/94/696484b0c13234c91b316bc3d82d432f9b589a9ef09d016875a31c670b76/websocket-client-1.5.1.tar.gz"
    sha256 "3f09e6d8230892547132177f575a4e3e73cfdf06526e20cc02aa1c3b47184d40"
  end

  def install
    virtualenv_install_with_resources
  end

  test do
    ENV["DOCKER_HOST"] = "does-not-exist:1234"
    output = shell_output("#{bin}/docker-squash not_an_image 2>&1", 1)
    assert_match "Could not create Docker client", output
  end
end
