Message-ID: <514240E6.1050806@yahoo.com>
Date: Thu, 14 Mar 2013 16:28:06 -0500
From: Tom Z <tomz30@yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] compiling kernel module with Xenomai support
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hi,

I am writing a kernel module that calls rt_task_add_hook() to add a hook 
when context switch occurs. I built a kernel module called 
*switch_hook.ko*, but when I /insmod switch_hook.ko/, it complains 
"*switch_hook: Unknown symbol rt_task_add_hook (err 0)*". I think I 
missed something during the build process (failed to include Xenomai 
source?) but I do not how to fix it. Below is my system settings, any 
help is greatly appreciated.
*Patched Linux kernel source* is at "/usr/src/linux-3.5.7"
*Xenomai source* is at "/usr/src/xenomai-2.6.2.1"
*Xenomai libraries and binaries* is at "/usr/xenomai"
*My kernel module source code* is at **"/home/tomz/switch_hook_mod/", 
and under this folder there are only two files: *Makefile* and 
*switch_hook.c*. Here is how I make this module, and Makefile and 
switch_hook.c's contents are attached as well:
/home/tomz/switch_hook_mod# *make EXTRA_CFLAGS="-I/usr/xenomai/include 
-D_GNU_SOURCE -D_REENTRANT -D__XENO" EXTRA_LDFLAGS="-lnative 
-L/usr/xenomai/lib -lxenomai -lpthread -lrt -lxenomai -lnative"*

*Makefile's content*
obj-m += switch_hook.o

all:
     make -C /lib/modules/$(shell uname -r)/build M=$(PWD) modules

clean:
     make -C /lib/modules/$(shell uname -r)/build M=$(PWD) clean

*switch_hook.c's content*
#include <linux/module.h>    /* Needed by all modules */
#include <linux/kernel.h>    /* Needed for KERN_INFO */
#include <linux/init.h>        /* Needed for the macros */

#include <native/task.h>
#include <native/timer.h>
#include  <rtdk.h>

void hook_func(void *cookie){
     printk(KERN_INFO "Context switch occured\n");
}

static int __init switch_hook_init(void)
{
     rt_print_auto_init(1);
     rt_printf("Add hook\n");
     rt_task_add_hook(T_HOOK_SWITCH, &hook_func);
     return 0;
}

static void __exit switch_hook_exit(void)
{
     printk(KERN_INFO "Goodbye\n");
}

module_init(switch_hook_init);
module_exit(switch_hook_exit);
//end of switch_hook.c
