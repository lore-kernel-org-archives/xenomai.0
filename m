Mime-Version: 1.0 (Apple Message framework v1076)
Content-Type: text/plain; charset=us-ascii; format=flowed; delsp=yes
From: Stefan Schaal <sschaal@domain.hid>
In-Reply-To: <B0122F57-107F-4E31-A663-D4DE560C08B8@domain.hid>
Date: Tue, 3 Nov 2009 22:35:27 -0800
Content-Transfer-Encoding: 7bit
Message-Id: <C790DE41-A093-46C5-9F44-D3F0EA839CF5@domain.hid>
References: <B0122F57-107F-4E31-A663-D4DE560C08B8@domain.hid>
Subject: Re: [Xenomai-help] bring down the system
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Stefan Schaal <sschaal@domain.hid>
Cc: xenomai@xenomai.org, Peter Pastor <pastor@domain.hid>

Sorry, I attached the wrong C-program in the previous posting ....  
here is the corrected version:

Hi,

  attached is a little C program that spawns off a task which runs a  
heavy tiny math job. Despite my 8 processor machine, taking this one  
task to 99% CPU load slows down the entire computer, often such that  
there is no return except for a forced restart.

I run the xenomai-head git, updated on Oct. 29 the last time, on a  
i386 ubuntu system with kernel 2.6.29.5.

Does anybody know what is going wrong here, i.e., am I not permitted  
to take my CPUs to the max load?

Any help would be highly appreciated!!!

Best wishes,

-Stefan



Compile statement:

gcc -o xtest xeno_spawn_test.c -I/usr/xenomai/include -Wl,@/usr/ 
xenomai/lib/posix.wrappers -L/usr/xenomai/lib -lpthre
ad_rt -lpthread -lrt  -lnative

Run:

unix> xtest



------------------------------------------------  xeno_spawn_test.c  
---------------------------------------------
#include <sys/mman.h>
#include <native/task.h>
#include <pthread.h>
#include <stdio.h>
#include <math.h>

RT_TASK task;

// a quick task run ....
void
run_task(void *dummy)
{
   int i;
   double foo = 1.0;

   for (i=1; i<=100000000; ++i)
     foo = foo*1.1;

   return;
}

// main program
int
main() {

   int rc;
   pthread_attr_t pth_attr;

   mlockall(MCL_CURRENT | MCL_FUTURE);

   // spawn the task
   if ((rc=rt_task_spawn(&task,"run_task",100000,1,T_JOINABLE|T_FPU| 
T_CPU(1),run_task,NULL)))
       printf("rt_task_spawn returned %d\n",rc);

   rt_task_join(&task);

   return 1;
}





