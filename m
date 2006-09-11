Message-ID: <4505E336.2060201@domain.hid>
Date: Tue, 12 Sep 2006 00:29:10 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] max size for pipes and rt-fifos?
References: <44FF3A22.5060901@domain.hid>
	<44FFE509.3090009@domain.hid>	<4500789C.9070804@domain.hid>
	<450113E7.6000907@domain.hid>	<4505C0F7.5060404@domain.hid>
	<17669.52163.920452.626173@domain.hid>
In-Reply-To: <17669.52163.920452.626173@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigEDBE4B9516EB168597B50CE2"
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
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigEDBE4B9516EB168597B50CE2
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Gilles Chanteperdrix wrote:
> Jeff Webb wrote:
>  > Jan Kiszka wrote:
>  > >>   /* Shut down the real-time thread */
>  > >>   pthread_cancel (fifotest_task);
>  > >>   pthread_join (fifotest_task, NULL); =20
>  > >=20
>  > > pthread_join requires RT context and will not work as expected. Bu=
t
>  > > that's unrelated to this problem.
>  >=20
>  > Okay.  (I now see this restriction in the docs.)  What is the proper=
 way to do this cleanup from kernel-space with Xenomai?  (Pardon my askin=
g, as I haven't done much programming using POSIX threads.  I believe thi=
s syntax was suggested, or at least acceptable, with RTLinux.)
>=20
> Calling pthread_cancel then pthread_join from a module cleanup routine
> should work. Because the cancelled thread preempts immediately the
> module cleanup routine, so when pthread_join is called, the thread no
> longer exists and there is no need to suspend the calling thread.
>=20

Yes, but only on UP. What about including a simple polling loop into
kernel-space pthread_join, something like rtdm_task_join_nrt?

Jan



--------------enigEDBE4B9516EB168597B50CE2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFBeM2niDOoMHTA+kRAgXDAJkBOWsFwGlT0TC6LbG1jS02OOwbCACfeIHM
tPGoEW3DQu8j9XZ0qAy/eKg=
=C6jR
-----END PGP SIGNATURE-----

--------------enigEDBE4B9516EB168597B50CE2--

