Message-ID: <5130FA30.5010106@siemens.com>
Date: Fri, 01 Mar 2013 19:57:52 +0100
From: Jan Kiszka <jan.kiszka@siemens.com>
MIME-Version: 1.0
References: <5130E77E.8030005@siemens.com>
In-Reply-To: <5130E77E.8030005@siemens.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [PULL] x86/ipipe: Small fixes and patch against BUG
 on legacy IRQs to APs
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: Xenomai <xenomai@xenomai.org>

On 2013-03-01 18:38, Jan Kiszka wrote:
> The following changes since commit 946ca3977e75316751caecc7182f4e64af6499d5:
> 
>   ipipe-core-3.5.7-blackfin-3 (2013-01-22 11:41:34 +0100)
> 
> are available in the git repository at:
>   git://git.xenomai.org/ipipe-jki.git for-upstream/3.5
>   (well, whatever transport works by then)
> 
> The most important fix is the backport of the upstream patch to fix
> unhandled legacy PIC IRQs that show up on secondary CPUs. Linux gets
> confused about this, I-pipe even raises a BUG in __ipipe_handle_irq.
> That's solved now according to user reports.
> 
> The rest deals with non-GPL exports of central symbols, a small fix for
> the latency tracer on x86 and cleanups.
> 
> Jan Kiszka (8):
>       ipipe: Export ipipe_root_only also for non-GPL modules
>       ipipe: Export __ipipe_spin_unlock_debug also for non-GPL modules
>       ipipe: Allow local_irq_enable/disable etc. for non-GPL modules
>       x86/ipipe: Fix irqoff tracing in __ipipe_syscall_root
>       x86/ipipe: Stop saving/restoring flags in __ipipe_syscall_root
>       x86/ipipe: Consolidate printing of I-pipe domain in show_regs
>       ipipe: Convert ipipe_check_irqoff into macro
>       ipipe: Remove unused get_wall_to_monotonic

Sorry, but I got hold of another bug and extended the pull therefor:

     x86/ipipe: Do not call TRACE_IRQS_OFF before __ipipe_divert_exception

 arch/x86/kernel/entry_32.S |    4 ++--
 arch/x86/kernel/entry_64.S |    8 ++++++--
 2 files changed, 8 insertions(+), 4 deletions(-)

Not critical as long as CONFIG_TRACE_IRQFLAGS if off. But when it's on
and someone triggers e.g. an INT1 or INT3, we corrupt the root domain
state.

Jan

> 
> Suresh Siddha (1):
>       x86, apic: Cleanup cfg->domain setup for legacy interrupts
> 
>  arch/x86/kernel/apic/io_apic.c |   20 ++++----------------
>  arch/x86/kernel/dumpstack_32.c |    6 +++---
>  arch/x86/kernel/dumpstack_64.c |    4 +---
>  arch/x86/kernel/ipipe.c        |   11 +++++++----
>  include/linux/ipipe_debug.h    |   10 +++++-----
>  include/linux/time.h           |    1 -
>  kernel/ipipe/core.c            |   10 +++++-----
>  kernel/time/timekeeping.c      |    6 ------
>  8 files changed, 25 insertions(+), 43 deletions(-)
> 

-- 
Siemens AG, Corporate Technology, CT RTC ITP SDP-DE
Corporate Competence Center Embedded Linux

