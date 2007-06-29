Date: Fri, 29 Jun 2007 14:19:50 +0200
From: "Axel Beierlein" <belatronix@domain.hid>
Content-Type: text/plain; format="flowed"; delsp="yes"; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID: <op.tuom7dvpt06gyn@domain.hid>
Subject: [Xenomai-help] Kompiling an RT Kernel Module
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "Xenomai-help@domain.hid" <Xenomai-help@domain.hid>

Hello,

Now a few hours i try to compile a simple file as an RT Kernel Module and  
i get errors over errors.
I have included the kernel sources and the xenomai sources in different  
ways. I get many "in file includes" and other errors.

What are the minimal requirements to compile such a native rt module?  
(include path, lib path ....)
I can´t use the output of xeno-config cause the rootfs on my target(ppc)  
is mounted over NFS from my development host(i386). I have a look at the  
makefile http://svn.gna.org/svn/xenomai/trunk/examples/common/Makefile but  
that solved not my probs. On the contrary it confuses me more and more  
cause i don´t understand why the Makro KSRC is defined as an pointer to  
the librarys and this Makro was also used to point to the Kernelheaders.

Is there anywhere an example working with support for cross-developement?

I´ve compiled the running kernel with all xenomai stuff inside (no  
modules) but with module load support on.

Axel

sorry for my terrible English ;-)

--------------------------------------------------------------------

The Example-Source of Kernel Module:

#include <native/task.h>

#define TASK_PRIO  99              /* Highest RT priority */
#define TASK_MODE  T_FPU|T_CPU(0)  /* Uses FPU, bound to CPU #0 */
#define TASK_STKSZ 4096            /* Stack size (in bytes) */

RT_TASK task_desc;

void task_body (void *cookie)
{
    for (;;) {
      /* ... "cookie" should be NULL ... */
      }
}

int init_module (void)
  {
	int err;

      /* ... */

     err = rt_task_create(&task_desc,
                           "MyTaskName",
                          TASK_STKSZ,
                          TASK_PRIO,
                          TASK_MODE);
      if (!err)
          rt_task_start(&task_desc,&task_body,NULL);

     /* ... */
  }

  void cleanup_module (void)
  {
      rt_task_delete(&task_desc);
  }

