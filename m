Message-ID: <453647E6.2050307@domain.hid>
Date: Wed, 18 Oct 2006 17:27:34 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Adeos/Xenomai Arm Port
References: <1161184570.5093.61.camel@domain.hid>
In-Reply-To: <1161184570.5093.61.camel@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig53BA5118506D772BC640A007"
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
To: =?ISO-8859-15?Q?=22Schl=E4gl_=5C=22Manfred_jun=2E=5C=22=22?= <manfred.schlaegl@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig53BA5118506D772BC640A007
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Schl=E4gl Manfred jun. wrote:
>=20
> -----------------------------------------------------------------------=
-
>=20
> Betreff:
> Re: [Xenomai-help] Adeos/Xenomai Arm Port
> Von:
> Schl=E4gl "Manfred jun." <manfred.schlaegl@domain.hid>
> Datum:
> Wed, 18 Oct 2006 17:15:09 +0200
> An:
> Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
>=20
> An:
> Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
>=20
>=20
> On Wed, 2006-10-18 at 14:05 +0200, Gilles Chanteperdrix wrote:
>=20
>> Some ARMs do not boot when spinlock debugging is enabled, so it would =
be
>> interesting to check if the error also occurs with I-pipe and Xenomai
>> off.
>>
>=20
> You were right!
>=20
> The kernel with active SPIN_DEBUG and without IPIPE doesn't boot (soft
> lockup).
>=20
> But very interresting: Kernel with SPIN_DEBUG and IPIPE seems to run
> normally (with xenomai, but without xenomai apps).
>=20
> Thanks
>=20
>=20
> #######################################################################=
########
>=20
> Again Latency:
>=20
> -sh-3.00#  time ./run -- -t 1 -p 1000 -T 10=20
> *
> *
> * Type ^C to stop this application.
> *
> *
> Using /lib/modules/2.6.15.7/kernel/kernel/xenomai/nucleus/xeno_nucleus.=
ko
> Using /lib/modules/2.6.15.7/kernel/kernel/xenomai/skins/native/xeno_nat=
ive.ko
> Using /lib/modules/2.6.15.7/kernel/kernel/xenomai/skins/rtdm/xeno_rtdm.=
ko
> Using /lib/modules/2.6.15.7/kernel/drivers/xenomai/testing/xeno_timerbe=
nch.ko
> =3D=3D Sampling period: 1000 us
> =3D=3D Test mode: in-kernel periodic task
> =3D=3D All results in microseconds
> warming up...
> RTT|  00:00:01  (in-kernel periodic task, 1000 us period, priority 99)
> RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat=

> worst
> RTD|      11.680|      16.586|      36.126|       0|      11.680|
> 36.126
> RTD|      11.182|      17.092|      43.947|       0|      11.182|
> 43.947
> RTD|      11.521|      17.091|      65.411|       0|      11.182|
> 65.411
> RTD|      11.981|      17.116|      63.388|       0|      11.182|
> 65.411
> RTD|      11.919|      17.121|      66.767|       0|      11.182|
> 66.767
> RTD|      12.354|      17.178|      42.996|       0|      11.182|
> 66.767
> RTD|      11.884|      17.122|      66.315|       0|      11.182|
> 66.767
> RTD|      11.849|      17.132|      65.287|       0|      11.182|
> 66.767
> RTD|      11.578|      17.093|      66.824|       0|      11.182|
> 66.824
> ---|------------|------------|------------|--------|-------------------=
------
> RTS|-1095668.296|       0.001|      93.252|   93340|
> 00:00:10/00:00:10

Looks like you forgot to recompile the user space part after applying my
patch. It changes the ABI between the driver and the test tool, so both
sides have to be in sync.

>=20
> real    0m17.730s
> user    0m0.840s
> sys     0m5.000s
> Time is running very slowly while running this test
> 0m17.730s on target, while 1m6 in reality
>=20

Sounds like Linux is not getting (enough) timer IRQs. Check
/proc/interrupts for progress.

Jan


--------------enig53BA5118506D772BC640A007
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFNkfmniDOoMHTA+kRAgKdAJ4ggHdrp8nmVvqhP/jfLslV+CivtgCfekhK
O1AKpMKRLVCGRiVmipYcnyU=
=Lk6i
-----END PGP SIGNATURE-----

--------------enig53BA5118506D772BC640A007--

