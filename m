References: <CA+_GcoBZSOuEs_yrdG0EWXxUk5_PEC1qf69+jfqQFC_MpgFb9w@mail.gmail.com>
 <908427a1-bdb4-2ac8-ce51-3087f0006b17@xenomai.org>
 <CA+_GcoC-cYVnRM9KCQmpJUiG8=b=gLdFiMgPvDgcNdYKpnjNfA@mail.gmail.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <212f288a-11c1-94f6-049e-c6d5aab99647@xenomai.org>
Date: Tue, 20 Dec 2016 12:18:52 +0100
MIME-Version: 1.0
In-Reply-To: <CA+_GcoC-cYVnRM9KCQmpJUiG8=b=gLdFiMgPvDgcNdYKpnjNfA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
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
To: Sebastien Schneider <seb.schneider@gmail.com>
Cc: xenomai@xenomai.org

On 12/20/2016 10:54 AM, Sebastien Schneider wrote:
> I am using xenomai-3.0.2 on a Raspberry PI 2 with patched kernel 4.1.21,
> and there is no CONFIG_XENO_OPT_WATCHDOG option available.

There is. It may require CONFIG_XENO_OPT_DEBUG to be enabled in your
kernel config to see this knob, depending on the config interface you
are using.

> After system has hang, I can even "dmesg" the kernel using the serial
> line, that leads to such messages:
> 
> [  258.813973] INFO: rcu_sched detected stalls on CPUs/tasks:
> [  258.814019]  2: (0 ticks this GP) idle=aa1/140000000000000/0
> softirq=2028/2028 fqs=1
> [  258.814035]  (detected by 3, t=2102 jiffies, g=2860, c=2859, q=460)
> [  258.814059] Task dump for CPU 2:
> [  258.814075] swapper/2       R running      0     0      1 0x00000002
> [  258.814140] [<80025028>] (xnarch_switch_to) from [<800f4688>]
> (___xnsched_run+0x260/0x558)
> [  258.814169] [<800f4688>] (___xnsched_run) from [<800f4f0c>]
> (__xnsched_run_handler+0x78/0xf4)
> [  258.814201] [<800f4f0c>] (__xnsched_run_handler) from [<800b2690>]
> (dispatch_irq_head+0xb4/0x170)
> [  258.814233] [<800b2690>] (dispatch_irq_head) from [<800b2c5c>]
> (__ipipe_dispatch_irq+0x108/0x20c)
> [  258.814263] [<800b2c5c>] (__ipipe_dispatch_irq) from [<80009204>]
> (__ipipe_grab_ipi+0x40/0x90)
> [  258.814292] [<80009204>] (__ipipe_grab_ipi) from [<8059cff4>]
> (__irq_svc+0x34/0x118)

The last event on the locked up CPU is a switch to a real-time task, so
the presence of a runaway code in this context seems likely. You may
want to check your RTDM driver task code, and enable the watchdog as
suggested.

-- 
Philippe.

