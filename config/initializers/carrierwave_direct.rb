#### configursción de CarrierWave

if Rails.env.production?


    CarrierWave.configure do |config|

      config.fog_credentials = {

          :provider => 'AWS',
          :aws_access_key_id => ENV["AMAZON_ACCESS_KEY_ID"],
          :aws_secret_access_key => ENV["AMAZON_SECRET_ACCESS_KEY"],
          :region => 'us-east-1'
      }



          config.fog_directory = ENV["S3_BUCKET_PROD"]
          config.fog_public = true
      #config.fog_host= 'http://localhost:3000'

      #config.root = ::Rails.root.to_s + "/public"

    end

elsif Rails.env.development?

    CarrierWave.configure do |config|

      config.fog_credentials = {

          :provider => 'AWS',
          :aws_access_key_id => ENV["AMAZON_ACCESS_KEY_ID"],
          :aws_secret_access_key => ENV["AMAZON_SECRET_ACCESS_KEY"],
          :region => 'us-east-1'
      }



      config.fog_directory = ENV["S3_BUCKET_DEV"]
      config.fog_public = true
      #config.fog_host= 'http://localhost:3000'

      #config.root = ::Rails.root.to_s + "/public"

    end

else

  CarrierWave.configure do |config|

    config.fog_credentials = {

        :provider => 'AWS',
        :aws_access_key_id => ENV["AMAZON_ACCESS_KEY_ID"],
        :aws_secret_access_key => ENV["AMAZON_SECRET_ACCESS_KEY"],
        :region => 'us-east-1'
    }



    config.fog_directory = ENV["S3_BUCKET_STAGING"]
    config.fog_public = true
    #config.fog_host= 'http://localhost:3000'

    #config.root = ::Rails.root.to_s + "/public"

  end


end