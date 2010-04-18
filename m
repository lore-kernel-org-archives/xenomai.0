Message-ID: <4BCB4138.8080105@domain.hid>
Date: Sun, 18 Apr 2010 19:28:24 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <cover.1271596366.git.Jan Kiszka
	jan.kiszka@domain.hid>	<ef0950a3fd1a8df178c2cf683187895ec74c45b7.1271596367.git.Jan	Kiszka
	jan.kiszka@domain.hid> <4BCB3EE7.8040801@domain.hid>
In-Reply-To: <4BCB3EE7.8040801@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig3293E32D0235E6832008A55D"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] [PATCH v3 23/24] RTDM: Early fd release with
 poll-free context reference tracking
List-Id: Xenomai life and development <xenomai.xenomai.org>
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
--------------enig3293E32D0235E6832008A55D
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Gilles Chanteperdrix wrote:
> Jan Kiszka wrote:
>> From: Jan Kiszka <jan.kiszka@domain.hid>
>>
>> Two changes in one as they are tightly related: Once close is called,
>> remove the file descriptor from open table, allowing its reuse while
>> close for the previous user proceeds.
>>
>> The second and major part of the patch avoids time-based polling while=

>> waiting for context references to be dropped. This specifically helps =
in
>> scenarios where references can be held for a longer time beyond the
>> first close.
>=20
> A few set_bit and clear_bit with an xnlock locked. Could not these been=

> replaced with __set_bit/__clear_bit in UP?
>=20

used_fildes: yes
context_flags: no (drivers may manipulated them as well)

Will add a corresponding patch to the next round.

Jan


--------------enig3293E32D0235E6832008A55D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAkvLQTgACgkQitSsb3rl5xSrkQCgg3eHTJv29CDoxXMr+E+1QdZx
twYAn1fGbXAEpDiqI2EFMix1bJ7VIc8q
=pAhX
-----END PGP SIGNATURE-----

--------------enig3293E32D0235E6832008A55D--

