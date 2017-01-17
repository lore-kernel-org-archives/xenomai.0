References: <CAD6zzEn4imLcrGfSu-Ehrs_L3Kyf3DM_Fhb4NuQREZ4xszbxpg@mail.gmail.com>
 <c0e1bcb9-3f9c-3427-a7ac-584f713ec39c@xenomai.org>
 <CAD6zzEn=+9DijMz_qtiwaJgWUCguUqgR+Jw2pVoVJ4z86-BygA@mail.gmail.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <97ebe9fe-c98a-a65a-15bb-bb8d41441e88@xenomai.org>
Date: Tue, 17 Jan 2017 12:00:04 +0100
MIME-Version: 1.0
In-Reply-To: <CAD6zzEn=+9DijMz_qtiwaJgWUCguUqgR+Jw2pVoVJ4z86-BygA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] hrtimer negative next event
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Marco Baracchi <cormabara@gmail.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 01/14/2017 10:08 PM, Marco Baracchi wrote:
> Hi,
> Thanks for interest, now we have some new elements.
> We take some time to jump to kernel 3.14.52 always with xenomai 2.6.5
> but the result is the same. After some time (also some days) our
> application slow down and the hrtimer doesn't schedule next events
> (because they are scheduled in the past).
> We check inside
> 
> void xntimer_next_local_shot(xnsched_t *sched)
> .....
> 
> 
>     delay = xntimerh_date(&timer->aplink) -
>         (xnarch_get_cpu_tsc() + nklatency);
> 
>     if (delay < 0) {
>         printk("DEIMO: xntimer_next_local_shot delay(%Ld) latency(%lu)
> tsc(%Lu) date(%Lu)\n", delay, nklatency, xnarch_get_cpu_tsc(),
> xntimerh_date(&timer->aplink));
>         delay = 0;
>     }
>     else if (delay > ULONG_MAX) {
>         printk("DEIMO: xntimer_next_local_shot delay(%Ld) latency(%lu)
> tsc(%Lu) date(%Lu)\n", delay, nklatency, xnarch_get_cpu_tsc(),
> xntimerh_date(&timer->aplink));
>         delay = ULONG_MAX;
>     }
> 
> ...
> 
> running our application but also the "latency " test
> sometimes the output on the console is :
> 
> .....
> 
> TD|     -0.667|      0.000|      9.999|       0|     0|     -0.667|    
> 13.666
> 
> The negative delay can be the possible cause of the freeze of the hrtimer ?

No, this is unrelated. This is due to a slight miscalibration of
Xenomai's core system timer. /proc/xenomai/latency can be used on 2.x
to tune this dynamically.

> 
> The main problem is the system slow down slowly (we check with a debug
> print inside our user threads and we find they slow down before all
> application freeze).
> The xenomai interrupt and all xenomai threads woke up by interrupts
> still run.
> 
> Maybe someone can help us to trace this problem ? Is possible a bug in
> the user space application can lock the hrtimer in this way ?
>  

Maybe, especially if the Xenomai clock is still ticking at the right
pace, but the regular kernel timers are not.

Or maybe the wrap time for your timer is large, hitting that bug:
http://git.xenomai.org/ipipe.git/commit/?h=ipipe-3.14&id=01c54cedfd0fe784fddf225a493eba5a69f7bc16

In case you did not do it already, you may want to first validate your
SoC with Xenomai without any application of your own in the picture,
only by running the latency and switchtest programs in parallel for
several days, with the current kernel configuration.

If the issue still manifests itself, then the pipeline code may be at
fault. But since you already observed the very same behavior on very
different kernel releases (and therefore I-pipe patches), it is possible
that your application might be involved.

-- 
Philippe.

