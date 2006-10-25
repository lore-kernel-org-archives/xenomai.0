Message-ID: <453FC279.8040608@domain.hid>
Date: Wed, 25 Oct 2006 15:00:57 -0500
From: Jeff Webb <jeff.webb@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] invalid use of FPU in Xenomai context
References: <450B2BE1.1050105@domain.hid>	 <20060916042719.M57867@domain.hid>
	<450F0451.8070102@domain.hid> <1158614598.5009.71.camel@domain.hid>
In-Reply-To: <1158614598.5009.71.camel@domain.hid>
Content-Type: multipart/mixed; boundary="------------010301080108020906050203"
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
Cc: xenomai@xenomai.org

This is a multi-part message in MIME format.
--------------010301080108020906050203
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

If I run the attached program, I get the following result:

  [root]# ./mqtest2
  CPU time limit exceeded

The kernel log contains:

  Oct 25 14:13:03 kernel: invalid use of FPU in Xenomai context at 0x80492f6

If I change the WRITE_SIZE #define at the top of the program to 511 instead of 512, I do not get an error message, and the program works as expected.

I have tried this under two versions of Xenomai with the same result:
  1) Xenomai 2.2.3 with the FPU patch posted here:
     https://mail.gna.org/public/xenomai-help/2006-09/msg00157.html
     (adeos-ipipe-2.6.17-i386-1.4-00.patch)
  2) Xenomai 2.2.4 (adeos-ipipe-2.6.17-i386-1.5-00.patch)

Other details:
  Linux version 2.6.17.13
  AMD Athlon(tm)64 X2 Dual Core Processor  4400+
  Fedora Core 5
  SMP kernel

This is very similar to a problem I described last month that affected my linux-2.4 system: https://mail.gna.org/public/xenomai-help/2006-09/msg00143.html .  Perhaps these problems are related.

Does anyone see a problem with what I'm doing here?  If not, can you reproduce the problem?

Thanks,

Jeff
 

--------------010301080108020906050203
Content-Type: text/x-csrc;
 name="mqtest2.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mqtest2.c"


/* Standard includes */
#include <stdio.h>
#include <errno.h>
#include <pthread.h>  /* POSIX threads and timers */
#include <stdlib.h>   /* Exit status macros and atexit */
#include <signal.h>   /* POSIX signals (sigaction) */
#include <sys/mman.h> /* Memory management (mlockall) */
#include <sys/stat.h> /* File creation modes (for mq_open) */
#include <mqueue.h>   /* POSIX message queues */
#include <error.h>    /* GNU error function */
#include <string.h>   /* String manipulation (strlen) */

/* Constants */
#define STACK_SIZE 1024*1024*8
#define QUEUE_MSG_SIZE 1024
#define QUEUE_MAX_MSGS 10
#define QUEUE_NAME "/queue1"
#define PRIORITY 10
#define WRITE_SIZE 512

/* Global variables */
sig_atomic_t abort_program = 0;
pthread_t rt_thread;
mqd_t queue1;
mqd_t queue1_rt;
int count = 0;
char send_buffer[QUEUE_MSG_SIZE];
char receive_buffer[QUEUE_MSG_SIZE];

/* Real-time thread cleanup routines */

void rt_thread_cleanup_queue1_rt (void * arg)
{
  mq_close(queue1_rt);
}

/* Real-time periodic thread code */
void * rt_loop(void * arg)
{
  double f = 0.0;

  /* Open the message queue */
  queue1_rt = mq_open(QUEUE_NAME, O_WRONLY | O_NONBLOCK);
  if (queue1_rt == (mqd_t) -1)
    error(0, errno, "could not open message queue '%s'", QUEUE_NAME);
  pthread_cleanup_push(rt_thread_cleanup_queue1_rt, NULL);

  pthread_set_mode_np(0, PTHREAD_WARNSW);
  
  /* Loop until the thread is cancelled */
  while (1)
    {
      /* Count the number of times this loop is executed */
      count++;
      
      /* Sleep for 1 second */
      {
        struct timespec dt_ts;
        dt_ts.tv_sec  = 1;
        dt_ts.tv_nsec = 0;
        clock_nanosleep(CLOCK_REALTIME, 0, &dt_ts, NULL);
      }

      /* Send a message to the non-rt thread */
      {
        int err;

        snprintf(send_buffer, QUEUE_MSG_SIZE, "count: %d %f", count, f);
        err = mq_send(queue1_rt, send_buffer, WRITE_SIZE, PRIORITY);
        if (err)
          error(0, errno, "could not write to message queue '%s'", 
                QUEUE_NAME);
        f = f + 0.1*count;
      }
    }

  /* Clean up thread resources */
  pthread_cleanup_pop(1);

  return NULL;
}

