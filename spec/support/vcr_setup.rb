require 'vcr'
require 'webmock/rspec'
VCR.configure do |config|
    config.cassette_library_dir = 'spec/vcr_cassettes'
    config.hook_into :webmock
end
