class Coursier < Formula
  desc "Pure Scala Artifact Fetching"
  homepage "https://get-coursier.io/"
  url "https://github.com/coursier/coursier/releases/download/v2.1.0-M6/coursier.jar"
  version "2.1.0-M6"
  sha256 "68c4380b16f424047b48ac33c426fa2750f3424a9907e37fcf0c8b111081aa6a"
  license "Apache-2.0"

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+(?:-M\d+)?)$/i)
  end

  bottle do
    rebuild 1
    sha256 cellar: :any_skip_relocation, all: "139ef6fa46e28903ca878e4b5b7beb55bf968932fe8257e4529576f0f36be82e"
  end

  depends_on "openjdk"

  def install
    (libexec/"bin").install "coursier.jar"
    chmod 0755, libexec/"bin/coursier.jar"
    (bin/"coursier").write_env_script libexec/"bin/coursier.jar", Language::Java.overridable_java_home_env

    generate_completions_from_executable("bash", "#{bin}/coursier", "completions", "bash",
                                         shell_parameter_format: :none, shells: [:bash])
    generate_completions_from_executable("bash", "#{bin}/coursier", "completions", "zsh",
                                         shell_parameter_format: :none, shells: [:zsh])
  end

  test do
    system bin/"coursier", "list"
    assert_match "scalafix", shell_output("#{bin}/coursier search scalafix")
  end
end
