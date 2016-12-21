MIME-Version: 1.0
In-Reply-To: <212f288a-11c1-94f6-049e-c6d5aab99647@xenomai.org>
References: <CA+_GcoBZSOuEs_yrdG0EWXxUk5_PEC1qf69+jfqQFC_MpgFb9w@mail.gmail.com>
 <908427a1-bdb4-2ac8-ce51-3087f0006b17@xenomai.org>
 <CA+_GcoC-cYVnRM9KCQmpJUiG8=b=gLdFiMgPvDgcNdYKpnjNfA@mail.gmail.com>
 <212f288a-11c1-94f6-049e-c6d5aab99647@xenomai.org>
From: Sebastien Schneider <seb.schneider@gmail.com>
Date: Wed, 21 Dec 2016 15:24:59 +0100
Message-ID: <CA+_GcoD-T2zraBLgTDYi89_4Fdx_EBmPqkU5wn3wV51-xUZSgw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Xenomai] System hang when doing several rtdm_task_init()
	calling
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

I've correctly set CONFIG_XENO_OPT_WATCHDOG thanks to CONFIG_XENO_OPT_DEBUG.
Here is the basic version of driver I try to load, and that leads to the
same effect :

*#define LOWEST_PRIORITY 0*
*#define HIGHEST_PRIORITY 99*
*rtdm_task_t task1;*
*rtdm_task_t task2;*

*void handler_task1(void *arg)*
*{*
*        while(1)*
*        {*
*        }*
*        return ;*
*}*

*void handler_task2(void *arg)*
*{*
*        while(1)*
*        {*
*        }*
*        return ;*
*}*

*static int __init vlc_driver_init(void)*
*{*
*        printk(KERN_INFO "VLC: Inserting module...\n");*
*        rtdm_task_init(&task1, "task1", handler_task1, NULL,
LOWEST_PRIORITY, 0);*
*        rtdm_task_init(&task2, "task2", handler_task2, NULL,
HIGHEST_PRIORITY, 0);*
*        return 0;*
*}*

*static void __exit vlc_driver_exit(void)*
*{*
*        printk(KERN_INFO "VLC: Removing module...\n");*
*        return;*
*}*

*module_init(vlc_driver_init);*
*module_exit(vlc_driver_exit);*
*MODULE_LICENSE("GPL");*

So, it must be something very basic I did not have understood !!!

2016-12-20 12:18 GMT+01:00 Philippe Gerum <rpm@xenomai.org>:

> On 12/20/2016 10:54 AM, Sebastien Schneider wrote:
> > I am using xenomai-3.0.2 on a Raspberry PI 2 with patched kernel 4.1.21,
> > and there is no CONFIG_XENO_OPT_WATCHDOG option available.
>
> There is. It may require CONFIG_XENO_OPT_DEBUG to be enabled in your
> kernel config to see this knob, depending on the config interface you
> are using.
>
> > After system has hang, I can even "dmesg" the kernel using the serial
> > line, that leads to such messages:
> >
> > [  258.813973] INFO: rcu_sched detected stalls on CPUs/tasks:
> > [  258.814019]  2: (0 ticks this GP) idle=aa1/140000000000000/0
> > softirq=2028/2028 fqs=1
> > [  258.814035]  (detected by 3, t=2102 jiffies, g=2860, c=2859, q=460)
> > [  258.814059] Task dump for CPU 2:
> > [  258.814075] swapper/2       R running      0     0      1 0x00000002
> > [  258.814140] [<80025028>] (xnarch_switch_to) from [<800f4688>]
> > (___xnsched_run+0x260/0x558)
> > [  258.814169] [<800f4688>] (___xnsched_run) from [<800f4f0c>]
> > (__xnsched_run_handler+0x78/0xf4)
> > [  258.814201] [<800f4f0c>] (__xnsched_run_handler) from [<800b2690>]
> > (dispatch_irq_head+0xb4/0x170)
> > [  258.814233] [<800b2690>] (dispatch_irq_head) from [<800b2c5c>]
> > (__ipipe_dispatch_irq+0x108/0x20c)
> > [  258.814263] [<800b2c5c>] (__ipipe_dispatch_irq) from [<80009204>]
> > (__ipipe_grab_ipi+0x40/0x90)
> > [  258.814292] [<80009204>] (__ipipe_grab_ipi) from [<8059cff4>]
> > (__irq_svc+0x34/0x118)
>
> The last event on the locked up CPU is a switch to a real-time task, so
> the presence of a runaway code in this context seems likely. You may
> want to check your RTDM driver task code, and enable the watchdog as
> suggested.
>
> --
> Philippe.
>
