Message-ID: <44719697.4080408@domain.hid>
Date: Mon, 22 May 2006 12:46:47 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] timer optimisations
References: <44717FBA.1030207@domain.hid> <447188F9.60905@domain.hid>
In-Reply-To: <447188F9.60905@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigB50E7A7C9422687A85D01F51"
Sender: jan.kiszka@domain.hid
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigB50E7A7C9422687A85D01F51
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Philippe Gerum wrote:
> Jan Kiszka wrote:
>> Hi,
>>
>> while I originally only wanted to add timer abstraction to RTDM, I now=

>> have patch series for xntimer pending on my box pushing this layer
>> closer to hrtimer.
>>
>> But before posting it for discussion (needs further testing anyway), I=

>> have two questions regarding some minor though not totally uninteresti=
ng
>> optimisation possibilities:
>>
>> 1. Is calling xntimer_start() with value=3DXN_INFINITE a real use case=
?
>>    It's not documented explicitly. The effect of such an invocation
>>    looks a bit like xntimer_stop(), but I didn't find a real caller so=

>>    far to asses it's relevance.
>=20
> xnpod_start_timer() uses this property to start the host tick relay
> timer. If XNARCH_HOST_TICK is zero, then no relay is required, and the
> timer should remain passive.

I see, but there is likely some other way to achieve this.

The point I'm having in mind is heavy usage of xntimer_start, e.g. from
inside some timer handler. RTnet could become such a user one day when
we may migrate the TDMA scheduler from thread context to a timer handler.=


>=20
>>
>>    If it is not used and could rather be declared illegal, we could sa=
fe
>>    the related code in the do_timer_start handlers.
>>
>=20
> Dunno. To do that, we would need to carefully inspect each and every
> caller, especially for the various skins, which implies to analyze the
> requirements of the mimicked API too.

For sure, but we will have to review and test some stuff anyway with my
patches. :)

>=20
>> 2. rthal_timer_program_shot() uses explicit rthal_local_irq_save_hw on=

>>    ia64 and i386. Given the head optimisation, IRQs should already be
>>    disabled when calling this service. So, can this IRQ masking be mad=
e
>>    depending on !CONFIG_XENO_OPT_PIPELINE_HEAD?
>>
>=20
> Yes.

Ok, will get integrated.

Jan


--------------enigB50E7A7C9422687A85D01F51
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEcZaXniDOoMHTA+kRAokPAJwPOYQckeo7pAS5zD/C1Rc76mkjVQCfXq6e
Y/ACik5dnZ63i9o6PI3ybDg=
=Ko24
-----END PGP SIGNATURE-----

--------------enigB50E7A7C9422687A85D01F51--

