MIME-Version: 1.0
In-Reply-To: <c0e1bcb9-3f9c-3427-a7ac-584f713ec39c@xenomai.org>
References: <CAD6zzEn4imLcrGfSu-Ehrs_L3Kyf3DM_Fhb4NuQREZ4xszbxpg@mail.gmail.com>
 <c0e1bcb9-3f9c-3427-a7ac-584f713ec39c@xenomai.org>
From: Marco Baracchi <cormabara@gmail.com>
Date: Sat, 14 Jan 2017 22:08:27 +0100
Message-ID: <CAD6zzEn=+9DijMz_qtiwaJgWUCguUqgR+Jw2pVoVJ4z86-BygA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Xenomai] hrtimer negative next event
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

Hi,
Thanks for interest, now we have some new elements.
We take some time to jump to kernel 3.14.52 always with xenomai 2.6.5 but
the result is the same. After some time (also some days) our application
slow down and the hrtimer doesn't schedule next events (because they are
scheduled in the past).
We check inside

void xntimer_next_local_shot(xnsched_t *sched)
.....


    delay = xntimerh_date(&timer->aplink) -
        (xnarch_get_cpu_tsc() + nklatency);

    if (delay < 0) {
        printk("DEIMO: xntimer_next_local_shot delay(%Ld) latency(%lu)
tsc(%Lu) date(%Lu)\n", delay, nklatency, xnarch_get_cpu_tsc(),
xntimerh_date(&timer->aplink));
        delay = 0;
    }
    else if (delay > ULONG_MAX) {
        printk("DEIMO: xntimer_next_local_shot delay(%Ld) latency(%lu)
tsc(%Lu) date(%Lu)\n", delay, nklatency, xnarch_get_cpu_tsc(),
xntimerh_date(&timer->aplink));
        delay = ULONG_MAX;
    }

...

running our application but also the "latency " test
sometimes the output on the console is :

.....

TD|     -0.667|      0.000|      9.999|       0|     0|     -0.667|
13.666

RTD|     -0.334|      0.000|     15.333|       0|     0|     -0.667|
15.333

[   91.520700] DEIMO: xntimer_next_local_shot delay(-6) latency(22l)
tsc(295512423) date(295512438)

RTD|     -0.334|      0.000|      9.999|       0|     0|     -0.667|
15.333

[   92.530805] DEIMO: xntimer_next_local_shot delay(-10) latency(22l)
tsc(298542722) date(298542733)

RTD|     -0.334|      0.000|     13.666|       0|     0|     -0.667|
15.333

RTD|     -0.334|      0.000|      5.666|       0|     0|     -0.667|
15.333

RTD|     -0.667|      0.000|     11.666|       0|     0|     -0.667|
15.333

RTD|     -0.334|      0.000|      8.999|       0|     0|     -0.667|
15.333

[   95.965102] DEIMO: xntimer_next_local_shot delay(-4) latency(22l)
tsc(308845623) date(308845640)

RTD|     -0.667|      0.000|      6.333|       0|     0|     -0.667|
15.333

[   96.874204] DEIMO: xntimer_next_local_shot delay(-9) latency(22l)
tsc(311572923) date(311572935)

RTD|     -0.334|      0.000|      9.666|       0|     0|     -0.667|
15.333
[   97.783304] DEIMO: xntimer_next_local_shot delay(-11) latency(22l)
tsc(314300223) date(314300233)
....

The negative delay can be the possible cause of the freeze of the hrtimer ?

The main problem is the system slow down slowly (we check with a debug
print inside our user threads and we find they slow down before all
application freeze).
The xenomai interrupt and all xenomai threads woke up by interrupts still
run.

Maybe someone can help us to trace this problem ? Is possible a bug in the
user space application can lock the hrtimer in this way ?

Regards


2016-12-12 17:00 GMT+01:00 Philippe Gerum <rpm@xenomai.org>:

> On 05/20/2015 11:53 AM, Marco Baracchi wrote:
> > We are using kernel *linux 3.0.35*, branch *imx_3.0.35_4.1.0* with
> > patches *adeos-xenomai
> > 2.6.4* for *mxc* on a freescale imx6 single core and we have  a problem
> > with hrtimer: sometimes after a couple of hour our periodic task inside
> > Xenomai blocks. checking inside /proc path we  found:
>
>
> Your kernel+xenomai combo is severely outdated, many issues fixed in
> later I-pipe and Xenomai releases are present in your code base - not to
> speak of Freescale's 3.0.35 imx vendor kernel itself. For the issue at
> hand, I would at the very least backport this fix to the pipeline:
>
> https://git.xenomai.org/ipipe.git/commit/?h=ipipe-3.14&id=
> 9a54331043f450636613e9edb2a5a41fe424c6ff
>
> Alternatively, you may want to disable NO_HZ_IDLE and see if this has a
> positive impact on the stability of the system.
>
> --
> Philippe.
>
