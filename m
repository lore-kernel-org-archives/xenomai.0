MIME-Version: 1.0
In-Reply-To: <4CD68353.6030600@domain.hid>
References: <AANLkTinQotwe=EwATsmdKnanN-ZwT8c+CobzBRDqptEj@domain.hid>
	<4CCB4573.30607@domain.hid> <4CD68353.6030600@domain.hid>
Date: Sun, 7 Nov 2010 10:09:13 -0600
Message-ID: <AANLkTinfxNrqc0VZh=RAzpFzPBPVhPmzDC1zviDdwr=0@domain.hid>
From: at91_enthus <nwromania@domain.hid>
Content-Type: multipart/mixed; boundary=0016e6dd95a98cdec9049478ba1e
Subject: Re: [Xenomai-help] High resolution timers disabled on AT91SAM9G20
 board after patching
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

--0016e6dd95a98cdec9049478ba1e
Content-Type: multipart/alternative; boundary=0016e6dd95a98cdec2049478ba1c

--0016e6dd95a98cdec2049478ba1c
Content-Type: text/plain; charset=ISO-8859-1

Yes, it solved the issue.

There is  one thing that bothers me, though. When I run  "xeno-test", the
average and minimal  latencies are constant all the time.

The unpatched version of the xeno kernel seems more consistent when it comes
to minimum, maximum and average latencies.

I attached a couple of snippets of  xeno-test outputs .

Thanks,

R.

On Sun, Nov 7, 2010 at 4:45 AM, Gilles Chanteperdrix <
gilles.chanteperdrix@xenomai.org> wrote:

