Message-ID: <46482FA3.2030709@domain.hid>
Date: Mon, 14 May 2007 11:45:07 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <19756477.1179132019857.JavaMail.ngmail@domain.hid>
In-Reply-To: <19756477.1179132019857.JavaMail.ngmail@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig0FBF34B92AC852F6F236ECB8"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] Scheduler: Strange priority handling with
 multiple tasks waiting for one semaphore
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
--------------enig0FBF34B92AC852F6F236ECB8
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

M. Koehrer wrote:
> Hi everybody,
>=20
> I see strange effect that I do not understand.
> What happens when multiple tasks (with different priority) are waiting =
for a single semaphore?
> Assume the following situation:
> Task H (High prio) and Task L (low prio) are waiting both for the same =
semaphore.
> A third task does the rt_sem_v() to grant access.
> Now H passes its rt_sem_p() and runs.=20
> A few statements later H calls rt_sem_v() to grant access to the semaph=
ore protected part.
> What happens now? As H is high priority there should be no reschedule, =
i.e. H continues to run.
> What happens now if H wants to enter again via rt_sem_p() (on the same =
semaphore)?
> I expect to allow H again the access as it has a higher priority than L=
=2E
> However, a small demo application for this use case shows me that this =
not the case.
> The heart of my demo application is the following task code fragment:
>=20
> void mytask(void *cookie)
> {
>     int id =3D (int)cookie;
>     int cnt =3D 0;
>=20
>     while (!end)
>     {
>         rt_sem_p(&sem, TM_INFINITE);
>         (....)
>         rt_sem_v(&sem);

Semaphores of the native skin do not know a 'mutex' mode (because there
are explicit mutexes), so you are most likely using the wrong tool here.

Semaphores have no owner. Once you release a semaphore, you pass the
access to the next highest waiter. And, in contrast to mutexes with
strict ownership, there is no way to get it back even if the new owner
hasn't been started yet.

>     }
>=20
>     printf("task %i: cnt %i\n", id, cnt);
> }
> There are two tasks with different priorities that execute this code.
> I expected to have only the higher priority task to be run, however the=
y run alternately.
> What is happening here? It looks as if the Xenomai scheduler does not h=
andle the priority=20
> correctly in this case.
> I have enclosed the C code of this application to this mail.
>=20
> Thanks for any feedback on this.
>=20
> Regards
>=20
> Mathias
>=20

In short: use mutexes for resource protection, then you will get the
desired behaviour!

Jan



--------------enig0FBF34B92AC852F6F236ECB8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGSC+mniDOoMHTA+kRAi4nAJ4wTdiWmED6B8tQMzolTffrDIX+3QCeMi4g
bvrnOL+nd9o+9ZzFDjktyiQ=
=W3TR
-----END PGP SIGNATURE-----

--------------enig0FBF34B92AC852F6F236ECB8--

