Message-ID: <44E37823.8080407@domain.hid>
Date: Wed, 16 Aug 2006 21:55:15 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] problem with installation
References: <20060816190510.20935.qmail@domain.hid>	<44E36F6A.7060004@domain.hid>
	<200608162137.09103.nicola17@domain.hid>
In-Reply-To: <200608162137.09103.nicola17@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig3019226A5A642CD1D80C060B"
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
To: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig3019226A5A642CD1D80C060B
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Nicola Pezzotti wrote:
> Alle 21:18, mercoled=C3=AC 16 agosto 2006, Jan Kiszka ha scritto:
>> Nicola Pezzotti wrote:
>>> Hi all.
>>>     I'm trying to install Xenomai on my pc.
>>> To do that I'm following this guide
>>> http://www.captain.at/xenomai-2.1-installation.php
>>> I'm using Kubuntu 6.6, linux-2.6.17 kernel and xenomai-2.2.0
>>> I have runned the script prepare-kernel.sh with the correct option as=
 in
>>> README.INSTALL
>>> Everything go well untill I reboot the system, then I have those erro=
rs
>>>
>>>
>>> Uncompressing Linux... ok, booting the kernel
>>> MP-BIOS bug 8254 timer not connected to IO-APIC
>>> Xenomai: incompatible timer mode(aperiodic found, need aperiodic)
>>                                                          ^^^^^^^^^
>> I guess this this is a typo, isn't it? I would expect "periodic" here.=

>=20
> Sorry=20
> Xenomai: incompatible timer mode(aperiodic found, need periodic)
>=20
>=20
>>> Xenomai: VxWorks skin init failed code -16
>>> Kernel Panic - not syncing: VFS Unable to mount root fs on unknow
>>> -block(0,0)
>> The VxWorks skin requires periodic timer mode. If you don't plan to us=
e
>> it, drop it from the kernel config . If you do want it, either set
>> CONFIG_XENO_OPT_TIMING_PERIOD to some reasonable value (see also the
>> related kernel-config help), or turn the nucleus into a module and pas=
s
>> the period via the module parameter "tick_arg" when insmod'ing
>> xeno_nucleus later.
>>
>=20
> I need VxWorks skin... can you give me an hint abount this configuratio=
n? in=20
> what part of installation I must this flag?

When you configure your kernel, watch out for Xenomai->Timing->"Use
periodic timer hardware" and "Time period". However, I guess this will
not solve the other issue.

Jan


--------------enig3019226A5A642CD1D80C060B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFE43gjniDOoMHTA+kRAvnBAJ4rveXHdI5EhP/sgiYPDDWOpvPy4gCeJ+cJ
QT/p6gElVF7pmjCMtBNK0LQ=
=qO1y
-----END PGP SIGNATURE-----

--------------enig3019226A5A642CD1D80C060B--