> Gilles Chanteperdrix wrote:
> > at91_enthus wrote:
> >> Hi!
> >>
> >> I installed the latest xenomai patch on a AT91SAM9G20 board and
> >> everything looked good at a first glance: no compilation problems, low
> >> latencies.
> >>
> >> However, when I typed cat /proc/timer_list , the resolutions in  cpu0
> >> and cpu1 items showed 100000 (ns).
> >> (I compiled the Xenomai patched kernel with High Resolution Timers
> enabled.)
> >>
> >> I don't have this problem when I boot a real time kernel (RT_PREEMPT).
> >
> > You mean another real-time kernel? If RT_PREEMPT uses the sys timer
> > running at 32kHz, and it tells you that it has a 1ns resolution, then it
> > is lying, because 32kHz, means a 30us resolution.
> >
> > Xenomai uses one TC as a timer at whatever frequency your chip proposes
> > over 1 MHz, this means a resolution below 1us, the downside is that this
> > also means a very short wrap time. And since the TC is also used as a
> > clock, this means that we must enter the timer interrupt handler before
> > the counter wraps. And this is something that Linux without Xenomai
> > running can not guarantee.
>
> On the other hand, we can keep the timer ticking behind Linux' back.
> Does the following patch fix the issue for you?
>
> diff --git a/arch/arm/mach-at91/at91_ipipe_time.c
> b/arch/arm/mach-at91/at91_ipipe_time.c
> index b0327eb..6c6f0d7 100644
> --- a/arch/arm/mach-at91/at91_ipipe_time.c
> +++ b/arch/arm/mach-at91/at91_ipipe_time.c
> @@ -76,9 +76,7 @@
>  #define TCNXCNS(timer,v) ((v) << ((timer)<<1))
>  #define AT91_TC_REG_MASK (0xffff)
>
> -static unsigned long next_match;
> -
> -static unsigned max_delta_ticks, min_delta_ticks;
> +static unsigned max_delta_ticks, min_delta_ticks, tick_pending;
>  static struct clock_event_device clkevt;
>  static int tc_timer_clock;
>
> @@ -116,7 +114,11 @@ EXPORT_SYMBOL(__ipipe_mach_ticks_per_jiffy);
>  */
>  static irqreturn_t at91_timer_interrupt(int irq, void *dev_id)
>  {
> -       clkevt.event_handler(&clkevt);
> +       if (__ipipe_mach_timerstolen || tick_pending) {
> +               tick_pending = 0;
> +               clkevt.event_handler(&clkevt);
> +       }
> +
>        return IRQ_HANDLED;
>  }
>
> @@ -130,12 +132,8 @@ void __ipipe_mach_acktimer(void)
>  {
>        at91_tc_read(AT91_TC_SR);
>
> -       if (unlikely(!__ipipe_mach_timerstolen)) {
> -               __ipipe_tsc_update();
> -               next_match = (next_match + __ipipe_mach_ticks_per_jiffy)
> -                       & AT91_TC_REG_MASK;
> -               write_RC(next_match);
> -       }
> +       if (unlikely(!__ipipe_mach_timerstolen))
> +               __ipipe_mach_set_dec(max_delta_ticks);
>  }
>
>  static void
> @@ -147,7 +145,7 @@ at91_tc_set_mode(enum clock_event_mode mode, struct
> clock_event_device *dev)
>        /* Disable all interrupts. */
>        at91_tc_write(AT91_TC_IDR, ~0ul);
>
> -       if (mode == CLOCK_EVT_MODE_PERIODIC) {
> +       if (mode == CLOCK_EVT_MODE_ONESHOT) {
>                unsigned long v;
>
>  #ifndef CONFIG_ARCH_AT91SAM9263
> @@ -169,9 +167,7 @@ at91_tc_set_mode(enum clock_event_mode mode, struct
> clock_event_device *dev)
>                /* Use the clock selected by at91_timer_init as input clock.
> */
>                at91_tc_write(AT91_TC_CMR, tc_timer_clock);
>
> -               /* Load the TC register C. */
> -               next_match = __ipipe_mach_ticks_per_jiffy;
> -               write_RC(next_match);
> +               __ipipe_mach_set_dec(max_delta_ticks);
>
>                /* Enable CPCS interrupt. */
>                at91_tc_write(AT91_TC_IER, AT91_TC_CPCS);
> @@ -181,6 +177,14 @@ at91_tc_set_mode(enum clock_event_mode mode, struct
> clock_event_device *dev)
>        }
>  }
>
> +static int
> +at91_tc_set_next_event(unsigned long delta, struct clock_event_device
> *dev)
> +{
> +       tick_pending = 1;
> +       __ipipe_mach_set_dec(delta);
> +       return 0;
> +}
> +
>  /*
>  * Reprogram the timer
>  */
> @@ -208,10 +212,11 @@ int __ipipe_check_tickdev(const char *devname)
>
>  static struct clock_event_device clkevt = {
>        .name           = "at91_tc" __stringify(CONFIG_IPIPE_AT91_TC),
> -       .features       = CLOCK_EVT_FEAT_PERIODIC,
> +       .features       = CLOCK_EVT_FEAT_ONESHOT,
>        .shift          = 20,
>        .rating         = 250,
>        .set_mode       = at91_tc_set_mode,
> +       .set_next_event = at91_tc_set_next_event,
>  };
>
>  static struct __ipipe_tscinfo tsc_info = {
> @@ -230,7 +235,7 @@ static struct __ipipe_tscinfo tsc_info = {
>
>  void __ipipe_mach_release_timer(void)
>  {
> -       __ipipe_mach_set_dec(__ipipe_mach_ticks_per_jiffy);
> +       clkevt.set_next_event(__ipipe_mach_ticks_per_jiffy, &clkevt);
>  }
>  EXPORT_SYMBOL(__ipipe_mach_release_timer);
>
> @@ -293,15 +298,16 @@ void __init at91_timer_init(void)
>        clkevt.max_delta_ns = wrap_ns;
>        clkevt.min_delta_ns = 2000;
>        clkevt.cpumask = cpumask_of(0);
> -       clockevents_register_device(&clkevt);
> -
> -       tsc_info.freq = divided_freq;
> -       __ipipe_tsc_register(&tsc_info);
>
>        __ipipe_mach_ticks_per_jiffy = (divided_freq + HZ/2) / HZ;
>        max_delta_ticks = (wrap_ns * clkevt.mult) >> clkevt.shift;
>        min_delta_ticks = ((unsigned long long) clkevt.min_delta_ns
>                           * clkevt.mult) >> clkevt.shift;
> +
> +       clockevents_register_device(&clkevt);
> +
> +       tsc_info.freq = divided_freq;
> +       __ipipe_tsc_register(&tsc_info);
>  }
>
>  #ifdef CONFIG_ARCH_AT91RM9200
>
>
> --
>                                             Gilles.
>

--0016e6dd95a98cdec2049478ba1c
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Yes, it solved the issue. <br><br>There is=A0 one thing that bothers me, th=
ough. When I run=A0 &quot;xeno-test&quot;, the average and minimal=A0 laten=
cies are constant all the time.<br><br>The unpatched version of the xeno ke=
rnel seems more consistent when it comes to minimum, maximum and average la=
tencies. <br>
<br>I attached a couple of snippets of=A0 xeno-test outputs . =A0 <br><br>T=
hanks,<br><br>R.<br><br><div class=3D"gmail_quote">On Sun, Nov 7, 2010 at 4=
:45 AM, Gilles Chanteperdrix <span dir=3D"ltr">&lt;<a href=3D"mailto:gilles=
.chanteperdrix@domain.hid">gilles.chanteperdrix@xenomai.org</a>&gt;</span> wro=
te:<br>
<blockquote class=3D"gmail_quote" style=3D"margin: 0pt 0pt 0pt 0.8ex; borde=
r-left: 1px solid rgb(204, 204, 204); padding-left: 1ex;"><div class=3D"im"=
>Gilles Chanteperdrix wrote:<br>
&gt; at91_enthus wrote:<br>
&gt;&gt; Hi!<br>
&gt;&gt;<br>
&gt;&gt; I installed the latest xenomai patch on a AT91SAM9G20 board and<br=
>
&gt;&gt; everything looked good at a first glance: no compilation problems,=
 low<br>
&gt;&gt; latencies.<br>
&gt;&gt;<br>
&gt;&gt; However, when I typed cat /proc/timer_list , the resolutions in =
=A0cpu0<br>
&gt;&gt; and cpu1 items showed 100000 (ns).<br>
&gt;&gt; (I compiled the Xenomai patched kernel with High Resolution Timers=
 enabled.)<br>
&gt;&gt;<br>
&gt;&gt; I don&#39;t have this problem when I boot a real time kernel (RT_P=
REEMPT).<br>
&gt;<br>
&gt; You mean another real-time kernel? If RT_PREEMPT uses the sys timer<br=
>
&gt; running at 32kHz, and it tells you that it has a 1ns resolution, then =
it<br>
&gt; is lying, because 32kHz, means a 30us resolution.<br>
&gt;<br>
&gt; Xenomai uses one TC as a timer at whatever frequency your chip propose=
s<br>
&gt; over 1 MHz, this means a resolution below 1us, the downside is that th=
is<br>
&gt; also means a very short wrap time. And since the TC is also used as a<=
br>
&gt; clock, this means that we must enter the timer interrupt handler befor=
e<br>
&gt; the counter wraps. And this is something that Linux without Xenomai<br=
>
&gt; running can not guarantee.<br>
<br>
</div>On the other hand, we can keep the timer ticking behind Linux&#39; ba=
ck.<br>
Does the following patch fix the issue for you?<br>
<br>
diff --git a/arch/arm/mach-at91/at91_ipipe_time.c b/arch/arm/mach-at91/at91=
_ipipe_time.c<br>
index b0327eb..6c6f0d7 100644<br>
--- a/arch/arm/mach-at91/at91_ipipe_time.c<br>
+++ b/arch/arm/mach-at91/at91_ipipe_time.c<br>
@@ -76,9 +76,7 @@<br>
=A0#define TCNXCNS(timer,v) ((v) &lt;&lt; ((timer)&lt;&lt;1))<br>
=A0#define AT91_TC_REG_MASK (0xffff)<br>
<br>
-static unsigned long next_match;<br>
-<br>
-static unsigned max_delta_ticks, min_delta_ticks;<br>
+static unsigned max_delta_ticks, min_delta_ticks, tick_pending;<br>
=A0static struct clock_event_device clkevt;<br>
=A0static int tc_timer_clock;<br>
<br>
@@ -116,7 +114,11 @@ EXPORT_SYMBOL(__ipipe_mach_ticks_per_jiffy);<br>
 =A0*/<br>
