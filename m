Message-ID: <45503D5B.5030100@domain.hid>
Date: Tue, 07 Nov 2006 09:01:31 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] rt_task_delete problem
References: <4550331E.6090707@domain.hid>
In-Reply-To: <4550331E.6090707@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigDDCF3B211F80FE91DE548FFA"
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
To: Philipp Keller <philipp.keller@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigDDCF3B211F80FE91DE548FFA
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Philipp Keller wrote:
> Hello
>=20
> We have troubles deleting the main task created with rt_task_shadow()
> from user space.
> In the course of initiating the program, we spawn two other threads fro=
m
> the main task with rt_task_spawn().
> When ending the application, both the spawned tasks can be deleted with=

> rt_task_delete(), but the main task returns with an unknown error code
> when calling rt_task_delete().

Please post that error. I never tried to delete main, so I would be
interested what happens then.

In any case, deleting the main thread is not required, it will be purged
on process termination. The same happens to your spawned tasks when they
decide to self-terminate.

> We believe to have released all recources before deleting, closing all
> sockets and file handlers.
> The trouble is that we cannot initiate rt can socket communication agai=
n
> after failing to delete the main thread.

That must be a different issue. Check /proc/xenomai/rtdm/open_fildes for
any leftover (CAN) file descriptor. Note that rt_dev_close() can fail if
the descriptor is busy. And such thing can happen if you simply kill the
task that currently blocks on a CAN device e.g.

The correct ordering is therefore: close the sockets, catch the failure
in the blocking threads, and make them self-terminate. Granted, note the
most comfortable situation, but I'm sure we can improve it in the future
(e.g. via auto-cleanup also for RTDM file descriptors).

> Doeas anyone have an idea what the probelm may be here?
>=20
> Thanks for any hint
> Philipp
>=20

Jan


--------------enigDDCF3B211F80FE91DE548FFA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFUD1fniDOoMHTA+kRAjXCAJkBA5VENEg4cgyg+pQGccRTuwdo6gCfUA16
K4+ODzH0a5ip8qb7be9rQgk=
=gna3
-----END PGP SIGNATURE-----

--------------enigDDCF3B211F80FE91DE548FFA--

