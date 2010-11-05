Message-ID: <4CD34B4F.6090503@domain.hid>
Date: Fri, 05 Nov 2010 01:09:51 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4CC82C8D.3080808@domain.hid>	<4CD18782.7090607@domain.hid>	<4CD191EE.7000604@domain.hid>	<4CD1936E.50203@domain.hid>	<4CD1BA29.9000303@domain.hid>	<1288816871.1842.84.camel@domain.hid>	<4CD1DC1B.8060407@domain.hid>	<4CD1DE12.5010309@domain.hid>	<4CD1E890.5010702@domain.hid>
	<4CD1EC2F.4040603@domain.hid>	<4CD1ED16.8030103@domain.hid>
	<4CD1EDA8.10007@domain.hid>	<4CD1F33C.5070208@domain.hid>
	<4CD1F3F5.5080505@domain.hid>	<4CD1F4FE.9020908@domain.hid>
	<4CD1F69B.9070100@domain.hid>	<4CD1F906.1070703@domain.hid>
	<4CD1FABD.1080301@domain.hid>	<4CD2612C.2070507@domain.hid>
	<4CD279F7.7070502@domain.hid>	<4CD27C46.8010302@domain.hid>
	<4CD27DC2.7060607@domain.hid>	<4CD2A96B.3080001@domain.hid>
	<4CD2B2A7.9010900@domain.hid>	<4CD2C50F.1090604@domain.hid>
	<4CD2C8E2.9090608@domain.hid>	<4CD2D25D.6000604@domain.hid>
	<4CD32EF1.7000202@domain.hid> <4CD33D59.1010003@domain.hid>
	<4CD340E0.7020109@domain.hid> <4CD34293.7040802@domain.hid>
	<4CD345F0.3040509@domain.hid>
In-Reply-To: <4CD345F0.3040509@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig272F3CF1BDEF55FA8EFE6230"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] Potential problem with rt_eepro100
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig272F3CF1BDEF55FA8EFE6230
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Am 05.11.2010 00:46, Gilles Chanteperdrix wrote:
> Jan Kiszka wrote:
>> Am 05.11.2010 00:25, Gilles Chanteperdrix wrote:
>>> Jan Kiszka wrote:
>>>> Am 04.11.2010 23:08, Gilles Chanteperdrix wrote:
>>>>> Jan Kiszka wrote:
>>>>>> rework. Safer for now is likely to revert 56ff4329ff, keeping nucl=
eus
>>>>>> debugging off.
>>>>> That is not enough.
>>>> It is, I've reviewed the code today.
>>> The fallouts I am talking about are:
>>> 47dac49c71e89b684203e854d1b0172ecacbc555
>>
>> Not related.
>>
>>> 38f2ca83a8e63cc94eaa911ff1c0940c884b5078
>>
>> An optimization.
>>
>>> 5e7cfa5c25672e4478a721eadbd6f6c5b4f88a2f
>>
>> That fall out of that commit is fixed in my series.
>>
>>>>> This commit was followed by several others to "fix
>>>>> the fix". You know how things are, someone proposes a fix, which fi=
xes
>>>>> things for him, but it breaks in the other people configurations (o=
ne of
>>>>> the fallouts was a complete revamp of include/asm-arm/atomic.h for
>>>>> instance).
>>>>>
>>>> I've pushed a series that reverts that commit, then fixes and cleans=
 up
>>>> on top of it. Just pushed if you want to take a look. We can find so=
me
>>>> alternative debugging mechanism independently (though I'm curious to=
 see
>>>> it - it still makes no sense to me).
>>> Since the fix is simply a modification to what we have currently. I
>>> would prefer if we did not remove it. In fact, I think it would be
>>> simpler if we started from what we currently have than reverting past=

>>> patches.
>>
>> Look at the series, it goes step by step to an IMHO clean state. We ca=
n
>> pull out the debugging check removal, though, if you prefer to work on=

>> top of the existing code.
>=20
> From my point of view, Anders looks for something that works, so=20
> following the rules that the minimal set of changes minimize the chance=
s
> of introducing new bugs while cleaning, I would go for the minimal set =

> of changes, such as:

I don't mind where to start, you need to understand the code anyway to
asses any change, may it be a complete rewrite, revert and then rework,
or a combination like below.

