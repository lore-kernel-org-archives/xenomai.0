Message-ID: <44168DA0.3090506@domain.hid>
Date: Tue, 14 Mar 2006 10:32:16 +0100
From: marcellin <marcellin.fotze@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-help] interrupt wait problem
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org



Hi, i'm trying to use the RealTimeClock IRQ 8, with a xenomai real time 
task. I configure the RTC to have a periodic interrupt on it with the 
linux standard API, and it works. After when i want to catch the IRQ 8 
in a xenomai real time task i have a problem a error ( " Operation not 
permitted ") with the " rt_intr_wait " fonction. Is there a special 
initialisation or configuration to make with the kernel or Xenomai ?


my conf : kernel 2.6.15.1 , Xenomai-2.1-rc4

in my program

//initialisation
             err = rt_intr_create(&intr_desc,"IRQ8",IRQ8,I_PROPAGATE);
             if(err){
           printf("AcqProcess -> failed to create interupt object : 
%s",strerror(-err));
       }
                  err = rt_intr_enable(&intr_desc);
             if(err){
           printf("AcqProcess -> failed to enable interupt object : 
%s",strerror(-err));
       }
             err = 
rt_task_create(&time_task,"SecondTask",TASK_STKSZ,TASK_PRIO,T_FPU|T_JOINABLE); 

       if(err){
           printf("AcqProcess -> failed to create task : 
%s",strerror(-err));
       }
              rt_task_start(&time_task,&timer_handler_thread,NULL);






//in the irq task


err = rt_intr_wait( &intr_desc,TIMEOUT );
                     if(err){
           printf("AcqProcess -> failed to wait interrupt : 
%s",strerror(-err));
       }


regards

Marcell1

