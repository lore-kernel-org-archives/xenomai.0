MIME-Version: 1.0
In-Reply-To: <908427a1-bdb4-2ac8-ce51-3087f0006b17@xenomai.org>
References: <CA+_GcoBZSOuEs_yrdG0EWXxUk5_PEC1qf69+jfqQFC_MpgFb9w@mail.gmail.com>
 <908427a1-bdb4-2ac8-ce51-3087f0006b17@xenomai.org>
From: Sebastien Schneider <seb.schneider@gmail.com>
Date: Tue, 20 Dec 2016 10:54:48 +0100
Message-ID: <CA+_GcoC-cYVnRM9KCQmpJUiG8=b=gLdFiMgPvDgcNdYKpnjNfA@mail.gmail.com>
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

I am using xenomai-3.0.2 on a Raspberry PI 2 with patched kernel 4.1.21,
and there is no CONFIG_XENO_OPT_WATCHDOG option available.
After system has hang, I can even "dmesg" the kernel using the serial line,
that leads to such messages:

[  258.813973] INFO: rcu_sched detected stalls on CPUs/tasks:
[  258.814019]  2: (0 ticks this GP) idle=aa1/140000000000000/0
softirq=2028/2028 fqs=1
[  258.814035]  (detected by 3, t=2102 jiffies, g=2860, c=2859, q=460)
[  258.814059] Task dump for CPU 2:
[  258.814075] swapper/2       R running      0     0      1 0x00000002
[  258.814140] [<80025028>] (xnarch_switch_to) from [<800f4688>]
(___xnsched_run+0x260/0x558)
[  258.814169] [<800f4688>] (___xnsched_run) from [<800f4f0c>]
(__xnsched_run_handler+0x78/0xf4)
[  258.814201] [<800f4f0c>] (__xnsched_run_handler) from [<800b2690>]
(dispatch_irq_head+0xb4/0x170)
[  258.814233] [<800b2690>] (dispatch_irq_head) from [<800b2c5c>]
(__ipipe_dispatch_irq+0x108/0x20c)
[  258.814263] [<800b2c5c>] (__ipipe_dispatch_irq) from [<80009204>]
(__ipipe_grab_ipi+0x40/0x90)
[  258.814292] [<80009204>] (__ipipe_grab_ipi) from [<8059cff4>]
(__irq_svc+0x34/0x118)
[  258.814308] Exception stack(0xb98f9f48 to 0xb98f9f90)
[  258.814331] 9f40:                   00000000 00000002 39751000 00000000
b98f8000 80858e1c
[  258.814356] 9f60: 80858dbc 805a22e8 0000406a 808c1bbc 00000000 b98f9f9c
8005d294 b98f9f90
[  258.814374] 9f80: 80092f0c 8005d2c0 60000013 ffffffff
[  258.814405] [<8059cff4>] (__irq_svc) from [<8005d2c0>]
(set_cpu_sd_state_idle+0x40/0x80)
[  258.814437] [<8005d2c0>] (set_cpu_sd_state_idle) from [<80092f0c>]
(tick_nohz_idle_enter+0x24/0x90)
[  258.814470] [<80092f0c>] (tick_nohz_idle_enter) from [<800638a8>]
(cpu_startup_entry+0x68/0x2d0)
[  258.814501] [<800638a8>] (cpu_startup_entry) from [<80016184>]
(secondary_start_kernel+0x12c/0x134)
[  258.814531] [<80016184>] (secondary_start_kernel) from [<0000974c>]
(0x974c)
[  258.814549] rcu_sched kthread starved for 2101 jiffies!

Is this log helpful ?

2016-12-19 18:20 GMT+01:00 Philippe Gerum <rpm@xenomai.org>:

> On 12/19/2016 03:04 PM, Sebastien Schneider wrote:
> > Hello,
> >
> > I am facing issues with the rtdm_task_init() function when trying to
> > developp a xenomai real-time base driver.
> > I firstly call the rtdm_task_init() method for a non periodic task with
> the
> > lowest priority. This lowest priority task infinitly executes code which
> > first consists on a rtdm_task_sleep() for a predefined amount of time,
> > before other various operations.
> > Then, I secondly call the rtdm_task_init() method for an another non
> > periodic task with the highest priority. And what happens after compiling
> > the code and trying to insert the obtained module, is that the system
> seems
> > to hang.
> >
> > Has anyone some idea that can help me ?
>
> Runaway thread #2, maybe never blocking unlike you would expect it to?
> Enabling the watchdog is recommended when developing Xenomai apps
> (CONFIG_XENO_OPT_WATCHDOG); it would trap when a rt thread runs away,
> suspending it with a warning message sent to the kernel log.
>
> Sharing the driver code in question would help. Such issue basically
> depends on what your code is exactly doing.
>
> --
> Philippe.
>
