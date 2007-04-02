Message-ID: <4610F5A4.20807@domain.hid>
Date: Mon, 02 Apr 2007 14:23:00 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Adeos-main] Re: Re: Porting to Intel IXP425
References: <899865CA54E4444DAF2E3639C04C5F4805EC65@domain.hid>
	<1175515305.5342.29.camel@domain.hid>
In-Reply-To: <1175515305.5342.29.camel@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: Quoted-Printable
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: =?ISO-8859-15?Q?=22Schl=E4gl_=5C=22Manfred_jun=2E=5C=22=22?= <manfred.schlaegl@domain.hid>
Cc: adeos-main@gna.org

Schl=E4gl Manfred jun. wrote:
> Am Montag, den 02.04.2007, 13:34 +0200 schrieb Richard Cochran:
>=20
>>>Then you have to implement it like I described.=20
>>>
>>>Take a look at the implementation for integrator-platforms.
>>>(Timer with wraparound)
>>
>>Well, as I said, the IXP425 one-shot timer mode does _not_ wrap around.
>>It just stops.
>=20
>=20
>>I'm not sure how (or why) to account for the clock ticks that transpire
>>during the interrupt handler.
>>
>>There are no clock ticks lost in __ipipe_mach_get_tsc, since this gets =
the
>>value of a free-flowing timer.
>>
>>Previously you wrote,
>>
>>
>>>These lost-ticks should be added to the global time-stamp (returned by
>>>get_tsc) and should mentioned at the linux-gettimeoffset-function also=
=2E
>>
>>Can you be more specific? What is the "linux-gettimeoffset-function" of
>>which you speak?
>=20
>=20
> Linux gettimeoffset calls a march-specific function
> (ixp4xx_gettimeoffset) which delivers the time in us since the last
> timer-tick (timer-interrupt).
>=20
>=20
>>>Lost-ticks could sum up to a bothering time-error.
>>
>>But in the plain-old Linux code, no such adjustment is made (using a
>>periodic timer, see below).
>=20
>=20
> In this implementation a time-stamp register is used. Excuse me, I
> misunderstood your mail before...
> Forget what i said. It's quite simpler to use such a timer for adeos.=20
> Gilles Chanteperdrix is right.

Actually, I was looking at the IXP465 datasheet which has a free-running
counter with match register. But if I understand correctly, the IXP425
has the same free running counter as IXP465 but no match register.

--=20
                                                 Gilles Chanteperdrix

