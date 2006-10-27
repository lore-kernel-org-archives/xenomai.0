Message-ID: <454232CE.3010206@domain.hid>
Date: Fri, 27 Oct 2006 18:24:46 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] enable/disable all interrupts from user space
References: <45420A72.8000700@domain.hid> <200610271108.14937.jweber@domain.hid>
In-Reply-To: <200610271108.14937.jweber@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig2D2A697A8A7D6FA97A785C8E"
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
To: Jeff Weber <jweber@domain.hid>
Cc: Xenomai Help <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig2D2A697A8A7D6FA97A785C8E
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Jeff Weber wrote:
> Thanks Jan.
>=20
> Another thought: is there a direct Adeos  call to enable/disable all=20
> interrupts, with nesting from user space?

Not yet, but that would be one option for the scenario I described.

>=20
> I'm porting some legacy RTAI code to the Xenomai native skin.  The RTAI=
 code=20
> has rtai_save_flags_and_cli()/rtai_restore_flags() for enabling/disabli=
ng all=20
> interrupts  direct from user space, with capability to handle nested ca=
lls. =20

You can use even more assembly magic in user-space for now:

#define local_irq_save(x) \
	__asm__ __volatile__("pushfl; popl %0; cli":"=3Dg" (x)::"memory")

#define local_irq_restore(x) \
	__asm__ __volatile__("pushl %0; popfl": :"g" (x):"memory", "cc")

Hope your RTAI code takes care of SMP as well (or excludes the execution
on such boxes).

>=20
> Yes, please add this to the native skin "wish list", along with a nesti=
ng=20
> capability.

Won't you? =3D> http://www.xenomai.org/wiki/index.php/TaskMarket

Ideas and requests on the mailing list are starting become volatile with
the increasing traffic we see...

Jan


--------------enig2D2A697A8A7D6FA97A785C8E
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFQjLOniDOoMHTA+kRAixsAJ9ebQqhaq10S2uFivg5nI2SEwbuCwCdGjOg
q1wXUn3wEituwjdnLxQq3OM=
=cM/P
-----END PGP SIGNATURE-----

--------------enig2D2A697A8A7D6FA97A785C8E--

