content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 May 2007 10:57:58 +0200
Message-ID: <5C40CD1E4697424ABDE3AC57CF1B22C6032202BF@FR0-MAILMB20.res.airbus.corp>
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
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai@xenomai.org, rtnet-users@domain.hid

> > Hi Everyone
> >=20
> > I'm programming a little client-server application to test=20
> network performances with xenomai 2.3.1 and rtnet 0.9.9.
> > The 2 programs are based on the rtnet frag-ip example.
> > The perdiodic scenario is :
> > - RSG program sends a datagram to the REMOTE program which=20
> was waiting.
> > - REMOTE sends a response to RSG.
> > - RSG simulates a CPU performing period using rt_timer_spin.
> > This cycle should take less than 2.5ms.
> >=20
> > I observe strange time measurement :
> >=20
> > For example when I want to run during 10 secs : 1000 cycles of 10 ms
> > The program calculates a time between 16 and 17 secs (using=20
> rt_timer_tsc)
> > But the effective elapsed time (i kept time with a chrono=20
> :-s ) is around 10secs
>=20
> Before I start looking at details, please check the=20
> consistency of your
> local Xenomai clock with this brand new tool:
>=20
> http://svn.gna.org/viewcvs/xenomai/trunk/src/testsuite/clockte
> st/clocktest.c?view=3Dmarkup
> (you don't have to switch to trunk, just grab the source and compile
> manually)

Ok I test it.

> In case the Linux clock is not screwed up as well, you can check for
> potential drifts and cross-cpu wraps that way.

I have tested the clocktest on the 2 boxes (P4 1.7Ghz and P4 Xeon 1.7Ghz)
(Note that on the 2 boxes, there's this 60% constant factor between effecti=
ve=20
and calculated time.

on P4 :
=3D=3D Tested clock: 0 (CLOCK_REALTIME)
CPU      ToD offset [us] ToD drift [us/s]      warps max delta [us]
--- -------------------- ---------------- ---------- --------------
  0            -592770.4           -0.210          0            0.0
the drift stays between -0.200us and -0.210us

on P4 Xeon :
=3D=3D Tested clock: 0 (CLOCK_REALTIME)
CPU      ToD offset [us] ToD drift [us/s]      warps max delta [us]
--- -------------------- ---------------- ---------- --------------
  0             -17620.8           -0.053          0            0.0
  1             -17620.8           -0.055          0            0.0
the drift stays between -0.050us and -0.060us

Is it normal ? And sorry, but I don't understand what do you mean about "cr=
oss-cpu wraps that way" ?

Thanks Jan.

> > When a cycle is supposed to be 5ms it is calculated to be 8.4ms
> >
> > When I want a rt_timer_spin of 0.750ms, result is a 1.27ms burning peri=
od.
> >
> > So a constant difference between effective and calculated time around +=
60%.
> >
> > Maybe there something wrong in my program but I don't know what.
> > Also, I have read some threads that mentionned time problem and /proc/x=
enomai/latency value.
> > I didn't understand everything.=20
> > Any suggestion ?
> >
> >
> > Thanks in advance.
> >
> > Niry
>
> Jan

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



