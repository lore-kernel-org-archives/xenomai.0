Content-Type: text/plain; charset=us-ascii; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v1076)
From: Stefan Schaal <sschaal@domain.hid>
Date: Wed, 28 Oct 2009 17:19:23 -0700
Content-Transfer-Encoding: 7bit
Message-Id: <1B242B31-29DB-4363-8B08-8E77B2928C34@domain.hid>
Subject: [Xenomai-help] analog output device with comedi/analogy -- suddenly
	threads don't work anymore
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
Cc: Peter Pastor Sampedro <pastorsa@domain.hid>

Hi,

   this is following up on an installation of Alex's Xenomai tree on  
Ubuntu 9.04 running the 2.6.29.5 kernel. While we managed to talk to  
the  NI data acquisition board we have with this tree, we suddenly  
discovered that some of our other software doesn't work anymore, in  
particular threads. Below is a tiny program to run a thread, and the  
compile statement we use. The thread never starts running. Does  
anybody know what is going wrong here?

Thanks  a lot for any hint!

Best wishes,

-Stefan

compile statement:

gcc -o xtest xeno_thread_test.c -I/Network/Servers/duerer/clmc/prog/ 
include -I/usr/xenomai/include -I/usr/xenomai/include/posix - 
D_GNU_SOURCE -D_REENTRANT -Wall -pipe -D__XENO__ -Wl,@/usr/xenomai/lib/ 
posix.wrappers -L/usr/xenomai/lib -lpthread_rt -lpthread -lrt


run the executable:

unix> xtest (which should generate some print-outs, but it doesn't ...)


//------------------------------------------------- start of file  
-----------------------------------------------------------------------
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
// ----------------------------------- end of file  
------------------------------------------------------------

