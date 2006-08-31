Message-ID: <44F7346D.20602@domain.hid>
Date: Thu, 31 Aug 2006 21:11:41 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [patch, RFC] detect unhandled interrupts
References: <b647ffbd0608291228i58bfa3fex5e8f3e18dc0ecc0@domain.hid>
	<1157013092.4359.11.camel@domain.hid>
In-Reply-To: <1157013092.4359.11.camel@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigA58C57251E36518A346B9558"
Sender: jan.kiszka@domain.hid
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
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigA58C57251E36518A346B9558
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Philippe Gerum wrote:
> On Tue, 2006-08-29 at 21:28 +0200, Dmitry Adamushko wrote:
>> Hello,
>>
>> Jan has rised this question initially and I was struggling last week
>> to get his request eventually done :)
>>
>> The main idea is to prevent system lockups when the cross domain IRQ
>> sharing isn't properly used (there were a number of reports recently).=

>>
>> So here is an initial patch as well as some related critics (yep, I
>> critisize my own patch).
>=20
> [...]
>=20
> Applied, thanks.
>=20

Unless I'm currently doing something completely wrong, it looks like it
doesn't work as it should. :(

I attached a xeno_16550A to the Ethernet NIC's IRQ line and opened the
serial port - lock-up.

Ok, and now I enabled shared IRQ support:

kernel/xenomai/nucleus/intr.c: In function 'xnintr_irq_handler':
kernel/xenomai/nucleus/intr.c:399: error: 'xnintr_t' has no member named
'unhandled'
kernel/xenomai/nucleus/intr.c:404: error: 'xnintr_t' has no member named
'unhandled'

Looks like our patch review failed... :-/

Jan


--------------enigA58C57251E36518A346B9558
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFE9zRtniDOoMHTA+kRAk1qAJ46RZCv2tFnDENAvS7iF3Jv169kxwCfVJl4
4tpOZjzg3wYpRJ+rK9aVD58=
=IPS4
-----END PGP SIGNATURE-----

--------------enigA58C57251E36518A346B9558--

