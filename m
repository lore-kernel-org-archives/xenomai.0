Subject: Re: [Xenomai-core] Re: [Adeos-main] ipip tracer porting for blackfin
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <4546494d0611100554h6dfee69boca6fa79978f1fac2@domain.hid>
References: <4546494d0609300059p2879d7bcwb9bc898f279df140@domain.hid>
	<45203E31.6050707@domain.hid>
	<4546494d0611100554h6dfee69boca6fa79978f1fac2@domain.hid>
Content-Type: text/plain
Date: Fri, 10 Nov 2006 15:27:11 +0100
Message-Id: <1163168831.5765.144.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Reply-To: rpm@xenomai.org
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: "Li Yi (Adam)" <liyiadam@domain.hid>
Cc: adeos-main@gna.org, Jan Kiszka <jan.kiszka@domain.hid>, xenomai@xenomai.org

On Fri, 2006-11-10 at 21:54 +0800, Li Yi (Adam) wrote:
> Hi Jan and Philippe,
> 
> I have tested the adeos-ipipe-bf53x-CVS-20061008-1.5-00.patch in
> Xenomai-2.2.5 with latest Blackfin uclinux toolchain 06r2 release:
> http://blackfin.uclinux.org/frs/download.php/1136/blackfin-toolchain-06r2-5.i386.rpm. Since the toolchain changed a little for the "mcount" call, the ipipe-tracer patch need to be updated a little.
> 
> Also I add trace for IRQ entry and exit as Jan suggested. Here is the
> details of the patch (with my explanation) 
> 
> diff -Nur linux-2.6.x-ipipe-orig/arch/blackfin/kernel/ipipe-mcount.S
> linux-2.6.x-ipipe/arch/blackfin/kernel/ipipe-mcount.S
> --- linux-2.6.x-ipipe-orig/arch/blackfin/kernel/ipipe-mcount.S
> 2006-11-10 21:04:21.000000000 +0800
> +++ linux-2.6.x-ipipe/arch/blackfin/kernel/ipipe-mcount.S
> 2006-11-10 16:41:11.000000000 +0800
> @@ -12,7 +12,7 @@
> 
>  .align 4       /* just in case */
> 
> -ENTRY(_mcount)
> +ENTRY(__mcount)
>         [--sp] = ( r7:0, p5:0 ); 
>         [--sp] = ASTAT;
>         p1.L = _ipipe_trace_enable;
> diff -Nur linux-2.6.x-ipipe-orig/arch/blackfin/kernel/ipipe-root.c
> linux-2.6.x-ipipe/arch/blackfin/kernel/ipipe-root.c
> --- linux-2.6.x-ipipe-orig/arch/blackfin/kernel/ipipe- root.c
> 2006-11-10 21:04:21.000000000 +0800
> +++ linux-2.6.x-ipipe/arch/blackfin/kernel/ipipe-root.c 2006-11-10
> 16:41:59.000000000 +0800
> @@ -281,6 +281,6 @@
>  EXPORT_SYMBOL(show_stack);
> 
>  #ifdef CONFIG_IPIPE_TRACE_MCOUNT 
> -void notrace mcount(void);
> -EXPORT_SYMBOL(mcount);
> +void notrace _mcount(void);
> +EXPORT_SYMBOL(_mcount);
>  #endif /* CONFIG_IPIPE_TRACE_MCOUNT */
> 
> <Yi's note>: The  gcc  will add "Call _ _mcount" to each function
> entry when there is "-pg" option 

Ok.

> 
> diff -Nur linux-2.6.x-ipipe-orig/arch/blackfin/mach-common/interrupt.S
> linux-2.6.x-ipipe/arch/blackfin/mach-common/interrupt.S
> --- linux-2.6.x-ipipe-orig/arch/blackfin/mach-common/interrupt.S
> 2006-11-10 21:04: 21.000000000 +0800
> +++ linux-2.6.x-ipipe/arch/blackfin/mach-common/interrupt.S
> 2006-11-10 16:43:55.000000000 +0800
> @@ -304,7 +304,10 @@
>         p0.l = _irq_flags;
>         p0.h = _irq_flags;
>         r0 = [p0]; 
> -       sti r0
> +       sti r0;
> +       /* Reenable interrupts */
> +       [--sp] = reti;
> +       r0 = [sp++];
>         rts;
> 
>  #endif /* CONFIG_IPIPE */
> 
> 
> <Yi's Note>: I used the ipipe-trace to trace the latency test case:
> "latency -t2 -p200 -f". And found that "__ipipe_call_irqtail()" will
> disable global interrupts, putting the Blackfin to a state like: 
> "IMASK: 0x0000FFFF, ILAT: 0x00000040, IPEND: 0x0000c010" - that is,
> Core Timer irq latched, but since IPEND[4] is set, the irq handler
> cannot be invoked - thus longer latency.
> 

Good catch, I forgot the fact that triggering an IRQ to run the
scheduling tail would raise the global disable bit. Applied, thanks.

[...]

-- 
Philippe.



