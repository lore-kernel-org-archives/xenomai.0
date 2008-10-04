Message-ID: <48E7A71A.3040304@domain.hid>
Date: Sat, 04 Oct 2008 19:25:46 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <48E76494.9030901@domain.hid> <48E778B3.8040004@domain.hid>
	<48E77F57.9010604@domain.hid> <48E78101.6070101@domain.hid>
In-Reply-To: <48E78101.6070101@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig5E6BB1D21E80F37AEA8B9051"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] gdb lockup on multi-threaded process exit
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
--------------enig5E6BB1D21E80F37AEA8B9051
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Gilles Chanteperdrix wrote:
> Jan Kiszka wrote:
>> Gilles Chanteperdrix wrote:
>>> Jan Kiszka wrote:
>>>> Hi,
>>>>
>>>> I'm banging my head against this issue for several days now, first
>>>> trying to sort out an unrelated bug I also came across at this chanc=
e,
>>>> then trying to understand what happens, and finally getting mad abou=
t
>>>> why this may only happen with Xenomai:
>>> I have not tried to understand your problem (yet). But do you happen =
to
>>> work with the latest TASK_ATOMICSWITCH changes? If yes, could you try=
 to
>>> revert them?
>> Yes, I'm on latest trunk. During my debug endeavour, I haven't seen th=
is
>> task state being involved. Also, if I got this correctly, it only
>> concerns the secondary->primary migration, and that one appears to be
>> out of scope here. Nevertheless, it's easy to verify if you tell me
>> which revision(s) I should revert.
>=20
> Should be:
> 4bc557d998f7cfac0a069d0c47e28510ef270cb2
> and:
> acaccc82ead113f33f8f717fdafea14dba8b885d
>=20

OK, I simply went back to 2.0-09 (I think I was there originally when
the bug showed up), but the effect remains the same.

Jan


--------------enig5E6BB1D21E80F37AEA8B9051
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAkjnpyMACgkQniDOoMHTA+kI0gCfctPXxDn+R68TEk7alsXpUT9H
AScAn2XIdZY05sSmydY/vR3S8OI0ocs3
=U+9N
-----END PGP SIGNATURE-----

--------------enig5E6BB1D21E80F37AEA8B9051--

