Message-ID: <4651B821.2080704@domain.hid>
Date: Mon, 21 May 2007 17:17:53 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <465099CE.2010004@domain.hid> <4651AFF9.5030402@domain.hid>
In-Reply-To: <4651AFF9.5030402@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [BUG] module_put called over non-root domain
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

Jan Kiszka wrote:
> Hi Philippe,
> 
> Jan Kiszka wrote:
> 
>>Just ran into this with CONFIG_IPIPE_DEBUG_CONTEXT (maybe due to some
>>bug of my own):
> 
> 
> Here is some code to trigger the issue reliably:
> 
> #include <sys/mman.h>
> #include <native/task.h>
> 
> void task_fnct(void *arg)
> {
>         rt_task_delete(NULL);
> }
> 
> main()
> {
>         RT_TASK task;
>         mlockall(MCL_CURRENT|MCL_FUTURE);
>         rt_task_spawn(&task, "task", 0, 10, 0, task_fnct, NULL);
> }
> 
> 
> 
>>[  102.616000] I-pipe: Detected illicit call from domain 'Xenomai'
>>[  102.616000]         into a service reserved for domain 'Linux' and below.
>>[  102.616000]        c741bdc8 00000000 00000000 c8860ef8 c741bdec c0105683 c032c200 c13fe22c
>>[  102.616000]        c0361f00 c741be08 c01519ed c032f5b8 c032c742 c03380b3 c8885100 c78beac0
>>[  102.616000]        c741be14 c0142ce9 c7a80b30 c741be3c c884d075 c885f150 c8860ef8 c741be3c
>>[  102.616000] Call Trace:
>>[  102.616000]  [<c0104d9f>] show_trace_log_lvl+0x1f/0x40
>>[  102.616000]  [<c0104e71>] show_stack_log_lvl+0xb1/0xe0
>>[  102.616000]  [<c0105683>] show_stack+0x33/0x40
>>[  102.616000]  [<c01519ed>] ipipe_check_context+0xad/0xc0
>>[  102.616000]  [<c0142ce9>] module_put+0x19/0x90
>>[  102.616000]  [<c884d075>] xnshadow_unmap+0xb5/0x130 [xeno_nucleus]
>>[  102.616000]  [<c8871dc5>] __shadow_delete_hook+0x25/0x30 [xeno_native]
>>[  102.616000]  [<c8842f78>] xnpod_schedule+0xb58/0x12f0 [xeno_nucleus]
>>[  102.616000]  [<c8844bfb>] xnpod_delete_thread+0x2cb/0x3d0 [xeno_nucleus]
>>[  102.616000]  [<c886f5bd>] rt_task_delete+0x20d/0x220 [xeno_native]
>>
>>I would dare to say that module_put in xnshadow_unmap is not well placed
>>as it can wakeup a Linux process. The module ref-counter maintenance
>>needs some postponing, I guess.
> 
> 
> Attached is a patch proposal. It solves the issue by postponing the
> module_put via a new schedule_linux_call. Note that this approach issues
> LO_WAKEUP_REQ where the old test (p->state != TASK_RUNNING) would not
> have done so. I don't see negative side effects yet, and I'm furthermore
> not sure of the old code was handling SMP scenarios safely (What if the
> thread to be unmapped was running on different CPU than xnshadow_unmap?
> How to ensure test-atomicity then?).

This one counts as mine! I am Ok with the fix, but IMHO, the
"if(p->state != TASK_RUNNING)" probably has a reason, so I would leave
it in the new implementation.

-- 
                                                 Gilles Chanteperdrix