>=20
> diff --git a/include/nucleus/sched.h b/include/nucleus/sched.h
> index df56417..8150510 100644
> --- a/include/nucleus/sched.h
> +++ b/include/nucleus/sched.h
> @@ -165,28 +165,27 @@ struct xnsched_class {
>  #endif /* CONFIG_SMP */
> =20
>  /* Test all resched flags from the given scheduler mask. */
> -static inline int xnsched_resched_p(struct xnsched *sched)
> +static inline int xnsched_remote_resched_p(struct xnsched *sched)
>  {
> -	return testbits(sched->status, XNRESCHED);
> +	return !xnarch_cpus_empty(current_sched->resched);
>  }
> =20
> -static inline int xnsched_self_resched_p(struct xnsched *sched)
> +static inline int xnsched_resched_p(struct xnsched *sched)
>  {
>  	return testbits(sched->status, XNRESCHED);
>  }
> =20
>  /* Set self resched flag for the given scheduler. */
>  #define xnsched_set_self_resched(__sched__) do {		\
> -  setbits((__sched__)->status, XNRESCHED);			\
> +  __setbits((__sched__)->status, XNRESCHED);			\
>  } while (0)
> =20
>  /* Set specific resched flag into the local scheduler mask. */
>  #define xnsched_set_resched(__sched__) do {				\
>    xnsched_t *current_sched =3D xnpod_current_sched();			\
> -  setbits(current_sched->status, XNRESCHED);				\
> +  __setbits(current_sched->status, XNRESCHED);				\
>    if (current_sched !=3D (__sched__))	{				\
>        xnarch_cpu_set(xnsched_cpu(__sched__), current_sched->resched);	=
\
> -      setbits((__sched__)->status, XNRESCHED);				\
>    }									\
>  } while (0)
> =20
> diff --git a/ksrc/nucleus/pod.c b/ksrc/nucleus/pod.c
> index 862838c..4cb707a 100644
> --- a/ksrc/nucleus/pod.c
> +++ b/ksrc/nucleus/pod.c
> @@ -276,18 +276,16 @@ EXPORT_SYMBOL_GPL(xnpod_fatal_helper);
> =20
>  void xnpod_schedule_handler(void) /* Called with hw interrupts off. */=

>  {
> -	xnsched_t *sched;
> +	xnsched_t *sched =3D xnpod_current_sched();
> =20
>  	trace_mark(xn_nucleus, sched_remote, MARK_NOARGS);
>  #if defined(CONFIG_SMP) && defined(CONFIG_XENO_OPT_PRIOCPL)
> -	sched =3D xnpod_current_sched();
>  	if (testbits(sched->status, XNRPICK)) {
>  		clrbits(sched->status, XNRPICK);
>  		xnshadow_rpi_check();
>  	}
> -#else
> -	(void)sched;
>  #endif /* CONFIG_SMP && CONFIG_XENO_OPT_PRIOCPL */
> +	xnsched_set_self_resched(sched);
>  	xnpod_schedule();
>  }
> =20
> @@ -2174,7 +2172,7 @@ static inline int __xnpod_test_resched(struct xns=
ched *sched)
>  	int resched =3D testbits(sched->status, XNRESCHED);
>  #ifdef CONFIG_SMP
>  	/* Send resched IPI to remote CPU(s). */
> -	if (unlikely(xnsched_resched_p(sched))) {
> +	if (unlikely(xnsched_remote_resched_p(sched))) {
>  		xnarch_send_ipi(sched->resched);
>  		xnarch_cpus_clear(sched->resched);
>  	}
> diff --git a/ksrc/nucleus/timer.c b/ksrc/nucleus/timer.c
> index 1fe3331..a0ac627 100644
> --- a/ksrc/nucleus/timer.c
> +++ b/ksrc/nucleus/timer.c
> @@ -97,7 +97,7 @@ void xntimer_next_local_shot(xnsched_t *sched)
>  	__clrbits(sched->status, XNHDEFER);
>  	timer =3D aplink2timer(h);
>  	if (unlikely(timer =3D=3D &sched->htimer)) {
> -		if (xnsched_self_resched_p(sched) ||
> +		if (xnsched_resched_p(sched) ||
>  		    !xnthread_test_state(sched->curr, XNROOT)) {
>  			h =3D xntimerq_it_next(&sched->timerqueue, &it, h);
>  			if (h) {
>=20
>=20

This looks correct. The next steps on top would then be
 - avoid local reschedule if only remotes need to be signaled
 - remaining conversions to non-atomic status access
 - UP optimization

Jan


--------------enig272F3CF1BDEF55FA8EFE6230
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.15 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org/

iEYEARECAAYFAkzTS1UACgkQitSsb3rl5xRTqgCgsRw3W8K3SH/MT0hYr6Oosb0F
57sAn2hSmNQQkgJezV+vodlypuLZQ+RN
=OmX+
-----END PGP SIGNATURE-----

--------------enig272F3CF1BDEF55FA8EFE6230--

