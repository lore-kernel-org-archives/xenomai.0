Message-ID: <4521576D.5050001@domain.hid>
Date: Mon, 02 Oct 2006 13:16:13 -0500
From: Jeff Webb <jeff.webb@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------020409090600020703040001"
Subject: [Xenomai-help] POSIX API Questions
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Xenomai help <xenomai@xenomai.org>

This is a multi-part message in MIME format.
--------------020409090600020703040001
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

I have a couple of questions regarding the userspace POSIX API...

I remember reading somewhere that in order to make blocking calls to Xenomai resources from the main thread, a Xenomai shadow thread needs to be created by calling rt_task_shadow.  Of course, this routine is part of the native API.  From my research, the equivalent way of doing this using the POSIX skin appears to be adding these lines to the main program:

  struct sched_param sparam;
  sparam.sched_priority = 0; /* Must be zero for SCHED_OTHER? */
  pthread_setschedparam(pthread_self(), SCHED_OTHER, &sparam);

The documentation says that calling pthread_setschedparam for the main thread will make it into a Xenomai task.  So, is the above code correct?  The main thread is intended to be a non-RT I/O thread that communicates with an RT thread via POSIX message queues.

When I look at /proc/xenomai/sched, it appears that a shadow thread is created even if I omit the call to pthread_setschedparam mentioned above.  Is this always done automatically, or should I follow the procedure above and explicitly call pthread_setschedparam?

I am new to POSIX thread programming (and Xenomai), so I am trying to figure out how everything works.  I have attached an example that compiles and runs under vanilla linux as well as Xenomai using the POSIX API.  It appears to work the way I would expect.  I would appreciate it if someone would look it over the example see if the signal handling, task creation/deletion, error handling, mqueue operation, etc. looks correct.  Am I doing anything that would make my rt_thread non-RT?  (e.g. is it okay to call snprintf?)

Any other words of advice for using the POSIX skin?

Thanks,

Jeff


--------------020409090600020703040001
Content-Type: text/x-csrc;
 name="mqtest.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mqtest.c"


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

/* Global variables */
sig_atomic_t abort_program = 0;
pthread_t rt_thread;
mqd_t queue1;
mqd_t queue1_rt;
int count = 0;

/* Real-time thread cleanup routines */

void rt_thread_cleanup_queue1_rt (void * arg)
{
  mq_close(queue1_rt);
}

/* Real-time periodic thread code */
void * rt_loop(void * arg)
{
  /* Open the message queue */
  queue1_rt = mq_open(QUEUE_NAME, O_WRONLY);
  if (queue1_rt == (mqd_t) -1)
    error(0, errno, "could not open message queue '%s'", QUEUE_NAME);
  pthread_cleanup_push(rt_thread_cleanup_queue1_rt, NULL);
  
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
        char buffer[QUEUE_MSG_SIZE];
        int err;

        snprintf(buffer, QUEUE_MSG_SIZE, "count: %d", count);
        err = mq_send(queue1_rt, buffer, strlen(buffer), PRIORITY);
        if (err)
          error(0, errno, "could not write to message queue '%s'", QUEUE_NAME);
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
      char buffer[QUEUE_MSG_SIZE];
      int err;

      /* Wait for data from the rt thread */
      err = mq_receive(queue1, buffer, QUEUE_MSG_SIZE, NULL);
      if (err < 0)
        error(0, errno, "error reading from message queue '%s'", QUEUE_NAME);
      else
        /* Print the message */
        printf("received message: %s\n", buffer);
    }

  /* Print the final loop count */
  printf("final count = %d\n", count);

  /* Cleanup is handled by atexit functions */
  return EXIT_SUCCESS;
}

--------------020409090600020703040001--