=A0static irqreturn_t at91_timer_interrupt(int irq, void *dev_id)<br>
=A0{<br>
- =A0 =A0 =A0 clkevt.event_handler(&amp;clkevt);<br>
+ =A0 =A0 =A0 if (__ipipe_mach_timerstolen || tick_pending) {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 tick_pending =3D 0;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 clkevt.event_handler(&amp;clkevt);<br>
+ =A0 =A0 =A0 }<br>
+<br>
 =A0 =A0 =A0 =A0return IRQ_HANDLED;<br>
=A0}<br>
<br>
@@ -130,12 +132,8 @@ void __ipipe_mach_acktimer(void)<br>
=A0{<br>
 =A0 =A0 =A0 =A0at91_tc_read(AT91_TC_SR);<br>
<br>
- =A0 =A0 =A0 if (unlikely(!__ipipe_mach_timerstolen)) {<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 __ipipe_tsc_update();<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 next_match =3D (next_match + __ipipe_mach_tic=
ks_per_jiffy)<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &amp; AT91_TC_REG_MASK;<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 write_RC(next_match);<br>
- =A0 =A0 =A0 }<br>
+ =A0 =A0 =A0 if (unlikely(!__ipipe_mach_timerstolen))<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 __ipipe_mach_set_dec(max_delta_ticks);<br>
=A0}<br>
<br>
=A0static void<br>
@@ -147,7 +145,7 @@ at91_tc_set_mode(enum clock_event_mode mode, struct clo=
ck_event_device *dev)<br>
 =A0 =A0 =A0 =A0/* Disable all interrupts. */<br>
 =A0 =A0 =A0 =A0at91_tc_write(AT91_TC_IDR, ~0ul);<br>
