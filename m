Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [Xenomai-help] Problem building MVM simulator in
	cross-compilation system
Date: Mon, 5 Dec 2005 07:28:33 +0200
Message-ID: <8DF1258D5F0FC94EBF5810BF2C7BF2FB4003AA@ILEX5.IL.NDS.COM>
From: "Ashri, Sarit" <Sashri@domain.hid>
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
Cc: xenomai@xenomai.org

Hi Philippe,

If I understood the MVM concept correctly, it is a real time control
layer=20
beneath the Xenomai layer that allows the user to write and test Xenomai
code
( without actual timing but with the actual thread priorities and
scheduling).
The code runs on the actual Xenomai version in the same manner in which
it will
Run on the target system (same minus the exact timing and performance).
If this is correct, I will have to use the actual Xenomai v2.1 code.
As far as I understood the Xenomai 2.1 code includes major changes from
the
Previous version, so my question is basically if it is stable enough for
a=20
beginner like me to start working with?

Thanks again for all you help!
Sarit.



>=20
> Ashri, Sarit wrote:
> > Hi Philippe,
> > Do you think I should wait for the v2.1 to be released or=20
> is it stable=20
> > enough To start playing with it now?
> >=20
>=20
> If we are still talking about the simulator, this is a rather=20
> mature piece of code since 2000 or so. Actually, it has been=20
> adapted from an old RTOS simulator project I recently moved to GNA:=20
> www.gna.org/projects/carbonkernel.
>=20
> > Thanks a lot for all your help!
> > Sarit.
> >=20
> >=20
> >>
> >>- Configure and cross-compile Xenomai for ppc without simulation=20
> >>support for installing to /opt/nfsroot
> >>- Configure and compile Xenomai natively for x86 with simulation=20
> >>support for installing to, e.g. /opt/local
> >>
> >>This way at least, you won't need to build the simulator apart, it=20
> >>will be built as part of the second step. Most of the native x86=20
> >>support won't be used (aside of the simulator, of course), but at=20
> >>least, this will work. On the host, you will need to set=20
> your PATH and=20
> >>LD_LIBRARY_PATH to /opt/local/bin, and /opt/local/lib=20
> respectively, so=20
> >>that the simulation libs and tools are found.
> >>
> >>The #warning won't go away though; only v2.1 gets rid of this by=20
> >>avoiding any kernel header inclusion in user-space. Debian systems=20
> >>would not bother you with this (at least sarge doesn't), but RH=20
> >>actually do.
> >>
> >>--
> >>
> >>Philippe.
> >>
> >=20
> --=20
>=20
> Philippe.
>=20

