AssetSync.configure do |config|
  config.fog_provider = 'AWS'
  config.fog_directory = "wtasystem-assets"#ENV['FOG_DIRECTORY']
  config.aws_access_key_id = "AKIAJIZUFUFDNZP67G3Q" #ENV['AWS_ACCESS_KEY_ID']
  config.aws_secret_access_key = "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" #ENV['AWS_SECRET_ACCESS_KEY']

  # Don't delete files from the store
  # config.existing_remote_files = "keep"
  #
  # Increase upload performance by configuring your region
  # config.fog_region = 'eu-west-1'
  #
  # Automatically replace files with their equivalent gzip compressed version
  # config.gzip_compression = true
  #
  # Use the Rails generated 'manifest.yml' file to produce the list of files to 
  # upload instead of searching the assets directory.
  # config.manifest = true
end