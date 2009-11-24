Message-ID: <4B0C670D.7010206@domain.hid>
Date: Wed, 25 Nov 2009 00:06:53 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4AFD01D3.1070604@domain.hid> <4AFD4C7F.1000106@domain.hid>
	<4AFD6013.9020608@domain.hid> <4AFE90A8.7090403@domain.hid>
	<4AFE91AC.6080904@domain.hid> <4B0C07AB.6060903@domain.hid>
In-Reply-To: <4B0C07AB.6060903@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig30DB368FFC240EA53A2930E9"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] What has highest priority RTcap or
	TDMA-synchronization reception?
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Benjamin Biegel <biegel@domain.hid>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig30DB368FFC240EA53A2930E9
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Benjamin Biegel wrote:
> Reading 'Life With Adeos' casts some light over the whole interrupt que=
stion.=20
> However I have some further questions.
>=20
> Why is it that the 'host interrupts' that you (Jan) mention below, can =
stall and=20
> cause jitter in the xenomai threads, when the host interrupts have not =
been=20
> given xenomai domain priorities? If such a host interrupt is played, Li=
fe With=20
> Adeos makes it sound that this interrupt is preemptable, given an inter=
rupt with=20
> higher priority occurs.

Not sure what you mean with "stall", but even low-prio interrupts still
involve basic I-pipe activity to acknowledge and record them when they
first occur during high-prio Xenomai activities. And this can cause
(though small) disturbances to the real-time jobs.

>=20
> Is it true that when RTcap is enabled, then every incoming frame will p=
lay an=20
> interrupt of highest possible priority (real time nucleus), as to times=
tamp the=20
> incoming frame?

This has nothing to do with RTcap, it is a property of RTnet NIC
drivers. Their RX interrupt handlers will run at high prio and perform
the timestamping. RTcap is just pushing all frames into Linux space for
collecting them via libpcap etc.

>=20
> Is it true, that when a TDMA synchronization frame arrives, this will a=
lso play=20
> an interrupt of highest possible priority (real time nucleus), as to ca=
lculate=20
> the offset between local and global clock?

Same IRQ (or if there are >1 NIC: IRQ of identical priority) as above.

Jan


--------------enig30DB368FFC240EA53A2930E9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAksMZxQACgkQitSsb3rl5xTdLwCaA3fouijVOlnav+LtAqLj1NQ5
bmUAoIFsVC/iPSuJslHb7jLnYHNPT2tl
=a0oO
-----END PGP SIGNATURE-----

--------------enig30DB368FFC240EA53A2930E9--

