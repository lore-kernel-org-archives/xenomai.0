Message-ID: <45423948.10203@domain.hid>
Date: Fri, 27 Oct 2006 18:52:24 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Problem with rt_queue
References: <20061027151347.62705.qmail@domain.hid>
In-Reply-To: <20061027151347.62705.qmail@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig11B3FBCDC44B6537CF8CB64A"
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
To: mani bhatti <imranbashirbhatti@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig11B3FBCDC44B6537CF8CB64A
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

mani bhatti wrote:
> Thanks a lot Jan for the reply.Now after changing the task name queue i=
s working but=20
>   following message is displayed by the sender if there is no queue whi=
ch you had pointed in the last email.
>   rt_queue_alloc(queue_inout, 8) failed
> Segmentation fault
>=20
>   Actually i dont  understand about the patch which you had sent in you=
r last email (because patch seems to be incomple to me ) because that see=
ms to be part of xenomai source code and if that is how can i use that so=
urce code in my program for solving my problem i mean at which place in m=
y program should i put that patch .Sorry for your inconvenience.thanks.
>  =20

Goto xenomai source directory and execute

# patch -p0 < native-queue-bcast-fix.patch

But I guess the patch will soon be SVN as well fixing your problem.

Jan


--------------enig11B3FBCDC44B6537CF8CB64A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFQjlIniDOoMHTA+kRAuv0AJ45yh53Uz7rcGq23S6vcwNqIdPx4ACdHh4P
pUKShZcO9Jbnt2BB68xKqsY=
=dsCH
-----END PGP SIGNATURE-----

--------------enig11B3FBCDC44B6537CF8CB64A--

