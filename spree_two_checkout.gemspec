# encoding: UTF-8
Gem::Specification.new do |s|
  s.platform    = Gem::Platform::RUBY
  s.name        = 'spree_two_checkout'
  s.version     = '0.3.1'
  s.summary     = 'Spree 2Checkout Payment Module'
  s.description = 'Spree 2Checkout Payment Module'
  s.required_ruby_version = '>= 1.9.1'

  s.author            = 'Craig Christenson'
  s.email             = 'christensoncraig@gmail.com'
  s.homepage          = 'https://github.com/craigchristenson'

  #s.files         = `git ls-files`.split("\n")
  #s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.require_path = 'lib'
  s.requirements << 'none'

end

