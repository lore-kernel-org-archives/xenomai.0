References: <87o8bzyxne.fsf@xenomai.org>
 <10a0-60d0d500-8b-29fb8780@204427917> <87lf72z6ux.fsf@xenomai.org>
 <19ba6735ee0f09c8abb7ff8aa405d6f63aae959e.camel@sprinte.eu>
 <2f00ba9e-c0e2-a0fb-4ba4-bb6cc7a651fe@siemens.com>
From: Philippe Gerum <rpm@xenomai.org>
Subject: Re: Large gpio interrupt latency
In-reply-to: <2f00ba9e-c0e2-a0fb-4ba4-bb6cc7a651fe@siemens.com>
Date: Tue, 22 Jun 2021 10:37:38 +0200
Message-ID: <87im26z44t.fsf@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Julien Blanc <julien.blanc@sprinte.eu>, "francois.legal@thom.fr.eu.org" <francois.legal@thom.fr.eu.org>, "xenomai@xenomai.org" <xenomai@xenomai.org>


Jan Kiszka <jan.kiszka@siemens.com> writes:

> On 22.06.21 09:49, Julien Blanc via Xenomai wrote:
>> Le mardi 22 juin 2021 =C3=A0 09:38 +0200, Philippe Gerum via Xenomai a
>> =C3=A9crit :
>>>
>>> With this in mind, assuming that we have previously sanitized the
>>> clock
>>> identifier, doing this:
>>>
>>> #define get_timestamp(__clock) \
>>> ({ (__clock) =3D=3D CLOCK_MONOTONIC ? rtdm_clock_read_monotonic() :
>>> rtdm_clock_read(); })
>>>
>>> may end up being faster than:
>>>
>>> xnticks_t (*__get_timestamp)(clockid_t clock);
>>> #define get_timestamp(__clock)	__get_timestamp(__clock)
>>=20
>> Is really a runtime switch necessary ? Since relying on the realtime
>> clock is inherently broken, my understanding is that it should be kept
>> as compatibility purpose only.
>
> Again: The real-time clock is not a broken clock per se. It is the basis
> of many services (POSIX...) and - if managed properly - it is as sound
> clock to build upon. If you need absolute timestamps to calculate
> absolute timeouts (like users of the existing code do), this is the
> clock to go, also in future versions.

Definitely correct, for timeout specs.

> Also if you want to use
> PTP-sync'ed clocks across systems (TSN...), it is THE way to go. At that
> point, monotonic timestamps will lose relevance in practice.
>

We are not there yet. So, let's all agree than we need both clock bases,
and a flexible way to select the current one.

--=20
Philippe.

