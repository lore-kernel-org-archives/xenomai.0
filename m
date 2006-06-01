Message-ID: <39142.155.98.4.39.1149186052.squirrel@domain.hid>
Date: Thu, 1 Jun 2006 12:20:52 -0600 (MDT)
From: "Brandt Erickson" <brandt@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/mixed;boundary="----=_20060601122052_91268"
Subject: [Xenomai-help] xnpod help
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

------=_20060601122052_91268
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit

Hey,
I'm trying to write a simple looping module to test out xenomai nucleus
usage.  The problem is, when I insert the module (code attached), only the
printks from the initialization function ever get displayed and none from
the indefinite loop.  All the pod startup functions return success, so is
the thread working and just not successfully sending the messages out or
is the thread not starting up at all?  Could someone tell me if I'm using
the xenomai nucleus correctly?  Thanks.
-Brandt

------=_20060601122052_91268
Content-Type: text/x-csrc; name="runloop.c"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment; filename="runloop.c"


////// Standard C/C++ headers //////
#include <linux/module.h>       
#include <linux/kernel.h>       


////// Xenomai (real-time) headers //////
#include <nucleus/xenomai.h>


////// Self-Header //////
#include "runloop.h"  //Right now an empty header


////// Global Variables for this Module //////
xnthread_t thread;


////// Loop Function Declaration //////
void runloop_fcn(int arg);


////// Module Initialization //////
int init_module(void) {


  /*
  int xnpod_init_thread(xnthread_t *thread,
			const char *name,
			int prio,
			xnflags_t flags,
			unsigned stacksize);
  */

  printk("Thread Initialization ...\n");
  switch (xnpod_init_thread(&thread, "Control Thread", 0, XNFPU, 0)) {
  case EINVAL:
  case -EINVAL:
    printk("EINVAL\n");
    break;
  case ENOMEM:
  case -ENOMEM:
    printk("ENOMEM\n");
    break;
  case 0:
    printk("Success.\n");
    break;
  default:
    printk("Unknown error.\n");
  }


  /*
  int xnpod_start_thread(xnthread_t *thread,
			 xnflags_t mode,
			 int imask,
			 xnarch_cpumask_t affinity,
			 void(*)(void *cookie) entry,
			 void * cookie);
  */
  printk("Starting Thread ...\n");
  switch (xnpod_start_thread(&thread, 0, 1, XNPOD_ALL_CPUS,
			     runloop_fcn, NULL)) {
  case EBUSY:
  case -EBUSY:
    printk("EBUSY\n");
    break;
  case EINVAL:
  case -EINVAL:
    printk("EINVAL\n");
    break;
  case 0:
    printk("Success.\n");
    break;
  default:
    printk("Unknown error.\n");
  }


  /*
  int xnpod_start_timer(u_long nstick,
			xnisr_t tickhandler);
  */

  
  printk("Starting Timer ...\n");
  switch (xnpod_start_timer(1, XNPOD_DEFAULT_TICKHANDLER)) {
  case EBUSY:
  case -EBUSY:
    printk("EBUSY\n");
    break;
  case EINVAL:
  case -EINVAL:
    printk("EINVAL\n");
    break;
  case ENODEV:
  case -ENODEV:
    printk("ENODEV\n");
    break;
  case ENOSYS:
  case -ENOSYS:
    printk("ENOSYS\n");
    break;
  case 0:
    printk("Success.\n");
    break;
  default:
    printk("Unknown error.\n");
  }
  



  /*
  int xnpod_set_thread_periodic(xnthread_t *thread,
				xnticks_t idate,
				xnticks_t period);
  */

  
  printk("Setting periodic behavior  ...\n");
  switch (xnpod_set_thread_periodic(&thread, xnpod_get_time() + 1000000, 
				    1000000)) {
  case ETIMEDOUT:
  case -ETIMEDOUT:
    printk("ETIMEOUT\n");
    break;
    
  case EWOULDBLOCK:
  case -EWOULDBLOCK:
    printk("EWOULDBLOCK\n");
    break;

  case 0:
    printk("Success.\n");
    break;
  default:
    printk("Unknown error.\n");
  }

  xnpod_unblock_thread(&thread);

  return 0;
}


////// Module Cleanup //////
void cleanup_module(void) {
  xnpod_stop_timer();
  xnpod_delete_thread(&thread);
}



////// Realtime Loop Function //////
void runloop_fcn(int arg) {
  printk("Loop Thread Started.\n");
  while (1) {
    xnpod_wait_thread_period(NULL);
    printk("Timer: %d\n", (int)xnpod_get_time());
  }
}
------=_20060601122052_91268--



