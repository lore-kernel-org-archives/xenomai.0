Message-ID: <50E4C4E3.2070909@openwide.fr>
Date: Thu, 03 Jan 2013 00:38:11 +0100
From: Romain Naour <romain.naour@openwide.fr>
MIME-Version: 1.0
References: <50E062E8.6030903@openwide.fr> <50E0BD01.1020404@xenomai.org>
	<50E17756.7030400@openwide.fr>
In-Reply-To: <50E17756.7030400@openwide.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] Xenomai 2.6.2 user-space compilation error on ARM <
 armv6
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Le 31/12/2012 12:30, Romain Naour a =C3=A9crit :
> Le 30/12/2012 23:15, Gilles Chanteperdrix a =C3=A9crit :
>> On 12/30/2012 04:51 PM, Romain Naour wrote:
>>
>>> Hi Gilles,
>>>
>>> First of all, thank you for the new release of Xenomai :)
>>>
>>> I'm compiling Xenomai 2.6.2 and Linux kernel 3.5.3 for mini2440 with
>>> buildroot 2012.11.
>>>
>>> During compilation I get the following error: error: #error "SMP not
>>> supported below armv6, compile with -march=3Darmv6 or above"
>>>
>>> This error is caused by the SMP mode which is now enabled by default
>>> on ARM. So I added the option --disable-smp on the buildroot's
>>> command line for ./configure (buildroot assumes that the SMP mode is
>>> not enabled when it compile Xenomai for arm)
>>>
>>> This option became mandatory for ARM < armv6 to pass this test:
>>> (xenomai-2.6/include/asm-arm/feature.h)
>>>
>>> #if __LINUX_ARM_ARCH__ < 6 && defined(CONFIG_SMP) #error "SMP not
>>> supported below armv6, compile with -march=3Darmv6 or above" #endif
>>>
>>> The error message may be advisable to add the option --disable-smp ?=20
>>> However, since your objective is to allow to run the same binary on
>>> UP and SMP system, it is safe to remove this test for ARM < armv6 now
>>> ?
>>
>>
>> Could you try the following patch?
>>
>> diff --git a/include/asm-arm/atomic_asm.h b/include/asm-arm/atomic_asm=
.h
>> index 47f17c9..ef62690 100644
>> --- a/include/asm-arm/atomic_asm.h
>> +++ b/include/asm-arm/atomic_asm.h
>> @@ -27,6 +27,10 @@
>>  #error "please don't include asm/atomic_asm.h directly"
>>  #endif
>> =20
>> +#if __LINUX_ARM_ARCH__ < 6 && defined(CONFIG_SMP)
>> +#error "SMP not supported below armv6 with ad-hoc atomic operations, =
compile without SMP or with -march=3Darmv6 or above"
>> +#endif
>> +
>>  extern void __xnarch_xchg_called_with_bad_pointer(void);
>> =20
>>  #define xnarch_read_memory_barrier()		xnarch_memory_barrier()
>> diff --git a/include/asm-arm/features.h b/include/asm-arm/features.h
>> index 279f752..bddaa5e 100644
>> --- a/include/asm-arm/features.h
>> +++ b/include/asm-arm/features.h
>> @@ -73,10 +73,6 @@
>>  #error "Could not find current ARM architecture"
>>  #endif
>> =20
>> -#if __LINUX_ARM_ARCH__ < 6 && defined(CONFIG_SMP)
>> -#error "SMP not supported below armv6, compile with -march=3Darmv6 or=
 above"
>> -#endif
>> -
>>  #define CONFIG_XENO_FASTSYNCH 1
>> =20
>>  #if CONFIG_XENO_ARM_TSC_TYPE =3D=3D __XN_TSC_TYPE_KUSER
>>
>=20
> Hi Gilles,
>=20
> I applied your patch and tried to compile with the following options:
> --with-atomic-ops=3Dad-hoc
> As expected, the build fails with this error:
> #error "SMP not supported below armv6 with ad-hoc atomic operations,
> compile without SMP or with -march=3Darmv6 or above"
>=20
> --with-atomic-ops=3Dbuiltins (or when this option is not specified)
> The build ends correctly.
> I haven't the board at this time, I'll do a test this week.
>=20
> Regards,
> Romain
>=20
> _______________________________________________
> Xenomai mailing list
> Xenomai@xenomai.org
> http://www.xenomai.org/mailman/listinfo/xenomai
>=20

Hi Gilles,

I did a test today with your previous patch, it works correctly.
However the following patch is required since the new ipipe-core.

Signed-off-by: Naour Romain <romain.naour@openwide.fr>
---

We need a minimal reload value for s3c2410_itimer, otherwise the hardware=
 timer stops.

 arch/arm/plat-samsung/time.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/plat-samsung/time.c b/arch/arm/plat-samsung/time.c
index 8d14b85..97fbdc5 100644
--- a/arch/arm/plat-samsung/time.c
+++ b/arch/arm/plat-samsung/time.c
@@ -364,6 +364,8 @@ static void s3c2410_timer_setup (void)
=20
 #ifdef CONFIG_IPIPE
 	s3c2410_itimer.freq =3D tcnt * HZ;
+	/* hardware timer can't be reloaded below 120ns */
+	s3c2410_itimer.min_delay_ticks =3D ipipe_timer_ns2ticks(&s3c2410_itimer=
, 120);
 	ipipe_timer_register(&s3c2410_itimer);
 #endif /* CONFIG_IPIPE */
 }
--=20
1.8.0.3



