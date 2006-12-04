Message-ID: <45743D46.8000502@domain.hid>
Date: Mon, 04 Dec 2006 16:22:46 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Xenomai install problems
References: <20061204133717.GA20186@domain.hid> <4574268C.7000705@domain.hid>
	<20061204143948.GA20411@domain.hid>
In-Reply-To: <20061204143948.GA20411@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig2D2BA15F7245DA5AD084558A"
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
To: Anthony Sharobaiko <anthony@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig2D2BA15F7245DA5AD084558A
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Anthony Sharobaiko wrote:
> On Mon, Dec 04, 2006 at 02:45:48PM +0100, Jan Kiszka wrote:
>> Is it a pure user-space crash, or do you also see some oops in the
>> kernel logs?
>=20
> Yes, sometimes (I still can not understand what affects this) it crashe=
s with oops:
> =3D=3D=3D cut here =3D=3D=3D
> root@domain.hid# ./run=20
> *
> *
> * Type ^C to stop this application.
> *
> *
> Bad mode in prefetch abort handler detected: mode UK13_32
> Internal error: Oops - bad mode: 0 [#1]
> Modules linked in:
> CPU: 0
> PC is at 0x228
> LR is at 0x22b
> pc : [<00000228>]    lr : [<0000022b>]    Not tainted
> sp : c06f1fb8  ip : 4002afd4  fp : be9d3cb8
> r10: 00000000  r9 : 00000000  r8 : 400331b4
> r7 : 00000001  r6 : be9d3e34  r5 : be9d3e3c  r4 : 4001c8dc
> r3 : 4001c8f0  r2 : be9d3cbc  r1 : 00000001  r0 : ffffffda
> Flags: nzcv  IRQs on  FIQs on  Mode UK13_32  Segment user
> Control: 397F  Table: A3F34000  DAC: 00000015
> Process latency (pid: 1099, stack limit =3D 0xc06f01a0)
> Stack: (0xc06f1fb8 to 0xc06f2000)
> 1fa0:                                                       ffffffda
> 00000001=20
> 1fc0: be9d3cbc 4001c8f0 4001c8dc be9d3e3c be9d3e34 00000001 400331b4
> 00000000=20
> 1fe0: 00000000 be9d3cb8 4002afd4 c06f1fb8 0000022b 00000228 0000001d
> ffffffff=20
> Backtrace: invalid frame pointer 0xbe9d3cb8
> Code: bad PC value.
>  /usr/xenomai/bin/xeno-load: line 247:  1099 Segmentation fault
>  $suflag $* $cmdargs
> =3D=3D=3D cut here =3D=3D=3D
>=20
> How can I provide more detailed log? ksymoops?

Give it a try, but the above complaints about invalid PC and frame
pointer sound like your kernel left the tracks and went south long ago.

You said you merged the patch for 2.6.15 on 2.6.16 and applied some
hunks manually. Did you check that the merge is obviously not hiding any
functional changes of the kernel? Do you have a chance to test a 2.6.15
kernel as well to see if this works? Note that I-pipe test does not
cover the whole functionality Xenomai uses.

>=20
>> If it's user-space, place attach gdb to find out where it
>> crashes.
>=20
> ok, I'll try to put gdbserver in there and look.
>=20

Unless a bell is already ringing for some of the ARM gurus here, it
could be helpful to try finding out if a particular syscall/operation of
the latency program triggers the problem. Of course, this direction only
makes sense if the I-pipe merge was most probably clean.

Jan


--------------enig2D2BA15F7245DA5AD084558A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFdD1GniDOoMHTA+kRArCuAJ0fc1PV2ttWuXop3KZaUfGU4rtr2QCfZY5w
VFOteieMcjzXtArsF/VF1oU=
=lIWq
-----END PGP SIGNATURE-----

--------------enig2D2BA15F7245DA5AD084558A--

