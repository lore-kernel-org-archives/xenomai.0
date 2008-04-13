Message-ID: <48020FEA.20309@domain.hid>
Date: Sun, 13 Apr 2008 15:51:38 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <001f01c89cc6$f269b250$0202a8c0@domain.hid>	<18433.65.910459.873472@domain.hid>
	<000701c89d68$8857e380$0202a8c0@domain.hid>
In-Reply-To: <000701c89d68$8857e380$0202a8c0@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig31DC78963964DF9DD5A4FB00"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] Communication between Xenomai and Linux domains
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: van der Linden <ejvanderlinden@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig31DC78963964DF9DD5A4FB00
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

van der Linden wrote:
> ...
> My real-time thread will call the alsa-sound library libasound and use =
the=20
> ALSA Linux kernel driver for my sound card.

I many cases, audio processing is a soft real-time task: quality
decreases as latency increases, but the world won't stop turning. So
unless you have very tight latency requirements (can you specify them,
BTW?), you are probably better off with the -rt (or "PREEMPT-RT")
patches. They achieve quite low, but generally not guaranteed latencies
for wide areas of the Linux kernel, including its sound subsystem (the
Linux audio community is using those patches e.g.).

If this doesn't fly for you (because of too low or actually hard latency
requirements), you will have to audit the relevant ALSA code paths from
the library in user land down to the low-level driver, either improve
them for your scenario on -rt or port a required subset over to
Xenomai's RTDM driver model.

Xenomai as-is will not improve ALSA latencies. Rather, your thread will
leave the RT space managed by Xenomai when it starts talking to this laye=
r.

Jan


--------------enig31DC78963964DF9DD5A4FB00
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.4-svn0 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFIAg/tniDOoMHTA+kRAjaYAJ49md463wU/tY/WxbJVmXI2yiiUOQCfTslz
p9Og6S0LMxvv2dI5Rv9iBuc=
=Qcbb
-----END PGP SIGNATURE-----

--------------enig31DC78963964DF9DD5A4FB00--

