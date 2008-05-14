Message-ID: <482B3EE5.9030702@domain.hid>
Date: Wed, 14 May 2008 21:35:01 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <A3B06EAFE0D9C14096681C935E0B300802110A0C@zue-s-15.zue.zwick.de>	<4829613B.3000500@domain.hid><0C9896A4B6D338488AD6FFFE58BAEF100276DBF6@domain.hid><48297566.1010607@domain.hid><0C9896A4B6D338488AD6FFFE58BAEF100276DC66@domain.hid>	<4829AA19.8070405@domain.hid>	<0C9896A4B6D338488AD6FFFE58BAEF100276DD0C@serveur3.lgm.com>	<4829C8C9.4020300@domain.hid>	<0C9896A4B6D338488AD6FFFE58BAEF100276DDDE@serveur3.lgm.com>
	<482B3BCF.8090700@domain.hid>
In-Reply-To: <482B3BCF.8090700@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig4159F92271ED2B4E9605AFF7"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] Interrupt management under rtdm driver
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: DOURNES Guillaume <Guillaume.DOURNES@lgm.fr>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig4159F92271ED2B4E9605AFF7
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Jan Kiszka wrote:
> DOURNES Guillaume wrote:
>> Since I add the watchdog option in my kernel configuration, The softwa=
re doesn't block.
>> But I obtain an EPREM (-1) error on the second call of rtdm_event_time=
dwait, and in dmesg : Xenomai: assertion failed at kernel/xenomai/skins/r=
tdm/drvlib.c:919 (!xnpod_unblockable_p()).
>=20
> See, that is interesting.
>=20
>> I don't understand why I have this error, because the rtdm_event_timed=
wait is used as the 16550A rtserial rtdm driver. And I use this rtserial =
driver, and it works.
>> Note that this problem doesn't appears when I call rt_task_suspend jus=
t after my rtdm_event_timedwait, and I resume the task by a gets.
>=20
> After having a look at your driver source meanwhile, the problem is tha=
t
> you register your IOCTL handler also for handling invocation from non-R=
T
> (precisely: "secondary") context. But rtdm_event_timedwait always
> requires primary (RT) context. That is something you either have to
> check in the IOCTL handler before trying to block a caller - or you
> simply do not register for nrt_ioctl (or use a different handler for th=
e
> set of IOCTLs in that context).
>=20
> The reason that suspending the caller made this issue go away was that
> you have several plain Linux services in your RT loop that switches the=

> caller automatically to secondary mode. Thus the first IOCTL succeeded,=

> but the second failed after re-entering it now as a plain Linux caller.=


=2E..But suspending the thread shortly before IOCTL re-entry automaticall=
y
switch it back into the right (=3D=3DRT) context.

Jan


--------------enig4159F92271ED2B4E9605AFF7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.4-svn0 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFIKz7oniDOoMHTA+kRAp5LAJ4xrfxaCfiTic+gbOzSjzNLOz8E+wCeIL0l
VwEaiM7FzWFOzlFzq4kLKjQ=
=bAQo
-----END PGP SIGNATURE-----

--------------enig4159F92271ED2B4E9605AFF7--

