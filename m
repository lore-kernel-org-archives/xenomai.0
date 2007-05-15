Message-ID: <464963FA.5050705@domain.hid>
Date: Tue, 15 May 2007 09:40:42 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <5C40CD1E4697424ABDE3AC57CF1B22C60322105D@FR0-MAILMB20.res.airbus.corp>
In-Reply-To: <5C40CD1E4697424ABDE3AC57CF1B22C60322105D@FR0-MAILMB20.res.airbus.corp>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig1FC61131CB2900838C85D49F"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] [RTnet-users] Time scale problem.
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "RAKOTOSALAMA, Nirilanto" <NIRILANTO.RAKOTOSALAMA@airbus.com>
Cc: xenomai@xenomai.org, rtnet-users@domain.hid

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig1FC61131CB2900838C85D49F
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

RAKOTOSALAMA, Nirilanto wrote:
> Hi Everyone
>=20
> I'm programming a little client-server application to test network perf=
ormances with xenomai 2.3.1 and rtnet 0.9.9.
> The 2 programs are based on the rtnet frag-ip example.
> The perdiodic scenario is :
> - RSG program sends a datagram to the REMOTE program which was waiting.=

> - REMOTE sends a response to RSG.
> - RSG simulates a CPU performing period using rt_timer_spin.
> This cycle should take less than 2.5ms.
>=20
> I observe strange time measurement :
>=20
> For example when I want to run during 10 secs : 1000 cycles of 10 ms
> The program calculates a time between 16 and 17 secs (using rt_timer_ts=
c)
> But the effective elapsed time (i kept time with a chrono :-s ) is arou=
nd 10secs

Before I start looking at details, please check the consistency of your
local Xenomai clock with this brand new tool:

http://svn.gna.org/viewcvs/xenomai/trunk/src/testsuite/clocktest/clocktes=
t.c?view=3Dmarkup
(you don't have to switch to trunk, just grab the source and compile
manually)

In case the Linux clock is not screwed up as well, you can check for
potential drifts and cross-cpu wraps that way.

>=20
> When a cycle is supposed to be 5ms it is calculated to be 8.4ms
>=20
> When I want a rt_timer_spin of 0.750ms, result is a 1.27ms burning peri=
od.
>=20
> So a constant difference between effective and calculated time around +=
60%.
>=20
> Maybe there something wrong in my program but I don't know what.
> Also, I have read some threads that mentionned time problem and /proc/x=
enomai/latency value.
> I didn't understand everything.=20
> Any suggestion ?
>=20
>=20
> Thanks in advance.
>=20
> Niry
>=20

Jan


--------------enig1FC61131CB2900838C85D49F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFGSWP6niDOoMHTA+kRArL0AJ93CtBBkWW3kL6axX/9xqNBgddFpwCfawAw
+nR6ObVc3wNxQsjWu5jqtpM=
=0xzi
-----END PGP SIGNATURE-----

--------------enig1FC61131CB2900838C85D49F--

