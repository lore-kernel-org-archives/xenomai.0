Message-ID: <435F39AF.1030005@domain.hid>
Date: Wed, 26 Oct 2005 10:09:19 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Spawn Task from a Task -vxworks-skin
References: <959.1130313667@domain.hid>
In-Reply-To: <959.1130313667@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "j.p.schulz" <j.p.schulz@domain.hid>
Cc: xenomai@xenomai.org

j.p.schulz wrote:
> Hello
> I have Problems spawning a Task from a Task under the vxworks skin!
> If I spawn my Tasks from a Funktion - it works!
> If I spawn my Tasks from a Task     - system crashes!

Make sure to use an Adeos patch >= 1.0-07. v0.9.1 ships with 1.0-02, so you 
likely want to upgrade and try again. Recent Adeos patches for x86 can be found 
here: http://download.gna.org/adeos/patches/v2.6/adeos/i386/

> 
> Here the programm:
> 
> #include <stdlib.h>
> #include <stdio.h>
> #include <string.h>
> #include <signal.h>
> #include <ctype.h>
> #include <fcntl.h>
> #include <sys/io.h>
> #include <sys/stat.h>
> #include <sys/ioctl.h>
> 
> #include <vxworks/vxworks.h>
> 
> #include "vxChain.h"
> #include "portutils.h"
> 
> 
> #define PRIORITY_LOW 	100
> #define PRIORITY_MID 	90
> #define PRIORITY_HIGH 	80
> 
> #define USE_FPU 		(VX_FP_TASK | VX_NO_STACK_FILL)
> #define NO_FPU 			VX_NO_STACK_FILL
> #define STACK_SIZE 		0x5000
> #define TASK_OPTIONS	USE_FPU
> 
> #define NUM_TASKS		8
> #define MAX_TASKS		15
> 
> SEM_ID		semId[MAX_TASKS * 2];
> int			taskId[MAX_TASKS];
> int			triggerId;
> 
> 
> int root_thread_init()
> {
> 	// Allow port I/O in userspace
> 	iopl(3);
> 	
> 	vxTest();		// Just a function call (works)
> //	vxSpawn();		// Spawns the function as a task (crashes)
> 
> 	return 0;	
> }
> 
> void vxSpawn( void )
> {
> 	taskSpawn ("Master Task", PRIORITY_HIGH, 
> 				TASK_OPTIONS, STACK_SIZE, 
> 				(FUNCPTR) vxTest,
> 				0,0,0,0,0,0,0,0,0,0); 					
> }
> 	
> void root_thread_exit (void)
> {
> 	printf ("root_thread_exit() called.\n");
> }	
> 
> void vxTest( void )
> {
> 	int i;  
>     char buf[80];
>         
>     for (i=0; i < NUM_TASKS; i++)
>     {
> 		semId[2*i]   = semBCreate( SEM_Q_PRIORITY, SEM_EMPTY);    
> 		semId[2*i+1] = semBCreate( SEM_Q_PRIORITY, SEM_EMPTY);        
>     }
>          
>     for (i=0; i < NUM_TASKS; i++)
>     { 
> 		sprintf(buf, "Task_%d", i);    
> 		taskId[i] = 
> 		taskSpawn(buf, PRIORITY_LOW, TASK_OPTIONS, STACK_SIZE,
> 			(FUNCPTR) WorkerTask, 
> 			i, 				// Task Nummer
> 			semId[i], 		// warten auf Semaphor
> 			semId[i+1],   	// anzutriggerndes Semaphor
> 			0,0,0,0,0,0,0);		
> 			
> 		printf ("task[%d] = 0x%08X, errno = %d\n", i, taskId[i], errnoGet());
>     }
> 
>     triggerId = taskSpawn ("Trigger task", PRIORITY_MID, 
>     					TASK_OPTIONS, STACK_SIZE,
> 						(FUNCPTR) TriggerTask, 0,0,0,0,0,0,0,0,0,0);
> 	printf ("taskTrigger = 0x%08X\n", triggerId);
> 	
> 	taskSuspend(taskIdSelf());
> }
> 
> void TriggerTask( void )
> {
> 	while( 1 )
> 	{
> 		taskDelay(1);
> 		semGive(semId[0]);
> 	}
> }
> 
> FUNCPTR WorkerTask(int i0,int i1,int i2,int i3,int i4,int i5,int i6,int
> i7,int i8,int i9)
> {
>     unsigned int task_num 	= (unsigned int) i0;
>     int sem_to_wait 		= i1;
>     int sem_to_trigger		= i2;
> 
> 	iopl(3);
>     while (1)
>     {
> 		semTake(sem_to_wait, WAIT_FOREVER);
> 		if (task_num < 8)
> 		{
> 			lpt_peak_bit (task_num);	
> 		}	
> 		semGive(sem_to_trigger);			
>     }
>     return 0;
> }    
> 
> 
> 
> Fusion 0.9.1
> Kernel 2.6.13-ipipe
> Suse 9.3
> Any Ideas?
> Thanks 
> Jan-Peter
> 


-- 

Philippe.

