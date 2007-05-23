From: Peter Feuerer <peter.feuerer@domain.hid>
In-Reply-To: <20070522145243.94232353428@domain.hid>
References: <20070522145243.94232353428@domain.hid>
Content-Type: multipart/mixed; boundary="=-Q6qGpf5+SHAaxNkFt0Pm"
Date: Wed, 23 May 2007 10:05:35 +0200
Message-Id: <1179907535.6119.14.camel@domain.hid>
Mime-Version: 1.0
Subject: Re: [Xenomai-help] ppc crosscompilation, missing headers
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Wolfgang Denk <wd@domain.hid>
Cc: xenomai@xenomai.org


--=-Q6qGpf5+SHAaxNkFt0Pm
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi,

History:
https://mail.gna.org/public/xenomai-help/2007-05/msg00260.html

> Please see FAQ 14.1.4. ELDK Include Files Missing
> http://www.denx.de/wiki/view/DULG/ELDKIncludeFilesMissing

After doing this workaround, I'm able to compile the userspace part of
Xenomai, but now I can't compile any little kernelmodule using the
xenomai api. I attached the Makefile and the sourcecode of my little
example.

When trying to compile it cannot find headers like asm/param.h or
asm/types.h (because they are not in krnsrc/include/asm-ppc/ and the
workaround just added the userspace/libc headers). I guess there must be
something wrong with the Makefile, but I cannot find the problem.

regards,
--peter

--=-Q6qGpf5+SHAaxNkFt0Pm
Content-Disposition: attachment; filename=Makefile
Content-Type: text/x-makefile; name=Makefile; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

### List of modules to be build
MODULES = krn

### Default to sources of currently running kernel
KSRC:=../../usr/src/linux

OBJS     := ${patsubst %, %.o, $(MODULES)}
CLEANMOD := ${patsubst %, .%*, $(MODULES)}
PWD      := $(shell if [ "$$PWD" != "" ]; then echo $$PWD; else pwd; fi)

obj-m        := $(OBJS)
EXTRA_CFLAGS := -I$(KSRC)/include/xenomai -I$(KSRC)/include/xenomai/posix

all::
	$(MAKE) -C $(KSRC) SUBDIRS=$(PWD) modules

clean::
	$(RM) $(CLEANMOD) *.o *.ko *.mod.c Module*.symvers
	$(RM) -R .tmp*

--=-Q6qGpf5+SHAaxNkFt0Pm
Content-Disposition: attachment; filename=krn.c
Content-Type: text/x-csrc; name=krn.c; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

#include <linux/module.h>
#include <native/task.h>

MODULE_LICENSE("GPL");
RT_TASK task;

void foo_task(void *cookie) {
   int i=0;
	rt_task_set_periodic(NULL, TM_NOW, 50000000);
   while(1)
   {
      rt_task_wait_period(NULL);
      printk("foo %d\n",i++);
   }
}

int init_module(void)
{
	rt_task_create(&task, "foo_task", 0, 99, 0);
	rt_task_start(&task, &foo_task,NULL);
	
	printk("krn module loaded\n");
	return 0;
}

void cleanup_module(void)
{
	rt_task_delete(&task);
	printk("krn module unloaded\n");
}

--=-Q6qGpf5+SHAaxNkFt0Pm--


