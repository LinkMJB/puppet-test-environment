# puppet-test-environment
A Docker container to be used as a Jenkins executor for running puppet-lint, puppet-syntax, and rspec tests against Puppet modules. Container can be pulled from Docker Hub using `hsnodgrass3/puppet-test-environment`. Link to Docker Hub: https://hub.docker.com/r/hsnodgrass3/puppet-test-environment/

## Notes
This container contains a patched `init.rb` file for `puppet/provider/service/init.rb`. The reason for this is that, when running `puppet-rspec` tests on Puppet modules that included the provider `puppetlabs/powershell`, errors would be thrown when lines 24 and 25 of `puppet/provider/service/init.rb` attempted to determine the default provider for the OS. This is most likely becuase this container is nix-based and `puppetlabs/powershell` only works on Windows. The fix was to convert the facter fact `os` to a string before envoking the `downcase` method on that fact, probably because there was no compatabile `os` fact and you can't `downcase` something that exists. I could also be completely wrong about this, but the hack has been working so far. The changes to `init.rb` are as follows:

```ruby
original init.rb

23.	  confine :true => begin
24.	      os = Facter.value(:operatingsystem).downcase
25.	      family = Facter.value(:osfamily).downcase
26.	      !(os == 'debian' || os == 'ubuntu' || family == 'redhat')
27.	  end

patched init.rb
23.	  confine :true => begin
24.	      os = Facter.value(:operatingsystem).to_s.downcase
25.	      family = Facter.value(:osfamily).to_s.downcase
26.	      !(os == 'debian' || os == 'ubuntu' || family == 'redhat')
27.	  end
```
