Message-ID: <50EFC153.8030406@web.de>
Date: Fri, 11 Jan 2013 08:37:55 +0100
From: Jan Kiszka <jan.kiszka@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] [PATCH] x86/ipipe: restore warning with AMD erratum
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Xenomai <xenomai@xenomai.org>

> From acc3c57390d275a1b28d66f1ec88c85e0f8c0890 Mon Sep 17 00:00:00 2001
> From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
> Date: Sat, 29 Dec 2012 17:48:20 +0100
> Subject: [PATCH] x86/ipipe: restore warning with AMD erratum
> =

> ---
>  arch/x86/kernel/apic/apic.c |   16 ++++++++++------
>  1 files changed, 10 insertions(+), 6 deletions(-)
> =

> diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
> index 7f07610..91531bb 100644
> --- a/arch/x86/kernel/apic/apic.c
> +++ b/arch/x86/kernel/apic/apic.c
> @@ -545,14 +545,18 @@ static void __cpuinit setup_APIC_timer(void)
>  	memcpy(levt, &lapic_clockevent, sizeof(*levt));
>  	levt->cpumask =3D cpumask_of(smp_processor_id());
>  #ifdef CONFIG_IPIPE
> -	if (!(lapic_clockevent.features & CLOCK_EVT_FEAT_DUMMY))
> +	if (!(lapic_clockevent.features & CLOCK_EVT_FEAT_DUMMY)
> +	    && !cpu_has_amd_erratum(amd_erratum_400))
>  		levt->ipipe_timer =3D &__get_cpu_var(lapic_itimer);
>  	else {
> -	       printk(KERN_INFO
> -		      "I-pipe: cannot use LAPIC as a tick device\n");
> -	       if (cpu_has_amd_erratum(amd_erratum_400))
> -		       printk(KERN_INFO
> -			      "I-pipe: disable C1E power state in your BIOS\n");
> +		static atomic_t printed =3D ATOMIC_INIT(-1);
> +		printk(KERN_INFO
> +		       "I-pipe: cannot use LAPIC on cpu #%d as a tick device\n",
> +		       smp_processor_id());
> +		if (cpu_has_amd_erratum(amd_erratum_400)
> +		    && atomic_inc_and_test(&printed))
> +			printk(KERN_INFO
> +			       "I-pipe: disable C1E power state in your BIOS\n");

printk_once should do the trick as well.

>  	}
>  #endif /* CONFIG_IPIPE */
>  =

> -- =

> 1.7.3.4

I can also carry an updated version in my queue if you like. Did you
already request a merge of your queue? Then I would rebase mine on top
these days.

Jan

PS: ipipe-jki.git works now, thanks again.


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 261 bytes
Desc: OpenPGP digital signature
URL: <http://www.xenomai.org/pipermail/xenomai/attachments/20130111/6d1ee42=
8/attachment.pgp>
