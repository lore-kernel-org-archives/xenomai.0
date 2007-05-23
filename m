Message-ID: <465448A7.5080803@domain.hid>
Date: Wed, 23 May 2007 15:59:03 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <7289437c0705230649u5a09e726q86204106bb22a7b8@domain.hid>
In-Reply-To: <7289437c0705230649u5a09e726q86204106bb22a7b8@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Problem API Posix : ressource temporarily
	unavailable
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Perrine Martignoni <perrmart@domain.hid>
Cc: xenomai@xenomai.org

Perrine Martignoni wrote:
> Hello,
>  
> I work on an ARM9 with the API Posix and I found a problem during my tests.
> I have written a simple example who show this problem.
> Here is my code :
>  
> #include <pthread.h>
> #include <string.h>
> #include <stdio.h>
> #include <signal.h>
> #include <time.h>
> #include <errno.h>
> #include <fcntl.h >
> #include <getopt.h>
> #include <unistd.h>
> #include <stdlib.h>
> #include <sys/mman.h>
> #include <sys/time.h>
> #include <limits.h>
> #include <mqueue.h>
> void routine (void * cookie);
> void routine (void * cookie)
> {
> struct timespec timeout;
> struct sched_param param = {.sched_priority = 10 };
> pthread_setschedparam(pthread_self(), SCHED_FIFO, &param);
> timeout.tv_sec=0;
> timeout.tv_nsec=200000000;
> 
> nanosleep ( &timeout, NULL);
> printf("destruction tache\n");
> pthread_exit(NULL);
> }
> 
> int main(int argc, char **argv)
> {
> int i = 0;
> int err;
> pthread_attr_t attr;
> pthread_t task;
> struct timespec timeout, timeout2;
> struct sched_param param = {.sched_priority = 10 };
> 
> mlockall(MCL_CURRENT | MCL_FUTURE);
> 
> timeout.tv_sec=50;
> timeout.tv_nsec=0;
> timeout2.tv_sec=0;
> timeout2.tv_nsec=500000000;
> 
> pthread_attr_init(&attr);
> pthread_attr_setdetachstate(&attr, PTHREAD_CREATE_JOINABLE);
> pthread_attr_setinheritsched(&attr, PTHREAD_EXPLICIT_SCHED);
> pthread_attr_setschedpolicy(&attr, SCHED_FIFO);
> pthread_attr_setschedparam(&attr, &param);
> pthread_attr_setstacksize(&attr, PTHREAD_STACK_MIN);
> 
> for(i=0;i<10000;i++){
>  printf("Tour %d\n", i);
>  if (err = pthread_create (&task,&attr,(void *)routine,NULL))
>  fprintf(stderr, "failed to create threads: %s\n", strerror(err));
>  if (err = pthread_create (&task,&attr,(void *)routine,NULL)) 
>  fprintf(stderr, "failed to create threads: %s\n", strerror(err));
>  if (err = pthread_create (&task,&attr,(void *)routine,NULL))
>  fprintf(stderr, "failed to create threads: %s\n", strerror(err));
> 
>  nanosleep ( &timeout2, NULL);
> }
>  
> nanosleep ( &timeout, NULL);
> return 0;
> }
> 
>  
> At the turn 509, it doesn't work any more. Ressources are unavailable to
> create another task.

If you create a joinable thread, ressources remain allocated until the
thread is joined. If you do not intend to join your threads, then create
them detached.

-- 
                                                 Gilles Chanteperdrix

