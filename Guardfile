# encoding: utf-8

guard :rspec, cmd: "bundle exec rspec" do

  watch("spec/tests/**/*_spec.rb")

  watch(%r{^lib/hexx/(\w+)\.rb$}) do |m|
    "spec/tests/#{ m[1] }_spec.rb"
  end

  watch("lib/hexx-cli.rb")     { "spec" }
  watch("spec/fixtures/**/*")  { "spec" }
  watch("spec/spec_helper.rb") { "spec" }

end # guard :rspec
