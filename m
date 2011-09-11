Message-ID: <4E6CC5CC.5020204@domain.hid>
Date: Sun, 11 Sep 2011 16:29:32 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4E6C927F.3070901@domain.hid> <4E6CC49C.1020403@domain.hid>
In-Reply-To: <4E6CC49C.1020403@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigA764E6BF28C6B0CF6145F3A6"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] Policy switching and XNOTHER maintenance
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigA764E6BF28C6B0CF6145F3A6
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 2011-09-11 16:24, Gilles Chanteperdrix wrote:
> On 09/11/2011 12:50 PM, Jan Kiszka wrote:
>> Hi all,
>>
>> just looked into the hrescnt issue again, specifically the corner case=

>> of a shadow thread switching from real-time policy to SCHED_OTHER.
>=20
> Doing this while holding a mutex looks invalid.

Looking at POSIX e.g., is there anything in the spec that makes this
invalid? If the kernel preserves or established proper priority
boosting, I do not see what could break in principle.

It is nothing I would design into some app, but we should somehow handle
it (doc update or code adjustments).

> If we do not do it, the current code is valid.

Except for its dependency on XNOTHER which is not updated on RT->NORMAL
transitions.

Jan



--------------enigA764E6BF28C6B0CF6145F3A6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.16 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk5sxdAACgkQitSsb3rl5xTYqwCg1thcQ/IEripfT/N/hHfj5KX5
UsIAmgKwBGqAn3wb1zJbT9vNJs9jI3x1
=TuWj
-----END PGP SIGNATURE-----

--------------enigA764E6BF28C6B0CF6145F3A6--

