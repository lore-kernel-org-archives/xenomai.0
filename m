Message-ID: <4EA1C2FB.1050009@domain.hid>
Date: Fri, 21 Oct 2011 21:07:39 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAMwkeZxmX1dU-5d2zDiYqv_SRcFqyDF+gmp+i8t=q1G6NXrmbg@domain.hid>	<4EA19A9D.1080502@domain.hid>	<CAMwkeZwpNG9i0fGFRXQBOtpaaLZU6L2HvD=bBjM21em3dVCfZg@domain.hid>	<4EA1B033.6060707@domain.hid>	<CAMwkeZyTBkswrYe5TKaVZcY6Hm9FpefTSzLLABaN4HkgXFCa8g@domain.hid>	<4EA1BE4C.5030301@domain.hid>
	<CAMwkeZzPDN5TFKiU05tuZdW4=yHT1XoWe2=xwceiimRw-rF4_w@domain.hid>
In-Reply-To: <CAMwkeZzPDN5TFKiU05tuZdW4=yHT1XoWe2=xwceiimRw-rF4_w@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] rt_task_wait_period returns an undocumented value
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: =?UTF-8?B?RmVybmFuZG8gSGVycmVybyBDYXJyw7Nu?= <elferdo@domain.hid>
Cc: Xenomai-help@domain.hid

On 10/21/2011 09:01 PM, Fernando Herrero Carr=C3=B3n wrote:
> El 21 de octubre de 2011 16:47, Gilles Chanteperdrix <
> gilles.chanteperdrix@xenomai.org> escribi=C3=B3:
>=20
>> On 10/21/2011 08:08 PM, Fernando Herrero Carr=C3=B3n wrote:
>>> Alright, excuse me, I missed that explanation.
>>>
>>> Then let me move to the actual figures at hand:
>>>
>>>  $ cat /proc/xenomai/latency
>>> 3349
>>>
>>> and, as I explained above, all values below 11450 are being rejected =
in
>> my
>>> case.
>>
>> I guess you have to check the code to understand what happens. But
>> really, running tasks with a 11500 period is already preposterous.
>=20
>=20
> It's the very minimal example that I could come up with, I can attach t=
he
> code if you will. But there is not much more than mlockall(),
> rt_task_shadow(), rt_task_set_periodic() and
> while(){rt_tast_wait_period()}...

I mean check xenomai code.

>=20
> Why do you mean it is preposterous? Because it is not a round figure or=

> because it is too low? If you mean it is too low, well, I have a DAQ bo=
ard
> that can make acquisitions at up to 120kHz, which means a period of 800=
0 ns.
> I want to achieve the fastest acquistion rate possible, and was pushing=
 the
> limits to see where xenomai could go.

Because it is way too low, you will get a complete lockup of your system
as soon as you starting putting load on it.

--=20
                                                                Gilles.


