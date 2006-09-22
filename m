Message-ID: <4513F625.9010709@domain.hid>
Date: Fri, 22 Sep 2006 16:41:41 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] 	[PATCH, RFC] Make ioremap'ed memory available
	through	rtdm_mmap_to_user()
References: <1158337583.13530.20.camel@domain.hid>	
	<450AD766.3000307@domain.hid>
	<1158613987.31164.9.camel@domain.hid>	
	<45100DF6.8030209@domain.hid>
	<1158914149.14421.10.camel@domain.hid>	
	<4513A5D0.3040507@domain.hid>
	<1158924874.19558.6.camel@domain.hid>
In-Reply-To: <1158924874.19558.6.camel@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig2DD94CF992D901FF506D1691"
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
To: Stelian Pop <stelian.pop@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig2DD94CF992D901FF506D1691
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Stelian Pop wrote:
> Le vendredi 22 septembre 2006 =E0 10:58 +0200, Jan Kiszka a =E9crit :
>=20
>>> 	d) make a special rtdm_mmap_iomem_to_user() function...
>> Also an option. Specifically, it wouldn't break the existing API... Wh=
at
>> about rtdm_iomap_to_user? Would you like to work out a patch in this
>> direction?
>=20
> Here it comes.

Your patch looks very good. Assuming that you have tested it
successfully, I'm going to merge it soon.

Thanks,
Jan


--------------enig2DD94CF992D901FF506D1691
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFE/YlniDOoMHTA+kRAgjyAJ9m96xgF7BPWYVAam0fEE/liYAmPwCfXxrY
x7gBFEeTfB0aEL9V3ykZLws=
=rP8F
-----END PGP SIGNATURE-----

--------------enig2DD94CF992D901FF506D1691--

