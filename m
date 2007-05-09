Message-ID: <4641B5CF.80303@domain.hid>
Date: Wed, 09 May 2007 13:51:43 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <22908039.1178707932628.JavaMail.ngmail@domain.hid>
In-Reply-To: <22908039.1178707932628.JavaMail.ngmail@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigA4EDD87282ED47140D34FC99"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] Xenomai and futexes - Native API optimized for
 user space only applications
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "M. Koehrer" <mathias_koehrer@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigA4EDD87282ED47140D34FC99
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

M. Koehrer wrote:
> Hi everybody,
>=20
> I am using Xenomai for a high performance real time simulation system. =

> All of the simulation code is executed within user space. One applicati=
on is running that consists
> of several Xenomai real time threads.
> For performance reasons I am always using the latest PC technology avai=
lable (which is currently
> Pentium D or Core2Duo PCs, we are thinking even of using quad-core CPUs=
).
> There has to be a kind of thread synchronisation e.g. when accessing sh=
ared data.
> Hardware I/O is done via rtnet or via PCI I/O boards that work in user =
space aswell (PCI memory
> mapped into the user space).
> This is done e.g. by using semaphores, mutexes et.c
> I like the Xenomai-native skin as it provides a very clear API that is =
easy to use.
> However, for a user space only application it is a performance killer, =
that all API calls
> lead to a mode switch from user to kernel space. Each API call takes ab=
out 1-2 microseconds (us)
> on my PC which is really expensive.
> Especially when inter process communication is used to protect the acce=
ss to shared data
> it is mostly the case that the calling thread does not have to wait. In=
 this situation there is no
> need for a context switch. The API call did not lead to a rescheduling =
of the available tasks.
> And for this the required 1-2 us do really hurt.
>=20
> Thus my question/proposal is if there is a plan to use a "variant" of t=
he native API that is optimized for
> user space only applications. In this case e.g. futexes can be used. If=
 there is a need to
> reschedule to another task it is fine to "invest" the 2us but it can be=
 avoided mostly which should
> increase the overall performance dramatically.

Your analysis is not wrong. But before going into any detail may I ask
you for on clarification: What do you want to optimise *primarily*, the
average execution time of your RT threads in order to gain more CPU time
for non-RT Linux jobs *or* the worst case execution time of your RT threa=
ds?

> This would lead to a library where a big part of the functionality is h=
andled directly in the library=20
> (in user space). Currently the skin passes the (user space) API call vi=
a a Xenomai System call=20
> to the kernel space to execute there the actual functionality.
>=20
> Thanks for any feedback on this proposal.
>=20
> Regards
>=20
> Mathias
>=20

Jan


--------------enigA4EDD87282ED47140D34FC99
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGQbXPniDOoMHTA+kRAiu+AJ9fan66IPJD7BMxTyXzH61tEHM2ywCeLE4a
QrGDq4QZCo/+0WKZjOEBanM=
=HPXe
-----END PGP SIGNATURE-----

--------------enigA4EDD87282ED47140D34FC99--

