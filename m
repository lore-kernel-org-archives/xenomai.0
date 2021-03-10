Subject: Re: [PATCH] cobalt/sched: dovetail: fix missed switching to OOB
 opportunities
References: <20210309044520.28816-1-hongzhan.chen@intel.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <c205e32d-27aa-9f3e-c996-24110151e384@siemens.com>
Date: Wed, 10 Mar 2021 17:15:16 +0100
MIME-Version: 1.0
In-Reply-To: <20210309044520.28816-1-hongzhan.chen@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: hongzha1 <hongzhan.chen@intel.com>, xenomai@xenomai.org, Philippe Gerum <rpm@xenomai.org>

On 09.03.21 05:45, hongzha1 via Xenomai wrote:
> Ask for switching back to oob mode once ptrace core tell that
> current is resuming from a stopped state, leaving space for
> other runnable RT threads of the process to take over.
> 
> Signed-off-by: hongzha1 <hongzhan.chen@intel.com>
> 
> diff --git a/kernel/cobalt/dovetail/kevents.c b/kernel/cobalt/dovetail/kevents.c
> index 966a63ce0..a640c4d9e 100644
> --- a/kernel/cobalt/dovetail/kevents.c
> +++ b/kernel/cobalt/dovetail/kevents.c
> @@ -492,6 +492,8 @@ static void handle_ptrace_cont(void)
>  			unregister_debugged_thread(curr);
>  
>  		xnthread_set_localinfo(curr, XNHICCUP);
> +
> +		dovetail_request_ucall(current);
>  	}
>  
>  	xnlock_put_irqrestore(&nklock, s);
> diff --git a/kernel/cobalt/dovetail/sched.c b/kernel/cobalt/dovetail/sched.c
> index de7c43b70..2bdddfeef 100644
> --- a/kernel/cobalt/dovetail/sched.c
> +++ b/kernel/cobalt/dovetail/sched.c
> @@ -56,9 +56,21 @@ int pipeline_leave_inband(void)
>  
>  int pipeline_leave_oob_prepare(void)
>  {
> -	dovetail_leave_oob();
> +	int suspmask = XNRELAX;
> +	struct xnthread *curr = xnthread_current();
>  
> -	return XNRELAX;
> +	dovetail_leave_oob();
> +	/*
> +	 * If current is being debugged, record that it should migrate
> +	 * back in case it resumes in userspace. If it resumes in
> +	 * kernel space, i.e.  over a restarting syscall, the
> +	 * associated hardening will clear XNCONTHI.
> +	 */
> +	if (xnthread_test_state(curr, XNSSTEP)) {
> +		xnthread_set_info(curr, XNCONTHI);
> +		suspmask |= XNDBGSTOP;
> +	}
> +	return suspmask;
>  }
>  
>  void pipeline_leave_oob_finish(void)
> 

I've applied this to wip/dovetail, but that alone does not fix 
ptrace/gdb use cases yet:

(gdb latency -> run)
[   52.097078] ------------[ cut here ]------------
[   52.097079] WARNING: CPU: 2 PID: 1318 at ../kernel/irq/pipeline.c:316 inband_irq_enable+0x10/0x20
[   52.097079] Modules linked in: 9p
[   52.097080] CPU: 2 PID: 1318 Comm: latency Not tainted 5.10.19+ #41
[   52.097080] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
[   52.097080] IRQ stage: Linux
[   52.097081] RIP: 0010:inband_irq_enable+0x10/0x20
[   52.097081] Code: 00 00 00 01 75 ee e8 cf fa ff ff 53 9d 5b c3 66 66 2e 0f 1f 84 00 00 00 00 00 80 3d 9a 38 b3 02 00 75 09 9c 58 f6 c4 02 75 02 <0f> 0b eb 8c 66 66 2e 0f 1f 84 00 00 00 00 00 90 0f 1f 44 00 00 48
[   52.097081] RSP: 0000:ffffc90000783f20 EFLAGS: 00010046
[   52.097082] RAX: 0000000000000046 RBX: ffffc90000783f58 RCX: 0000000000000000
[   52.097082] RDX: ffffc90000783ef0 RSI: ffffffff8109e600 RDI: ffffffff81d4eee2
[   52.097082] RBP: ffff888006e70000 R08: 0000000000000000 R09: 0000000000000000
[   52.097083] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000004000
[   52.097083] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
[   52.097083] FS:  00007ffff7fe6640(0000) GS:ffff88803ed00000(0000) knlGS:0000000000000000
[   52.097084] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   52.097084] CR2: 00007ffff7243610 CR3: 00000000070c6001 CR4: 0000000000370ee0
[   52.097084] Call Trace:
[   52.097084]  noist_exc_debug+0xf7/0x180
[   52.097085]  ? asm_exc_debug+0x23/0x30
[   52.097085]  asm_exc_debug+0x2b/0x30
[   52.097085] RIP: 0033:0x401df3
[   52.097086] Code: 00 00 e9 b0 fb ff ff ff 25 62 44 20 00 68 44 00 00 00 e9 a0 fb ff ff ff 25 5a 44 20 00 68 45 00 00 00 e9 90 fb ff ff 31 ed 90 <e8> f9 30 01 00 48 8d 65 d8 5b 41 5c 41 5d 41 70 44 40 00 48 c7 c1
[   52.097086] RSP: 002b:00007fffffffe1c0 EFLAGS: 00000346
[   52.097086] RAX: 00007ffff7ffe0e0 RBX: 00007ffff7ffe0e0 RCX: 00007ffff7df23c7
[   52.097087] RDX: 0000103e00000000 RSI: 0000000000000000 RDI: 0000000000000000
[   52.097087] RBP: 00007fffffffe3a0 R08: 00007ffff6e8f008 R09: 0000000000000009
[   52.097087] R10: 00007ffff7ffd990 R11: 0000000000000206 R12: 0000000000000000
[   52.097087] R13: 00007ffff7ffe110 R14: 00007ffff7ffe110 R15: 00007ffff7fe6640
[   52.097088] irq event stamp: 0
[   52.097088] hardirqs last  enabled at (0): [<0000000000000000>] 0x0
[   52.097088] hardirqs last disabled at (0): [<ffffffff8106c648>] copy_process+0x718/0x1cd0
[   52.097089] softirqs last  enabled at (0): [<ffffffff8106c648>] copy_process+0x718/0x1cd0
[   52.097089] softirqs last disabled at (0): [<0000000000000000>] 0x0
[   52.097089] ---[ end trace b07496576d3779dc ]---

Do I miss some other patch?

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

