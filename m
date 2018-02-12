From: Lange Norbert <norbert.lange@andritz.com>
Date: Mon, 12 Feb 2018 14:25:45 +0000
Message-ID: <99BAB48E90E86D42AD41F0BCE3225AEB019FBEC572@GRZSMS582.andritz.com>
References: <44eflvcaft.fsf@lowell-desk.lan>
 <31210f5e-1137-54e8-9e22-7562de250614@xenomai.org>
 <115c0698-ad5f-2dae-4ed4-1e027839eae1@xenomai.org>
 <44d11e1akp.fsf@be-well.ilk.org> <44o9kumikv.fsf@lowell-desk.lan>
In-Reply-To: <44o9kumikv.fsf@lowell-desk.lan>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
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
To: Lowell Gilbert <kludge@be-well.ilk.org>, "xenomai@xenomai.org" <xenomai@xenomai.org>

Hello,

this seems identical to an issue I have. I wanted to start a millisecond ti=
ck, aligned to seconds, but used the POSIX timerfd_settime.
Under Linux this works as intendent, under cobalt it doesn't.

I  expect that the first timeout would be somewhat close to the call, on a =
"whole" millisecond.

What happens is that the timer-function convert the (Nano-)seconds to the i=
nternal resolution. This has a small error, which normally won't matter for=
 short timespans.
The problem here is, that the absolute time will get converted with a big (=
absolute) error - growing bigger the longer your system is up.

What you could do, is reading the current time and fixing it up to a whole =
tick close to it, name this prev_secondtime, then use this as initial value=
.
Now the driver will have to fixup nothing or only a small amount, keeping t=
he error low.

You can also try fixing this at driver level, but I haven't dissected this =
carefully yet.
Basically the driver should calculate in the "source time" for as long as p=
ossible and only use the converted internal value for close events to keep =
conversion errors bounded.

Norbert

Highly experimental patch for ./kernel/cobalt/timer.c

--- timer.c.org 2017-12-18 10:09:37.283116000 +0100
+++ timer.c     2017-12-18 10:39:36.085302719 +0100
@@ -116,7 +116,7 @@
 {
        struct xnclock *clock =3D xntimer_clock(timer);
        xntimerq_t *q =3D xntimer_percpu_queue(timer);
-       xnticks_t date, now, delay, period;
+       xnticks_t date, now, delay, period, expired =3D 0;
        unsigned long gravity;
        int ret =3D 0;

@@ -141,6 +141,7 @@
        default: /* XN_ABSOLUTE || XN_REALTIME */
                date =3D xnclock_ns_to_ticks(clock, value);
                if ((xnsticks_t)(date - now) <=3D 0) {
+                       _ xnticks t nextvalue;
                        if (interval =3D=3D XN_INFINITE)
                                return -ETIMEDOUT;
                        /*
@@ -148,9 +149,17 @@
                         * delivery, wait for the next shot on the
                         * periodic time line.
                         */
-                       delay =3D now - date;
+                       expired =3D xnarch_div64(xnclock_ticks_to_ns(now - =
date), interval);
+                       nextvalue =3D value + interval * (expired + 1);
+
+                       /*
+                        * Note: need to think about errors for big offsets=
,
+                        * iteration of the correction is likely necessary,
+                        * until the value is within the boundaries [now, n=
ow + period)
+                        */
+                       date =3D xnclock_ns_to_ticks(clock, nextvalue);
+
                        period =3D xnclock_ns_to_ticks(clock, interval);
-                       date +=3D period * (xnarch_div64(delay, period) + 1=
);
                }
                break;
        }

 >-----Original Message-----
 >From: Xenomai [mailto:xenomai-bounces@xenomai.org] On Behalf Of Lowell
 >Gilbert
 >Sent: Montag, 12. Februar 2018 14:41
 >To: xenomai@xenomai.org
 >Subject: Re: [Xenomai] rtdm_timer_start latency?
 >
 >E-MAIL FROM A NON-ANDRITZ SOURCE: AS A SECURITY MEASURE, PLEASE
 >EXERCISE CAUTION WITH E-MAIL CONTENT AND ANY LINKS OR
 >ATTACHMENTS.
 >
 >
 >Lowell Gilbert <kludge@be-well.ilk.org> writes:
 >
 >> Philippe Gerum <rpm@xenomai.org> writes:
 >>
 >>> On 02/09/2018 11:02 AM, Philippe Gerum wrote:
 >>>> On 02/09/2018 12:45 AM, Lowell Gilbert wrote:
 >>>>> Am I correct in assuming that when calling rtdm_timer_start(), I sho=
uld
 >>>>> not be getting multi-second latencies before the first call to the t=
imer
 >>>>> routine? Just checking before I dig in too far.
 >>>>>
 >>>>
 >>>> Of course not. I suspect an absolute expiry time is given with a
 >>>> relative mode spec.
 >>>>
 >>>
 >>> More generally, an absolute expiry time which is not based on the righ=
t
 >>> clock specified by the mode argument.
 >>>
 >>> i.e.
 >>>
 >>> expiry =3D rtdm_clock_monotonic(), mode =3D RTDM_TIMERMODE_REALTIME
 >=3D> BAD
 >>> expiry =3D rtdm_clock_realtime(), mode =3D RTDM_TIMERMODE_ABSOLUTE =3D=
>
 >BAD
 >>> expiry =3D rtdm_clock_realtime() or _monotonic(), mode =3D
 >>> RTDM_TIMERMODE_RELATIVE =3D> BAD
 >>
 >> Okay, that makes sense.
 >>
 >> I was using 0 for expiry, because I really just wanted the periodic
 >> wakeup. I don't remember why I didn't create a periodic task instead of
 >> using a timer.
 >>
 >> What clock do I want to use to get the timer started? Once it starts, i=
t
 >> runs fine; but it often takes two or three seconds before the first cal=
l
 >> into the handler.
 >>
 >> To put it another way, I'm trying to figure out what am I doing wrong i=
n:
 >>               ret =3D rtdm_timer_start(&pstate.collect.timer, 1,
 >>                                      pstate.collect.period,
 >>                                      RTDM_TIMERMODE_RELATIVE);
 >
 >I could just rewrite the code to use a periodic task, but I'd prefer to
 >understand what is actually wrong with my current code first, to be sure
 >that refactoring will really solve my problem.
 >
 >Or I could have the timer run constantly, but that is just hacking
 >around the problem, not really solving it.
 >
 >Thanks for all help, past and future.
 >
 >_______________________________________________
 >Xenomai mailing list
 >Xenomai@xenomai.org
 >https://xenomai.org/mailman/listinfo/xenomai
________________________________

This message and any attachments are solely for the use of the intended rec=
ipients. They may contain privileged and/or confidential information or oth=
er information protected from disclosure. If you are not an intended recipi=
ent, you are hereby notified that you received this email in error and that=
 any review, dissemination, distribution or copying of this email and any a=
ttachment is strictly prohibited. If you have received this email in error,=
 please contact the sender and delete the message and any attachment from y=
our system.

ANDRITZ HYDRO GmbH


Rechtsform/ Legal form: Gesellschaft mit beschr=C3=A4nkter Haftung / Corpor=
ation

Firmensitz/ Registered seat: Wien

Firmenbuchgericht/ Court of registry: Handelsgericht Wien

Firmenbuchnummer/ Company registration: FN 61833 g

DVR: 0605077

UID-Nr.: ATU14756806


Thank You
________________________________

