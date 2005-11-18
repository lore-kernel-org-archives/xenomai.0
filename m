Message-ID: <437DD08E.1020202@domain.hid>
Date: Fri, 18 Nov 2005 14:01:02 +0100
From: Jan Kiszka <kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] v2.1 status
References: <437CB8BA.8040902@domain.hid>
In-Reply-To: <437CB8BA.8040902@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig92D15F878460C6526341E107"
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig92D15F878460C6526341E107
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Philippe Gerum wrote:
>=20
> Here is an update regarding the way things progress on the v2.1 branch:=

>=20
> o The build system has been deeply revamped, so that we now fully leave=

> the burden of building Xenomai's kernel support to Linux. To this end,
> the code tree has been reorganized in two major sections, the first one=

> contains the kernel-related sources (ksrc/), the other is hosting the
> user-space support (src/). Since the user-space portion does not need t=
o
> know about the kernel sources anymore, several issues have been solved
> in the same move. All in all, things are way simpler than before, which=

> seems to indicate that we are heading to the right direction. The
> documentation for the installation process needs to be updated though.
>=20
> o Also as a matter of build system (and a bit more), v2.1 has been
> backported to Linux 2.4, starting with the ppc32 support. We rely on
> Denx's 2_4-devel tree as our 2.4 kernel of reference for this port [1].=

> A second backport to 2.4/x86 will happen when this combo is I-pipe
> ready. We are ahead of schedule regarding this backport, since it was
> initially planned for Q12006, but since we are going to add more
> supported architectures in the next months, it's better to have a stabl=
e
> build system for that.
>=20
> o PowerPC-wise (again), we should be close to ready for 2.6.15, since
> Heikki merged both the 32 and 64-bit trees in a single one.
>=20
> All other tasks planned are undergoing. For my part, I'm going to fiddl=
e
> now with ADI's Blackfin for which we already have the required Adeos
> support, and create the Xenomai port for it. Since this one is uClinux
> based, we should be able to check that the new build system is ok to
> host any kind of port sanely.
>=20

Question: On recent roadmaps I'm so far missing the topic "RT-signal
support in userspace". Are there any concrete schedules (Qx 200y)?

I think to remember that you said Adeos would be involved in such an
extension. Maybe it would be a good time to think about this also when
we extend the Adeos API by shareable IRQs.

Jan



--------------enig92D15F878460C6526341E107
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFDfdCOncNeS9Q0k+IRAgTfAJ9RAlR1YXeN6rrGHMANjf3td+FnrwCff0De
5e4IoMjZ7nhSN9Ke0Os5uZE=
=1bNL
-----END PGP SIGNATURE-----

--------------enig92D15F878460C6526341E107--

