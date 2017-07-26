Gem::Specification.new do |s|
  s.name = 'humble_rpi-plugin-button'
  s.version = '0.4.0'
  s.summary = 'A humble_rpi plugin which detects a button press.'
  s.authors = ['James Robertson']
  s.files = Dir['lib/humble_rpi-plugin-button.rb']
  s.add_runtime_dependency('rpi_pinin_msgout', '~> 0.3', '>=0.3.5')
  s.signing_key = '../privatekeys/humble_rpi-plugin-button.pem'
  s.cert_chain  = ['gem-public_cert.pem']
  s.license = 'MIT'
  s.email = 'james@jamesrobertson.eu'
  s.homepage = 'https://github.com/jrobertson/humble_rpi-plugin-button'
end
