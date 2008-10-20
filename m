Message-ID: <48FC440E.90000@domain.hid>
Date: Mon, 20 Oct 2008 10:40:46 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <48F9F12F.7090708@domain.hid>	<48FB15A8.30703@domain.hid>	<48FB17BD.7010904@domain.hid>	<48FB1891.3060609@domain.hid>
	<48FB19F7.1030107@domain.hid>	<48FB5BD5.1060205@domain.hid>
	<48FB5F1C.401@domain.hid> <48FC405E.8010603@domain.hid>
In-Reply-To: <48FC405E.8010603@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigA1DB470BF3582A6419C50279"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] [PATCH 1/1] Use SIGWINCH to trigger
 priority	change in user-space.
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
Cc: Xenomai core <Xenomai-core@domain.hid>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigA1DB470BF3582A6419C50279
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Gilles Chanteperdrix wrote:
> Gilles Chanteperdrix wrote:
>> Philippe Gerum wrote:
>>> Well, what about merging the solutions: trap the signal from the libr=
ary
>>> constructor by default for people relying on #1, AND document the sha=
dow signal
>>> handler for people who can do #2?
>> For me, merging the two, would mean keep sigshadow_install called upon=

>> thread creation, but export xeno_sigwinch_handler to be callable from
>> user signals.
>>
>> This way, if people install their signal handler before the first thre=
ad
>> creation, they have nothing to worry about. If they install their sign=
al
>> handler at a later time, they have to take care of calling
>> xeno_sigwinch_handler and look at its return value.
>=20
> Jan, do you agree? The main argument is that people may use third-party=

> libraries such as, say, libreadline or libqt which intercept the
> SIGWINCH signal, and that we do not want to recompile these libraries t=
o
> run with Xenomai.

Yes, I'm fine with the current approach + doc + xeno_sigwinch_handler.

Jan


--------------enigA1DB470BF3582A6419C50279
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAkj8RBUACgkQniDOoMHTA+nm0ACdEh1boVZt703tSOUIaXVW0SPu
Gn0AnRe4BGvie29q6inrz74k6PfIZa1j
=LIKZ
-----END PGP SIGNATURE-----

--------------enigA1DB470BF3582A6419C50279--

