Message-ID: <4EA1B033.6060707@domain.hid>
Date: Fri, 21 Oct 2011 19:47:31 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAMwkeZxmX1dU-5d2zDiYqv_SRcFqyDF+gmp+i8t=q1G6NXrmbg@domain.hid>	<4EA19A9D.1080502@domain.hid>
	<CAMwkeZwpNG9i0fGFRXQBOtpaaLZU6L2HvD=bBjM21em3dVCfZg@domain.hid>
In-Reply-To: <CAMwkeZwpNG9i0fGFRXQBOtpaaLZU6L2HvD=bBjM21em3dVCfZg@domain.hid>
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

On 10/21/2011 07:37 PM, Fernando Herrero Carr=C3=B3n wrote:
> El 21 de octubre de 2011 14:15, Gilles Chanteperdrix <
> gilles.chanteperdrix@xenomai.org> escribi=C3=B3:
>=20
>> On 10/21/2011 06:04 PM, Fernando Herrero Carr=C3=B3n wrote:
>>> Dear list,
>>>
>>> I am running xenomai-2.6-rc4 on an amd64 linux kernel version 2.6.38.=
8.
>>>
>>> I am setting up a periodic task using
>>>
>>> rt_task_set_periodic(NULL, TM_NOW, 11500);
>>>
>>> For period values smaller than 11450 I get an EINVAL return value. I'=
ve
>> got
>>> one question regarding this, and it's how is this threshold calculate=
d?
>>
>> See:
>>
>> http://www.xenomai.org/documentation/trunk/html/api/group__pod.html#ga=
ed5776a428e7c59b52b1da76f0d765fa
>>
>=20
> Hmm, that doesn't make very clear why some values for "period" are acce=
pted
> and some others are not. Are they fixed? Are they calculated based on s=
ome
> system-dependent calibration procedure?

Summarized version: "-EINVAL is returned if (...) period is different
from TM_INFINITE but shorter than the scheduling latency value for the
target system, as available from /proc/xenomai/latency"

I do not see how it could be made more clear.

>=20
>=20
>>>
>>> However, further down the program, supposing rt_task_set_periodic()
>> failed
>>> with the above result, calling
>>>
>>> rt_task_wait_period()
>>>
>>> will return EAGAIN, which is not documented in
>>>
>> http://www.xenomai.org/documentation/trunk/html/api/group__task.html#g=
a1645d3a072ef3cefeed3bcbb27dcf108
>>> .
>>
>> That is because glibc choose to have EWOULDBLOCK =3D=3D EAGAIN. And
>> EWOULDBLOCK is documented.
>>
>>
> Ok, I see. This seems a bit confusing to me. What would happen if someo=
ne
> were using a different libc than glibc? If the code is using EWOULDBLOC=
K all
> over the place then that's fine.
>=20
> Finally, what do you think of extending:

I find the current version perfectly clear and find no reason to extend
it this way. Having called a function which failed should be equivalent
to not having called the function, in any reasonable API.

Not checking services return values, and continuing anyway in case of
error is a bad programming habit, especially when writing "critical" code=
=2E

--=20
					    Gilles.


