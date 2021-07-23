References: <87czseyzzm.fsf@xenomai.org> <10a7-60fa6980-b1-35a6e6c0@10117939>
From: Philippe Gerum <rpm@xenomai.org>
Subject: Re: Large gpio interrupt latency
In-reply-to: <10a7-60fa6980-b1-35a6e6c0@10117939>
Date: Fri, 23 Jul 2021 10:04:58 +0200
Message-ID: <87v9515uc5.fsf@xenomai.org>
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
To: =?utf-8?Q?Fran=C3=A7ois?= Legal <devel@thom.fr.eu.org>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, Julien Blanc <julien.blanc@sprinte.eu>, "xenomai@xenomai.org" <xenomai@xenomai.org>


Fran=C3=A7ois Legal <devel@thom.fr.eu.org> writes:

> Le Mardi, Juin 22, 2021 12:07 CEST, Philippe Gerum <rpm@xenomai.org> a =
=C3=A9crit:=20
>=20=20
>>=20
>> Jan Kiszka <jan.kiszka@siemens.com> writes:
>>=20
>> > On 22.06.21 11:31, Philippe Gerum wrote:
>> >>=20
>> >> Jan Kiszka <jan.kiszka@siemens.com> writes:
>> >>=20
>> >>> On 22.06.21 10:37, Philippe Gerum wrote:
>> >>>>
>> >>>> Jan Kiszka <jan.kiszka@siemens.com> writes:
>> >>>>
>> >>>>> On 22.06.21 09:49, Julien Blanc via Xenomai wrote:
>> >>>>>> Le mardi 22 juin 2021 =C3=A0 09:38 +0200, Philippe Gerum via Xeno=
mai a
>> >>>>>> =C3=A9crit :
>> >>>>>>>
>> >>>>>>> With this in mind, assuming that we have previously sanitized the
>> >>>>>>> clock
>> >>>>>>> identifier, doing this:
>> >>>>>>>
>> >>>>>>> #define get_timestamp(__clock) \
>> >>>>>>> ({ (__clock) =3D=3D CLOCK_MONOTONIC ? rtdm_clock_read_monotonic(=
) :
>> >>>>>>> rtdm_clock_read(); })
>> >>>>>>>
>> >>>>>>> may end up being faster than:
>> >>>>>>>
>> >>>>>>> xnticks_t (*__get_timestamp)(clockid_t clock);
>> >>>>>>> #define get_timestamp(__clock)	__get_timestamp(__clock)
>> >>>>>>
>> >>>>>> Is really a runtime switch necessary ? Since relying on the realt=
ime
>> >>>>>> clock is inherently broken, my understanding is that it should be=
 kept
>> >>>>>> as compatibility purpose only.
>> >>>>>
>> >>>>> Again: The real-time clock is not a broken clock per se. It is the=
 basis
>> >>>>> of many services (POSIX...) and - if managed properly - it is as s=
ound
>> >>>>> clock to build upon. If you need absolute timestamps to calculate
>> >>>>> absolute timeouts (like users of the existing code do), this is the
>> >>>>> clock to go, also in future versions.
>> >>>>
>> >>>> Definitely correct, for timeout specs.
>> >>>>
>> >>>>> Also if you want to use
>> >>>>> PTP-sync'ed clocks across systems (TSN...), it is THE way to go. A=
t that
>> >>>>> point, monotonic timestamps will lose relevance in practice.
>> >>>>>
>> >>>>
>> >>>> We are not there yet. So, let's all agree than we need both clock b=
ases,
>> >>>> and a flexible way to select the current one.
>> >>>>
>> >>>
>> >>> What's still missing with Dovetail and a Linux-operated PTP sync for=
 the
>> >>> main clocksource? Hardending of software-based sync paths? Where it's
>> >>> hw-based, that should already be fine (latest Intel SOCs).
>> >>>
>> >>=20
>> >> Again, we have two use cases: absolute timeouts based on a common epo=
ch
>> >> which may change, and delays. We do know PTP with hw-based support is=
 an
>> >> efficient way to maintain consistency among users of the former,
>> >> nevertheless we still need to express/measure strict delays in other
>> >> cases. So, we do need both clocks.
>> >>=20
>> >
>> > If you need cross-system event stamping, the unsync'ed monotonic clock
>> > is the wrong choice as well.
>> >
>>=20
>> As usual, it's a trade-off, a risk assessment between observing
>> non-coherent SMP readings and warp jumps. This is a call an application
>> should be allowed to make, I see no reason to impose a solution
>> arbitrarily without knowing what the app actually wants to do.
>>=20
>> > Again: What is missing to use PTP-sync'ed clock-realtime under Dovetail
>> > today?
>> >
>>=20
>> Nothing when it comes to reading timestamps, via the NMI-safe
>> ktime_get_real_fast_ns() service (updates will be non-preemptible while
>> holding the seqlock).
>>=20
>
> Hi there,
>
> to move this topic forward, I propose to create a patch to replace the ca=
ll to rtdm_clock_read_monotonic by rtdm_clock_read in gpio_core.c,
> plus another one that would introduce the possibility to switch between t=
hose 2 different clocks.
>

There is no timed wait calls in this driver which might benefit from a
general "clock switch" feature, is it?  So what about either of these
options instead:

- adding GPIO_RTIOC_TS_REAL only for the purpose of retrieving
  timestamps. That would leave the existing client code unaffected, and
  _might_ be backported to the stable tree since this is a mere
  extension of the ABI.

- renaming the current ioctl request to GPIO_RTIOC_GET_TS_MONO, and
  provide GPIO_RTIOC_GET_TS[_REAL] based on rtdm_clock_read() in the
  same move. That would force the existing client code to revisit their
  implementation wrt retrieving a timestamp, providing the desired
  alternative between mono/real too. That sort of change would have to
  wait for 3.2 though.

--=20
Philippe.

