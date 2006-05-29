Subject: Re: [Xenomai-core] Xenomai on PXA255
From: Bart Jonkers <jonkersbart@domain.hid>
In-Reply-To: <17530.65147.519598.892978@domain.hid>
References: <1148554757.9498.19.camel@domain.hid>
	<17530.65147.519598.892978@domain.hid>
Content-Type: text/plain
Date: Mon, 29 May 2006 16:14:04 +0200
Message-Id: <1148912044.9574.30.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

On Mon, 2006-05-29 at 16:00 +0200, Gilles Chanteperdrix wrote:
> Bart Jonkers wrote:
>  > Hey,
>  > 
>  > I'm trying to run Xenomai enabled kernel on the PXA255 (arm). When I
>  > compile the patched kernel, I get some undefined references errors.
>  > When I search through the patched kernel, I found the functions an
>  > variables defined for the integrator architecture.
>  > 
>  > Which functions and variables need I to define for the PXA255 and what
>  > are there purpose, so I can add support for the PXA255 processor.
>  > Or are there some patches around to support the PXA255.
> 
> The Ipipe patch for ARM only support the integrator platform for
> now. There exist patch for another ARM platform, but it exist only as
> a separated patch. Looking at the patch contents it seems that the only
> patched files specific to the integrator architecture are :
> arch/arm/mach-integrator/core.c
> arch/arm/mach-integrator/integrator_cp.c
> include/asm-arm/arch-integrator/entry-macro.S
> include/asm-arm/arch-integrator/platform.h
> include/asm-arm/arch-integrator/timex.h
> 
> Looking rapidly at these files, it seems that the machine specific
> functions and variables are reduced to:
> 
> int __ipipe_mach_timerint;
> int __ipipe_mach_timerstolen;
> unsigned int __ipipe_mach_ticks_per_jiffy;
> 
> void __ipipe_mach_acktimer(void);
> unsigned long long __ipipe_mach_get_tsc(void);
> void __ipipe_mach_set_dec(unsigned long reload);
> unsigned long __ipipe_mach_get_dec(void);
> 
> If you provide the same variables and functions for the PXA platform, I
> think there is no modification to be done at Xenomai level.
I found this out already. But it would be a easier to implement this
functions if I know what they have to do. So could somebody give an
explanation of this variables and functions?

Thanks,
Bart
> 


