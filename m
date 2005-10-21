From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17241.24548.920222.440189@domain.hid>
Date: Fri, 21 Oct 2005 23:38:44 +0200
Subject: Re: [Xenomai-help] Strangeness in named Semaphores(xenomai posix skin)
In-Reply-To: <43590FD1.5030503@domain.hid>
References: <43590FD1.5030503@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Luotao Fu <devtty0@domain.hid>
Cc: xenomai@xenomai.org

Luotao Fu wrote:
 > Hi folks,
 > 
 > I got the feeling, that named semaphores in xenomai posix skin don't
 > work properly. I hacked some simple code to test this and attached the
 > code to this mail, so that you might have a look of my problem yourself.

There was one issue on POSIX skin side: the sem_timedwait function
was not implemented in Xenomai user-space POSIX library, your code was
hence calling libc sem_timedwait, which accounted for the segfault. The
remaining misbehaviours you observed are due to problems in the example
code.

 > (...)
 > #include <stdio.h>
 > #include <stdlib.h>
 > #include <string.h>
 > #include <fcntl.h>
 > #include <pthread.h>
 > #include <limits.h>
 > #include <semaphore.h>
 > #include <pthread.h>
 > #include <sys/mman.h>
 > #include <sys/ipc.h>
 > #include <sys/types.h>
 > #include <signal.h>
 > #include <errno.h>
 > #define THR_AMOUNT 1
 > 
 > char *semName = "/testSem";
 > struct timespec t;
 > 
 > void *funcA(void *parm){
 > 	sem_t *binSem;
 >  	if ((binSem = sem_open(semName, O_CREAT)) == SEM_FAILED){

When calling sem_open with the O_CREAT flag, you have to pass a "mode"
and most importantly a "value" argument which is the initial value of
the semaphore. Your also make the assumption that 0 is a valid numeric
value for the enum O_RDONLY/O_WRONLY/O_RDWR.


 > 	  	perror("cannot open Semaphore"); 
 > 	  	exit(1);
 >  	}
 > 	printf("semAdress: %p\n", binSem);
 > 	printf("starting Thread A\n");	
 > 	clock_gettime(CLOCK_REALTIME, &t);
 > 	//while (sem_wait(binSem) == -1 && errno == EINTR)
 > 	//  ;
 > 	t.tv_sec += 5;
 > 	sem_timedwait(binSem, &t);	

You should always check the return value of system calls. If you do not
want to clutter your code with these checks, then you can define
something along the lines :

int xsem_timedwait(sem_t *sem, const struct timespect *to)
{
    int rc;

    while ((rc = sem_timedwait(sem, to)) == -1 && errno == EINTR)
         ;
    if (rc == -1 && errno != ETIMEDOUT)
          fatal("unexpected error %d (%s) in sem_timedwait", rc, strerror(rc));

    return rc;
}

And use xsem_timedwait everywhere.

 > 	printf("finishing Thread A\n");
 >  	sem_close(binSem);
 > 	pthread_exit(NULL);
 > }
 > 
 > int main(int argc, char **argv)
 > {	
 > 	int co,rc;	
 > 	pthread_t testThread[THR_AMOUNT];
 >  	pthread_attr_t thrAttr;	
 >  	struct sched_param param = { .sched_priority = 99 };
 > 	sem_t *binSem;
 >  	if (mlockall(MCL_CURRENT | MCL_FUTURE) == -1) {
 >  		perror("could not lock memeory\n");
 >  		exit(1);
 >  	}
 >  	if ((binSem = sem_open(semName, O_CREAT)) == SEM_FAILED){

Same remark as above.

 > 	  	perror("cannot open Semaphore"); 
 > 	  	exit(1);
 >  	}
 > 	printf("semAdress: %p\n", binSem);
 > 	sem_post(binSem);
 >  	sem_wait(binSem); 	

Pending on a semaphore is forbidden for non-Xenomai threads, so sem_wait
returns -1 with errno set to EPERM here and the semaphore remains
available, assuming, of course that the call to sem_open was changed to
initialize the semaphore value to 0.

 > 	pthread_attr_init(&thrAttr);
 >  	pthread_attr_setdetachstate(&thrAttr,PTHREAD_CREATE_JOINABLE);
 >  	pthread_attr_setinheritsched(&thrAttr,PTHREAD_EXPLICIT_SCHED);	
 >  	pthread_attr_setschedpolicy(&thrAttr,SCHED_FIFO); 
 >  	pthread_attr_setschedparam(&thrAttr,&param); 
 > 	if ( (rc = pthread_create(&testThread[0],&thrAttr, funcA, NULL))
 >  	     != 0 ){
 >  	        fprintf(stderr, "cannot create Threads %s\n", strerror(rc)); 
 >  		exit(1);
 >  	}
 >  	for ( co = 0; co < THR_AMOUNT; co++) {
 >  		if ( pthread_join(testThread[co], NULL) != 0 ){
 >  			perror("cannot join Threads");			
 >  			exit(1);
 >  		}
 >  	}
 >  	if (munlockall() == -1){
 >  		perror("munlockall failure");
 >  		exit(1);
 >  	}
 >  	sem_close(binSem);
 > 	sem_unlink(semName);
 > 	return 0;
 > }
 > _______________________________________________
 > Xenomai-help mailing list
 > Xenomai-help@domain.hid
 > https://mail.gna.org/listinfo/xenomai-help

-- 


					    Gilles Chanteperdrix.

