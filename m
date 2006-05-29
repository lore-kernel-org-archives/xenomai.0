Subject: Re: [Xenomai-core] Xenomai on PXA255
From: Stelian Pop <stelian.pop@domain.hid>
In-Reply-To: <1148912044.9574.30.camel@domain.hid>
References: <1148554757.9498.19.camel@domain.hid>
	<17530.65147.519598.892978@domain.hid>
	<1148912044.9574.30.camel@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15
Date: Mon, 29 May 2006 16:45:33 +0200
Message-Id: <1148913934.5494.15.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Bart Jonkers <jonkersbart@domain.hid>
Cc: xenomai@xenomai.org

Le lundi 29 mai 2006 =E0 16:14 +0200, Bart Jonkers a =E9crit :

> > The Ipipe patch for ARM only support the integrator platform for
> > now. There exist patch for another ARM platform, but it exist only as
> > a separated patch. Looking at the patch contents it seems that the on=
ly
> > patched files specific to the integrator architecture are :
> > arch/arm/mach-integrator/core.c
> > arch/arm/mach-integrator/integrator_cp.c
> > include/asm-arm/arch-integrator/entry-macro.S
> > include/asm-arm/arch-integrator/platform.h
> > include/asm-arm/arch-integrator/timex.h
> >=20
> > Looking rapidly at these files, it seems that the machine specific
> > functions and variables are reduced to:
> >=20
> > int __ipipe_mach_timerint;
> > int __ipipe_mach_timerstolen;
> > unsigned int __ipipe_mach_ticks_per_jiffy;
> >=20
> > void __ipipe_mach_acktimer(void);
> > unsigned long long __ipipe_mach_get_tsc(void);
> > void __ipipe_mach_set_dec(unsigned long reload);
> > unsigned long __ipipe_mach_get_dec(void);
> >=20
> > If you provide the same variables and functions for the PXA platform,=
 I
> > think there is no modification to be done at Xenomai level.

Gilles is 100% correct. All the platform specific code has to do is
provide the low level timer manipulation functions.

> I found this out already. But it would be a easier to implement this
> functions if I know what they have to do. So could somebody give an
> explanation of this variables and functions?

Well, __ipipe_mach_acktimer acks the timer, __ipipe_mach_get_tsc returns
the TSC of the platform, __ipipe_mach_set_dec sets the decrementer etc.
Should I go on ?

If you have specific questions feel free to ask. But I suggest you read
and try to understand the code first.

Stelian.
--=20
Stelian Pop <stelian.pop@domain.hid>



