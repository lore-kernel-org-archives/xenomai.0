Message-ID: <469F4A98.3080307@domain.hid>
Date: Thu, 19 Jul 2007 13:27:20 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <469BF43D.1040704@domain.hid> <46973753.6010206@domain.hid>
	<4694ED98.6000000@domain.hid>	<46937E70.10903@domain.hid>	<469345EB.6060302@domain.hid>	<22554361.1184054457326.JavaMail.ngmail@domain.hid>	<2026261.1184070574283.JavaMail.ngmail@domain.hid>	<1982070.1184078400928.JavaMail.ngmail@domain.hid>	<4693A702.1010604@domain.hid>	<913919.1184311634860.JavaMail.ngmail@domain.hid>
	<21969019.1184569651818.JavaMail.ngmail@domain.hid>
	<29054475.1184842736562.JavaMail.ngmail@domain.hid>
In-Reply-To: <29054475.1184842736562.JavaMail.ngmail@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig58E8BCE8DA51FB014EF644B7"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] Sporadic PC freeze after rt_task_start
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai-help <xenomai@xenomai.org>, "M. Koehrer" <mathias_koehrer@domain.hid>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig58E8BCE8DA51FB014EF644B7
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

M. Koehrer wrote:
> Hi!
>=20
> After a couple of over-night test runs, I finally got an NMI watchdog d=
etected lockup with the sporadic freeze option.
> I started the system with the argument nmi_watchdog=3D1 (also isolcpus=3D=
1).
> See the code below. As I have not connected a serial console, I have at=
tached a screen shot in a fairly
> bad quality as jpg file... However, it is good enough to be able to rea=
d everything...=20
> The lockup is in function rpi_pop [xeno_nucleus].
> It is called from gatekeeper_thread and from default_wake_function.
> See the attached jpg for details.

Looks like we are stuck on rpilock, Philippe.

And when looking at the holders of rpilock, I think one issue could be
that we hold that lock while calling into xnpod_renice_root [1], ie.
doing a potential context switch. Was this checked to be save?
Furthermore, that code path reveals that we take nklock nested into
rpilock [2]. I haven't found a spot for the other way around (and I hope
there is none), but such nesting is already evil per se...

Mathias, already tried your test case with our old friend "priority
coupling" switched off? *If* this lock-up is actually due to rpilock
brokenness, switching the feature off should make it disappear.

Jan


[1]http://www.rts.uni-hannover.de/xenomai/lxr/source/ksrc/nucleus/shadow.=
c?v=3DSVN-trunk#435
[2]http://www.rts.uni-hannover.de/xenomai/lxr/source/include/nucleus/pod.=
h?v=3DSVN-trunk#308


--------------enig58E8BCE8DA51FB014EF644B7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGn0qYniDOoMHTA+kRAn6BAJ4j6XhhGjhtH5x5y5+V7aWnVQw/lwCdFU6N
mpBeRzTSHjRjNuCECTA4eFk=
=2umg
-----END PGP SIGNATURE-----

--------------enig58E8BCE8DA51FB014EF644B7--

