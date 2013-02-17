source /home/sm00th/.rvm/environments/ruby-1.9.3-p374
#gem install execjs
cd /home/sm00th/rails_projects/eclouds/eCloudsV0.1
 echo _____________________ >> /home/sm00th/eClouds/agentLog.txt
date >> /home/sm00th/eClouds/agentLog.txt
RAILS_ENV=production bundle exec rake checkForJobs >> /home/sm00th/eClouds/agentLog.txt
