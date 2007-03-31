From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Message-ID: <17934.14577.400116.242615@domain.hid>
Date: Sat, 31 Mar 2007 12:33:21 +0200
Subject: Re: [Adeos-main] Re: Porting to Intel IXP425
In-Reply-To: <1175290163.5363.16.camel@domain.hid>
References: <899865CA54E4444DAF2E3639C04C5F4805EC60@domain.hid>
	<460D219D.5070302@domain.hid> <1175290163.5363.16.camel@domain.hid>
Content-Transfer-Encoding: Quoted-Printable
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: "=?ISO-8859-1?Q?Schl=E4gl?= Manfred jun." <manfred.schlaegl@domain.hid>
Cc: adeos-main@gna.org

Schl=E4gl "Manfred jun." wrote:
 > Am Freitag, den 30.03.2007, 16:41 +0200 schrieb Gilles Chanteperdrix:
 > > Richard Cochran wrote:
 > > >>The timer is aperiodic (most of the time) when running Xenomai, so
 > > >>__ipipe_mach_set_dec is called for each timer tick and programs th=
e
 > > >>timer hardware for the next tick.
 > > >=20
 > > >=20
 > > > Okay, so does that mean that I should implement a "one-shot" timer=
, or
 > > > are we talking about resetting the periodic timer once in a while?
 > > >=20
 > > > (BTW, in one-shot mode, the IXP425 timer does not do what the Deve=
lopers
 > > > Manual, part 252480-006, says that it does!)
 > >=20
 > > Yes, the one shot mode is Xenomai default mode. The implementation o=
f a
 > > periodic timer over the one-shot timer is already done by the generi=
c
 > > ARM part of the Adeos patch.
 >=20
 > It's better to use a periodic implementation in background, because th=
en
 > you are able to messure the lost ticks between a timer-interrupt and
 > programming next timer-event.
 >=20
 > Example with 16bit timer:
 >  * Periode: 27000 Ticks=20
 >  * Timer counts down to zero (Interrupt) & wrap around to 2^16-1=20
 >  * Reprogramm Timer with new Periode (lost-ticks =3D 2^16 - timerval)
 >=20
 > These lost-ticks should be added to the global time-stamp (returned by
 > get_tsc) and should mentioned at the linux-gettimeoffset-function also=
=2E
 >=20
 >=20
 > Lost-ticks could sum up to a bothering time-error.

This is needed for machines where the hardware timer is based on a
decrementer. But for machines with a free-running counter and a match
register, reading the value of the free-running counter is
simpler. IXP425 is in the  "free-running counter and match register
category". So, its implementation should look like the one of the PXA.

--=20


					    Gilles Chanteperdrix.

