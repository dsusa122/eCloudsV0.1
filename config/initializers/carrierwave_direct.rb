#### configursción de CarrierWave

if Rails.env.production?


    CarrierWave.configure do |config|

      config.fog_credentials = {

          :provider => 'AWS',
          :aws_access_key_id => 'AKIAJPESCLIRTTE5MOWQ',
          :aws_secret_access_key => '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',
          :region => 'us-east-1'
      }



          config.fog_directory = 'ecloudsProd'
          config.fog_public = false
      #config.fog_host= 'http://localhost:3000'

      #config.root = ::Rails.root.to_s + "/public"

    end

elsif Rails.env.development?

    CarrierWave.configure do |config|

      config.fog_credentials = {

          :provider => 'AWS',
          :aws_access_key_id => 'AKIAJPESCLIRTTE5MOWQ',
          :aws_secret_access_key => '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',
          :region => 'us-east-1'
      }



      config.fog_directory = 'eclouds'
      config.fog_public = false
      #config.fog_host= 'http://localhost:3000'

      #config.root = ::Rails.root.to_s + "/public"

    end

else

  CarrierWave.configure do |config|

    config.fog_credentials = {

        :provider => 'AWS',
        :aws_access_key_id => 'AKIAJPESCLIRTTE5MOWQ',
        :aws_secret_access_key => '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',
        :region => 'us-east-1'
    }



    config.fog_directory = 'eclouds'
    config.fog_public = false
    #config.fog_host= 'http://localhost:3000'

    #config.root = ::Rails.root.to_s + "/public"

  end


end