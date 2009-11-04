Content-Type: text/plain; charset=us-ascii; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v1076)
From: Stefan Schaal <sschaal@domain.hid>
Date: Tue, 3 Nov 2009 17:18:14 -0800
Content-Transfer-Encoding: 7bit
Message-Id: <B0122F57-107F-4E31-A663-D4DE560C08B8@domain.hid>
Subject: [Xenomai-help] bring down the system
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
Cc: Peter Pastor <pastor@domain.hid>

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
#include <pthread.h>
#include <stdio.h>

pthread_t cthread;

// a quick thread to run ....
void *
run_thread(void *dummy)
{
   int i;

   for (i=1; i<=1000; ++i) {
     printf("%d thread is runnning\n",i);
     sleep(1);
   }
   return NULL;
}

// main program
int
main() {

   int rc;
   pthread_attr_t pth_attr;

#ifdef __XENO__
   mlockall(MCL_CURRENT | MCL_FUTURE);
#endif

   if ((rc=pthread_attr_init(&pth_attr)))
       printf("pthread_attr_init returned %d\n",rc);

   if ((rc=pthread_create( &cthread, &pth_attr, run_thread, NULL)))
       printf("pthread_create returned with %d\n",rc);

   // wait a bit to get some print outs from the thread
   sleep(10);

   return 1;
}


