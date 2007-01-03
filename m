Subject: Re: [Xenomai-help] Latest SVN version: tasklist_lock not exported
	with UP
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <17158062.1167829649968.JavaMail.ngmail@domain.hid>
References: <17158062.1167829649968.JavaMail.ngmail@domain.hid>
Content-Type: text/plain
Date: Wed, 03 Jan 2007 14:44:02 +0100
Message-Id: <1167831842.18647.8.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Reply-To: rpm@xenomai.org
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "M. Koehrer" <mathias_koehrer@domain.hid>
Cc: xenomai@xenomai.org

On Wed, 2007-01-03 at 14:07 +0100, M. Koehrer wrote:
> Hi all,
> 
> using the latest SVN version (#2039) of Xenomai on a 2.6.19.1 kernel (Pentium 4),
> I found out that the build is broken if the nucleus skin is compiled as module and
> if UP (and not SMP) is selected.
> in arch/i386/kernel/ipipe.c
> the EXPORT_SYMBOL(tasklist_lock)
> is encapsulated in a #ifdef CONFIG_SMP
> which is not true for a UP kernel.

Apply this, or disable CONFIG_DEBUG_SPINLOCK until the fix is merged
into the next I-pipe release:

--- arch/i386/kernel/ipipe.c~	2006-12-21 17:55:47.000000000 +0100
+++ arch/i386/kernel/ipipe.c	2007-01-03 14:42:28.000000000 +0100
@@ -900,8 +900,10 @@
 EXPORT_SYMBOL_GPL(__switch_to);
 EXPORT_SYMBOL_GPL(show_stack);
 EXPORT_PER_CPU_SYMBOL_GPL(init_tss);
-#ifdef CONFIG_SMP
+#if defined(CONFIG_SMP) || defined(CONFIG_DEBUG_SPINLOCK)
 EXPORT_SYMBOL(tasklist_lock);
+#endif /* CONFIG_SMP || CONFIG_DEBUG_SPINLOCK */
+#ifdef CONFIG_SMP
 EXPORT_SYMBOL(__ipipe_logical_cpuid);
 EXPORT_PER_CPU_SYMBOL_GPL(cpu_tlbstate);
 #endif /* CONFIG_SMP */

> 
> Regards
> 
> Mathias
> 
-- 
Philippe.



