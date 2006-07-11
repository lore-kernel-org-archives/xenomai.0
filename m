Message-ID: <44B341E2.9040506@domain.hid>
Date: Tue, 11 Jul 2006 08:14:58 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Sychronize between Linux and Xenomai domain
References: <4546494d0607092316s7dbc7406j2436714deccbfb91@domain.hid>	
	<44B1FDBD.4060600@domain.hid>	
	<4546494d0607100148s1f5476e3tb3f58d7ae48d4a72@domain.hid>	
	<44B218C5.9000804@domain.hid>	
	<4546494d0607100231x469aa596s2513e5b36cad8550@domain.hid>	
	<44B2216A.1060904@domain.hid>
	<4546494d0607102125w2817ccd1j746651214cac3a6d@domain.hid>
In-Reply-To: <4546494d0607102125w2817ccd1j746651214cac3a6d@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigAF991AA41CBEED288F16CFF3"
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
To: "Li Yi (Adam)" <liyiadam@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigAF991AA41CBEED288F16CFF3
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Li Yi (Adam) wrote:
> Hi Jan,
>=20
> Sometimes there is situation to  protect a  Non-real time task in kerne=
l
> space NOT to be interrupted by Xenomai task.
> Is disabling HW interrupt the only way? Can I stall Xenomai Domain from=


Think of SMP as well (ok, blackfin is UP so far, right? :)): you need
IRQ lock + some spinlock that is acquired in the IRQ handler(s) as well,
thus you end up with that rtdm_lock_t again.

> handling interrupt while let the Linux domain
> handle interrupt normally?

Stalling (i.e. preventing IRQ delivery) higher prio domains (like
Xenomai) implicitly means stalling all lower prio ones (including
Linux): No, this is not possible. You might prevent rescheduling by
setting the scheduler lock of Xenomai, but this still doesn't protect
from IRQs.

Jan


--------------enigAF991AA41CBEED288F16CFF3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFEs0HnniDOoMHTA+kRAtzkAJ4lX13ZpFmNEsnBbI9wwMs4mysBKACfYyBe
yHWMQ+e7hdrMTmO4whHqKA4=
=XVA1
-----END PGP SIGNATURE-----

--------------enigAF991AA41CBEED288F16CFF3--

