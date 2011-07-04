Content-Class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 4 Jul 2011 11:43:12 +0200
Message-ID: <3FF315C710820E47A04E55C6F7D9B0AD7FF1F4@domain.hid>
In-Reply-To: <1309708106.2127.0.camel@domain.hid>
References: <3FF315C710820E47A04E55C6F7D9B0AD7FE9FF@AREXCH02.mra.roland-man.biz>
	<1308044391.2699.2.camel@domain.hid>
	<3FF315C710820E47A04E55C6F7D9B0AD7FEA2C@AREXCH02.mra.roland-man.biz>
	<1308387052.2122.14.camel@domain.hid> <4DFCABDA.6000702@domain.hid>
	<1308406918.2122.24.camel@domain.hid>
	<3FF315C710820E47A04E55C6F7D9B0AD7FECDA@AREXCH02.mra.roland-man.biz>
	<1308652557.2125.45.camel@domain.hid> <1309708106.2127.0.camel@domain.hid>
From: <roderik.wildenburg@domain.hid>
Subject: Re: [Xenomai-help] Xenomai 2.5.6 with PPC-Kernel 2.4.25
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: rpm@xenomai.org
Cc: xenomai@xenomai.org

Hello Philippe,

thank you very much for your patch and your precious time you spent on =
solving this issue!
Switchtest now seems to work proper (but fluctuation increased from 2% =
to 5% 1173->1108 see below).
I will perform the latency measurement for 2.4.5+2.5.6 as soon as =
possible.

Roderik

RTH|ctx switches|-------total
RTD|        1173|      148279
RTD|        1173|      149452
RTD|        1173|      150625
RTD|        1173|      151798
RTD|        1173|      152971
RTD|        1173|      154144
RTD|        1108|      155252
RTD|        1173|      156425
RTD|        1171|      157596
RTD|        1171|      158767
RTD|        1173|      159940
RTD|        1173|      161113
RTD|        1173|      162286
RTD|        1173|      163459
RTD|        1173|      164632
mrconfig:~ # uname -r
2.4.25
mrconfig:~ # cat /proc/xenomai/version
2.5.6
mrconfig:~ #


> -----Urspr=C3=BCngliche Nachricht-----
> Von: Philippe Gerum [mailto:rpm@xenomai.org]
> Gesendet: Sonntag, 3. Juli 2011 17:48
> An: Wildenburg, Roderik RAEK1 MRA
> Cc: gilles.chanteperdrix@xenomai.org; xenomai@xenomai.org
> Betreff: Re: AW: [Xenomai-help] Xenomai 2.5.6 with PPC-Kernel 2.4.25
>=20
> On Tue, 2011-06-21 at 12:35 +0200, Philippe Gerum wrote:
> > On Tue, 2011-06-21 at 12:04 +0200, roderik.wildenburg@domain.hid
> > wrote:
> > > I confirm that switchtest runs (nearly) perfectly on PPC-Kernel =
2.6.34 with
> Xenomai 2.5.6. The only anomaly I could see is a "collapse" of the =
number of
> context switches exactly every 7 seconds by 2% (see below).  Is this =
worth to pay
> attention to? (No other Xenomai-Task is running except for a watchdog =
task with a
> period of 500ms)
> >
> > 2% off seems a lot for a transient load, and this would not happen =
on a
> > periodic basis anyway. This needs to be investigated. Could you run
> > switchtest in nofpu mode?
> >
> > >
> > > On the opposite, switchtest runs erratic on PPC-2.4.25 with =
Xenomai 2.5.6 as
> you already mentioned: The number of context switches is much smaller =
then
> (only about 2%) with  PPC-2.6.34 and fluctuate very much (see below).
> > > Do you think you will find some spare time to fix this Problem?
> > >
> >
> > Spare time has become a luxury over the last months. I'll try to =
find a
> > time slot next week to have a look at this again.
>=20
> This should help, no I-pipe update needed.
>=20
> http://git.xenomai.org/?p=3Dxenomai-
> rpm.git;a=3Dcommit;h=3D35e9df567e19410526089e24fbbaf92c47de9c43
>=20
> --
> Philippe.
>=20
>

--------------------------------------------------------
manroland AG
Vorsitzender des Aufsichtsrates: Hanno C. Fiedler
Vorstand: Gerd Finkbeiner (Vorsitzender), Dr. Ingo Koch, Dr. Markus =
Rall, Paul Steidle  =20
Sitz der Gesellschaft: Offenbach am Main, Registergericht: Amtsgericht =
Offenbach HRB-Nr. 42592
USt-Ident-Nr. DE 250200933


