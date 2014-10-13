#!/usr/bin/env ruby


# require 'rbconfig'
require 'openssl'
puts "verify peer: #{OpenSSL::SSL::VERIFY_PEER}, none: #{OpenSSL::SSL::VERIFY_NONE}"
OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE
require 'net/https'


# ctx = OpenSSL::SSL::SSLContext.new
# ctx.ssl_version = :TLSv1_1
# puts ctx

# require "openssl"
# puts OpenSSL::OPENSSL_VERSION
# puts "SSL_CERT_FILE: %s" % OpenSSL::X509::DEFAULT_CERT_FILE
# puts "SSL_CERT_DIR: %s" % OpenSSL::X509::DEFAULT_CERT_DIR

# uri = URI('https://www.yahoo.com')
# uri = URI('https://github.com')
uri = URI('https://ic2500.powerauctions.com')


ruby = File.join(RbConfig::CONFIG['bindir'], RbConfig::CONFIG['ruby_install_name'])
ruby_version = RUBY_VERSION
if patch = RbConfig::CONFIG['PATCHLEVEL']
  ruby_version += "-p#{patch}"
end
puts "%s (%s)" % [ruby, ruby_version]

openssl_dir = OpenSSL::X509::DEFAULT_CERT_AREA
mac_openssl = '/System/Library/OpenSSL' == openssl_dir
puts "%s: %s" % [OpenSSL::OPENSSL_VERSION, openssl_dir]
[OpenSSL::X509::DEFAULT_CERT_DIR_ENV, OpenSSL::X509::DEFAULT_CERT_FILE_ENV].each do |key|
  puts "%s=%s" % [key, ENV[key].to_s.inspect]
end

ca_file = ENV[OpenSSL::X509::DEFAULT_CERT_FILE_ENV] || OpenSSL::X509::DEFAULT_CERT_FILE
ca_path = (ENV[OpenSSL::X509::DEFAULT_CERT_DIR_ENV] || OpenSSL::X509::DEFAULT_CERT_DIR).chomp('/')

puts "\nHEAD https://#{uri.host}:#{uri.port}"
# http = Net::HTTP.new(uri.host, uri.port)
# http.use_ssl = true
# http.get


Net::HTTP.start(uri.host, uri.port,
  :use_ssl => uri.scheme == 'https') do |http|
  # http.verify_mode = OpenSSL::SSL::VERIFY_NONE
  http.use_ssl = true

  http.cert_store = OpenSSL::X509::Store.new
  http.cert_store.set_default_paths

  http.verify_mode = OpenSSL::SSL::VERIFY_PEER
  failed_cert = failed_cert_reason = nil


  if mac_openssl
    warn "warning: will not be able show failed certificate info on OS X's OpenSSL"
    # This drives me absolutely nuts. It seems that on Rubies compiled against OS X's
    # system OpenSSL, the mere fact of defining a `verify_callback` makes the
    # cert verification fail for requests that would otherwise be successful.
  else
    http.verify_callback = lambda { |verify_ok, store_context|
      if !verify_ok
        failed_cert = store_context.current_cert
        failed_cert_reason = "%d: %s" % [ store_context.error, store_context.error_string ]
      end
      verify_ok
    }
  end



  begin
    request = Net::HTTP::Get.new uri
    response = http.request request # Net::HTTPResponse object
    puts response
  rescue Errno::ECONNREFUSED
    puts "Error: connection refused"
    exit 1
  rescue OpenSSL::SSL::SSLError => e
    puts "#{e.class}: #{e.message}"

    if failed_cert
      puts "\nThe server presented a certificate that could not be verified:"
      puts "  subject: #{failed_cert.subject}"
      puts "  issuer: #{failed_cert.issuer}"
      puts "  error code %s" % failed_cert_reason
    end

    ca_file_missing = !File.exist?(ca_file) && !mac_openssl
    ca_path_empty = Dir["#{ca_path}/*"].empty?

    if ca_file_missing || ca_path_empty
      puts "\nPossible causes:"
      puts "  `%s' does not exist" % ca_file if ca_file_missing
      puts "  `%s/' is empty" % ca_path if ca_path_empty
    end

    exit 1
  end
end

# require 'https'

# http = Net::HTTP.new('github.com', 443)
# http.use_ssl = true
# http.verify_mode = OpenSSL::SSL::VERIFY_PEER

# http.cert_store = OpenSSL::X509::Store.new
# http.cert_store.set_default_paths
# http.cert_store.add_file('./cacert.pem')
# # ...or:
# cert = OpenSSL::X509::Certificate.new(File.read('mycert.pem'))
# http.cert_store.add_cert(cert)
