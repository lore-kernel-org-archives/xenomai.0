Message-ID: <4643469A.4020005@domain.hid>
Date: Thu, 10 May 2007 18:21:46 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <25556725.1178802170156.JavaMail.ngmail@domain.hid>
	<4642E54B.3060600@domain.hid>	<1178727256.11688.35.camel@domain.hid>	<22908039.1178707932628.JavaMail.ngmail@domain.hid>	<12120203.1178785866207.JavaMail.ngmail@domain.hid>
	<30635766.1178804493587.JavaMail.ngmail@domain.hid>
In-Reply-To: <30635766.1178804493587.JavaMail.ngmail@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig82562066582114C6C3815712"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] Xenomai and futexes - Native API optimized
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
--------------enig82562066582114C6C3815712
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

M. Koehrer wrote:
> Hi Jan,
>=20
> here is the (truncated) output of opreport -l (which seems to be more u=
seful...).

Are you sure you predominately measured the semaphore scenario, not also
some things that happens before and after (or during) that test? Make
sure the test loop runs longer than setup/cleanup.

>=20
> Regards
>=20
> Mathias
> ------------------
> Profiler running.
> delta is 2030247695 per step: 5075
> Stopping profiling.
> CPU: P4 / Xeon, speed 3192.18 MHz (estimated)
> Counted GLOBAL_POWER_EVENTS events (time during which processor is not =
stopped) with a unit mask of 0x01 (mandatory) count 100000
> samples  %        image name               app name                 sym=
bol name
> 27423    64.2074  vmlinux                  vmlinux                  __i=
pipe_hard_cpuid

Mmpf, that's heavy. Can someone comment on this? Is the related hardware
access that costly or are we calling it too often?

> 2309      5.4062  xeno_nucleus             xeno_nucleus             (no=
 symbols)

We are lacking module symbols here. Dunno if one can teach them to
oprofile (likely somehow), but the easiest approach would be to compile
xeno_native and nucleus into the kernel.

Jan


--------------enig82562066582114C6C3815712
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGQ0abniDOoMHTA+kRAk0lAJ42jVLAQ1sE1gkf/iZlls5xHOor8wCdFLwv
P/ScvHIQGt7y6cPfbsW3qRE=
=8vBA
-----END PGP SIGNATURE-----

--------------enig82562066582114C6C3815712--

