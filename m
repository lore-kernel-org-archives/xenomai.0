Message-ID: <446E2107.8060504@domain.hid>
Date: Fri, 19 May 2006 21:48:23 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Almost running - kernel BUG in add_preempt_count
	at	kernel/sched.c:2819!
References: <B4D14EA407C38B4DAF92B8EAC9249D7F02D0F285@domain.hid>
In-Reply-To: <B4D14EA407C38B4DAF92B8EAC9249D7F02D0F285@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig3E9EB408FAB645DA563A41F7"
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
To: "Rosenow, Jim" <Jim.Rosenow@domain.hid>
Cc: xenomai@xenomai.org, wallace@domain.hid

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig3E9EB408FAB645DA563A41F7
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Rosenow, Jim wrote:
> Sorry for the missing history.
>=20
> I started with a vanilla 2.6.14-7 kernel from kernel.org, I patched it
> with a Motorola patch to enable the features specific to the mvme5500.
> I built under ELDK 4.0 and the kernel ran just fine.
>=20
> Next I retrieved xenomai-2.1.1 and followed the install instructions.
> The adeos version adeos-ipipe-2.6.14-1.2.03.patch.  This patch applied
> and I rebuilt the kernel.  I ran into a problem with xmon not compiling=

> so I removed that switch from the kernel hacking menu and it built fine=
=2E
>=20
> That brings us to now.
>=20
> In reference to your recommendation, can I simply disable ipipe and
> leave xenomai enabled and expect the kernel to run?  I thought there wa=
s
> a pretty close coupling between the two.

No, you are right, this is not possible. I meant booting with both ipipe
and xenomai disabled.

Is your board able to boot without the Motorola patches? If yes, does
the problem persist? BTW, did the ipipe patch apply cleanly on top of
the Motorola patch or did you have to fix some hunks?


@all: What will help to track this down are back-traces of the crash.
Does the console contain a stack trace as well? If not, try using the
ipipe-tracer (additional patch [1]) and put an
ipipe_trace_panic_freeze() + ipipe_trace_panic_dump() before that BUG()
(with the same condition, of course). Actually, this tool can report
more than a stack trace. It records a full function call history and may
reveal where the ipipe patch left the correct path.

Jan


PS: Just in case you thought about this, switching the ipipe patch to
1.3 may only hide the problem. The newer patches contain optimisations,
not bug fixes of the 1.2 series.


[1] http://download.gna.org/adeos/patches/v2.6/ppc/tracer


--------------enig3E9EB408FAB645DA563A41F7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEbiEHniDOoMHTA+kRAsQcAJ9XRpE7p4B9NnJGhXt3pYuR0GIy7gCfaVTM
p53WAlSlQn1qptZIMkKmGO4=
=YWny
-----END PGP SIGNATURE-----

--------------enig3E9EB408FAB645DA563A41F7--

