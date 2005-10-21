Message-ID: <43590FD1.5030503@domain.hid>
Date: Fri, 21 Oct 2005 17:57:05 +0200
From: Luotao Fu <devtty0@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------010901020100050209000605"
Subject: [Xenomai-help] Strangeness in named Semaphores(xenomai posix skin)
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

This is a multi-part message in MIME format.
--------------010901020100050209000605
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

Hi folks,

I got the feeling, that named semaphores in xenomai posix skin don't
work properly. I hacked some simple code to test this and attached the
code to this mail, so that you might have a look of my problem yourself.

In my code the main thread initialize a named Semaphore, locks it up and
than create a thread. The thread initialize a semaphore with the same
name and than tries to lock it. Since the semaphore is already locked by
the main thread, the thread blocks. As the main thread is waiting for
the finishing of the thread. It blocks too. So at this point the
programm should block. I tried two sem lock call in the thread, in one
it calls simply sem_wait() and blocks till the Implosion of the Universe
or the arrival of SIGINT, in the other it calls a sem_timedwait() and
blocks for 5 seconds. Both variants work just fine as normal posix
binay. Once compiled and linked against the xenomai posix library, the
sem_wait() appears however not to block at all and the trhead just
marchs through. the sem_timedwait() quits with a segfault.

I'm quite not understanding this. Have I overlooked something or is
there evtl. a bug in the posix skin?

P.S.
Systemconfiguration
Kernel: Vanilla 2.6.13 patched with adeos-linux-2.6.13-i386-r13.patch
Distr. Debian 3.1
Testhost: vmware 5.0
compiler gcc 3.3.5
Xenomai: 2.0, the most recent version from svn. (just updated it 15 Min.
ago. :-) )

Thanx a lot in advance
Cheers
Luotao Fu

--------------010901020100050209000605
Content-Type: text/x-csrc;
 name="test.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="test.c"

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <fcntl.h>
#include <pthread.h>
#include <limits.h>
#include <semaphore.h>
#include <pthread.h>
#include <sys/mman.h>
#include <sys/ipc.h>
#include <sys/types.h>
#include <signal.h>
#include <errno.h>
#define THR_AMOUNT 1

char *semName = "/testSem";
struct timespec t;

void *funcA(void *parm){
	sem_t *binSem;
 	if ((binSem = sem_open(semName, O_CREAT)) == SEM_FAILED){
	  	perror("cannot open Semaphore"); 
	  	exit(1);
 	}
	printf("semAdress: %p\n", binSem);
	printf("starting Thread A\n");	
	clock_gettime(CLOCK_REALTIME, &t);
	//while (sem_wait(binSem) == -1 && errno == EINTR)
	//  ;
	t.tv_sec += 5;
	sem_timedwait(binSem, &t);	
	printf("finishing Thread A\n");
 	sem_close(binSem);
	pthread_exit(NULL);
}

int main(int argc, char **argv)
{	
	int co,rc;	
	pthread_t testThread[THR_AMOUNT];
 	pthread_attr_t thrAttr;	
 	struct sched_param param = { .sched_priority = 99 };
	sem_t *binSem;
 	if (mlockall(MCL_CURRENT | MCL_FUTURE) == -1) {
 		perror("could not lock memeory\n");
 		exit(1);
 	}
 	if ((binSem = sem_open(semName, O_CREAT)) == SEM_FAILED){
	  	perror("cannot open Semaphore"); 
	  	exit(1);
 	}
	printf("semAdress: %p\n", binSem);
	sem_post(binSem);
 	sem_wait(binSem); 	
	pthread_attr_init(&thrAttr);
 	pthread_attr_setdetachstate(&thrAttr,PTHREAD_CREATE_JOINABLE);
 	pthread_attr_setinheritsched(&thrAttr,PTHREAD_EXPLICIT_SCHED);	
 	pthread_attr_setschedpolicy(&thrAttr,SCHED_FIFO); 
 	pthread_attr_setschedparam(&thrAttr,&param); 
	if ( (rc = pthread_create(&testThread[0],&thrAttr, funcA, NULL))
 	     != 0 ){
 	        fprintf(stderr, "cannot create Threads %s\n", strerror(rc)); 
 		exit(1);
 	}
 	for ( co = 0; co < THR_AMOUNT; co++) {
 		if ( pthread_join(testThread[co], NULL) != 0 ){
 			perror("cannot join Threads");			
 			exit(1);
 		}
 	}
 	if (munlockall() == -1){
 		perror("munlockall failure");
 		exit(1);
 	}
 	sem_close(binSem);
	sem_unlink(semName);
	return 0;
}

--------------010901020100050209000605--

