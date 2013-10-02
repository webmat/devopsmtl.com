require 'yaml'

require 'bundler'
Bundler.require

class Default < Thor
end

class Cloudflare < Thor

  desc "refresh", "Refreshes the Cloudflare trusted addresses"
  def refresh
    ipv4 = Excon.get('https://www.cloudflare.com/ips-v4')
    # TODO ipv6 = Excon.get('https://www.cloudflare.com/ips-v6')
    File.write  'roles/nginx-cloudflare/vars/main.yml',
                YAML.dump({'cloudflare_ipv4' => ipv4.body.split("\n")})
  end

end
