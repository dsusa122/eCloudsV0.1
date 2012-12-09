# Acá inicializo constantes y cosas generales de la app

VIRTUAL_MACHINE_EVENTS = { :STARTED => "STARTED",
                           :STOPPED => "STOPPED",
                           :REBOOTED=>"REBOOTED",
                           :TERMINATED => "TERMINATED",
                           :CREATED => "CREATED"}

JOBS_STATUS =  { :PENDING=> "PENDING",
                 :PREPARING => "PREPARING",
                 :WAITING => "WAITING",
                 :QUEUED => "QUEUED",
                 :INSTALLING => "INSTALLING",
                 :RUNNING =>"RUNNING",
                 :FAILED => "FAILED",
                 :UPLOADING_OUTPUTS => "UPLOADING_OUTPUTS",
                 :FINISHED => "FINISHED",
                 :ASSIGNING => "ASSIGNING"}

VM_PRICING = {"t1.micro"  => 0.020,
              "m1.small"  => 0.065,
              "c1.medium"  => 0.165,
              "m1.large"  => 0.260,
              "m1.xlarge"  => 0.520,
              "c1.xlarge" => 0.660}

AWS_ACCESS_KEY_ID = 'AKIAJPESCLIRTTE5MOWQ'

AWS_SECRET_ACCESS_KEY = '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'

PRESCHEDULING_QUEUE = 'prescheduling'

PROCESS_EXECUTION_MSG = 'PROCESS_EXECUTION'

ASSIGN_EXECUTION_MSG = 'ASSIGN_EXECUTION'

SWITCH_TO_QUEUE_MSG = 'SWITCH_TO_QUEUE'

SCHEDULE_JOB_MSG = 'SCHEDULE_JOB'
RUN_JOB_MSG = 'RUN_JOB'
INSTALLING_APP_MSG = 'INSTALLING_APP'
RUNNING_APP_MSG = 'RUNNING_APP_MSG'
UPLOADING_OUTPUTS_MSG = 'UPLOADING_OUTPUTS_MSG'
REGISTER_FILE_MSG = 'REGISTER_FILE_MSG'
FINISHED_JOB_MSG = 'FINISHED_JOB_MSG'



SCHEDULING_QUEUE = 'scheduling'