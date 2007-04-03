Message-ID: <46122548.3060400@domain.hid>
Date: Tue, 03 Apr 2007 11:58:32 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Adeos-main] Re: Re: Porting to Intel IXP425
References: <899865CA54E4444DAF2E3639C04C5F4805EC63@domain.hid>
	<1175511404.5342.12.camel@domain.hid>
In-Reply-To: <1175511404.5342.12.camel@domain.hid>
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
> Am Montag, den 02.04.2007, 08:52 +0200 schrieb Richard Cochran:
>=20
>>>This is needed for machines where the hardware timer is based on a
>>>decrementer. But for machines with a free-running counter and a match
>>>register, reading the value of the free-running counter is
>>>simpler. IXP425 is in the  "free-running counter and match register
>>>category". So, its implementation should look like the one of the PXA.
>>
>>The IXP425 does not have a match register, AFAICT.
>>
>>It does have four 32-bit counters clocked at 66.66 MHz: a watch dog, a
>>free-running timestamp, and two general purpose timers.
>>
>>The general purpose timers may be used either as one-shot timers
>>(count down to zero and stop) or as periodic times (count down,
>>automatically reload, and keep going).
>>
>>I already have xenomai running on the IXP425, but I will have to take
>>a closer look at the timer code.
>>
>>Richard
>=20
>=20
> Then you have to implement it like I described.=20
>=20
> Take a look at the implementation for integrator-platforms.
> (Timer with wraparound)

I have tried to put together on Xenomai wiki some ideas on porting the
ARM I-pipe patch on a new platform. I have not explained the case of the
integrator, in the hope that others who know better could modify the howt=
o.

http://www.xenomai.org/index.php/I-pipe:ArmPorting

--=20
                                                 Gilles Chanteperdrix

