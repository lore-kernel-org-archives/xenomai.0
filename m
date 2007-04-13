Message-ID: <461F199A.5070803@domain.hid>
Date: Fri, 13 Apr 2007 07:48:10 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <461B7079.7070703@domain.hid> <461EBF65.5010604@domain.hid>
In-Reply-To: <461EBF65.5010604@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig3828DD60645F4735ECF92ABE"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] [ag-automation] [ANNOUNCE] RTDM for Linux-rt
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Carsten Emde <Carsten.Emde@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>, ag-automation@domain.hid

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig3828DD60645F4735ECF92ABE
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Carsten,

[adding xenomai to cc again]

Carsten Emde wrote:
> Wolfgang,
>=20
>> Attached you can find a README on how to install and use RTDM-native a=
nd
>> the current implementation status.
> I couldn't stop my curiosity to see it working. So, I downloaded the=20
> material from the repository and attacked linux-2.6.21-rc6-rt0 after=20
> enabling everything available in the "Real-time subsystem". BTW:=20
> Wouldn't it be less confusing to call this section differently? For=20
> example "RTDM subsystem" or similar? Sorry, just a first thought - ther=
e=20
> is so much real-time everywhere.

Yes, I think so as well. The menu naming comes from the history of the
build system (Xenomai).

>=20
> I then tried to build a new kernel. With a single exception, everything=
=20
> compiled without warning. The exception was switchtest that refused to =

> build:
>=20
> drivers/xenomai/testing/switchtest.c:1:27: error: nucleus/synch.h: No=20
> such file or directory
> drivers/xenomai/testing/switchtest.c:2:28: error: nucleus/thread.h: No =

> such file or directory
> drivers/xenomai/testing/switchtest.c:5:32: error: asm/xenomai/fptest.h:=
=20
> No such file or directory

That driver shouldn't be part of rtdm-native, it's for stress-testing
the Xenomai nucleus.

>=20
> After disabling it, all sources could be compiled without any further=20
> problem. Linking xeno_rtdmtest.ko and xeno_16550A.ko, however, failed:
> WARNING: "hrtimer_init_sleeper"=20
> [drivers/xenomai/testing/xeno_rtdmtest.ko] undefined!
> WARNING: "hrtimer_init_sleeper" [drivers/xenomai/serial/xeno_16550A.ko]=
=20
> undefined!

At least in 2.6.20, hrtimer_init_sleeper() is not exported to modules.
Hmm, maybe Wolfgang tested both as built-in components, but that would
just be a workaround.

>=20
> I then disabled these two modules as well. The rest could be compiled=20
> and linked smoothly. The kernel was able to boot and the modules=20
> xeno_irqbench and xeno_can_virt could be loaded normally.
>=20
> I then tried linux-2.6.20-rt8 - same situation as described above.
>=20
> Will do some testing later. Anybody out there who would like to join th=
e=20
> RTDM-Native Testing Group?

Would love to, but short on time...

You may want to start by playing with irqbench [1] (IRQ latency tests
across nullmodem or laplink cable) or with the CAN stack, for which
xeno_can_virt offers you a virtual local bus of two CAN interfaces [2].

Jan

[1]http://www.rts.uni-hannover.de/xenomai/lxr/source/doc/txt/irqbench.txt=

[2]http://www.rts.uni-hannover.de/xenomai/lxr/source/src/utils/can/README=



--------------enig3828DD60645F4735ECF92ABE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGHxmaniDOoMHTA+kRAmiAAJ9BJhwKArD4NapcdCNnVqLs4H0lSwCeNB4l
wwdWtdObgFDeKm+V9driTNg=
=/70T
-----END PGP SIGNATURE-----

--------------enig3828DD60645F4735ECF92ABE--

