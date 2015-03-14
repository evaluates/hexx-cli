# encoding: utf-8

# Loads the RSpec test suit and settings
require "hexx-rspec"

# Loads coverage
Hexx::RSpec.load_metrics_for(self)

# Loads the code under test
require "hexx-cli"
