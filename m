Message-ID: <456D9031.30807@domain.hid>
Date: Wed, 29 Nov 2006 14:50:41 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] tool for external jitter measurement
References: <ac3922a00611290435j11e339a1l55743fe4e9cb43d0@domain.hid>
In-Reply-To: <ac3922a00611290435j11e339a1l55743fe4e9cb43d0@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig731AD40408343CEB3546791F"
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
To: Syed Amer Gilani <amg@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig731AD40408343CEB3546791F
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Syed Amer Gilani wrote:
> I wrote with my little Xenomai experience a rtdm kernel module witch
> generates an external signal to measure it on an Oscilloscope. The
> Result is satisfying. With no other load there is nearly no jitter.
> With "dd if=3D/dev/zero of=3D/dev/null" and "ping -f" from an external
> machine the jitter is +-15=B5sec.

15 us looks fairly good, maybe too good. You may also want to try the
cache calibrator as load (see TROUBLESHOOTING for details).

> My Question now is if my approach is OK or is there a better way to
> generate the signal with Xenomai which would result in better results.
> Maybe by using hardware timer interrupt or something?

We have postponed the API definition for RTDM timers until the nucleus
timers have been reworked (scheduled for 2.4), but that service would
probably give you even better results (no reschedule, pins will be
toggled in IRQ context). Check drivers/testing/timerbench.c for a hack
to achieve this already.

Jan


--------------enig731AD40408343CEB3546791F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFbZAxniDOoMHTA+kRAvfVAJ4+j48ICBVMFaGo3J/KAJeLQosVQwCfZJc6
tLZskT5RYzCRsn5XrJOUWWo=
=+BWY
-----END PGP SIGNATURE-----

--------------enig731AD40408343CEB3546791F--

