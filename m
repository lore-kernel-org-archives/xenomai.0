Message-ID: <46924E04.7080803@domain.hid>
Date: Mon, 09 Jul 2007 17:02:28 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <46924A1A.4010909@domain.hid>	
	<1183992374.6014.84.camel@domain.hid> <46924B1B.1010308@domain.hid>
	<1183993194.6014.87.camel@domain.hid>
In-Reply-To: <1183993194.6014.87.camel@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig276CE2DB508325C0E05C41B3"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] [PATCH] __deprecated not defined for Linux 2.4
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
--------------enig276CE2DB508325C0E05C41B3
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Philippe Gerum wrote:
> On Mon, 2007-07-09 at 16:50 +0200, Jan Kiszka wrote:
>> Philippe Gerum wrote:
>>> On Mon, 2007-07-09 at 16:45 +0200, Wolfgang Grandegger wrote:
>>>> Hello,
>>>>
>>>> the attached patch changes:
>>>>
>>>>    2007-07-09  Wolfgang Grandegger  <wg@domain.hid>
>>>>
>>>>   * include/asm-generic/wrappers.h: add  __deprecated for Linux 2.4.=

>>>>
>>> Merged, thanks.
>> You are too fast for me - I was still test-building my approach!
>>
>> Looks rather like I picked the wrong expression for marking
>> rtdm_task_sleep_until deprecated. I would prefer to go for this varian=
t
>> and back Wolfgang's patch out again:
>=20
> __deprecated is going to be useful in backporting 2.6 stuff to 2.4. Thi=
s
> is not only a RTDM issue.

No problem, as you like it.

Jan


--------------enig276CE2DB508325C0E05C41B3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGkk4EniDOoMHTA+kRAqzmAJ9HMIDNYDdh/EpFikRwVygPOFlGZQCfVuUu
iZFBhJtlflLUm4vtWXDaeNY=
=jYej
-----END PGP SIGNATURE-----

--------------enig276CE2DB508325C0E05C41B3--

