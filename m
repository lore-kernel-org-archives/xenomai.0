From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <27223852.1178871002720.JavaMail.ngmail@domain.hid>
References: <46441EC7.4000603@domain.hid>
	<15183185.1178867312688.JavaMail.ngmail@domain.hid>
	<27223852.1178871002720.JavaMail.ngmail@domain.hid>
Content-Type: text/plain
Date: Fri, 11 May 2007 10:21:46 +0200
Message-Id: <1178871707.5451.17.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-help] Xenomai and futexes - Native API optimized
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
Cc: xenomai@xenomai.org, jan.kiszka@domain.hid

On Fri, 2007-05-11 at 10:10 +0200, M. Koehrer wrote:
> Hi Jan,
> 
> > As an experiment, you could try implementing the cpuid lookup via
> > raw_smp_processor_id(), given you use 2.6.20. Hmm, maybe/likely some
> > Xenomai tuning is required as well to make sure that the PDA is set
> > correctly when a Xenomai task is created/migrated. Results welcome!
> 
> I have applied a patch (below) to my SMP kernel 2.6.20.4.
> And actually the results are now much better.
> I have been back on my "original" kernel version without the oprofile support.
> The "original" ipipe.c delivered times of 4.5 us per step with my test project.
> The patched ipipe.c (using raw_smp_processor_id()) delivers 1.25 us per step!
> This is really an excellent improvement!
> I do not know if there are any side effects - if not: why not using this method instead
> of the previous one...

We are going to use it. PDAs have been recently introduced and the
I-pipe patch for x86_64 already uses them, but I simply overlooked the
fact that they have been made available for x86 too. Will fix, thanks.

> 
> Regards
> 
> Mathias
> 
> ------------------------- patch start ------------------
> --- ipipe.c.orig        2007-05-09 16:16:32.000000000 +0200
> +++ ipipe.c     2007-05-11 10:00:44.000000000 +0200
> @@ -74,6 +74,7 @@
> 
>  static notrace int __ipipe_hard_cpuid(void)
>  {
> +#if 0
>         unsigned long flags;
>         int cpu;
> 
> @@ -81,6 +82,9 @@
>         cpu = __ipipe_apicid_2_cpu[GET_APIC_ID(apic_read(APIC_ID))];
>         local_irq_restore_hw_notrace(flags);
>         return cpu;
> +#endif
> +        return raw_smp_processor_id();
> +
>  }
> 
>  #endif /* CONFIG_SMP */
> ------------------------- patch end ------------------
> 
> 
-- 
Philippe.



