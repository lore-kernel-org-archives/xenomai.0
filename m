Message-ID: <4859A54C.1070302@domain.hid>
Date: Thu, 19 Jun 2008 02:16:12 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <2F8EE677D406514ABE53EF9C0934A666042ABE7E@anubis2.clb.tcfr.thales>
In-Reply-To: <2F8EE677D406514ABE53EF9C0934A666042ABE7E@anubis2.clb.tcfr.thales>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Problem using xenomai threads with eclipse
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Laurent.POYART@fr.thalesgroup.com
Cc: xenomai@xenomai.org

Laurent.POYART@fr.thalesgroup.com wrote:
> Hi,
> 
> I'm compiling a xenomai user land application using eclipse CDT 3.2.2  and
> my Pc hangs when I run it using debug (gbd). 
> 
> Context:
> 
> Linux kernel : 2.6.23
> Xenomai : 2.4.1
> Architecture: Pentium Dual Core (PC).
> Xenomai Configuration : priority coupling.
> Linker options: -Wl,--wrap,pthread_create -Wl,-soname=pthread_rt
> (only pthread_create is wrapped)
> 
> The application code is the following (the problem is described after the
> source code):
> 
> #include<iostream>
> #include<cassert>
> using namespace std;
> 
> #include <sys/mman.h>
> #include <pthread.h>
> #include <semaphore.h>
> #include <mqueue.h>
> #include <errno.h>
> 
> // Lock used to make the thread wait for start enable
> sem_t s_SemThreadStartEnable;
> 
> // For Test
> sem_t s_SemThreadTest;
>  
> // Thread function for the Xenomai RT Thread 
> void* mythreadfunctionrt(void* arg)
> {
> 	// Wait start Enable (not wrapped => linux syscall)
>     int result = sem_wait(&s_SemThreadStartEnable);
>     assert(result == 0);
> 
>     // Enter Thread Loop
> 	while(1)
> 	{
> 		// Wait for lock test (is not available => must preempt the
> thread)
> 		result = sem_wait(&s_SemThreadTest);
> 		assert(result == 0);
> 		
> 		// Never reach this point because lock is never released
> 	}	   
> 		
> 	return(0);	
> }
> 
> // Thread function for the linux Thread (not RT)
> void* mythreadfunction(void* arg)
> {
> 	mq_attr mqAttributs;
> 	mqAttributs.mq_flags = 0;
> 	mqAttributs.mq_maxmsg = 1; 
> 	mqAttributs.mq_msgsize =  sizeof(void*);	
> 	mqAttributs.mq_curmsgs = 0;
> 	// generates name
> 	mqd_t handle = mq_open("/OEmqTest",(O_RDWR | O_CREAT),(S_IRWXU |
> S_IRWXG),&mqAttributs);
> 	assert(handle >= 0);
> 	
> 	while(1)
> 	{
> 		 // Pend on the message queue (message is a pointer size =
> sizeof(void*))		
> 		 char* pt_obj = 0;
> 		 cout << "block on mqueue reception" << endl;
> 		 int result =
> mq_receive(handle,(char*)&pt_obj,sizeof(void*),0);
> 		 assert(result == 0);
> 	}	   
> 		
> 	return(0);	
> }
> 
> // ================================================================
> // Function   : AppStartTask
> // Goal    : Application Start Task
> // ================================================================
> void*  AppStartTask(void *p_arg)
> {
>     // ================  LINUX THREAD (NOT RT) ====================
>     // ================  REAL TIME PRIORITY => 12 / SCHED FIFO ==========
> 	 cout << "Create Linux Thread" << endl;	
>     // Thread Attributs Init
> 	pthread_t mythread;
> 	pthread_attr_t threadAttributs;
> 	int result = pthread_attr_init(&threadAttributs);	
> 	assert(result == 0);
> 	struct sched_param  scheduleParams;
> 	scheduleParams.sched_priority = 12;
> 	result =
> pthread_attr_setschedparam(&threadAttributs,&scheduleParams);
> 	assert(result == 0);
> 	pthread_attr_setschedpolicy (&threadAttributs,SCHED_FIFO);
> 	assert(result == 0);
> 	pthread_attr_setinheritsched
> (&threadAttributs,PTHREAD_EXPLICIT_SCHED);
> 	assert(result == 0);
>     result = __real_pthread_create(&mythread,
>     							&threadAttributs,
>     							mythreadfunction,
>     							0);
>     assert(result == 0);
> 
>     // Lock that enable RT thread loop
>     sem_init(&s_SemThreadStartEnable,false,0);		// not available
> 
>     // Test Lock
>     sem_init(&s_SemThreadTest,false,0);				// not
> available
>     
>     // ================  XENOMAI THREAD  ====================
>     // =======  REAL TIME PRIORITY => 11 / SCHED FIFO =======
> 	 cout << "Create Xenomai Thread" << endl;    
>     pthread_t mythreadrt;//
> 	pthread_attr_t threadAttributsrt;
> 	int resultrt = pthread_attr_init(&threadAttributsrt);
> 	assert(resultrt == 0);
> 	struct sched_param  scheduleParamsrt;
> 	scheduleParamsrt.sched_priority = 11;
> 	resultrt =
> pthread_attr_setschedparam(&threadAttributsrt,&scheduleParamsrt);
> 	assert(resultrt == 0);
> 	result = pthread_attr_setschedpolicy
> (&threadAttributsrt,SCHED_FIFO);
> 	assert(resultrt == 0);
> 	resultrt = pthread_attr_setinheritsched
> (&threadAttributsrt,PTHREAD_EXPLICIT_SCHED);
> 	assert(resultrt == 0);
>     resultrt = pthread_create(&mythreadrt,
>     							&threadAttributsrt,
>     							mythreadfunctionrt,
>     							0);
> ////// NOTE : NO PROBLEM IF A REPLACE pthread_create by
> __real_pthread_create
>     
>     assert(resultrt == 0);
>    
>     
>     // Enable Thread Start
> 	cout << "Enable Thread Loop Start" << endl;    
>     resultrt = sem_post(&s_SemThreadStartEnable);
>     assert(result == 0);
>     
> 	// Suspend AppTask
>     sem_t lockEnd;
>     sem_init(&lockEnd,false,0);		// not available
> 	cout << "Infinite wait end app" << endl;     
>     sem_wait(&lockEnd);
> 
>     return(0);
> }
> 
> // Function   : Main
> int main(int argc,char* argv[])
> {
> 	// Mlock All for Xenomai
> 	mlockall(MCL_CURRENT | MCL_FUTURE);
> 	
> 	AppStartTask(0);	
> 
> 	return 0;
> }
> 
> Problem description:
> when I run the application with eclipse using "run" command (no debug using
> gdb) the application run correctly and I can stop it from eclipse.
> The console output is:
> Create Linux Thread
> block on mqueue reception
> Create Xenomai Thread
> Enable Thread Loop Start
> Infinite wait end app
> 
> when I launch the application with eclipse using "debug" command (gdb is
> run). The console output is the same but when I stop the application, the PC
> hangs (I need to push the reset button).
> 
> this problem doesn't occur when I only use linux standard threads (all
> __real_pthread_create).
> 
> Do you have any idea? I'm I doing something totally wrong in my example.

When running under gdb, a lot of signals are sent, so, you should be 
prepared to restart syscalls when EINTR is returned, instead of simply 
failing with assert. However, assert should not cause your system to freeze.

Can you get any kernel messages, either by redirecting the console to a 
serial driver, or by running your example (with gdb) in plain text mode ?

-- 


					    Gilles.

