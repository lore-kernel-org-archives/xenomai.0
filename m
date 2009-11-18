Message-ID: <4B047FB4.7010509@domain.hid>
Date: Thu, 19 Nov 2009 00:13:56 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4B042121.2050509@domain.hid>	<1258562983.2348.168.camel@domain.hid>	<4B042B0F.2080003@domain.hid>	<1258564904.2348.170.camel@domain.hid>	<4B042E1C.40505@domain.hid>
	<4B0430E6.30304@domain.hid>
	<1258566503.2348.178.camel@domain.hid>
	<4B047EF3.4060904@domain.hid>
In-Reply-To: <4B047EF3.4060904@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig7962E434DAEDD0D381DB1BCF"
Sender: jan.kiszka@domain.hid
Subject: Re: [Adeos-main] [PATCH] x86: Move ipipe_suspend_domain out of
	IRQ-disabled section
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: adeos-main <adeos-main@gna.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig7962E434DAEDD0D381DB1BCF
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Jan Kiszka wrote:
> Philippe Gerum wrote:
>> On Wed, 2009-11-18 at 18:37 +0100, Jan Kiszka wrote:
>>> Jan Kiszka wrote:
>>>> Philippe Gerum wrote:
>>>>> On Wed, 2009-11-18 at 18:12 +0100, Jan Kiszka wrote:
>>>>>> This fixes the valid complaint about safe_halt being called with t=
he
>>>>>> root domain unstalled.
>>>>> The fix should go to the caller. ipipe_suspend_domain() acts as a
>>>>> logical barrier: after that point, you may assume that the current
>>>>> domain is unstalled.
>>>> The caller so far expect to find no interruption window between retu=
rn
>>>> from ipipe_suspend_domain and yet another local_irq_disable. It expe=
cts
>>>> to remain stalled all the time until safe_halt.
>>> Checked again: Opening the IRQ window here is bogus, may cause
>>> rescheduling delays to Linux (if not much worse things).
>>>
>>> I suppose it's better to adjust the assumption that ipipe_suspend_dom=
ain
>>> behaves like "sti; hlt". Are there users that rely on this?
>>> __ipipe_walk_pipeline does not look like it would.
>> I chose to never apply the mantra "never care for out of tree code" fo=
r
>> Adeos, granted, at the expense of quite a lot of headaches, but that
>> layer is a standalone building block which exports a stable API since
>> years.
>>
>> I may revert that decision in a foreseeable future, when X3 starts
>> notably. But I'm still reluctant to break such a significant assumptio=
n
>> in the current patch series.
>>
>> I would rather move ipipe_suspend_domain() out of the atomic section o=
n
>> x86 (granted, this should be done carefully if ever possible).
>=20
> Likely feasible. The good news is I missed the fact that there is
> another check for needs_resched later on, right before the actual halt.=

> So the problem should be curable by moving ipipe_suspend_domain, at
> least on x86.
>=20
> Jan
>=20
> -------->
>=20
> x86: Move ipipe_suspend_domain out of IRQ-disabled section
>=20
> ipipe_suspend_domain reenables IRQs on return, so we have to move it
> before the point where the kernel disables it for halt.
>=20
> This fixes the valid complaint about safe_halt being called with the
> root domain unstalled.
>=20
> Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>
> ---
>  arch/x86/kernel/process_32.c |    3 ++-
>  arch/x86/kernel/process_64.c |    4 +++-
>  2 files changed, 5 insertions(+), 2 deletions(-)
>=20
> diff --git a/arch/x86/kernel/process_32.c b/arch/x86/kernel/process_32.=
c
> index a8a5cd1..e31de9e 100644
> --- a/arch/x86/kernel/process_32.c
> +++ b/arch/x86/kernel/process_32.c
> @@ -111,10 +111,11 @@ void cpu_idle(void)
>  			if (cpu_is_offline(cpu))
>  				play_dead();
>=20
> +			ipipe_suspend_domain();
> +
>  			local_irq_disable();
>  			/* Don't trace irqs off for idle */
>  			stop_critical_timings();
> -  			ipipe_suspend_domain();
>  			pm_idle();
>  			start_critical_timings();
>  		}
> diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.=
c
> index 02efd18..b30dc4d 100644
> --- a/arch/x86/kernel/process_64.c
> +++ b/arch/x86/kernel/process_64.c
> @@ -136,6 +136,9 @@ void cpu_idle(void)
>=20
>  			if (cpu_is_offline(smp_processor_id()))
>  				play_dead();
> +
> +			ipipe_suspend_domain();
> +
>  			/*
>  			 * Idle routines should keep interrupts disabled
>  			 * from here on, until they go to idle.
> @@ -145,7 +148,6 @@ void cpu_idle(void)
>  			enter_idle();
>  			/* Don't trace irqs off for idle */
>  			stop_critical_timings();
> -  			ipipe_suspend_domain();
>  			pm_idle();
>  			start_critical_timings();
>  			/* In many cases the interrupt that ended idle
>=20

Oops, forgot to switch off line wrapping. You can pull from

git://git.kiszka.org/ipipe-2.6.git queues/2.6.31-x86

instead.

Jan


--------------enig7962E434DAEDD0D381DB1BCF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAksEf7QACgkQitSsb3rl5xQHewCfXdYEY1hAcUMcE5JQKCl0Hx1X
Oa8AoJY752bsXcWdKRFYQ6ZNKe5GfSti
=BvBa
-----END PGP SIGNATURE-----

--------------enig7962E434DAEDD0D381DB1BCF--

