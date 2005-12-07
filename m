Message-ID: <439729A6.3010309@domain.hid>
Date: Wed, 07 Dec 2005 19:27:50 +0100
From: Jan Kiszka <kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigA62932D175F65AEAB3D62680"
Subject: [Xenomai-core] [RFC] rt_task_join?
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigA62932D175F65AEAB3D62680
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi all,

we ran into some issue where we have to wait on the termination of a
native real-time userspace thread during cleanup. This can be done in a
custom way of course, either via some polling on a flag or by blocking
on a standard posix semaphore that are signalled by the terminating
real-time thread. But maybe it is more useful to have a generic function
available with the native skin.

The problem is now that the pthreads underneath the real-time threads
are created with PTHREAD_CREATE_DETACHED. Changing this also changes the
semantic of other rt_task_xxx functions as posix then requires the
creator to call pthread_join (i.e. a new rt_task_join) in any case. A
better option might be to introduce a new mode bit T_JOINABLE to decide
if the related pthread should be created detached or not. Default would
remain PTHREAD_CREATE_DETACHED, if rt_task_join is to be used,
T_JOINABLE could be passed to rt_task_create.

What do you think, worth the effort?

Jan


--------------enigA62932D175F65AEAB3D62680
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFDlymmncNeS9Q0k+IRAvYsAJ46mlSCCf05FENZ1fYwIhWrjQlKjQCg3Rf2
mWPkZzhzDLmipirv/mGjjLg=
=0u0C
-----END PGP SIGNATURE-----

--------------enigA62932D175F65AEAB3D62680--

