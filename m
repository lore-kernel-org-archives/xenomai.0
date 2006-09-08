Message-ID: <45015AF8.6070004@domain.hid>
Date: Fri, 08 Sep 2006 13:58:48 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Resource leaking problem
References: <450157A6.80000@domain.hid>
In-Reply-To: <450157A6.80000@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig8BD33F223A1BA8662C437472"
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
To: Dirk Eibach <eibach@domain.hid>
Cc: Xenomai help <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig8BD33F223A1BA8662C437472
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Dirk Eibach wrote:
> Hello,
>=20
> we have lots of tasks, semaphores and mutexes in our complex
> application. Stopping and restarting seems to leak some resources,
> because we get ENOMEM when a thread is created after restarting the
> application, first time everything goes well.
>=20
> Probably we do something wrong, maybe somebody can tell us what.

What skin do you use? Native? Only the POSIX skin currently does
auto-cleanup, the others require explicit care.

>=20
> What do we have to do in order to clean up all resources properly,
> especially if our application is ended by SIGKILL?

Install a signal handler and do cleanup of all allocated objects (tasks
get deleted when they terminate). Either keep track of your allocated
resources in some list(s) or signal the owners (tasks) that they should
terminate and cleanup their locally allocated resources. There are
dozens of ways to do this, depending on your application design.

But if you think that you are cleaning up correctly and still face
leaks, try to derive a simple test that demonstrates the issue.

Jan


--------------enig8BD33F223A1BA8662C437472
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFAVr4niDOoMHTA+kRAniBAJ9cgVHqURnvj0EADSoTAW/zQqWULgCfQ/lI
uMnJ87LjZTpH6nK26wA97jo=
=mxmz
-----END PGP SIGNATURE-----

--------------enig8BD33F223A1BA8662C437472--

