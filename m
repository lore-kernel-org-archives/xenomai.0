Message-ID: <43E8FD05.5060600@domain.hid>
Date: Tue, 07 Feb 2006 21:03:17 +0100
From: Jan Kiszka <kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] RTDM mmap alternative
References: <20060203192739.87567.qmail@domain.hid>
	<200602061900.35411.lbocseg@domain.hid>
	<43E8DB10.5000901@domain.hid>
	<200602071722.06921.lbocseg@domain.hid>
In-Reply-To: <200602071722.06921.lbocseg@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig0BD533D5ED1BE094A076B1B9"
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Rodrigo Rosenfeld Rosas <lbocseg@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig0BD533D5ED1BE094A076B1B9
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Rodrigo Rosenfeld Rosas wrote:
> Hi Jan, thank you for your precious code! :)
>=20
> But, while it is executed in Linux context, ie, in a non-rt context, I =
could=20
> register a normal Linux file descriptor and call mmap on it. Or I could=
 mmap=20

You still need the back-end, i.e. some Linux device being registered and
catch your mmap call. That's how /dev/rtheap e.g. works.

> the device /dev/mem for mapping the memory region I would need. I can o=
btain=20
> the absolute address from a RTDM ioctl call.

/dev/mem is all or nothing: once you allow access, you cannot control
which memory region gets mapped. Closing this loop in kernel space
produces safer code with the option to get it even secure one day
(current Xenomai APIs do not address the latter aspect yet).

>=20
> Anyway, I'll be missing the V4L2 compatibility but that is not a great =
issue.=20

You mean some kind of rt_dev_mmap(..., rt-fildes, ...) (or wrapped mmap
in the posix skin)? We could define a standard RTDM-IOCTL and write the
user-space lib functions so that interested drivers can receive such
requests in a canonical way. The implementation in the driver would
still be different to Linux (just rtdm_mmap_to_user, no page-on-demand
e.g.).

> But since I only need to call this on initialization, I don't need to b=
e in=20
> RT-context in my specific application. But since I'm also developing a =

> robotic programming framework it would be nice to have this mmap capabi=
lity=20
> in real-time context.

Dynamic mmap'ping in RT is contradictory: Touching your current process'
mm creates dependencies on a lot of kernel code paths that can modify it
as well - if such modifications can be made deterministic at all in
Linux. But I guess you don't means this. Even V4L2 mmap's only during
init and not during the critical capturing process - it's far to slow.

You know that, due to Xenomai's automatic mode switching, you would be
free to call such rt_dev_mmap even from RT tasks? It would just switch
you temporarily over.

>=20
> But thank you anyway. I really appreciate your code.
>=20
> Best regards,
>=20
> Rodrigo.
>=20

Jan


--------------enig0BD533D5ED1BE094A076B1B9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFD6P0GncNeS9Q0k+IRAttfAKCsyEAGERoHQ2UJk7i9BD4dONNhlQCeOoHO
VIt0JYoB9NEnMTjsYpOEmKk=
=bxPK
-----END PGP SIGNATURE-----

--------------enig0BD533D5ED1BE094A076B1B9--

