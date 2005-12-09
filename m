Message-ID: <4399E716.8060502@domain.hid>
Date: Fri, 09 Dec 2005 21:20:38 +0100
From: Paolo Gai <pj@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Xenomai 2.0.1 - Posix Skin - realtime priorities
	-	what I'm doing wrong?
References: <439995C0.6030006@domain.hid>	<200512091650.11637.schwab@domain.hid>
	<17305.51026.541872.815402@domain.hid>
In-Reply-To: <17305.51026.541872.815402@domain.hid>
Content-Type: multipart/mixed; boundary="------------010500030407000601000108"
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

This is a multi-part message in MIME format.
--------------010500030407000601000108
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Dear Gilles,

Thanks again for the answer...

Gilles Chanteperdrix wrote:

>[...]
>What happens for certain is that the access to stdout buffer, when
>compiling with the -D_REENTRANT flag, is serialized with a GNU libc
>POSIX mutex. This account for the consistent behaviour between GNU libc
>libpthread, or Xenomai POSIX skin library. The scheduling order is the
>one of the libc POSIX library, and knowing exactly what happens would
>require further investigation (there may be a difference between NPTL
>and linuxthreads for example).
>  
>
yes, I agree that mutexes called inside stdout primitives could change 
the behavior of the scheduler... and that understanding what really 
happens in this case is probably out of the scope of the mailing list.