/* Handle POSIX signals */
void signal_handler(int sig)
{
  abort_program = 1;
}

/* Cleanup routines */

void cleanup_queue1(void)
{
  /* Close the message queue */
  mq_close(queue1);

  /* Delete the message queue */
  mq_unlink(QUEUE_NAME);
}

void cleanup_rt_thread(void)
{
  /* Tell the real-time thread to terminate */
  pthread_cancel(rt_thread);

  /* Wait for the real-time thread to terminate */
  pthread_join(rt_thread, NULL);
}


/* Main program */
int main(void)
{
  int err;

  /* Disable paging for this program's memory */
  err = mlockall(MCL_CURRENT | MCL_FUTURE);
  if (err)
    error(EXIT_FAILURE, errno,
          "could not disable memory paging for this program");

  /* Set the scheduling policy of the main program */
  {
    struct sched_param sparam;

    sparam.sched_priority = 0; /* Must be zero for SCHED_OTHER */
    err = pthread_setschedparam(pthread_self(), SCHED_OTHER, &sparam);
    if (err)
      error(EXIT_FAILURE, err,
            "error setting schedule parameters for main program");
  }

  /* Install POSIX signal handlers */
  {
    struct sigaction new_action;
    int * sig_ptr;
    int signals[] = {SIGTERM, SIGQUIT, SIGHUP, SIGINT, 0};
    
    new_action.sa_handler = signal_handler;
    sigemptyset(&new_action.sa_mask);
    new_action.sa_flags = 0;

    for (sig_ptr = signals; *sig_ptr != 0; sig_ptr++)
      {
        err = sigaction(*sig_ptr, &new_action, NULL);
        if (err)
          error(EXIT_FAILURE, errno, 
                "could not install signal handler for signal %d", *sig_ptr);
      }
  }

  /* Create a message queue */
  {
    struct mq_attr attr;

    attr.mq_flags = 0;
    attr.mq_maxmsg = QUEUE_MAX_MSGS;
    attr.mq_msgsize = QUEUE_MSG_SIZE;

    mq_unlink(QUEUE_NAME);
    queue1 = mq_open(QUEUE_NAME, O_RDONLY | O_CREAT | O_EXCL,
                     S_IRUSR | S_IWUSR | S_IXUSR, &attr);
    if (queue1 == (mqd_t) -1)
      error(EXIT_FAILURE, errno, "could not create message queue '%s'", 
            QUEUE_NAME);
    atexit(cleanup_queue1);
  }

  /* Create the real-time task */
  {
    pthread_attr_t attr;
    size_t stacksize = STACK_SIZE;
    struct sched_param sparam;

    pthread_attr_init(&attr);
    pthread_attr_setdetachstate(&attr, PTHREAD_CREATE_JOINABLE);
    pthread_attr_setstacksize (&attr, stacksize);
    pthread_attr_setinheritsched(&attr, PTHREAD_EXPLICIT_SCHED);
    pthread_attr_setschedpolicy(&attr, SCHED_FIFO);
    sparam.sched_priority = 99; /* High priority */
    pthread_attr_setschedparam(&attr, &sparam);
    pthread_create(&rt_thread, &attr, &rt_loop, NULL);
    pthread_attr_destroy(&attr);
    if (err)
      error(EXIT_FAILURE, err, "could not create thread");
    atexit(cleanup_rt_thread);
  }

  /* Wait for program to be aborted with <ctrl-c> */
  while(!abort_program)
    {
      int err;

      /* Wait for data from the rt thread */
      err = mq_receive(queue1, receive_buffer, QUEUE_MSG_SIZE, NULL);
      if (err < 0)
        error(0, errno, "error reading from message queue '%s'", QUEUE_NAME);
      else
        /* Print the message */
        printf("received message: %s\n", receive_buffer);
    }

  /* Print the final loop count */
  printf("final count = %d\n", count);

  /* Cleanup is handled by atexit functions */
  return EXIT_SUCCESS;
}

--------------010301080108020906050203--

