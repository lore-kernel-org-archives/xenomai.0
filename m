Message-ID: <462CAEE7.8030509@domain.hid>
Date: Mon, 23 Apr 2007 15:04:39 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <46265FC8.1070207@domain.hid>	<1176926837.5010.90.camel@domain.hid>	<46268879.30507@domain.hid>	<462C7DF4.9060002@domain.hid>	<1177324208.30217.98.camel@domain.hid>	<17964.35957.487976.245056@domain.hid>
	<17964.36864.695360.167360@domain.hid>
	<462CAB3B.9080408@domain.hid> <462CADFB.40008@domain.hid>
In-Reply-To: <462CADFB.40008@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig4D6C17F1064D9455821C9D18"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] [BUG] target width of shifts on 64 bits
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
--------------enig4D6C17F1064D9455821C9D18
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Gilles Chanteperdrix wrote:
> Jan Kiszka wrote:
>> Who the hell is using the ffnz implementation in system.h? The
>> simulator? I kicked it out for a x64-build here, and I got no noticeab=
le
>> effects.
>=20
> No, the simulator uses the one in asm-sim/system.h. The one in
> nucleus/system.h is, for instance, for xnmlqueue_t in user-space.
>=20

Thus a removable UVM remainder? At least this ffs/ffsl issue doesn't
explain my scheduling problem.


--------------enig4D6C17F1064D9455821C9D18
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGLK7nniDOoMHTA+kRApThAJoDHQDtjPmTImwKUcnkYoanaGaFrACfemCY
Eik0V9aYbKoMq9M4P29SDHE=
=FkQ7
-----END PGP SIGNATURE-----

--------------enig4D6C17F1064D9455821C9D18--

