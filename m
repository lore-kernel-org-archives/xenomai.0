From: "Jeff Webb" <jeff.webb@domain.hid>
Subject: Fw: [Fwd: Re: [Xenomai-help] invalid use of FPU in Xenomai context]
Date: Fri, 15 Sep 2006 23:38:59 -0500
Message-Id: <20060916042719.M57867@domain.hid>
In-Reply-To: <450B2BE1.1050105@domain.hid>
References: <450B2BE1.1050105@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=OPENWEBMAIL_ATT_0.606195492294745"
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

------=OPENWEBMAIL_ATT_0.606195492294745
Content-Type: text/plain;
	charset=iso-8859-1

Jeff Webb wrote:
> Unfortunately, I get the same results with this patch applied.  I 
> haven't been able to isolate the problem yet.  I did discover that 
> putting in a clock_nanosleep call at certain points in my simulation 
> loop allowed the loop to execute to completion without any FPU errors.  
> Maybe this is a clue...  I do still get an FPU error message at some 
> point after the main simulation loop is done, though.

Okay...  I have found a simple example that exhibits the problem on my
linux-2.4 system (see attached).  I am running xenomai 2.2.2 with the two RTAI
FIFO patches (and the latest FPU-related patch).  I get two unresolved
math-related symbols when I try to insert this module on my FC5 2.6 machine,
so I can't comment on the linux-2.6 behavior at this time.  But that's a
puzzle for another day...

When I insert the attached module, I get the following kernel log output:

Sep 15 17:30:08 kernel: fptest_init
Sep 15 17:30:08 kernel: rtf_create returned: 1
Sep 15 17:30:08 kernel: invalid use of FPU in Xenomai context at [f1f410a4]
Sep 15 17:30:08 kernel: Xenomai: suspending kernel thread efe22d30
('efe22d30') at 0xf1f410a4 after exception #7
Sep 15 17:30:08 kernel: spawned task

Removing the module yields:

Sep 15 17:30:13 kernel: fptest_cleanup
Sep 15 17:30:13 kernel: rtf_destroy returned: 0
Sep 15 17:30:13 kernel: f = 1

If I change the rtf_put command to output 500 bytes instead of 5000, the
program works as expected:

Sep 15 17:29:54 simhost kernel: fptest_init
Sep 15 17:29:54 simhost kernel: rtf_create returned: 1
Sep 15 17:29:54 simhost kernel: loop 0, f=1
Sep 15 17:29:54 simhost kernel: spawned task
Sep 15 17:29:55 simhost kernel: loop 1, f=2
Sep 15 17:29:56 simhost kernel: loop 2, f=3
Sep 15 17:29:57 simhost kernel: loop 3, f=4
Sep 15 17:29:58 simhost kernel: loop 4, f=5
Sep 15 17:29:59 simhost kernel: loop 5, f=6
Sep 15 17:30:00 simhost kernel: fptest_cleanup
Sep 15 17:30:00 simhost kernel: rtf_destroy returned: 0
Sep 15 17:30:00 simhost kernel: f = 6

Does this mean there is some FPU-related problem in the RTAI FIFO code?

Thanks,

Jeff


-- 
This message has been scanned for viruses and
dangerous content by MailScanner, and is
believed to be clean.


------=OPENWEBMAIL_ATT_0.606195492294745
Content-Type: text/x-csrc;
 name="fptest3k.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="fptest3k.c"


/* Linux kernel includes */
#include <linux/module.h>

/* Xenomai includes */
#include <pthread.h>
#include <time.h>
#include <rtai/fifo.h>

/* RTAI FIFO numbers /dev/rtf? */
#define FIFO1 3

/* Global variables */
pthread_t fptest_task = NULL;
double f = 0.0;

/* Real-time task */
void * fptest_routine (void *cookie)
{  
  struct timespec dt_ts;

  int i;
  char c[6000];

  for (i=0; i<101; i++)
    {
      /* Do a floating point calclation */
      f = f * 1.0 + 1.1;

      /* Stuff some (garbage) data in a FIFO */
      rtf_put(FIFO1, c, 5000);

      /* Print message to the kernel log */
      if (i % 1 == 0)
	{
	  printk("loop %d, f=%d\n", i, (int)f);
	}

      /* Sleep for 1 second */
      dt_ts.tv_sec  = 1;
      dt_ts.tv_nsec = 0;      
      clock_nanosleep(CLOCK_REALTIME, 0, &dt_ts, NULL);
    };

  return NULL;
}

static int fptest_init(void)
{
  int err;
  pthread_attr_t attr;
 
  printk("fptest_init\n");

  /* Create an FIFO */
  err = rtf_create(FIFO1, 1024*1024*1);
  printk("rtf_create returned: %d\n", err);
  if (err < 0)
    {
      printk("could not create FIFO\n");
      return -1;
    }

  /* Create a real-time task */
  pthread_attr_init(&attr);
  pthread_attr_setfp_np(&attr, 1);
  err = pthread_create(&fptest_task, &attr, &fptest_routine, NULL);
  if (err)
    {
      printk("could not create thread (error code: %d)\n", err);
      err = rtf_destroy(FIFO1);
      printk("rtf_destroy returned: %d\n", err);
      return -1;
    }
  else
    {
      printk("spawned task\n");
    };

  return 0;
}

static void fptest_cleanup(void)
{
  int err;

  printk("fptest_cleanup\n");
  
  /* Shut down the real-time thread */
  pthread_cancel (fptest_task);
  pthread_join (fptest_task, NULL);  

  /* Destroy the fifo */
  err = rtf_destroy(FIFO1);
  printk("rtf_destroy returned: %d\n", err);

  /* Print the floating point result */
  printk("f = %d\n", (int)f);  
}

module_init(fptest_init);
module_exit(fptest_cleanup);



------=OPENWEBMAIL_ATT_0.606195492294745--

