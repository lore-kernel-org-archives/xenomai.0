Message-ID: <4500789C.9070804@domain.hid>
Date: Thu, 07 Sep 2006 14:53:00 -0500
From: Jeff Webb <jeff.webb@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] max size for pipes and rt-fifos?
References: <44FF3A22.5060901@domain.hid> <44FFE509.3090009@domain.hid>
In-Reply-To: <44FFE509.3090009@domain.hid>
Content-Type: multipart/mixed; boundary="------------090200030407080208030105"
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
--------------090200030407080208030105
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit

Thanks for your input, Jan.

Jan Kiszka wrote:
> Jeff Webb wrote:
>> It appears that the maximum pipe size that can be created using
>> rt_pipe_create() is 16 MB.  Is this correct?  If so, what is the cause
>> of this limitation, and are there any work-arounds?  I am using a 128 MB
>> FIFO in my rtlinux simulation.  Any ideas on how I can port this?
> 
> Maybe it's a 2.4-related issue (my 2.4 setup is broken, can't test). On
> a 2.6.17 kernel I face no problems allocating far larger rt_pipes.

I have discovered the source of the inconsistency:

  xenomai-2.1-rc4: include/nucleus/heap.h:
    #define XNHEAP_MAXEXTSZ   (1 << 24) /* i.e. 16Mb */

  xenomai-2.2.1: include/nucleus/heap.h:
    #define XNHEAP_MAXEXTSZ   (1 << 31) /* i.e. 2Gb */

  Changelog:  
    2006-07-15  Philippe Gerum  <rpm@xenomai.org>
        * include/nucleus/heap.h (XNHEAP_MAXEXTSZ): Raise maximum extent size to 2Gb.

I can now create a 128 MB rt-pipe on my xenomai-2.2.1 / kernel 2.6 dual-core machine, if I boot with vmalloc=256M and add "uppermem 524288" to my grub config.  I have not built an updated 2.4 kernel to test on my Fedora Core I machine yet, but I will do this soon.

> RTAI FIFO allocate their buffers from the real-time system heap, and
> that on is 128 KB by default (see kernel config).

Ah, I see.

I know this is not the ideal solution, but could the system heap be made something big, like 256 MB?  That might solve my problem, for the short term.  Of course, if there is a memory leak in the FIFO creation/deletion, I will have BIG problems... ;)
 
> Allocation in Xenomai pipes works differently...

Is there some reason the RTAI FIFO emulation is not handled the same way?  I believe the real RTL and RTAI FIFOs are handled like the Xenomai pipes are done now -- using kmalloc or vmalloc:

  https://www.rtai.org/documentation/magma/html/api/group__fifos__ipc.html#ga8

I know my FIFOs are on the huge side, but I know I'm not the only one using more than 128KB total for all their FIFOs...

> The potential leak you found needs to be examined. Could you post a
> simple test that demonstrate it?

I'm attaching a sample kernel module that creates a 100KB FIFO on module insertion, and destroys it on module removal.  I can only run this one time.  The write fails on subsequent runs because the memory cannot be allocated.  Is there something I am not cleaning up properly?

Thanks!

-Jeff



--------------090200030407080208030105
Content-Type: text/x-csrc;
 name="fifotestk.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="fifotestk.c"


/* Linux kernel includes */
#include <linux/module.h>

/* Xenomai includes */
#include <pthread.h>
#include <rtai/fifo.h>

/* Global variables */
pthread_t fifotest_task = NULL;

/* Real-time task */
void * fifotest_routine (void *cookie)
{  
  int err;

  err = rtf_put(1, "hello ", 6);
  printk("rtf_put: %d\n", err);
  return NULL;
}

static int fifotest_init(void)
{
  int err;
  pthread_attr_t attr;
 
  printk("fifotest_init\n");

  /* Create a FIFO */
  err = rtf_create(1, 1024*100);
  printk("rtf_create returned: %d\n", err);

  /* Create a real-time task */
  pthread_attr_init(&attr);
  pthread_attr_setfp_np(&attr, 1);
  err = pthread_create(&fifotest_task, &attr, &fifotest_routine, NULL);
  if (err)
    {
      printk("could not create thread (error code: %d)\n", err);
      err = rtf_destroy(1);
      printk("rtf_destroy returned: %d\n", err);
      return -1;
    }

  return 0;
}
static void fifotest_cleanup(void)
{
  int err;

  printk("fifotest_cleanup\n");
  
  /* Shut down the real-time thread */
  pthread_cancel (fifotest_task);
  pthread_join (fifotest_task, NULL);  

  /* Destroy the fifo */
  err = rtf_destroy(1);
  printk("rtf_destroy returned: %d\n", err);
  
}

module_init(fifotest_init);
module_exit(fifotest_cleanup);


--------------090200030407080208030105--

