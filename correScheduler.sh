source /home/david/.rvm/environments/ruby-1.9.3-p194
#gem install execjs
cd /home/david/RubymineProjects/eCloudsV0.1
 echo _____________________ >> /home/david/eClouds/agentLog.txt 
date >> /home/david/eClouds/agentLog.txt
RAILS_ENV=production /home/david/.rvm/gems/ruby-1.9.3-p194@global/bin/rake checkForJobs >> /home/david/eClouds/agentLog.txt
