Message-ID: <44ABBFA1.4090706@domain.hid>
Date: Wed, 05 Jul 2006 15:33:21 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] delete queues "offline"; /proc/stat
References: <5D63919D95F87E4D9D34FF7748CE2C2A3BD0B3@domain.hid>
In-Reply-To: <5D63919D95F87E4D9D34FF7748CE2C2A3BD0B3@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig078FDEAAC9D5A7C4619CE97A"
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
To: Roderik_Wildenburg@domain.hid
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig078FDEAAC9D5A7C4619CE97A
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Roderik_Wildenburg@domain.hid wrote:
> when a xenomai-task crashs which created some queues (rt_queue_create)
> and I try to restart the task the creation of the queues will fail as
> the queue still exists (error EEXIST =3D=3D 17). Is there a possibility=
 to
> see which queues exist (I did not find a hint in the /proc/xenomai
> directory) and to get rid of these queues (or geneally spoken : to get
> rid of allocated resources) e.g. with a commandline tool ?

Native or posix skin? Gilles added per-process resource cleanup to the
posix skin in 2.2-rc3.

Otherwise: the names should be found in /proc/xenomai/registry. Writing
a tiny tool to pick up a name and resources type, attach to it, and then
release it should be straightforward. But I think we will have
per-process cleanup also for other skins in the future.

Stalled RTDM descriptors can be released via "echo DESCR_NO >
/proc/xenomai/rtdm/open_fildes" (I still have to make use of Gilles'
per-process cleanup also for the posix rtdm part...).

> An other question, I would appreciate some help for, is :
> How could I determine the CPU-load when a xenomai thread is running? Is=

> the data provided by /proc/stat valid with xenomai ?

Nope, they aren't. We actually need to do something in this direction,
maybe a simple per-xeno-thread execution time accounting if
XENO_OPT_STATS is set.

Jan


--------------enig078FDEAAC9D5A7C4619CE97A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEq7+hniDOoMHTA+kRApNBAJ99supdmu68zoGZUD1NDg2tTG8TqQCeLC1U
WcDxLVsAlClx2F/LCHjsqNA=
=CZMH
-----END PGP SIGNATURE-----

--------------enig078FDEAAC9D5A7C4619CE97A--

