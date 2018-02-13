From: "Auel, Kendall" <Kendall.Auel@3DSystems.Com>
Date: Tue, 13 Feb 2018 19:36:34 +0000
Message-ID: <fdeb1736b05c471ea168fb6d35a6197b@P10-EX01.3DSystems.Internal>
References: <44eflvcaft.fsf@lowell-desk.lan>
 <31210f5e-1137-54e8-9e22-7562de250614@xenomai.org>
 <115c0698-ad5f-2dae-4ed4-1e027839eae1@xenomai.org>
 <44d11e1akp.fsf@be-well.ilk.org> <44o9kumikv.fsf@lowell-desk.lan>
 <44sha4lt2h.fsf@lowell-desk.lan>
In-Reply-To: <44sha4lt2h.fsf@lowell-desk.lan>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Xenomai] rtdm_timer_start latency?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

I encountered a similar problem with a hardware clock implementation. Our i=
mplementation of "ns_to_ticks" for the xnclock struct had a very small trun=
cation error. Immediately after booting the system, we didn't see a problem=
. In that case the absolute time was small, thus making the truncation erro=
r negligible. However, after the system had been up a day or two, relative =
timers had a very large initial delay (100s of ms). Eventually the startup =
delays were many seconds, if the clock had been running for days. For relat=
ive time durations, the truncation in the time conversion was also negligib=
le, so after the initial delay there was no problem.

You might take a look at ...xenomai/clock.c, there are a number of #ifdef s=
tatements for choosing which math functions to use.

In our case, the truncation occurred with this code (in our custom driver f=
or the hardware timer):

	ticks =3D xnarch_ulldiv(ns, 1000000000/TIMER_HZ, &rem);
	if (rem)
		ticks++;
	return ticks;

Note the TIMER_HZ value is just a little less than 40000. Thus the truncati=
on error is in the range from 0.0000000 to 0.000025 of the original ns valu=
e. In our case it was about 0.000010. If we didn't have a random-looking cl=
ock frequency we would have never noticed the issue.

Anyway, to fix the problem, we changed it to:

	return xnarch_llimd(ns, TIMER_HZ, 1000000000);

I hope this helps,
Kendall

(PS - does anybody have a good MS-Outlook compatible tool for bottom-postin=
g?)

> -----Original Message-----
> From: Xenomai [mailto:xenomai-bounces@xenomai.org] On Behalf Of
> Lowell Gilbert
> Sent: Tuesday, February 13, 2018 9:04 AM
> To: xenomai@xenomai.org
> Subject: Re: [Xenomai] rtdm_timer_start latency?
>=20
> Lowell Gilbert <kludge@be-well.ilk.org> writes:
>=20
> > Lowell Gilbert <kludge@be-well.ilk.org> writes:
> >
> >> Philippe Gerum <rpm@xenomai.org> writes:
> >>
> >>> On 02/09/2018 11:02 AM, Philippe Gerum wrote:
> >>>> On 02/09/2018 12:45 AM, Lowell Gilbert wrote:
> >>>>> Am I correct in assuming that when calling rtdm_timer_start(), I
> >>>>> should not be getting multi-second latencies before the first call
> >>>>> to the timer routine? Just checking before I dig in too far.
> >>>>>
> >>>>
> >>>> Of course not. I suspect an absolute expiry time is given with a
> >>>> relative mode spec.
> >>>>
> >>>
> >>> More generally, an absolute expiry time which is not based on the
> >>> right clock specified by the mode argument.
> >>>
> >>> i.e.
> >>>
> >>> expiry =3D rtdm_clock_monotonic(), mode =3D
> RTDM_TIMERMODE_REALTIME =3D>
> >>> BAD expiry =3D rtdm_clock_realtime(), mode =3D
> RTDM_TIMERMODE_ABSOLUTE
> >>> =3D> BAD expiry =3D rtdm_clock_realtime() or _monotonic(), mode =3D
> >>> RTDM_TIMERMODE_RELATIVE =3D> BAD
> >>
> >> Okay, that makes sense.
> >>
> >> I was using 0 for expiry, because I really just wanted the periodic
> >> wakeup. I don't remember why I didn't create a periodic task instead
> >> of using a timer.
> >>
> >> What clock do I want to use to get the timer started? Once it starts,
> >> it runs fine; but it often takes two or three seconds before the
> >> first call into the handler.
> >>
> >> To put it another way, I'm trying to figure out what am I doing wrong =
in:
> >> 		ret =3D rtdm_timer_start(&pstate.collect.timer, 1,
> >> 				       pstate.collect.period,
> >> 				       RTDM_TIMERMODE_RELATIVE);
> >
> > I could just rewrite the code to use a periodic task, but I'd prefer
> > to understand what is actually wrong with my current code first, to be
> > sure that refactoring will really solve my problem.
> >
> > Or I could have the timer run constantly, but that is just hacking
> > around the problem, not really solving it.
>=20
> I have a feature request that would require me to run the data collection
> constantly (or at least whenever there's a consumer ready to receive it),=
 so
> that will ameliorate the problems for me. However, I'd prefer to understa=
nd
> what's happening, because as far as I understand at the moment, what I am
> doing *should* work.
>=20
> Also, as a matter of design, is there any reason to prefer a periodic tas=
k over
> a timer or vice versa? It can potentially cycle at fairly high rates (a p=
eriod as
> low as 10 microseconds), although expected use cases will not.
>=20
> Be well.
>=20
> _______________________________________________
> Xenomai mailing list
> Xenomai@xenomai.org
> https://xenomai.org/mailman/listinfo/xenomai

