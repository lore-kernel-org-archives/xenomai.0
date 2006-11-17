Message-ID: <455E0940.7070705@domain.hid>
Date: Fri, 17 Nov 2006 20:10:56 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <DD39B5C3F4963040ADC9768BE7E430CB0154E8D7@domain.hid>	
	<1163784779.4980.47.camel@domain.hid> <455E025B.5030906@domain.hid>
	<1163790315.4980.73.camel@domain.hid>
In-Reply-To: <1163790315.4980.73.camel@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig1FEB2F9E0F2F681D4E78B5FE"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] Re: XENO_OPT_DEBUG impact
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
--------------enig1FEB2F9E0F2F681D4E78B5FE
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Philippe Gerum wrote:
> On Fri, 2006-11-17 at 19:41 +0100, Jan Kiszka wrote:
>> I'm currently seeing two potential "misuses" of the common switch:
>>
>>  - the posix skin (Gilles, how heavy-weighted are those checks?)
>>    =3D> CONFIG_XENO_OPT_DEBUG_POSIX
>>
>>  - CONFIG_XENO_SPINLOCK_DEBUG =3D> CONFIG_XENO_OPT_DEBUG_SPINLOCK
>>
>> Both should be explicitly controllable in Kconfig.
>>
>=20
> Nack for CONFIG_XENO_OPT_DEBUG_SPINLOCK. Most of the issue we tracked
> with Gilles regarding the domain migration code had side-effects on the=

> nucleus lock. So having CONFIG_XENO_OPT_DEBUG enabled for identifying
> internal state weirdnesses - like those triggered by migration bugs -
> implies enabling the spinlock watchdogs too.

Ok, if it only makes sense to have both enabled at the same time, then
let us create XENO_OPT_DEBUG_NUCLEUS. It should include both, but it
shall not be automatically on when, say, only XENO_OPT_DEBUG_RTDM is
required.

Jan


--------------enig1FEB2F9E0F2F681D4E78B5FE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFXglAniDOoMHTA+kRAjXuAKCA6XHnHS/IhpLU2+0jNDBZpQZJVQCeO4Pj
H3CoE/ygBZlEz3mmaG0O1yg=
=SULV
-----END PGP SIGNATURE-----

--------------enig1FEB2F9E0F2F681D4E78B5FE--