<br>
- =A0 =A0 =A0 if (mode =3D=3D CLOCK_EVT_MODE_PERIODIC) {<br>
+ =A0 =A0 =A0 if (mode =3D=3D CLOCK_EVT_MODE_ONESHOT) {<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0unsigned long v;<br>
<br>
=A0#ifndef CONFIG_ARCH_AT91SAM9263<br>
@@ -169,9 +167,7 @@ at91_tc_set_mode(enum clock_event_mode mode, struct clo=
ck_event_device *dev)<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* Use the clock selected by at91_timer_ini=
t as input clock. */<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0at91_tc_write(AT91_TC_CMR, tc_timer_clock);=
<br>
<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Load the TC register C. */<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 next_match =3D __ipipe_mach_ticks_per_jiffy;<=
br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 write_RC(next_match);<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 __ipipe_mach_set_dec(max_delta_ticks);<br>
<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* Enable CPCS interrupt. */<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0at91_tc_write(AT91_TC_IER, AT91_TC_CPCS);<b=
r>
@@ -181,6 +177,14 @@ at91_tc_set_mode(enum clock_event_mode mode, struct cl=
ock_event_device *dev)<br>
 =A0 =A0 =A0 =A0}<br>
=A0}<br>
<br>
+static int<br>
+at91_tc_set_next_event(unsigned long delta, struct clock_event_device *dev=
)<br>
+{<br>
+ =A0 =A0 =A0 tick_pending =3D 1;<br>
+ =A0 =A0 =A0 __ipipe_mach_set_dec(delta);<br>
+ =A0 =A0 =A0 return 0;<br>
+}<br>
+<br>
=A0/*<br>
 =A0* Reprogram the timer<br>
 =A0*/<br>
