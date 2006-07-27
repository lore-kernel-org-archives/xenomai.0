Message-ID: <44C8C5B0.9080000@domain.hid>
Date: Thu, 27 Jul 2006 15:54:56 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Timer optimisations, continued
References: <448E98A3.6080707@domain.hid> <448E9E8B.70809@domain.hid>	
	<448EA7F7.5000802@domain.hid> <448EB038.8070802@domain.hid>	
	<448EE593.7010809@domain.hid> <448EF022.1040901@domain.hid>	
	<17550.61982.685449.470866@domain.hid>
	<44C6626A.6000304@domain.hid>	 <1153990428.5251.46.camel@domain.hid>	
	<17608.46241.732781.448429@domain.hid>
	<1154006347.4984.2.camel@domain.hid>
In-Reply-To: <1154006347.4984.2.camel@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig2345A3ABDA699CD07D876451"
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
To: rpm@xenomai.org
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig2345A3ABDA699CD07D876451
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Philippe Gerum wrote:
> On Thu, 2006-07-27 at 14:42 +0200, Gilles Chanteperdrix wrote:
>> Philippe Gerum wrote:
>>  > >  o A further improvement should be achievable for scenarios 4 and=
 5 by
>>  > >    introducing absolute xntimers (more precisely: a flag to
>>  > >    differentiate between the mode on xntimer_start). I have an ou=
tdated
>>  > >    patch for this in my repos, needs re-basing.
>>  > >=20
>>  >=20
>>  > Grmblm... Well, I would have preferred that we don't add that kind =
of
>>  > complexity to the nucleus interface, but I must admit that some
>>  > important use cases are definitely better served by absolute timesp=
ecs,
>>  > so I would surrender to this requirement, provided the implementati=
on is
>>  > confined to xnpod_suspend_thread() + xntimer_start().
>>
>> It would be nice if absolute timeouts were also available when using
>> xnsynch_sleep_on. There are a few use cases in the POSIX skin.
>=20
> Makes sense, since xnpod_suspend_thread() and xnsynch_sleep_on() are
> tightly integrated interfaces.
>=20

Anyone any idea how to extend both function interfaces best to
differentiate absolute/relative timeouts? I guess we need an additional
argument to the functions, don't we?

I had the weird idea of using the sign bit of the timeout value for
this. But the potential side effects of halving the absolute time domain
this way scares me.

Jan


--------------enig2345A3ABDA699CD07D876451
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEyMWwniDOoMHTA+kRAjt5AJ0Zv6B4i8Gnhz2P6WQLZwooVP600ACfb/g1
CvH3GOv4M5tPDDMCMAR2jrw=
=QjdX
-----END PGP SIGNATURE-----

--------------enig2345A3ABDA699CD07D876451--

