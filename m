Message-ID: <47AF7F3C.6080805@domain.hid>
Date: Sun, 10 Feb 2008 23:48:28 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <18350.7135.108901.491437@domain.hid>	<18350.7315.555644.171720@domain.hid>	<47AF057A.3070305@domain.hid>	<18351.28960.164520.295075@domain.hid>	<47AF781E.4070102@domain.hid>
	<18351.31369.697255.825404@domain.hid>
In-Reply-To: <18351.31369.697255.825404@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigF60C28B227C1E800CEB17CB6"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] [patch 2/4] RTDM support for select-like service.
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigF60C28B227C1E800CEB17CB6
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Gilles Chanteperdrix wrote:
> Jan Kiszka wrote:
>  > Gilles Chanteperdrix wrote:
>  > > Jan Kiszka wrote:
>  > >  > Gilles Chanteperdrix wrote:
>  > >  > > stats:
>  > >  > >  include/rtdm/rtdm.h        |    4 ++
>  > >  > >  include/rtdm/rtdm_driver.h |   30 +++++++++++++++-
>  > >  > >  ksrc/skins/rtdm/core.c     |   84 ++++++++++++++++++++++++++=
+++++--------------
>  > >  > >  ksrc/skins/rtdm/device.c   |   10 +++++
>  > >  > >  ksrc/skins/rtdm/drvlib.c   |   76 ++++++++++++++++++++++++++=
++++++++++----
>  > >  > >  5 files changed, 170 insertions(+), 34 deletions(-)
>  > >  > >=20
>  > >  >=20
>  > >  > /me thinks that going for inline patches on this list is overdu=
e...
>  > >  >=20
>  > >  > > @@ -1148,8 +1208,8 @@ int rtdm_sem_timeddown(rtdm_sem_t *sem,=
=20
>  > >  > > =20
>  > >  > >  	if (testbits(sem->synch_base.status, RTDM_SYNCH_DELETED))
>  > >  > >  		err =3D -EIDRM;
>  > >  > > -	else if (sem->value > 0)
>  > >  > > -		sem->value--;
>  > >  > > +	else if (sem->value > 0 && !--sem->value)
>  > >  > > +			xnselect_signal(&sem->select_block, 0);
>  > >  > >  	else if (timeout < 0) /* non-blocking mode */
>  > >  > >  		err =3D -EWOULDBLOCK;
>  > >  > >  	else {
>  > >  >=20
>  > >  > Uuuh, this doesn't look equivalent (for --sem->value < 0).
>  > >  >=20
>  > >  > Otherwise it's OK with me.
>  > >=20
>  > > After testing, it appears that the "owner" of a file descriptor ch=
anged from=20
>  > > current->mm=20
>  > > to
>  > > container_of(xnshadow_ppd_get(__rtdm_muxid), struct rtdm_process, =
ppd)
>  >=20
>  > Yes, indeed, forgot about it. We have a full-blown owner structure n=
ow
>  > to track comm and pid.
>  >=20
>  > >=20
>  > > So, I now need a ppd hash lookup in __rtdm_context_get.
>  > >=20
>  >=20
>  > You could add mm to rtdm_process. This means another indirection and=

>  > makes things worse (more cache misses in the worst case...).
>=20
> Would not it be simpler to put a pointer to the task_struct ? After all=
,
> it already has a pid, comm and mm, and a file descriptor will not
> survive a task_struct thanks to automatic closing of file descriptors.

Hmm, hmm, hmmmm... Sounds reasonable, should be safe.

>=20
>  Could you
>  > live without the check until we have per-process fd tabled, or was i=
t
>  > essential for the select thing?
>=20
> An application which I ported to Xenomai (and which uses the select
> call) closes all file descriptors in a for loop. The purpose of this
> loop is, I guess, to avoid leaving a file descriptor opened that was
> passed through exec.

OK.

So, will you change rtdm_process too? Thanks.

Jan


--------------enigF60C28B227C1E800CEB17CB6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.4-svn0 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFHr39BniDOoMHTA+kRAoveAJ90FB3gqncVQDyWSZ3gfbFx3U6ZsACeMZCt
IjAJ4fNOeaQupgs/abIrnJk=
=ae+u
-----END PGP SIGNATURE-----

--------------enigF60C28B227C1E800CEB17CB6--

