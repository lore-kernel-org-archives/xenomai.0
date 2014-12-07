Date: Sun, 7 Dec 2014 13:40:41 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20141207124041.GS10014@hermes.click-hack.org>
References: <471986235a5c47e395ece6b3d18830bd@EX132MBOX1A.de2.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <471986235a5c47e395ece6b3d18830bd@EX132MBOX1A.de2.local>
Subject: Re: [Xenomai] Sleeping function called from invalid context
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Stoidner, Christoph" <c.stoidner@arvero.de>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On Sat, Dec 06, 2014 at 02:19:27PM +0000, Stoidner, Christoph wrote:
> 
> Hi at all,
> 
> I am using linux 3.10.18 and ipipe-core-3.10.18-arm-1 on a Freescale i.MX28. I have also merged PREEMPT RT rt14 into the kernel. FCSE is disabled.
> 
> I have enabled several debug options in the kernel. When a started program exits I get the message below:
> 
> [   33.187104] BUG: sleeping function called from invalid context at kernel/rtmutex.c:659
> [   33.187125] in_atomic(): 1, irqs_disabled(): 128, pid: 87, name: 
> [   33.187138] 1 lock held by /87:
> [   33.187213]  #0:  (rcu_read_lock){......}, at: [<c002add8>] __lock_task_sighand+0x24/0xf4
> [   33.187232] Preemption disabled at:[<  (null)>]   (null)
> [   33.187237] 
> [   33.187262] CPU: 0 PID: 87 Comm:  Not tainted 3.10.18-rt14-arvero-rev01-ipipe #2
> [   33.187337] [<c0013110>] (unwind_backtrace+0x0/0xf0) from [<c001158c>] (show_stack+0x10/0x14)
> [   33.187398] [<c001158c>] (show_stack+0x10/0x14) from [<c04a0b70>] (rt_spin_lock+0x20/0x64)
> [   33.187444] [<c04a0b70>] (rt_spin_lock+0x20/0x64) from [<c002ae28>] (__lock_task_sighand+0x74/0xf4)
> [   33.187479] [<c002ae28>] (__lock_task_sighand+0x74/0xf4) from [<c002aecc>] (do_send_sig_info+0x24/0x64)
> [   33.187522] [<c002aecc>] (do_send_sig_info+0x24/0x64) from [<c00b0878>] (lostage_handler+0xf8/0x128)
> [   33.187568] [<c00b0878>] (lostage_handler+0xf8/0x128) from [<c0073860>] (rthal_apc_handler+0x60/0x84)
> [   33.187615] [<c0073860>] (rthal_apc_handler+0x60/0x84) from [<c0066a58>] (__ipipe_do_sync_stage+0x1f8/0x288)
> [   33.187655] [<c0066a58>] (__ipipe_do_sync_stage+0x1f8/0x288) from [<c00145c0>] (__ipipe_syscall_root+0xf4/0x13c)
> [   33.187694] [<c00145c0>] (__ipipe_syscall_root+0xf4/0x13c) from [<c000ea34>] (vector_swi+0x54/0x74)
> 
> For me it seems as I have done something wrong when merging spinlocks of PREEMPT RT and ipipe. Isn't rt_spin_lock() allowed to be called within that context? Does anyone has an idea why?

>From what I understand of Xenomai 2.6 code (if this is the version
you are using), normally, the apc should be invoked from the
rthal_apc_thread context, not from rthal_apc_handler.

The virq handler should be rthal_apc_kicker, which wakes up the
process.

This code is #ifdef CONFIG_PREEMPT_RT, is not CONFIG_PREEMPT_RT
defined in your kernel ?

-- 
					    Gilles.

