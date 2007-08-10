Message-ID: <46BC4ED9.6000909@domain.hid>
Date: Fri, 10 Aug 2007 13:41:13 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <46BC1160.6040109@domain.hid>
	<2ff1a98a0708100246q6f136ce3u99ed8378d47726aa@domain.hid>
In-Reply-To: <2ff1a98a0708100246q6f136ce3u99ed8378d47726aa@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig6D1D83214975F88EDC6D3D77"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] [PATCH] fix doxygen complaints
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
--------------enig6D1D83214975F88EDC6D3D77
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Gilles Chanteperdrix wrote:
>> -/*!
>> - * \fn int rthal_timer_request(void (*tick_handler) (void), void (*mo=
de_emul)(int mode, void *tdev), int (*tick_emul)(unsigned long delay, voi=
d *tdev), int cpu)
>> +/**
>> + * \fn int rthal_timer_request(void (*tick_handler)(void),
>> + *             void (*mode_emul)(enum clock_event_mode mode, struct i=
pipe_tick_device *tdev),
>> + *             int (*tick_emul)(unsigned long delay, struct ipipe_tic=
k_device *tdev), int cpu)
>=20
> Doxygen does not like when the function arguments are not on one line.
> At least some version that was used in the past.
>=20

Hmm, I was using Doxygen 1.5.0 here, and there were neither complaints
during compile-time nor obvious quirks in the output. Maybe this issue
got fixed in the meantime. What was the precise effect?

Jan


--------------enig6D1D83214975F88EDC6D3D77
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGvE7ZniDOoMHTA+kRAgRgAJ4gAmELBE2sCmGgMJZc5fzlKx1UXQCeObaT
NPgTyuTpQ1Zz+pehOAs09DI=
=TV25
-----END PGP SIGNATURE-----

--------------enig6D1D83214975F88EDC6D3D77--

