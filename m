Message-ID: <44F592AD.2000900@domain.hid>
Date: Wed, 30 Aug 2006 15:29:17 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <b647ffbd0608291228i58bfa3fex5e8f3e18dc0ecc0@domain.hid>	
	<44F49A6C.5050603@domain.hid>
	<b647ffbd0608291334u4182e78bub6d874e252abbbc9@domain.hid>
In-Reply-To: <b647ffbd0608291334u4182e78bub6d874e252abbbc9@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigCB1AA35649820E721FBB6C78"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] Re: [patch, RFC] detect unhandled interrupts
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Dmitry Adamushko <dmitry.adamushko@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigCB1AA35649820E721FBB6C78
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Dmitry Adamushko wrote:
> On 29/08/06, Jan Kiszka <jan.kiszka@domain.hid> wrote:
>>
>> Dmitry Adamushko wrote:
>>
>> I think the additional costs of maintaining an error counter are almos=
t
>> negligible. The test is in the unlikely path, and the first condition
>> already keeps us away from touching the counter.
>=20
>=20
> But it's updated (unhandled =3D 0) any time the ISR(s) report something=

> different from XN_ISR_NONE.  Hence, it's at the beginning of the xnintr=
_t
> structure, hopefully, at the same cache line with other highly-used mem=
bers
> (i.e. isr, cookie and hits).

Mmh, considering this and also the existing code I wonder if we could
optimise this a bit. I'm only looking at xnintr_irq_handler now (sharing
is slow anyway): currently the intr object is touched both before
(naturally...) and after the call to the ISR handler. Maybe we can push
all accesses before the handler for the fast path. E.g.:

int unhandled =3D intr->unhandled;

intr->unhandled =3D 0;
++intr->hits;
s =3D intr->isr(...);

if (s =3D=3D XN_ISR_NONE) {
	intr->unhandled =3D ++unhandled;
	if (unhandled =3D=3D XNINTR_MAX_UNHANDLED)
		ALARM!
}

Jan


--------------enigCB1AA35649820E721FBB6C78
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFE9ZKuniDOoMHTA+kRAvcUAJ4kGRhuTpB/mmH50msZZrZTZ2VV6ACfRKGo
A63E1J8JDIJXtjfMTeY46D8=
=aFLm
-----END PGP SIGNATURE-----

--------------enigCB1AA35649820E721FBB6C78--

