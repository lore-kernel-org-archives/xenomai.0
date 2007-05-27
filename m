From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <464AA637.7070803@domain.hid>
References: <46476686.8020407@domain.hid>  <464AA637.7070803@domain.hid>
Content-Type: text/plain
Date: Sun, 27 May 2007 11:03:04 +0200
Message-Id: <1180256584.5015.6.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Adeos-main] [RFC][PATCH 2/2] Dump ipipe trace on kernel oopses
Reply-To: rpm@xenomai.org
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: adeos-main <adeos-main@gna.org>

On Wed, 2007-05-16 at 08:35 +0200, Jan Kiszka wrote:
> Jan Kiszka wrote:
> > This is not a must-have, and it is not for all archs so far anyway:
> > 
> > Dump an I-pipe panic trace on ordinary kernel oopses. For me this turned
> > out to be useful already, but not everyone may love to see his/her
> > console flooded with call-history traces on oops, though this only
> > happens if the tracer is enabled.
> > 
> > Comments welcome.
> > 
> 
> Following your suggestion, this version makes the panic freezing a
> configurable option. Also, it adds support for x86_64 (note that all
> arch bits are in the same patch here!) and should now cover any arch
> I-pipe runs on.
> 

Merged, thanks.

> I would say: No longer an RFC, now a request to apply.
> 
> Jan
> 
> 
> ---
>  arch/i386/mm/fault.c        |    5 +++
>  arch/x86_64/mm/fault.c      |    3 ++
>  include/linux/ipipe_trace.h |   10 +++----
>  kernel/ipipe/Kconfig.debug  |   18 +++++++++---
>  kernel/ipipe/tracer.c       |   62 ++++++++++++++++++++++++--------------------
>  lib/bust_spinlocks.c        |    5 +++
>  6 files changed, 65 insertions(+), 38 deletions(-)
> 
> Index: linux-2.6.20/arch/i386/mm/fault.c
> ===================================================================
> --- linux-2.6.20.orig/arch/i386/mm/fault.c
> +++ linux-2.6.20/arch/i386/mm/fault.c
> @@ -23,6 +23,7 @@
>  #include <linux/module.h>
>  #include <linux/kprobes.h>
>  #include <linux/uaccess.h>
> +#include <linux/ipipe_trace.h>
>  
>  #include <asm/system.h>
>  #include <asm/desc.h>
> @@ -68,9 +69,13 @@ void bust_spinlocks(int yes)
>  	int loglevel_save = console_loglevel;
>  
>  	if (yes) {
> +		ipipe_trace_panic_freeze();
>  		oops_in_progress = 1;
>  		return;
>  	}
> +
> +	ipipe_trace_panic_dump();
> +
>  #ifdef CONFIG_VT
>  	unblank_screen();
>  #endif
> Index: linux-2.6.20/lib/bust_spinlocks.c
> ===================================================================
> --- linux-2.6.20.orig/lib/bust_spinlocks.c
> +++ linux-2.6.20/lib/bust_spinlocks.c
> @@ -12,14 +12,19 @@
>  #include <linux/tty.h>
>  #include <linux/wait.h>
>  #include <linux/vt_kern.h>
> +#include <linux/ipipe_trace.h>
>  
> 
>  void bust_spinlocks(int yes)
>  {
>  	if (yes) {
> +		ipipe_trace_panic_freeze();
>  		oops_in_progress = 1;
>  	} else {
>  		int loglevel_save = console_loglevel;
> +
> +		ipipe_trace_panic_dump();
> +
>  #ifdef CONFIG_VT
>  		unblank_screen();
>  #endif
> Index: linux-2.6.20/include/linux/ipipe_trace.h
> ===================================================================
> --- linux-2.6.20.orig/include/linux/ipipe_trace.h
> +++ linux-2.6.20/include/linux/ipipe_trace.h
> @@ -2,7 +2,7 @@
>   * include/linux/ipipe_trace.h
>   *
>   * Copyright (C) 2005 Luotao Fu.
> - *               2005, 2006 Jan Kiszka.
> + *               2005-2007 Jan Kiszka.
>   *
>   * This program is free software; you can redistribute it and/or modify
>   * it under the terms of the GNU General Public License as published by
> @@ -23,8 +23,6 @@
>  #ifndef _LINUX_IPIPE_TRACE_H
>  #define _LINUX_IPIPE_TRACE_H
>  
> -#ifdef CONFIG_IPIPE_TRACE
> -
>  #include <linux/types.h>
>  
>  void ipipe_trace_begin(unsigned long v);
> @@ -36,14 +34,16 @@ void ipipe_trace_pid(pid_t pid, short pr
>  int ipipe_trace_max_reset(void);
>  int ipipe_trace_frozen_reset(void);
>  
> +#ifdef CONFIG_IPIPE_TRACE_PANIC
> +
>  void ipipe_trace_panic_freeze(void);
>  void ipipe_trace_panic_dump(void);
>  
> -#else /* !CONFIG_IPIPE_TRACE */
> +#else /* !CONFIG_IPIPE_TRACE_PANIC */
>  
>  static inline void ipipe_trace_panic_freeze(void) { }
>  static inline void ipipe_trace_panic_dump(void) { }
>  
> -#endif /* !CONFIG_IPIPE_TRACE */
> +#endif /* !CONFIG_IPIPE_TRACE_PANIC */
>  
>  #endif	/* !__LINUX_IPIPE_H */
> Index: linux-2.6.20/kernel/ipipe/Kconfig.debug
> ===================================================================
> --- linux-2.6.20.orig/kernel/ipipe/Kconfig.debug
> +++ linux-2.6.20/kernel/ipipe/Kconfig.debug
> @@ -31,9 +31,10 @@ config IPIPE_TRACE
>  	  in-kernel tracing API. The collected data and runtime control
>  	  is available via /proc/ipipe/trace/*.
>  
> +if IPIPE_TRACE
> +
>  config IPIPE_TRACE_ENABLE
>  	bool "Enable tracing on boot"
> -	depends on IPIPE_TRACE
>  	default y
>  	---help---
>  	  Disable this option if you want to arm the tracer after booting
> @@ -42,7 +43,6 @@ config IPIPE_TRACE_ENABLE
>  
>  config IPIPE_TRACE_MCOUNT
>  	bool "Instrument function entries"
> -	depends on IPIPE_TRACE
>  	default y
>  	---help---
>  	  When enabled, records every kernel function entry in the tracer
> @@ -53,7 +53,6 @@ config IPIPE_TRACE_MCOUNT
>  
>  config IPIPE_TRACE_IRQSOFF
>  	bool "Trace IRQs-off times"
> -	depends on IPIPE_TRACE
>  	default y
>  	---help---
>  	  Activate this option if I-pipe shall trace the longest path
> @@ -63,14 +62,12 @@ config IPIPE_TRACE_SHIFT
>  	int "Depth of trace log (14 => 16Kpoints, 15 => 32Kpoints)"
>  	range 10 18
>  	default 14
> -	depends on IPIPE_TRACE
>  	---help---
>  	  The number of trace points to hold tracing data for each
>  	  trace path, as a power of 2.
>  
>  config IPIPE_TRACE_VMALLOC
>  	bool "Use vmalloc'ed trace buffer"
> -	depends on IPIPE_TRACE
>  	default y if EMBEDDED
>  	---help---
>  	  Instead of reserving static kernel data, the required buffer
> @@ -79,9 +76,20 @@ config IPIPE_TRACE_VMALLOC
>  	  but it slightly degrades overall performance. Try this option
>  	  when a traced kernel hangs unexpectedly at boot time.
>  
> +config IPIPE_TRACE_PANIC
> +	bool "Enable panic back traces"
> +	default y
> +	---help---
> +	  Provides services to freeze and dump a back trace on panic
> +	  situations. This is used on IPIPE_DEBUG_CONTEXT exceptions
> +	  as well as ordinary kernel oopses. You can control the number
> +	  of printed back trace points via /proc/ipipe/trace.
> +
>  config IPIPE_TRACE_ENABLE_VALUE
>  	int
>  	default 0 if !IPIPE_TRACE_ENABLE
>  	default 1 if IPIPE_TRACE_ENABLE
>  
>  endif
> +
> +endif
> Index: linux-2.6.20/kernel/ipipe/tracer.c
> ===================================================================
> --- linux-2.6.20.orig/kernel/ipipe/tracer.c
> +++ linux-2.6.20/kernel/ipipe/tracer.c
> @@ -132,7 +132,9 @@ static unsigned long trace_overhead;
>  
>  static DEFINE_MUTEX(out_mutex);
>  static struct ipipe_trace_path *print_path;
> +#ifdef CONFIG_IPIPE_TRACE_PANIC
>  static struct ipipe_trace_path *panic_path;
> +#endif /* CONFIG_IPIPE_TRACE_PANIC */
>  static int print_pre_trace;
>  static int print_post_trace;
>  
> @@ -564,25 +566,6 @@ int ipipe_trace_frozen_reset(void)
>  }
>  EXPORT_SYMBOL(ipipe_trace_frozen_reset);
>  
> -void ipipe_trace_panic_freeze(void)
> -{
> -	unsigned long flags;
> -	int cpuid;
> -
> -	if (!ipipe_trace_enable)
> -		return;
> -
> -	ipipe_trace_enable = 0;
> -	local_irq_save_hw_notrace(flags);
> -
> -	cpuid = raw_smp_processor_id();
> -
> -	panic_path = &trace_paths[cpuid][active_path[cpuid]];
> -
> -	local_irq_restore_hw(flags);
> -}
> -EXPORT_SYMBOL(ipipe_trace_panic_freeze);
> -
>  static void
>  __ipipe_get_task_info(char *task_info, struct ipipe_trace_point *point,
>                        int trylock)
> @@ -615,6 +598,26 @@ __ipipe_get_task_info(char *task_info, s
>  	strcpy(task_info + (11 - strlen(buf)), buf);
>  }
>  
> +#ifdef CONFIG_IPIPE_TRACE_PANIC
> +void ipipe_trace_panic_freeze(void)
> +{
> +	unsigned long flags;
> +	int cpuid;
> +
> +	if (!ipipe_trace_enable)
> +		return;
> +
> +	ipipe_trace_enable = 0;
> +	local_irq_save_hw_notrace(flags);
> +
> +	cpuid = raw_smp_processor_id();
> +
> +	panic_path = &trace_paths[cpuid][active_path[cpuid]];
> +
> +	local_irq_restore_hw(flags);
> +}
> +EXPORT_SYMBOL(ipipe_trace_panic_freeze);
> +
>  void ipipe_trace_panic_dump(void)
>  {
>  	int cnt = back_trace;
> @@ -681,6 +684,7 @@ void ipipe_trace_panic_dump(void)
>  	panic_path = NULL;
>  }
>  EXPORT_SYMBOL(ipipe_trace_panic_dump);
> +#endif /* CONFIG_IPIPE_TRACE_PANIC */
>  
> 
>  /* --- /proc output --- */
> @@ -803,8 +807,17 @@ static void __ipipe_print_symname(struct
>  
>  	sym_name = kallsyms_lookup(eip, &size, &offset, &modname, namebuf);
>  
> -	/* printing to /proc? */
> -	if (m) {
> +#ifdef CONFIG_IPIPE_TRACE_PANIC
> +	if (!m) {
> +		/* panic dump */
> +		if (sym_name) {
> +			printk("%s+0x%lx", sym_name, offset);
> +			if (modname)
> +				printk(" [%s]", modname);
> +		}
> +	} else
> +#endif /* CONFIG_IPIPE_TRACE_PANIC */
> +	{
>  		if (sym_name) {
>  			if (verbose_trace) {
>  				seq_printf(m, "%s+0x%lx", sym_name, offset);
> @@ -814,13 +827,6 @@ static void __ipipe_print_symname(struct
>  				seq_puts(m, sym_name);
>  		} else
>  			seq_printf(m, "<%08lx>", eip);
> -	} else {
> -		/* panic dump */
> -		if (sym_name) {
> -			printk("%s+0x%lx", sym_name, offset);
> -			if (modname)
> -				printk(" [%s]", modname);
> -		}
>  	}
>  }
>  
> Index: linux-2.6.20/arch/x86_64/mm/fault.c
> ===================================================================
> --- linux-2.6.20.orig/arch/x86_64/mm/fault.c
> +++ linux-2.6.20/arch/x86_64/mm/fault.c
> @@ -24,6 +24,7 @@
>  #include <linux/module.h>
>  #include <linux/kprobes.h>
>  #include <linux/uaccess.h>
> +#include <linux/ipipe_trace.h>
>  
>  #include <asm/system.h>
>  #include <asm/pgalloc.h>
> @@ -73,8 +74,10 @@ void bust_spinlocks(int yes)
>  {
>  	int loglevel_save = console_loglevel;
>  	if (yes) {
> +		ipipe_trace_panic_freeze();
>  		oops_in_progress = 1;
>  	} else {
> +		ipipe_trace_panic_dump();
>  #ifdef CONFIG_VT
>  		unblank_screen();
>  #endif
> 
-- 
Philippe.



