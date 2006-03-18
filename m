Message-ID: <441C57DA.8080708@domain.hid>
Date: Sat, 18 Mar 2006 19:56:26 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Re: get the simulator running...
References: <441C2574.4030901@domain.hid> <441C4279.10800@domain.hid>
	<441C4460.9030103@domain.hid> <441C5371.1080208@domain.hid>
	<441C5562.7000800@domain.hid>
In-Reply-To: <441C5562.7000800@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig973A33328ACBC25CE006DAD7"
Sender: jan.kiszka@domain.hid
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig973A33328ACBC25CE006DAD7
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Philippe Gerum wrote:
> Jan Kiszka wrote:
>> Philippe Gerum wrote:
>>
>>> Philippe Gerum wrote:
>>>
>>>> Jan Kiszka wrote:
>>>> Fortunately, I had that demo I once produced
>>>>
>>>>
>>>>> (last year), but that one was easier to build. I first had to drag =
in
>>>>> the libs and includes of both the simulator and a regular xenomai
>>>>> installation (I think to remember this once worked without this
>>>>> add-ons). Then I need this additional trick in the simulators inclu=
de
>>>>> dir:
>>>>>
>>>>> mkdir asm
>>>>> ln -s <xeno-inst-dir>/include/asm-sim asm/xenomai
>>>>>
>>>>> This maps #include <asm/xenomai/system.h> to the correct "arch".
>>>>> Shouldn't this be created automatically during the simulator
>>>>> installation? Or is something else broken on my box?
>>>>>
>>>>
>>>> You clearly should not need this trick to compile apps against the
>>>> simulation environment; the instrumenter (gcic) sets the proper flag=
s.
>>>> I'm going to rebuild one and let you know.
>>>
>>> Confirmed. You don't need this hand-made link.
>>>
>>
>>
>> Err, "confirmed" means that it works for you without the link and the
>> extra paths for gcic?
>=20
> Yes (actually, it has always worked for me this way).
>=20
>  The compilation of the simulator runs fine with
>> latest SVN here, but gcic still does not know any include paths.
>> Attached is the native skin demo I tried.
>=20
> gcic explicitely sets -I<install-dir>/include/asm-sim before invoking
> the gcc toolchain. Try adding --verbose to see what's passed.
>=20

kiszka@domain.hid> ../inst/bin/gcic -c nat-demo.c -o
nat-demo_sim.o --verbose
/usr/src/xeno-sim/inst/libexec/gcic/bin/gcc  -isystem
/usr/src/xeno-sim/inst/libexec/gcic/i686-pc-linux-gnu/include -isystem
/usr/src/xeno-sim/inst/libexec/gcic/lib/gcc-lib/i686-pc-linux-gnu/2.95.3/=
include
-E -B/usr/src/xeno-sim/inst/libexec/gcic/lib/gcc-lib/ -D__GCIC__
-D__XENO_SIM__ -D__XENO__ -I/usr/src/xeno-sim/inst/include/asm-sim
-I/usr/src/xeno-sim/inst/include nat-demo.c > /tmp/ic0@domain.hid
nat-demo.c:22: native/task.h: Datei oder Verzeichnis nicht gefunden
nat-demo.c:23: native/sem.h: Datei oder Verzeichnis nicht gefunden
gcic: failed to preprocess nat-demo.c.

I only see the simulator include paths, no link to the xenomai source
base (here: /usr/src/xenomai) or its installation
(/usr/src/xenomai/inst, but I haven't submitted this anyway).

Jan


--------------enig973A33328ACBC25CE006DAD7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEHFfaniDOoMHTA+kRAp2FAJ9IYMaj2FZGx8mxHskPElU2pDjC9QCeLDMG
djM057sJX+gMBrENcNTVr6k=
=ZLOR
-----END PGP SIGNATURE-----

--------------enig973A33328ACBC25CE006DAD7--

