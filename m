Message-ID: <4D750348.1050505@domain.hid>
Date: Mon, 07 Mar 2011 17:09:44 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4D74EE69.5020705@domain.hid> <4D74EFB0.7000807@domain.hid>
	<4D74FC69.1080000@domain.hid>
In-Reply-To: <4D74FC69.1080000@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] Build and run xenomai 2.5.5.2 - linux-2.6.33 on
 imx27
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Fabrice Gasnier <fabrice.gasnier@domain.hid>
Cc: xenomai@xenomai.org

Fabrice Gasnier wrote:
> Gilles Chanteperdrix wrote:
>> Fabrice Gasnier wrote:
>>   =20
>>> Dear all,
>>>
>>> I'm currently evaluating xenomai 2.5.5.2 on a i.MX27 platform with
>>> adeos-ipipe-2.6.33-arm-1.18-01.patch.
>>>
>>>
>>> I've encountred two issues for the time being  (same with
>>> adeos-ipipe-2.6.33-arm-1.18-00.patch).
>>>
>>> 1=C2=B0/ First one happens when building a 2.6.33.3 kernel (after xen=
omai
>>> prepare/configure/compile stage):
>>>
>>> CC      arch/arm/plat-mxc/time.o
>>> arch/arm/plat-mxc/time.c: In function 'mxc_timer_init':
>>> arch/arm/plat-mxc/time.c:400: error: 'TIM1_BASE_ADDR' undeclared (fir=
st
>>> use in this function)
>>> arch/arm/plat-mxc/time.c:400: error: (Each undeclared identifier is
>>> reported only once
>>> arch/arm/plat-mxc/time.c:400: error: for each function it appears in.=
)
>>> make[1]: *** [arch/arm/plat-mxc/time.o] Erreur 1
>>> make: *** [arch/arm/plat-mxc] Erreur 2
>>>
>>>
>>> I first tried 2.6.31 kernel that was compiling (patched with
>>> adeos-ipipe-2.6.31-arm-1.16-02.patch).
>>> Looking for differences lead me to patch my kernel with:
>>>
>>> Index: linux-2.6.33.3/arch/arm/plat-mxc/time.c
>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>> --- linux-2.6.33.3.orig/arch/arm/plat-mxc/time.c    2011-02-28
>>> 11:44:02.000000000 +0100
>>> +++ linux-2.6.33.3/arch/arm/plat-mxc/time.c    2011-02-28
>>> 11:48:19.000000000 +0100
>>> @@ -395,12 +395,17 @@
>>>        tsc_info.freq =3D clk_get_rate(timer_clk);
>>>        mxc_min_delay =3D ((__ipipe_cpu_freq + 500000) / 1000000) ?: 1=
;
>>>
>>> -    if (cpu_is_mx1() || cpu_is_mx2()) {
>>> -#if defined(CONFIG_ARCH_MX1) || defined(CONFIG_ARCH_MX2)
>>> +    if (cpu_is_mx1()) {
>>> +#ifdef CONFIG_ARCH_MX1
>>>            tsc_info.u.counter_paddr =3D (TIM1_BASE_ADDR + MX1_2_TCN);=

>>>            tsc_info.counter_vaddr =3D
>>>                (unsigned long)(timer_base + MX1_2_TCN);
>>>    #endif
>>> +    } else if (cpu_is_mx2()) {
>>> +#ifdef CONFIG_ARCH_MX2
>>> +        tsc_info.u.counter_paddr =3D (GPT1_BASE_ADDR + MX1_2_TCN);
>>> +        tsc_info.counter_vaddr =3D (unsigned long)(timer_base + MX1_=
2_TCN);
>>> +#endif
>>>        } else if (cpu_is_mx3()) {
>>>    #ifdef CONFIG_ARCH_MX3
>>>            tsc_info.u.counter_paddr =3D (GPT1_BASE_ADDR + MX3_TCN);
>>>     =20
>> Ok. I'll take this one.
>>
>>   =20
>>>    #ifdef CONFIG_IPIPE
>>>    void ipipe_mach_allow_hwtimer_uaccess(unsigned long aips1, unsigne=
d
>>> long aips2);
>>> +#if defined(CONFIG_ARCH_MX1) || defined(CONFIG_ARCH_MX2)
>>> +void ipipe_mach_allow_uaccess(unsigned long aipi_base_addr, unsigned=

>>> long bit_num);
>>> +#endif
>>>    #endif
>>>     =20
>> Look the function above, you are adding a function which is already
>> there, please reuse the same function, instead of duplicating it...
>>
>>   =20
> Not exactly the same, I'd be pleased to use it, but I didn't manage to =

> get it working (yet?). It hangs everything when I try to use it.
> It seems there are differences beetween existing routine (used by=20
> i.MX25) and what is needed by i.MX27.
> Having a look at datasheet for both products shows i.MX25 has an "AIPS"=
=20
> where i.MX27 has an "AIPI".
> Mapping in both case seem to be slightly different (registers seems=20
> different). I'm quite confused.
> This is why i created quite similar routine ...
>=20
> In i.MX25 case:
> __raw_writel(0x0, aips1 + 0x40);
> __raw_writel(0x0, aips1 + 0x44);
> __raw_writel(0x0, aips1 + 0x48);
> __raw_writel(0x0, aips1 + 0x4C);
>=20
>=20
> In i.MX27 case:
> __raw_writel(tmp & ~(1 << bit_num), IO_ADDRESS(aipi_base_addr +=20
> 0x00000008));
>=20
> This second alternative seem to work properly.

Just put an if in the function... if (cpu_is_mx27()) etc... Remember
that the MXC code is supposed to be able to run on several boards at the
same time.


--=20
					    Gilles.


