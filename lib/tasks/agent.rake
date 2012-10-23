task :checkQueue => :environment do
  puts 'I wil check the queue to see if I have to execute any job'

  @sqs = Aws::Sqs.new(AMAZON_ACCESS_KEY_ID, AMAZON_SECRET_ACCESS_KEY)
  @queue = @sqs.queue(SCHEDULING_QUEUE)

  @msg = @queue.receive

  puts 'I just received the message:'
  puts @msg

end
