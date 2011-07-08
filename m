Message-ID: <4E16F4E0.8020900@domain.hid>
Date: Fri, 08 Jul 2011 14:15:28 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4E160578.5020405@domain.hid> <4E16F032.1050905@domain.hid>
In-Reply-To: <4E16F032.1050905@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig544CCE69B16BD1CBDF5DD013"
Sender: jan.kiszka@domain.hid
Subject: Re: [Adeos-main] [PATCH] ipipe: Prevent unwritable pages after
	mprotect
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/options/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: adeos-main <adeos-main@gna.org>, Philippe Gerum <rpm@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig544CCE69B16BD1CBDF5DD013
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 2011-07-08 13:55, Gilles Chanteperdrix wrote:
> On 07/07/2011 09:14 PM, Jan Kiszka wrote:
>> From: Jan Kiszka <jan.kiszka@domain.hid>
>>
>> Page protection changes issued via mprotect, e.g. to enable executable=

>> stacks, cause spurious minor faults as they remove the write permissio=
n
>> from the modified range again. Avoid this by faking shared pages so th=
at
>> vm_get_page_prot returns the desired page permissions.
>=20
> This looks dangerous to me. Have you checked that write to private heap=
s
> will not end up corrupting shared data?

Can't follow this yet.

If you check the comment on protection_map in mm/mmap.c, the difference
between private and shared is in real write vs. COW-able write. That's
what my patch is exploiting to get the proper arch-dependent page
protection bits.

Are you aware of side effects or do you know a better way to inject
write permissions into the protection flags?

Jan


--------------enig544CCE69B16BD1CBDF5DD013
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.15 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk4W9OIACgkQitSsb3rl5xTxbACgvV5UKTNUiSUfcQoKrNb/9p6I
yaUAn0Gi5hU2ytJVu+ktLNdczE4CX6Es
=hmkz
-----END PGP SIGNATURE-----

--------------enig544CCE69B16BD1CBDF5DD013--

