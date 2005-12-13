Message-ID: <439F0B78.2000002@domain.hid>
Date: Tue, 13 Dec 2005 18:57:12 +0100
From: Paolo Gai <pj@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------090602020507000004010505"
Subject: [Xenomai-help] Xenomai 2.0.1 - Posix Skin - implementing a periodic
	thread
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
--------------090602020507000004010505
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Dear all,

here is another small demo... this time of a periodic thread in POSIX.

It works under Xenomai, but it fails under Posix Real-Time.

The reason of the failure is the SIGUSR1 not being blocked by the main 
thread. If in main() the comments below the note "// REMOVE THE COMMENTS 
BELOW" are removed, then the signal is masked also in the main(), and as 
a result the POSIX version works.

The question I have is if the behavior in Xenomai (that is, not failing 
like the POSIX counterpart) is correct or not...

bye

Paolo

-- 
Evidence S.R.L. - Paolo Gai, CEO
http://www.evidence.eu.com   Tel: +39 0587 274823   Fax: +39 0587 291904


--------------090602020507000004010505
Content-Type: text/x-csrc;
 name="ex_periodic.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ex_periodic.c"

#include <stdlib.h>
#include <stdio.h>
#include <time.h>
#include <errno.h>
#include <signal.h>
#include <unistd.h>
#include <pthread.h>

void abort_perror(const char *msg)
{
  perror(msg);
  exit(1);
}


void *my_periodic_thread (void *cookie)
{
  struct itimerspec its;
  struct sigevent sig;
  sigset_t blocked;
  siginfo_t si;
  timer_t mytimer;
  int i;

  /* create a timer that will be used to periodically send a signal */
  sig.sigev_notify = SIGEV_SIGNAL;
  sig.sigev_signo = SIGUSR1;
  sig.sigev_value.sival_ptr = &sig;
  if(timer_create(CLOCK_REALTIME, &sig, &mytimer))
    abort_perror("timer_create");

  /* block the signal used by the timer */
  sigemptyset(&blocked);
  sigaddset(&blocked, SIGUSR1);
  pthread_sigmask(SIG_BLOCK, &blocked, NULL);

  /* set the periodic timer */
  its.it_value.tv_sec = 0;
  its.it_value.tv_nsec = 40000000; /* 40 ms */
  its.it_interval.tv_sec = 0;
  its.it_interval.tv_nsec = 20000000; /* 20 ms */;
  if(timer_settime(mytimer, 0, &its, NULL))
    abort_perror("timer_settime");

  printf("periodic thread started...\n");

  for (i=0; i<40; i++) {
    while (sigwaitinfo(&blocked, &si) == -1 && errno == EINTR);

    /* The thread body */
    printf("%d\n",i);
  }

  printf("...periodic thread end!\n");
  
  timer_delete(mytimer);
  return NULL;
}

int main()
{
  pthread_t mythread;
  pthread_attr_t myattr;
  struct sched_param myparam;
  void *returnvalue;
  sigset_t blocked;

  /* block the signal used by the timer */
  // REMOVE THE COMMENTS BELOW
  //  sigemptyset(&blocked);
  //  sigaddset(&blocked, SIGUSR1);
  //  pthread_sigmask(SIG_BLOCK, &blocked, NULL);

  /* initializes the thread attribute */
  pthread_attr_init(&myattr);
  pthread_attr_setinheritsched(&myattr, PTHREAD_EXPLICIT_SCHED);
  pthread_attr_setschedpolicy(&myattr, SCHED_FIFO);
  myparam.sched_priority = 3;
  pthread_attr_setschedparam(&myattr, &myparam);

  printf("starting a periodic thread...\n");

  if (pthread_create(&mythread, &myattr, my_periodic_thread, NULL))
    abort_perror("pthread_create");

  pthread_attr_destroy(&myattr);

  /* wait the end of the thread we just created */
  pthread_join(mythread, &returnvalue);

  printf("ending main...\n");

  return 0;
}


--------------090602020507000004010505--

