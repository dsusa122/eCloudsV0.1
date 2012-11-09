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
                 :FINISHED => "FINISHED"}

AWS_ACCESS_KEY_ID = 'AKIAJPESCLIRTTE5MOWQ'

AWS_SECRET_ACCESS_KEY = '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'

PRESCHEDULING_QUEUE = 'prescheduling'

SCHEDULE_JOB_MSG = 'SCHEDULE_JOB'
RUN_JOB_MSG = 'RUN_JOB'
INSTALLING_APP_MSG = 'INSTALLING_APP'
RUNNING_APP_MSG = 'RUNNING_APP_MSG'
UPLOADING_OUTPUTS_MSG = 'UPLOADING_OUTPUTS_MSG'
REGISTER_FILE_MSG = 'REGISTER_FILE_MSG'
FINISHED_JOB_MSG = 'FINISHED_JOB_MSG'



SCHEDULING_QUEUE = 'scheduling'