>Working around this issue means using calls to unlocked versions of libc
>functions protected with Xenomai POSIX mutexes, such as, for example,
>myputs and myputchar (sufficient for Paolo example) defined as :
>[...]
>  
>
Ok! I tried it, and I also tried another slightly modified version of 
the demo, that simply replaces putchars with an unprotected array of 
chars (let's suppose there are no race conditions) that is printed out 
to stdout at the end of the game.

the results are the following, where the first part is RR and the second 
is FIFO (it's quite strange for me that FIFO has more contect changes 
than RR (?))

[root@domain.hid xenomai-demos]# ./rt_ex_rr2
....##################################################################################L...............................................................................###############################################################################.............................................................................###############################################################################..................................................................................############################################################..........................................................   
...###L.......################...........................############.............#############.............############.............#############............#############.............################................############............#############.............#############.............############............#############.............################................#############.............############............#############............##########.............#############.............###############................############............#############.............######################

and, moreover, another strange thing is that the threads does not call 
any primitive...!!!
(I attach the two modified examples)


>Now, your answer yields another important question: are domain
>migrations inocuous from a scheduling point of view ?
>Intuitively, if two tasks A and B in the same priority group are
>runnable, and task A undergoes a migration from secondary to primary,
>followed by a migration from primary to secondary without a suspension,
>the scheduling order will be wrong.
>
>The reason for this behaviour is that when task A migrates from
>primary mode to secondary mode and will be waken up in Linux scheduler,
>it should be put at the end of its priority group, so that B should
>become the running task.
>
>In short, the two successive migrations are equivalent to calling
>sched_yield() from Linux scheduler point of view.
>
>  
>
Ok, seems reasonable from the Xenomai point of view, excepts that users 
should be aware of this behavior since they may make assumptions on the 
non-preemptability at a given priority level of a particular piece of 
code...

bye

Paolo

--------------010500030407000601000108
Content-Type: text/x-csrc;
 name="ex_rr2.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ex_rr2.c"

#include <stdio.h>
#include <pthread.h>
#include <stdlib.h>

/* for sched_param.c */
#include <sched.h> 

/* ------------------------------------------------------------ */
/* unprotected buffer to avoid migrations */

char buf[10000];
volatile char *buf_current=buf;

void myputchar(char c)
{
  *buf_current++ = c;
}

void myprintbuf(void)
{
  *buf_current=0;
  puts(buf);
}
/* ------------------------------------------------------------ */


void *low(void *arg)
{
  myputchar('L');
  return NULL;
}

void *medium(void *arg)
{
  int i,j;

  for (i=0; i<300; i++) {
    for (j=0; j<1000000; j++) ;
    myputchar(((char *)arg)[0]);
  }

  return NULL;
}

void my_create(int policy)
{
  pthread_t th1, th2, th3;
  pthread_attr_t medium_attr, low_attr;
  struct sched_param medium_policy, low_policy;

  pthread_attr_init(&medium_attr);
  pthread_attr_setschedpolicy(&medium_attr, policy);
  medium_policy.sched_priority = 2;
  pthread_attr_setschedparam(&medium_attr, &medium_policy);

  pthread_attr_init(&low_attr);
  pthread_attr_setschedpolicy(&low_attr, SCHED_FIFO);
  low_policy.sched_priority = 1;
  pthread_attr_setschedparam(&low_attr, &low_policy);

  pthread_create(&th1, &medium_attr, medium, (char *)".");
  pthread_create(&th2, &medium_attr, medium, (char *)"#");
  pthread_create(&th3, &low_attr, low, NULL);
  
  pthread_attr_destroy(&medium_attr);
  pthread_attr_destroy(&low_attr);

  pthread_join(th1, NULL);
  pthread_join(th2, NULL);
  pthread_join(th3, NULL);
  
  myputchar(' ');
  myputchar(' ');
  myputchar(' ');
}


void *high(void *arg)
{
  /* first experiment:
     - two medium priority thread scheduled with RR
     - one low priority thread scheduled with FIFO
  */
  my_create(SCHED_RR);

  /* second experiment:
     - two medium priority thread scheduled with FIFO
     - one low priority thread scheduled with FIFO
  */
  my_create(SCHED_FIFO);

  return NULL;

}

int main()
{
  pthread_t mythread;
  pthread_attr_t myattr;
  struct sched_param myparam;

  int err;
  void *returnvalue;


  /* initializes the thread attribute */
  pthread_attr_init(&myattr);
  pthread_attr_setschedpolicy(&myattr, SCHED_FIFO);
  myparam.sched_priority = 3;
  pthread_attr_setschedparam(&myattr, &myparam);

  err = pthread_create(&mythread, &myattr, high, NULL);

  if (err) {
    perror("ERROR");
    exit(1);
  }

  pthread_attr_destroy(&myattr);

  /* wait the end of the thread we just created */
  pthread_join(mythread, &returnvalue);

  myprintbuf();

  return 0;
}


--------------010500030407000601000108
Content-Type: text/x-csrc;
 name="ex_rr.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ex_rr.c"


#include <stdio.h>
#include <pthread.h>
#include <stdlib.h>

/* for sched_param.c */
#include <sched.h> 



pthread_mutex_t xeno_stdout_lock;

int myputchar(int c)
{
    int err;

    pthread_mutex_lock(&xeno_stdout_lock);
    err = putchar_unlocked(c);
    pthread_mutex_unlock(&xeno_stdout_lock);

    return err;
}

void *low(void *arg)
{
  myputchar('L');
  return NULL;
}

void *medium(void *arg)
{
  int i,j;

  for (i=0; i<300; i++) {
    for (j=0; j<1000000; j++) ;
    myputchar(*(char *)arg);
  }

  return NULL;
}

void my_create(int policy)
{
  pthread_t th1, th2, th3;
  pthread_attr_t medium_attr, low_attr;
  struct sched_param medium_policy, low_policy;

  pthread_attr_init(&medium_attr);
  pthread_attr_setschedpolicy(&medium_attr, policy);
  medium_policy.sched_priority = 2;
  pthread_attr_setschedparam(&medium_attr, &medium_policy);

  pthread_attr_init(&low_attr);
  pthread_attr_setschedpolicy(&low_attr, SCHED_FIFO);
  low_policy.sched_priority = 1;
  pthread_attr_setschedparam(&low_attr, &low_policy);

  pthread_create(&th1, &medium_attr, medium, (char *)".");
  pthread_create(&th2, &medium_attr, medium, (char *)"#");
  pthread_create(&th3, &low_attr, low, NULL);
  
  pthread_attr_destroy(&medium_attr);
  pthread_attr_destroy(&low_attr);

  pthread_join(th1, NULL);
  pthread_join(th2, NULL);
  pthread_join(th3, NULL);
}


void *high(void *arg)
{
  /* first experiment:
     - two medium priority thread scheduled with RR
     - one low priority thread scheduled with FIFO
  */
  my_create(SCHED_RR);

  /* second experiment:
     - two medium priority thread scheduled with FIFO
     - one low priority thread scheduled with FIFO
  */
  my_create(SCHED_FIFO);

  return NULL;

}

int main()
{
  pthread_t mythread;
  pthread_attr_t myattr;
  struct sched_param myparam;

  int err;
  void *returnvalue;

  /* initializes the thread attribute */
  pthread_attr_init(&myattr);
  pthread_attr_setschedpolicy(&myattr, SCHED_FIFO);
  myparam.sched_priority = 3;
  pthread_attr_setschedparam(&myattr, &myparam);

  err = pthread_create(&mythread, &myattr, high, NULL);

  if (err) {
    perror("ERROR");
    exit(1);
  }

  pthread_attr_destroy(&myattr);

  /* wait the end of the thread we just created */
  pthread_join(mythread, &returnvalue);

  return 0;
}


--------------010500030407000601000108--

