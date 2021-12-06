lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'slack_wrapper/version'

Gem::Specification.new do |spec|
  spec.name          = 'slack-wrapper'
  spec.version       = SlackWrapper::VERSION
  spec.authors       = ['James Glenn']
  spec.email         = ['47917431+JR-G@users.noreply.github.com']

  spec.summary       = 'A wrapper to make life easier whilst working with the Slack API'
  spec.description   = 'A wrapper to make life easier whilst working with the Slack API'
  spec.homepage      = 'https://github.com/JR-G/slack-wrapper'
  spec.license       = 'MIT'

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"

    spec.metadata['homepage_uri'] = spec.homepage
    spec.metadata['source_code_uri'] = 'https://github.com/JR-G/slack-wrapper'
    spec.metadata['changelog_uri'] = 'https://github.com/JR-G/slack-wrapper/CHANGELOG.md'
  else
    raise 'RubyGems 2.0 or newer is required to protect against ' \
      'public gem pushes.'
  end

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path('lib', __dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'bundler'
  spec.add_dependency 'dotenv'
  spec.add_dependency 'pry'
  spec.add_dependency 'rake'
  spec.add_dependency 'rspec'
  spec.add_dependency 'slack-ruby-client'
end
