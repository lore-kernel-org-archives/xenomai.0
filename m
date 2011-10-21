Message-ID: <4EA1BE4C.5030301@domain.hid>
Date: Fri, 21 Oct 2011 20:47:40 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAMwkeZxmX1dU-5d2zDiYqv_SRcFqyDF+gmp+i8t=q1G6NXrmbg@domain.hid>	<4EA19A9D.1080502@domain.hid>	<CAMwkeZwpNG9i0fGFRXQBOtpaaLZU6L2HvD=bBjM21em3dVCfZg@domain.hid>	<4EA1B033.6060707@domain.hid>
	<CAMwkeZyTBkswrYe5TKaVZcY6Hm9FpefTSzLLABaN4HkgXFCa8g@domain.hid>
In-Reply-To: <CAMwkeZyTBkswrYe5TKaVZcY6Hm9FpefTSzLLABaN4HkgXFCa8g@domain.hid>
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

On 10/21/2011 08:08 PM, Fernando Herrero Carr=C3=B3n wrote:
> Alright, excuse me, I missed that explanation.
>=20
> Then let me move to the actual figures at hand:
>=20
>  $ cat /proc/xenomai/latency
> 3349
>=20
> and, as I explained above, all values below 11450 are being rejected in=
 my
> case.

I guess you have to check the code to understand what happens. But
really, running tasks with a 11500 period is already preposterous.

> my point of view. Especially when it refers to documentation, I believe=
 that
> "too much" is never too much.

Conciseness is really important for a documentation, look at an example,
the sentence explaining the -EINVAL return value for
rt_task_make_periodic was a bit long, and you missed the important part,
even though I had told you that it was where was the answer to your
question. So, too much documentation is a problem, because users will
inevitably miss what is important.

Now look at an example outside Xenomai documentation:
http://pubs.opengroup.org/onlinepubs/000095399/functions/pthread_mutex_lo=
ck.html

The documentation for EINVAL says:
[EINVAL]
    The value specified by mutex does not refer to an initialized mutex
object.

It does not say, "or an object for which pthread_mutex_init failed", it
is pretty obvious that if pthread_mutex_init failed, the mutex is not
initialized. period.

--=20
                                                                Gilles.


