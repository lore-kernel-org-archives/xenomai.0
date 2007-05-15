content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 May 2007 12:12:02 +0200
Message-ID: <5C40CD1E4697424ABDE3AC57CF1B22C6032202C1@domain.hid>
From: "RAKOTOSALAMA, Nirilanto" <NIRILANTO.RAKOTOSALAMA@airbus.com>
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
To: jan.kiszka@domain.hid
Cc: xenomai@xenomai.org, rtnet-users@domain.hid



> >>> Hi Everyone
> >>>
> >>> I'm programming a little client-server application to test=20
> >> network performances with xenomai 2.3.1 and rtnet 0.9.9.
> >>> The 2 programs are based on the rtnet frag-ip example.
> >>> The perdiodic scenario is :
> >>> - RSG program sends a datagram to the REMOTE program which=20
> >> was waiting.
> >>> - REMOTE sends a response to RSG.
> >>> - RSG simulates a CPU performing period using rt_timer_spin.
> >>> This cycle should take less than 2.5ms.
> >>>
> >>> I observe strange time measurement :
> >>>
> >>> For example when I want to run during 10 secs : 1000=20
> cycles of 10 ms
> >>> The program calculates a time between 16 and 17 secs (using=20
> >> rt_timer_tsc)
> >>> But the effective elapsed time (i kept time with a chrono=20
> >> :-s ) is around 10secs
> >>
> >> Before I start looking at details, please check the=20
> >> consistency of your
> >> local Xenomai clock with this brand new tool:
> >>
> >> http://svn.gna.org/viewcvs/xenomai/trunk/src/testsuite/clockte
> >> st/clocktest.c?view=3Dmarkup
> >> (you don't have to switch to trunk, just grab the source=20
> and compile
> >> manually)
> >=20
> > Ok I test it.
> >=20
> >> In case the Linux clock is not screwed up as well, you can=20
> check for
> >> potential drifts and cross-cpu wraps that way.
> >=20
> > I have tested the clocktest on the 2 boxes (P4 1.7Ghz and=20
> P4 Xeon 1.7Ghz)
> > (Note that on the 2 boxes, there's this 60% constant factor=20
> between effective=20
> > and calculated time.
> >=20
> > on P4 :
> > =3D=3D Tested clock: 0 (CLOCK_REALTIME)
> > CPU      ToD offset [us] ToD drift [us/s]      warps max delta [us]
> > --- -------------------- ---------------- ---------- --------------
> >   0            -592770.4           -0.210          0            0.0
> > the drift stays between -0.200us and -0.210us
> >=20
> > on P4 Xeon :
> > =3D=3D Tested clock: 0 (CLOCK_REALTIME)
> > CPU      ToD offset [us] ToD drift [us/s]      warps max delta [us]
> > --- -------------------- ---------------- ---------- --------------
> >   0             -17620.8           -0.053          0            0.0
> >   1             -17620.8           -0.055          0            0.0
> > the drift stays between -0.050us and -0.060us
>=20
> Looks sane.

Ok.
=20
> > Is it normal ? And sorry, but I don't understand what do=20
> you mean about "cross-cpu wraps that way" ?
>=20
> That would mean that the TSCs of the SMP box are not in sync and may
> cause jumps when migrating between the CPUs or comparing time=20
> stamps of
> different origins.

Thanks, it's more clear for me now.

> Anyway, you issue requires a closer look at the code:
>=20
> ...
> > rt_timer_ticks2ns(rt_timer_tsc())
>=20
> Are you sure that ticks =3D=3D tsc? RTFM :->

Oh, what stupid I am !!! Sorry and thanks lot for your help.
I'm not yet a boss in using xenomai, but I'll work.

Thanks agin for your help.

Niry


This e-mail is intended only for the above addressee. It may contain privil=
eged information.
If you are not the addressee you must not copy, distribute, disclose or use=
 any of the information in it.=20
If you have received it in error please delete it and immediately notify th=
e sender.
Security Notice: all e-mail, sent to or from this address, may be accessed =
by someone other than the recipient, for system management and security rea=
sons. This access is controlled under Regulation of security reasons.
This access is controlled under Regulation of Investigatory Powers Act 2000=
, Lawful Business Practises.



