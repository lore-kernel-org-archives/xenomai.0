Message-ID: <482B3BCF.8090700@domain.hid>
Date: Wed, 14 May 2008 21:21:51 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <A3B06EAFE0D9C14096681C935E0B300802110A0C@zue-s-15.zue.zwick.de>	<4829613B.3000500@domain.hid><0C9896A4B6D338488AD6FFFE58BAEF100276DBF6@domain.hid><48297566.1010607@domain.hid><0C9896A4B6D338488AD6FFFE58BAEF100276DC66@domain.hid>	<4829AA19.8070405@domain.hid>	<0C9896A4B6D338488AD6FFFE58BAEF100276DD0C@serveur3.lgm.com>	<4829C8C9.4020300@domain.hid>
	<0C9896A4B6D338488AD6FFFE58BAEF100276DDDE@serveur3.lgm.com>
In-Reply-To: <0C9896A4B6D338488AD6FFFE58BAEF100276DDDE@serveur3.lgm.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig5B7F2E98ED999034DF6E0D77"
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
--------------enig5B7F2E98ED999034DF6E0D77
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

DOURNES Guillaume wrote:
> Since I add the watchdog option in my kernel configuration, The softwar=
e doesn't block.
> But I obtain an EPREM (-1) error on the second call of rtdm_event_timed=
wait, and in dmesg : Xenomai: assertion failed at kernel/xenomai/skins/rt=
dm/drvlib.c:919 (!xnpod_unblockable_p()).

See, that is interesting.

> I don't understand why I have this error, because the rtdm_event_timedw=
ait is used as the 16550A rtserial rtdm driver. And I use this rtserial d=
river, and it works.
> Note that this problem doesn't appears when I call rt_task_suspend just=
 after my rtdm_event_timedwait, and I resume the task by a gets.

After having a look at your driver source meanwhile, the problem is that
you register your IOCTL handler also for handling invocation from non-RT
(precisely: "secondary") context. But rtdm_event_timedwait always
requires primary (RT) context. That is something you either have to
check in the IOCTL handler before trying to block a caller - or you
simply do not register for nrt_ioctl (or use a different handler for the
set of IOCTLs in that context).

The reason that suspending the caller made this issue go away was that
you have several plain Linux services in your RT loop that switches the
caller automatically to secondary mode. Thus the first IOCTL succeeded,
but the second failed after re-entering it now as a plain Linux caller.

HTH,
Jan


--------------enig5B7F2E98ED999034DF6E0D77
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.4-svn0 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFIKzvSniDOoMHTA+kRAsNSAJwIMieOdY7bNGZG4IqRf67lJS+8FgCfZQuZ
rTIFV2qD/Brlpvm9jld9WNE=
=tSfW
-----END PGP SIGNATURE-----

--------------enig5B7F2E98ED999034DF6E0D77--

