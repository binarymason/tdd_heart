Gem::Specification.new do |s|
  s.name        = 'tdd_heart'
  s.version     = '0.0.3'
  s.date        = '2016-11-06'
  s.summary     = '♥ passing tests'
  s.description = 'A simple executable that adds a green or red heart to tmux status bar depending on passing/failing tests.'
  s.authors     = ['John Mason']
  s.files       = ['lib/tdd_heart.rb']
  s.executables << 'tdd_heart'
  s.bindir      = 'bin'
  s.homepage    = 'https://github.com/binarymason/tdd_heart'
  s.license     = 'MIT'
end
