Message-ID: <456332AF.8010106@domain.hid>
Date: Tue, 21 Nov 2006 18:09:03 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [PATCH 1/3] decouple spinlock stats
	from	XENO_OPT_STATS
References: <456236D2.3050402@domain.hid> <45632BFA.30000@domain.hid>
In-Reply-To: <45632BFA.30000@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig4787C0D6422676419B8553FC"
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
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig4787C0D6422676419B8553FC
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Gilles Chanteperdrix wrote:
> Jan Kiszka wrote:
>>  #ifdef CONFIG_XENO_SPINLOCK_DEBUG
>> @@ -343,7 +340,7 @@ static inline spl_t __xnlock_get_irqsave
>>  #else /* !CONFIG_XENO_SPINLOCK_DEBUG */
>>  static inline spl_t __xnlock_get_irqsave (xnlock_t *lock)
>>  {
>> -#endif /* !CONFIG_XENO_SPINLOCK_DEBUG */
>> +#endif /* CONFIG_XENO_SPINLOCK_DEBUG */
>=20
> I prefer the notation:
>=20
> #if cond
> #endif /* cond */
>=20
> and
>=20
> #if cond
> #else /* !cond */
> #endif /* !cond */
>=20
> to
>=20
> #if cond
> #endif /* cond */
>=20
> and
>=20
> #if cond
> #else /* !cond */
> #endif /* cond */
>=20
> Because in the first case, when I see a #endif in the middle of a lot o=
f
> code, I immediately know what predicate is true above the #endif.
>=20

Ok, I understand the logic. Nevertheless, I had the impression the first
scheme is used far more often than the second one in Xenomai and I-pipe,
so I took the chance to consolidate the code.

So, what should be the common rule from now on? Is there a kernel-style
rule for this issue we should follow, or are we free and should convert
to your preferred scheme?

Jan


--------------enig4787C0D6422676419B8553FC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFYzKwniDOoMHTA+kRAuyaAJ9xN3tnhAFUMFjfpYjkj+Zr2QHq5wCeI1iy
iKwFRvvw9BAVVXieXj85qY4=
=Xlby
-----END PGP SIGNATURE-----

--------------enig4787C0D6422676419B8553FC--

