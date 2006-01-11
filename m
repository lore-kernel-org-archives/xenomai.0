Message-ID: <43C58EB0.8060300@domain.hid>
Date: Thu, 12 Jan 2006 00:03:12 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] question about task migrating to primary mode
References: <200601112256.41723.kisda@domain.hid>
In-Reply-To: <200601112256.41723.kisda@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigD4F23B66043C0D1AA07B566E"
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
To: Stefan Kisdaroczi <kisda@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigD4F23B66043C0D1AA07B566E
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Stefan Kisdaroczi wrote:
> Hi,
>=20
> I have a question about migrating a task to primary mode.
>=20
> Following code is from Captain's  "Hard Real Time Serial Port (RS232)=20
> Example" [1]:
> ...
>   while (1) {
>     /* switch to primary mode */
>     ret =3D rt_task_set_mode(0, T_PRIMARY, NULL);
>     if (ret) {
>       printf(WTASK_PREFIX "error while rt_task_set_mode, code %d\n",ret=
);
>       goto exit_write_task;
>     }
>     ret =3D rt_task_wait_period();
>     if (ret) {
>       printf(WTASK_PREFIX "error while rt_task_wait_period, code %d\n",=
ret);
>       goto exit_write_task;
>     }
>     sz =3D sizeof(buf);
>     written =3D rt_dev_write(my_fd, &buf, sizeof(buf));
>     printf(WTASK_PREFIX "rt_dev_write written=3D%d sz=3D%d\n", written,=
 sz);
>     if (written !=3D sz ) {
>       if (written < 0 ) {
>         printf(WTASK_PREFIX "error while rt_dev_write, code %d\n",writt=
en);
>       } else {
>         printf(WTASK_PREFIX "only %d / %d byte transmitted\n",written, =
sz);
>       }
>       goto exit_write_task;
>     }
>   }
> ...
>=20
> Is the rt_task_set_mode(0, T_PRIMARY, NULL) call really necessary?

Damn, this is the old-style RTDM 16550A serial driver example code which
found it way here. I think that even the original code on my side is
still outdated.

No, this is no longer needed here. All native functions automatically
switch to the right mode on invocation. The former issue was with the
RTDM API (rt_dev_xxx) which required the right mode on entry in case the
driver in the background only supports a specific one (e.g. if there is
no blocking read for a specific device from secondary mode - rather usual=
).

Things evolved, this restriction was removed in Xenomai, the original
demo got reordered, but the mode switches remained. We need to clean
this up.

> I seems the call is used here to migrate to task back to primary mode i=
f a=20
> error-"printf" switched the task to secondary mode.
>=20
> From the "Native API Tour"-Document, page 8 [2]:
> "By convention, all Xenomai services which
> might block the caller cause such transition when necessary; in other w=
ords, real=AD
> time tasks blocked on Xenomai resources are always aslept in primary mo=
de."
>=20
> As the next call is rt_task_wait_period which should block, i think its=
 not=20
> necessary to force a migration "by hand" to primary mode. Is this true =
?
>=20

Yes, definitly. Even with the old RTDM code this would have been redundan=
t.

You only need explicit mode switches with RTDM device in case there are
handlers both for the primary and secondary case and you want to pick a
specific one. Corner cases, but not purely theoretical:

Creating RTnet UDP sockets e.g. can happen in both contexts. In primary
mode, the required buffers are taken from a limited global pool of
pre-allocated buffers. In secondary mode, these buffers are allocated
classically, using Linux kernel services (kmem_cache_alloc). So, when
you are already in a real-time task and want to call rt_dev_socket but
you do have some time, you should explicitely switch to secondary mode
and then issue the request.

That's the idea behind it, and I hope it became a bit clearer than it is
now with existing code and docs.

> Thank you Hannes for all your examples.
>=20
> Thanks
> kisda
>=20
> [1] http://www.captain.at/xenomai-serial-port-example.php
> [2]=20
> http://snail.fsffrance.org/www.xenomai.org/documentation/branches/v2.0.=
x/pdf/Native-API-Tour.pdf
>=20

Jan


--------------enigD4F23B66043C0D1AA07B566E
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFDxY6wniDOoMHTA+kRAsJ0AJ0e5pZiZX0ZgqqbydpNeGTTJl45cgCeNGGd
Mbx/ekSz6TaBKF/wPynD4H4=
=UmxZ
-----END PGP SIGNATURE-----

--------------enigD4F23B66043C0D1AA07B566E--

