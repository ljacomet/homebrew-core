class GradleAT7 < Formula
  desc "Open-source build automation tool based on the Groovy and Kotlin DSL"
  homepage "https://www.gradle.org/"
  url "https://services.gradle.org/distributions/gradle-7.6.1-all.zip"
  sha256 "518a863631feb7452b8f1b3dc2aaee5f388355cc3421bbd0275fbeadd77e84b2"
  license "Apache-2.0"

  livecheck do
    url "https://gradle.org/releases/"
    regex(/href=.*?gradle[._-]v?(7(?:\.\d+)+)-all\.(?:zip|t)/i)
  end

  bottle do
    sha256 cellar: :any_skip_relocation, all: "8d62d254f3578c6a50b0578ee96584b84a42cdc50086c71eb73bbbb7acfa83c6"
  end

  keg_only :versioned_formula

  depends_on "openjdk"

  def install
    rm_f Dir["bin/*.bat"]
    libexec.install %w[bin docs lib src]
    env = Language::Java.overridable_java_home_env("19")
    (bin/"gradle").write_env_script libexec/"bin/gradle", env
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/gradle --version")

    (testpath/"settings.gradle").write ""
    (testpath/"build.gradle").write <<~EOS
      println "gradle works!"
    EOS
    gradle_output = shell_output("#{bin}/gradle build --no-daemon")
    assert_includes gradle_output, "gradle works!"
  end
end
