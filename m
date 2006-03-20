Message-ID: <441EB558.9040408@domain.hid>
Date: Mon, 20 Mar 2006 14:59:52 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] rtdm_event_timedwait hang-up
References: <200603201434.15258@domain.hid>
In-Reply-To: <200603201434.15258@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig25263457032D9BFCDEEAE48E"
Sender: jan.kiszka@domain.hid
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Petr Cervenka <grugh@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig25263457032D9BFCDEEAE48E
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Petr Cervenka wrote:
> Hello,
> I'm trying to port a  driver of a AD card to RTDM.
> When I use rtdm_event_timedwait in IOCTL handler (called from NRT user =
app), the system will hang-up immediately.
> Does it have something to do with: https://mail.gna.org/public/xenomai-=
help/2006-03/msg00035.html
> , ie. it's not possible to call wait /caller blocking functions from no=
n-real-time, is it?

Yep, that's exactly the point, it's an illegal usage.

And the fact that this still causes a crash instead of some more
graceful failure reminds me of one reason why I asked for the new
XENO_ASSERT macro: adding debug checks for such mistakes to RTDM.

> Is there a posibility to do some workaround to solve this or other alte=
rnative. I need to wait couple of seconds for IRQ from device.

A) turn the waiter into a xenomai shadow thread, even if it will wait
for several seconds without hard timing constraints (use priority 1 e.g.)=


B) signal the event arrival via rtdm_nrtsig to a Linux handler which
could in turn wake up a non-RT waiter blocking on standard Linux
wait_queue or so

The latter options involves more work and code and should only be picked
if A) is really not desired.

>=20
> My configuration: kernel-2.6.15.6, adeos-ipipe-2.6.15-i386-1.2-01, xeno=
mai-2.1.0
> Thanks for any help
>=20
> Petr Cervenka
>=20

Jan


--------------enig25263457032D9BFCDEEAE48E
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEHrVYniDOoMHTA+kRAgq/AJ4nZj8RIfbMnATJLDVlbJQ2qgVnfwCeLNw9
sxAF4nTJt3vmTbS89PNVZFE=
=89Lz
-----END PGP SIGNATURE-----

--------------enig25263457032D9BFCDEEAE48E--

