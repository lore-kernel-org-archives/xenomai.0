Message-ID: <4500821B.8040703@domain.hid>
Date: Thu, 07 Sep 2006 22:33:31 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Low-level isr in ADEOS/RTDM
References: <45007B5B.9010000@domain.hid>
In-Reply-To: <45007B5B.9010000@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig37454244B620C5EA84A597BE"
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
To: Sean McGranaghan <smm@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig37454244B620C5EA84A597BE
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Sean McGranaghan wrote:
> Hello all,
>=20
> I am having an issue with a "lost" interrupt in an RTDM driver. This is=
 a long=20
> story so I will try to summarize:
>=20
> Hardware description -
> I have a Geode2 based PC/104 stack with CAN and ADC/DAC cards. The moth=
erboard=20
> implements a standard XT-PIC in its super io. The system is running Xen=
omai=20
> 2.2.1 with a Gentoo  Linux 2.6.17 kernel. There are several external de=
vices on=20
> the CAN bus to load the bus with traffic.
>=20
> Software description -
> I have two RTDM drivers that provide simple ioctl() interfaces to the=20
> application. One driver supports two CAN controllers. (PCAN/SJA1000. I =

> implemented this driver many months before RTCAN was available. Sorry I=
 couldn't=20
> wait, paying customer and all. ;-)

Yeah. :)

> The other driver supports a ADC/DAQ card. The=20
> application runs several Xenomai tasks using message queues for communi=
cation.
>=20
> Failure Description -
> The application starts. I can see IRQ lines being raised and lowered as=
=20
> interrupts are handled. The application runs normally. After about one =
or two=20
> minutes depending on the bus load, I "lose" the IRQ15 interrupt. My int=
errupt=20
> service routine is never called and the interrupt chain is broken for t=
hat=20
> device. I have traced the IRQ lines from the devices on the oscilloscop=
e and see=20
> that the IRQ goes high, but is never acknowledged. (See attached. I add=
ed labels=20
> to each trace.) This failure is sporadic and seems to depend on all thr=
ee=20
> devices generating interrupts in the system.
>=20
> Theory -
> The interrupt is never acknowledged because the PIC did not notify the =
processor=20
> or software never acknowledged the PIC.
>=20
> Testing approach -
> I need to determine if the hardware or software has lost the interrupt.=
 I would=20
> tend to suspect software first so I decided to start there. I am using =
the=20
> parallel port pins as GPIO output and trying to instrument the low-leve=
l=20
> ADEOS/Xenomai interrupt handling. If I catch the interrupt soon enough =
in the=20
> interrupt pipeline I can determine that some software issue is preventi=
ng my isr=20
> from running. If no interrupt ever occurs then I can suspect the hardwa=
re.
>=20
> Assumptions -
> ADEOS/Xenomai/RTDM catches the interrupt and propagates it to my isr. I=
f my isr=20
> is the first level interrupt handler I am out of luck.
>=20
> Any thoughts or suggestions are appreciated.

Already had a look at the ipipe-tracer?

http://download.gna.org/adeos/patches/v2.6/i386/tracer

If you can determine the error condition in software, it's easy to
trigger a freeze of the past invoked functions: xntrace_user_freeze. You
can call it from any context, also from user-space. Check
/proc/ipipe/tracer for the output ("frozen") and tunables (specifially
"back_trace_points"). If help on interpreting the result is required,
post it (or relevant excerpts) here.

Jan


--------------enig37454244B620C5EA84A597BE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFFAIIiniDOoMHTA+kRAqS+AJ9gLamCaKpY+zF5I1YD6VRaAlRBHgCggk5O
HE9M4bzZ8wUKBOBJajoQpIU=
=+TKC
-----END PGP SIGNATURE-----

--------------enig37454244B620C5EA84A597BE--