@@ -208,10 +212,11 @@ int __ipipe_check_tickdev(const char *devname)<br>
<br>
=A0static struct clock_event_device clkevt =3D {<br>
 =A0 =A0 =A0 =A0.name =A0 =A0 =A0 =A0 =A0 =3D &quot;at91_tc&quot; __stringi=
fy(CONFIG_IPIPE_AT91_TC),<br>
- =A0 =A0 =A0 .features =A0 =A0 =A0 =3D CLOCK_EVT_FEAT_PERIODIC,<br>
+ =A0 =A0 =A0 .features =A0 =A0 =A0 =3D CLOCK_EVT_FEAT_ONESHOT,<br>
 =A0 =A0 =A0 =A0.shift =A0 =A0 =A0 =A0 =A0=3D 20,<br>
 =A0 =A0 =A0 =A0.rating =A0 =A0 =A0 =A0 =3D 250,<br>
 =A0 =A0 =A0 =A0.set_mode =A0 =A0 =A0 =3D at91_tc_set_mode,<br>
+ =A0 =A0 =A0 .set_next_event =3D at91_tc_set_next_event,<br>
=A0};<br>
<br>
=A0static struct __ipipe_tscinfo tsc_info =3D {<br>
@@ -230,7 +235,7 @@ static struct __ipipe_tscinfo tsc_info =3D {<br>
<br>
=A0void __ipipe_mach_release_timer(void)<br>
=A0{<br>
- =A0 =A0 =A0 __ipipe_mach_set_dec(__ipipe_mach_ticks_per_jiffy);<br>
+ =A0 =A0 =A0 clkevt.set_next_event(__ipipe_mach_ticks_per_jiffy, &amp;clke=
vt);<br>
=A0}<br>
=A0EXPORT_SYMBOL(__ipipe_mach_release_timer);<br>
<br>
@@ -293,15 +298,16 @@ void __init at91_timer_init(void)<br>
 =A0 =A0 =A0 =A0clkevt.max_delta_ns =3D wrap_ns;<br>
 =A0 =A0 =A0 =A0clkevt.min_delta_ns =3D 2000;<br>
 =A0 =A0 =A0 =A0clkevt.cpumask =3D cpumask_of(0);<br>
- =A0 =A0 =A0 clockevents_register_device(&amp;clkevt);<br>
-<br>
- =A0 =A0 =A0 tsc_info.freq =3D divided_freq;<br>
- =A0 =A0 =A0 __ipipe_tsc_register(&amp;tsc_info);<br>
<br>
 =A0 =A0 =A0 =A0__ipipe_mach_ticks_per_jiffy =3D (divided_freq + HZ/2) / HZ=
;<br>
 =A0 =A0 =A0 =A0max_delta_ticks =3D (wrap_ns * clkevt.mult) &gt;&gt; clkevt=
.shift;<br>
 =A0 =A0 =A0 =A0min_delta_ticks =3D ((unsigned long long) clkevt.min_delta_=
ns<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 * clkevt.mult) &gt;&gt=
; clkevt.shift;<br>
+<br>
+ =A0 =A0 =A0 clockevents_register_device(&amp;clkevt);<br>
+<br>
+ =A0 =A0 =A0 tsc_info.freq =3D divided_freq;<br>
+ =A0 =A0 =A0 __ipipe_tsc_register(&amp;tsc_info);<br>
=A0}<br>
<br>
=A0#ifdef CONFIG_ARCH_AT91RM9200<br>
<br>
<br>
--<br>
<font color=3D"#888888"> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Gilles.<br>
</font></blockquote></div><br>

--0016e6dd95a98cdec2049478ba1c--

--0016e6dd95a98cdec9049478ba1e
Content-Type: application/octet-stream; name=benchmark_no_patch
Content-Disposition: attachment; filename=benchmark_no_patch
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gg8481sy0

d2FybWluZyB1cC4uLgpSVFR8ICAwMDowMDowMSAgKHBlcmlvZGljIHVzZXItbW9kZSB0YXNrLCAx
MDAwIHVzIHBlcmlvZCwgcHJpb3JpdHkgOTkpClJUSHwtLS0tbGF0IG1pbnwtLS0tbGF0IGF2Z3wt
LS0tbGF0IG1heHwtb3ZlcnJ1bnwtLS1tc3d8LS0tbGF0IGJlc3R8LS1sYXQgd29yc3QKUlREfCAg
ICAgMTMuNTY1fCAgICAgMTMuNTY1fCAgICAgMTkuMzc5fCAgICAgICAwfCAgICAgMHwgICAgIDEz
LjU2NXwgICAgIDE5LjM3OQpSVER8ICAgICAxMy41NjV8ICAgICAxNS41MDN8ICAgICA3NC42MTJ8
ICAgICAgIDB8ICAgICAwfCAgICAgMTMuNTY1fCAgICAgNzQuNjEyClJURHwgICAgIDEzLjU2NXwg
ICAgIDQ1LjU0MnwgICAgIDcyLjY3NHwgICAgICAgMHwgICAgIDB8ICAgICAxMy41NjV8ICAgICA3
NC42MTIKUlREfCAgICAgMTQuNTM0fCAgICAgMTQuNTM0fCAgICAgMzguNzU5fCAgICAgICAwfCAg
ICAgMHwgICAgIDEzLjU2NXwgICAgIDc0LjYxMgpSVER8ICAgICA1Ni4yMDF8ICAgICA1Ny4xNzB8
ICAgICA4MC40MjZ8ICAgICAgIDB8ICAgICAwfCAgICAgMTMuNTY1fCAgICAgODAuNDI2ClJURHwg
ICAgIDE0LjUzNHwgICAgIDE0LjUzNHwgICAgIDM0Ljg4M3wgICAgICAgMHwgICAgIDB8ICAgICAx
My41NjV8ICAgICA4MC40MjYKUlREfCAgICAgNTYuMjAxfCAgICAgNTYuMjAxfCAgICAgNzEuNzA1
fCAgICAgICAwfCAgICAgMHwgICAgIDEzLjU2NXwgICAgIDgwLjQyNgpSVER8ICAgICAxNC41MzR8
ICAgICA0NS41NDJ8ICAgICA3Mi42NzR8ICAgICAgIDB8ICAgICAwfCAgICAgMTMuNTY1fCAgICAg
ODAuNDI2ClJURHwgICAgIDE0LjUzNHwgICAgIDE0LjUzNHwgICAgIDMxLjAwN3wgICAgICAgMHwg
ICAgIDB8ICAgICAxMy41NjV8ICAgICA4MC40MjYKUlREfCAgICAgMTguNDEwfCAgICAgNTYuMjAx
fCAgICAgODEuMzk1fCAgICAgICAwfCAgICAgMHwgICAgIDEzLjU2NXwgICAgIDgxLjM5NQpSVER8
ICAgICAxNC41MzR8ICAgICAxNC41MzR8ICAgICAzMC4wMzh8ICAgICAgIDB8ICAgICAwfCAgICAg
MTMuNTY1fCAgICAgODEuMzk1ClJURHwgICAgIDEzLjU2NXwgICAgIDE0LjUzNHwgICAgIDMzLjkx
NHwgICAgICAgMHwgICAgIDB8ICAgICAxMy41NjV8ICAgICA4MS4zOTUKUlREfCAgICAgNTUuMjMy
fCAgICAgNTYuMjAxfCAgICAgNzYuNTUwfCAgICAgICAwfCAgICAgMHwgICAgIDEzLjU2NXwgICAg
IDgxLjM5NQpSVER8ICAgICAxNC41MzR8ICAgICAxNC41MzR8ICAgICAzNS44NTJ8ICAgICAgIDB8
ICAgICAwfCAgICAgMTMuNTY1fCAgICAgODEuMzk1ClJURHwgICAgIDU2LjIwMXwgICAgIDU3LjE3
MHwgICAgIDgwLjQyNnwgICAgICAgMHwgICAgIDB8ICAgICAxMy41NjV8ICAgICA4MS4zOTUKUlRE
fCAgICAgMTMuNTY1fCAgICAgMTQuNTM0fCAgICAgNTAuMzg3fCAgICAgICAwfCAgICAgMHwgICAg
IDEzLjU2NXwgICAgIDgxLjM5NQpSVER8ICAgICA1Ni4yMDF8ICAgICA1Ni4yMDF8ICAgICA3Mi42
NzR8ICAgICAgIDB8ICAgICAwfCAgICAgMTMuNTY1fCAgICAgODEuMzk1ClJURHwgICAgIDE0LjUz
NHwgICAgIDQ1LjU0MnwgICAgIDczLjY0M3wgICAgICAgMHwgICAgIDB8ICAgICAxMy41NjV8ICAg
ICA4MS4zOTUKUlREfCAgICAgMTQuNTM0fCAgICAgMTQuNTM0fCAgICAgMzEuMDA3fCAgICAgICAw
fCAgICAgMHwgICAgIDEzLjU2NXwgICAgIDgxLjM5NQpSVER8ICAgICAxOC40MTB8ICAgICA1Ni4y
MDF8ICAgICA4MC40MjZ8ICAgICAgIDB8ICAgICAwfCAgICAgMTMuNTY1fCAgICAgODEuMzk1ClJU
RHwgICAgIDE0LjUzNHwgICAgIDE0LjUzNHwgICAgIDMyLjk0NXwgICAgICAgMHwgICAgIDB8ICAg
ICAxMy41NjV8ICAgICA4MS4zOTUK
--0016e6dd95a98cdec9049478ba1e
Content-Type: application/octet-stream; name=benchmark_patched
Content-Disposition: attachment; filename=benchmark_patched
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gg848ii01

d2FybWluZyB1cC4uLgpSVFR8ICAwMDowMDowMSAgKHBlcmlvZGljIHVzZXItbW9kZSB0YXNrLCAx
MDAwIHVzIHBlcmlvZCwgcHJpb3JpdHkgOTkpClJUSHwtLS0tbGF0IG1pbnwtLS0tbGF0IGF2Z3wt
LS0tbGF0IG1heHwtb3ZlcnJ1bnwtLS1tc3d8LS0tbGF0IGJlc3R8LS1sYXQgd29yc3QKUlREfCAg
ICAgNDcuNDgwfCAgICAgNDcuNDgwfCAgICAgNTAuMzg3fCAgICAgICAwfCAgICAgMHwgICAgIDQ3
LjQ4MHwgICAgIDUwLjM4NwpSVER8ICAgICA0Ny40ODB8ICAgICA0Ny40ODB8ICAgICA2Ny44Mjl8
ICAgICAgIDB8ICAgICAwfCAgICAgNDcuNDgwfCAgICAgNjcuODI5ClJURHwgICAgIDQ3LjQ4MHwg
ICAgIDQ3LjQ4MHwgICAgIDU5LjEwOHwgICAgICAgMHwgICAgIDB8ICAgICA0Ny40ODB8ICAgICA2
Ny44MjkKUlREfCAgICAgNDcuNDgwfCAgICAgNDcuNDgwfCAgICAgNjUuODkxfCAgICAgICAwfCAg
ICAgMHwgICAgIDQ3LjQ4MHwgICAgIDY3LjgyOQpSVER8ICAgICA0Ny40ODB8ICAgICA0Ny40ODB8
ICAgICA2Ny44Mjl8ICAgICAgIDB8ICAgICAwfCAgICAgNDcuNDgwfCAgICAgNjcuODI5ClJURHwg
ICAgIDQ3LjQ4MHwgICAgIDQ3LjQ4MHwgICAgIDYxLjA0NnwgICAgICAgMHwgICAgIDB8ICAgICA0
Ny40ODB8ICAgICA2Ny44MjkKUlREfCAgICAgNDcuNDgwfCAgICAgNDcuNDgwfCAgICAgNTkuMTA4
fCAgICAgICAwfCAgICAgMHwgICAgIDQ3LjQ4MHwgICAgIDY3LjgyOQpSVER8ICAgICA0Ny40ODB8
ICAgICA0Ny40ODB8ICAgICA2MS4wNDZ8ICAgICAgIDB8ICAgICAwfCAgICAgNDcuNDgwfCAgICAg
NjcuODI5ClJURHwgICAgIDQ3LjQ4MHwgICAgIDQ3LjQ4MHwgICAgIDU5LjEwOHwgICAgICAgMHwg
ICAgIDB8ICAgICA0Ny40ODB8ICAgICA2Ny44MjkKUlREfCAgICAgNDcuNDgwfCAgICAgNDcuNDgw
fCAgICAgNTkuMTA4fCAgICAgICAwfCAgICAgMHwgICAgIDQ3LjQ4MHwgICAgIDY3LjgyOQpSVER8
ICAgICA0Ny40ODB8ICAgICA0Ny40ODB8ICAgICA3Ny41MTl8ICAgICAgIDB8ICAgICAwfCAgICAg
NDcuNDgwfCAgICAgNzcuNTE5ClJURHwgICAgIDQ3LjQ4MHwgICAgIDQ3LjQ4MHwgICAgIDU4LjEz
OXwgICAgICAgMHwgICAgIDB8ICAgICA0Ny40ODB8ICAgICA3Ny41MTkKUlREfCAgICAgNDcuNDgw
fCAgICAgNDcuNDgwfCAgICAgNTguMTM5fCAgICAgICAwfCAgICAgMHwgICAgIDQ3LjQ4MHwgICAg
IDc3LjUxOQpSVER8ICAgICA0Ny40ODB8ICAgICA0Ny40ODB8ICAgICA1OS4xMDh8ICAgICAgIDB8
ICAgICAwfCAgICAgNDcuNDgwfCAgICAgNzcuNTE5ClJURHwgICAgIDQ3LjQ4MHwgICAgIDQ3LjQ4
MHwgICAgIDU4LjEzOXwgICAgICAgMHwgICAgIDB8ICAgICA0Ny40ODB8ICAgICA3Ny41MTkKUlRE
fCAgICAgNDcuNDgwfCAgICAgNDcuNDgwfCAgICAgNjEuMDQ2fCAgICAgICAwfCAgICAgMHwgICAg
IDQ3LjQ4MHwgICAgIDc3LjUxOQpSVER8ICAgICA0Ny40ODB8ICAgICA0Ny40ODB8ICAgICA3Ny41
MTl8ICAgICAgIDB8ICAgICAwfCAgICAgNDcuNDgwfCAgICAgNzcuNTE5ClJURHwgICAgIDQ3LjQ4
MHwgICAgIDQ3LjQ4MHwgICAgIDU4LjEzOXwgICAgICAgMHwgICAgIDB8ICAgICA0Ny40ODB8ICAg
ICA3Ny41MTkKUlREfCAgICAgNDcuNDgwfCAgICAgNDcuNDgwfCAgICAgNTkuMTA4fCAgICAgICAw
fCAgICAgMHwgICAgIDQ3LjQ4MHwgICAgIDc3LjUxOQpSVER8ICAgICA0Ny40ODB8ICAgICA0Ny40
ODB8ICAgICA2MC4wNzd8ICAgICAgIDB8ICAgICAwfCAgICAgNDcuNDgwfCAgICAgNzcuNTE5ClJU
RHwgICAgIDQ3LjQ4MHwgICAgIDQ3LjQ4MHwgICAgIDYwLjA3N3wgICAgICAgMHwgICAgIDB8ICAg
ICA0Ny40ODB8ICAgICA3Ny41MTkK
--0016e6dd95a98cdec9049478ba1e--

