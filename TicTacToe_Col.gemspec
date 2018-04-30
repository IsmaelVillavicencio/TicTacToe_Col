
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "TicTacToe_Col/version"

Gem::Specification.new do |spec|
  spec.name          = "TicTacToe_Col"
  spec.version       = TicTacToeCol::VERSION
  spec.authors       = ["Ismael Villavicencio"]
  spec.email         = ["villavicencioismael@gmail.com"]

  spec.summary       = %q{Tic Tac Toe is an awesome gem.}
  spec.description   = %q{Two players represented with X and O, first time the game is played, X starts. Each player alternate turns to put a mark in the board on any available slot. The game ends when either one of the players matches three marks in a horizontal, vertical or diagonal row or there are no more moves available, once the game finishes, players are asked if they want to play again. If they do, the player who lost the previous match starts. In case of a draw, the player who did the second-to-last movement starts}
  spec.homepage      = "https://github.com/IsmaelVillavicencio/TicTacToe_Col"
  spec.license       = "MIT"

  spec.files         = Dir.glob("{bin,lib}/**/*")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^test/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "matrix", "~> 0.0.1"
  spec.add_development_dependency "colorize", "~> 0.8.1"
end
