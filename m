Message-ID: <67b6b3430811101607k75eaa084ga387c453096d2710@domain.hid>
Date: Mon, 10 Nov 2008 16:07:20 -0800
From: "Mark Saiia" <mark.saiia@domain.hid>
In-Reply-To: <4915C4D3.8030304@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_114490_16543491.1226362040370"
References: <51CAD0CE1504444DBE77CBBE51A0135D533259@domain.hid>
	<490ECE11.208@domain.hid>
	<51CAD0CE1504444DBE77CBBE51A0135D53325A@slcmail.slc.mew.int>
	<490F2F23.2080307@domain.hid>
	<67b6b3430811031237v4cfba0c9sf63e40a697f3da58@domain.hid>
	<49100825.9000502@domain.hid> <4915C4D3.8030304@domain.hid>
Subject: Re: [Xenomai-help] fpu context switch issue
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

------=_Part_114490_16543491.1226362040370
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello,

The patch would not apply cleanly(rejected Hunk) against 2.4.5
w/linux2.6.26.3 or svn 4368 w/linux2.6.26.7.

I edited pod_32.h to try and incorporate the changes listed in the patch.

Building with both Xenomai/Linux combinations gives the following errors.
include/asm/xenomai/bits/pod_32.h: In function 'xnarch_init_fpu':
include/asm/xenomai/bits/pod_32.h:220: error: 'x86_fpu_state' undeclared
(first use in this function)
include/asm/xenomai/bits/pod_32.h:220: error: (Each undeclared identifier is
reported only once
include/asm/xenomai/bits/pod_32.h:220: error: for each function it appears
in.)
include/asm/xenomai/bits/pod_32.h:220: error: 'fpup' undeclared (first use
in this function)
include/asm/xenomai/bits/pod_32.h:229: error: dereferencing pointer to
incomplete type
include/asm/xenomai/bits/pod_32.h:229: error: dereferencing pointer to
incomplete type
include/asm/xenomai/bits/pod_32.h:229: error: dereferencing pointer to
incomplete type
include/asm/xenomai/bits/pod_32.h:229: error: dereferencing pointer to
incomplete type
include/asm/xenomai/bits/pod_32.h:229: error: dereferencing pointer to
incomplete type
include/asm/xenomai/bits/pod_32.h:229: error: dereferencing pointer to
incomplete type
include/asm/xenomai/bits/pod_32.h:230: error: dereferencing pointer to
incomplete type
include/asm/xenomai/bits/pod_32.h:233: error: dereferencing pointer to
incomplete type
include/asm/xenomai/bits/pod_32.h:238: error: dereferencing pointer to
incomplete type
include/asm/xenomai/bits/pod_32.h:238: error: memory input 0 is not directly
addressable


My init_fpu function looks like this, which I believe corresponds to your
patch.

       struct task_struct *task = tcb->user_task;
       x86_fpu_state *fpup = tcb->fpup;

       /* Initialize the FPU for a task. This must be run on behalf of the
       task. */

       if (cpu_has_fxsr) {
               struct i837_fxsave_struct *fx = &fpup->fxsave;

               memset(fx, 0, sizeof(*fx));
               fx->cwd = 0x37f;
               if (cpu_has_xmm) {
                       unsigned long __mxcsr = 0x1f80UL & 0xffbfUL;
                       fx->mxcsr = __mxcsr;
               }

               clts();

               __asm__ __volatile__("fxrstor %0": /* no output */
:"m"(*fx));
       } else {
               struct i387_fsave_struct *fp = &fpup->fsave;

               memset(fp, 0, sizeof(*fp));
               fp->cwd = 0xffff037fu;
               fp->swd = 0xffff0000u;
               fp->twd = 0xffffffffu;
               fp->fos = 0xffff0000u;

               clts();

               __asm__ __volatile__("frstor %0": /* no output */ :"m"(*fp));
       }
        if (task) {
        /* Real-time shadow FPU initialization: tell Linux that this
           thread initialized its FPU hardware. The fpu usage bit is
           necessary for xnarch_save_fpu to save the FPU state at next
           switch. */
        xnarch_set_fpu_init(task);
        wrap_set_fpu_used(task);
    }

Please let me know, if I did anything incorrectly, or if the patch was not
completely posted.


Thanks for your work,

Mark


On Sat, Nov 8, 2008 at 8:56 AM, Gilles Chanteperdrix <
gilles.chanteperdrix@xenomai.org> wrote:

> Gilles Chanteperdrix wrote:
> > Mark Saiia wrote:
> >> Hello,
> >>
> >> The switchtest output is as follows.  This was run on 2.4.5 with
> 2.6.26.3
> >> AMD Geode LX800 board.
> >> In order to get it to run, I had to remove modprobe xeno_native from my
> >> start-up script.  I don't know if that is an expected requirement prior
> to
> >> running the test.
> >>
> >> == Testing FPU check routines...
> >> r0: 1 != 2
> >> r1: 1 != 2
> >> r2: 1 != 2
> >> r3: 1 != 2
> >> r4: 1 != 2
> >> r5: 1 != 2
> >> r6: 1 != 2
> >> r7: 1 != 2
> >> == FPU check routines: OK.
> >> == Threads: sleeper_ufps-0 rtk-1 rtk-2 rtk_fp-3 rtk_fp-4 rtk_fp_ufpp-5
> >> rtk_fp_ufpp-6 rtup-7 rtup-8 rtup_ufpp-9 rtup_ufpp-10 rtus-11 rtus-12
> >> rtus_ufps-13 rtus_ufps-14 rtuo-15 rtuo-16 rtuo_ufpp-17 rtuo_ufpp-18
> >> rtuo_ufps-19 rtuo_ufps-20 rtuo_ufpp_ufps-21 rtuo_ufpp_ufps-22
> >> RTT|  00:00:01
> >> RTH|ctx switches|-------total
> >> RTD|       17250|       17250
> >> RTD|       17250|       34500
> >> RTD|       17250|       51750
> >> RTD|       17250|       69000
> >> RTD|       17273|       86273
> >> RTD|       17273|      103546
> >> RTD|       17273|      120819
> >> RTD|       17250|      138069
> >> RTD|       17250|      155319
> >> RTD|       17273|      172592
> >> RTD|       17250|      189842
> >> RTD|       17250|      207092
> >> RTD|       17273|      224365
> >> RTD|       17273|      241638
> >> RTD|       17273|      258911
> >> RTD|       17250|      276161
> >> RTD|       17250|      293411
> >> RTD|       17250|      310661
> >> RTD|       17273|      327934
> >> RTD|       17273|      345207
> >> RTD|       17250|      362457
> >>
> >> Thanks in advance for any help.
> >>
> >> Mark Saiia
> >
> >
> > Hi,
> >
> > It seems you do not get the same error with switchtest as you get with
> > your test program. I had a look at linux fpu handling, and it seems to
> > be very different from Xenomai fpu handling. I need to dig a little bit
> > more, but will send you a patch soon.
>
> Here comes the promised patch.
>
> Index: include/asm-x86/bits/pod_32.h
> ===================================================================
> --- include/asm-x86/bits/pod_32.h       (revision 4355)
> +++ include/asm-x86/bits/pod_32.h       (working copy)
> @@ -194,16 +194,37 @@ static inline void xnarch_init_thread(xn
>  static inline void xnarch_init_fpu(xnarchtcb_t * tcb)
>  {
>        struct task_struct *task = tcb->user_task;
> +       x86_fpu_state *fpup = tcb->fpup;
>        /* Initialize the FPU for a task. This must be run on behalf of the
>           task. */
>
> -       __asm__ __volatile__("clts; fninit");
> +       if (cpu_has_fxsr) {
> +               struct i837_fxsave_struct *fx = &fpup->fxsave;
>
> -       if (cpu_has_xmm) {
> -               unsigned long __mxcsr = 0x1f80UL & 0xffbfUL;
> -               __asm__ __volatile__("ldmxcsr %0"::"m"(__mxcsr));
> -       }
> +               memset(fx, 0, sizeof(*fx));
> +               fx->cwd = 0x37f;
> +               if (cpu_has_xmm) {
> +                       unsigned long __mxcsr = 0x1f80UL & 0xffbfUL;
> +                       fx->mxcsr = __mxcsr;
> +               }
> +
> +               clts();
> +
> +               __asm__ __volatile__("fxrstor %0": /* no output */
> :"m"(*fx));
> +       } else {
> +               struct i387_fsave_struct *fp = &fpup->fsave;
> +
> +               memset(fp, 0, sizeof(*fp));
> +               fp->cwd = 0xffff037fu;
> +               fp->swd = 0xffff0000u;
> +               fp->twd = 0xffffffffu;
> +               fp->fos = 0xffff0000u;
> +
> +               clts();
>
> +               __asm__ __volatile__("frstor %0": /* no output */
> :"m"(*fp));
> +       }
> +
>        if (task) {
>                /* Real-time shadow FPU initialization: tell Linux that this
>                   thread initialized its FPU hardware. The fpu usage bit is
>
>
>
> --
>                                             Gilles.
>

------=_Part_114490_16543491.1226362040370
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello,<br><br>The patch would not apply cleanly(rejected Hunk) against 2.4.5 w/linux2.6.26.3 or svn 4368 w/linux2.6.26.7.<br><br>I edited pod_32.h to try and incorporate the changes listed in the patch.<br><br>Building with both Xenomai/Linux combinations gives the following errors.<br>
include/asm/xenomai/bits/pod_32.h: In function 'xnarch_init_fpu':<br>include/asm/xenomai/bits/pod_32.h:220: error: 'x86_fpu_state' undeclared (first use in this function)<br>include/asm/xenomai/bits/pod_32.h:220: error: (Each undeclared identifier is reported only once<br>
include/asm/xenomai/bits/pod_32.h:220: error: for each function it appears in.)<br>include/asm/xenomai/bits/pod_32.h:220: error: 'fpup' undeclared (first use in this function)<br>include/asm/xenomai/bits/pod_32.h:229: error: dereferencing pointer to incomplete type<br>
include/asm/xenomai/bits/pod_32.h:229: error: dereferencing pointer to incomplete type<br>include/asm/xenomai/bits/pod_32.h:229: error: dereferencing pointer to incomplete type<br>include/asm/xenomai/bits/pod_32.h:229: error: dereferencing pointer to incomplete type<br>
include/asm/xenomai/bits/pod_32.h:229: error: dereferencing pointer to incomplete type<br>include/asm/xenomai/bits/pod_32.h:229: error: dereferencing pointer to incomplete type<br>include/asm/xenomai/bits/pod_32.h:230: error: dereferencing pointer to incomplete type<br>
include/asm/xenomai/bits/pod_32.h:233: error: dereferencing pointer to incomplete type<br>include/asm/xenomai/bits/pod_32.h:238: error: dereferencing pointer to incomplete type<br>include/asm/xenomai/bits/pod_32.h:238: error: memory input 0 is not directly addressable<br>
<br><br>My init_fpu function looks like this, which I believe corresponds to your patch.<br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct task_struct *task = tcb-&gt;user_task;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; x86_fpu_state *fpup = tcb-&gt;fpup;<br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Initialize the FPU for a task. This must be run on behalf of the<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp; task. */<br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (cpu_has_fxsr) {<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct i837_fxsave_struct *fx = &amp;fpup-&gt;fxsave;<br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memset(fx, 0, sizeof(*fx));&nbsp;&nbsp;&nbsp; <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; fx-&gt;cwd = 0x37f;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (cpu_has_xmm) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned long __mxcsr = 0x1f80UL &amp; 0xffbfUL;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; fx-&gt;mxcsr = __mxcsr;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; clts();<br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __asm__ __volatile__(&quot;fxrstor %0&quot;: /* no output */ :&quot;m&quot;(*fx));<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct i387_fsave_struct *fp = &amp;fpup-&gt;fsave;<br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memset(fp, 0, sizeof(*fp));<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; fp-&gt;cwd = 0xffff037fu;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; fp-&gt;swd = 0xffff0000u;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; fp-&gt;twd = 0xffffffffu;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; fp-&gt;fos = 0xffff0000u;<br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; clts();<br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __asm__ __volatile__(&quot;frstor %0&quot;: /* no output */ :&quot;m&quot;(*fp));<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (task) {<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; /* Real-time shadow FPU initialization: tell Linux that this<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp; thread initialized its FPU hardware. The fpu usage bit is<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp; necessary for xnarch_save_fpu to save the FPU state at next<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp; switch. */<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; xnarch_set_fpu_init(task);<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; wrap_set_fpu_used(task);<br>&nbsp;&nbsp;&nbsp; }<br><br>Please let me know, if I did anything incorrectly, or if the patch was not completely posted.<br><br><br>Thanks for your work,<br>
<br>Mark<br><br><br><div class="gmail_quote">On Sat, Nov 8, 2008 at 8:56 AM, Gilles Chanteperdrix <span dir="ltr">&lt;<a href="mailto:gilles.chanteperdrix@xenomai.org">gilles.chanteperdrix@xenomai.org</a>&gt;</span> wrote:<br>
<blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"><div><div></div><div class="Wj3C7c">Gilles Chanteperdrix wrote:<br>
&gt; Mark Saiia wrote:<br>
&gt;&gt; Hello,<br>
&gt;&gt;<br>
&gt;&gt; The switchtest output is as follows. &nbsp;This was run on 2.4.5 with <a href="http://2.6.26.3" target="_blank">2.6.26.3</a><br>
&gt;&gt; AMD Geode LX800 board.<br>
&gt;&gt; In order to get it to run, I had to remove modprobe xeno_native from my<br>
&gt;&gt; start-up script. &nbsp;I don&#39;t know if that is an expected requirement prior to<br>
&gt;&gt; running the test.<br>
&gt;&gt;<br>
&gt;&gt; == Testing FPU check routines...<br>
&gt;&gt; r0: 1 != 2<br>
&gt;&gt; r1: 1 != 2<br>
&gt;&gt; r2: 1 != 2<br>
&gt;&gt; r3: 1 != 2<br>
&gt;&gt; r4: 1 != 2<br>
&gt;&gt; r5: 1 != 2<br>
&gt;&gt; r6: 1 != 2<br>
&gt;&gt; r7: 1 != 2<br>
&gt;&gt; == FPU check routines: OK.<br>
&gt;&gt; == Threads: sleeper_ufps-0 rtk-1 rtk-2 rtk_fp-3 rtk_fp-4 rtk_fp_ufpp-5<br>
&gt;&gt; rtk_fp_ufpp-6 rtup-7 rtup-8 rtup_ufpp-9 rtup_ufpp-10 rtus-11 rtus-12<br>
&gt;&gt; rtus_ufps-13 rtus_ufps-14 rtuo-15 rtuo-16 rtuo_ufpp-17 rtuo_ufpp-18<br>
&gt;&gt; rtuo_ufps-19 rtuo_ufps-20 rtuo_ufpp_ufps-21 rtuo_ufpp_ufps-22<br>
&gt;&gt; RTT| &nbsp;00:00:01<br>
&gt;&gt; RTH|ctx switches|-------total<br>
&gt;&gt; RTD| &nbsp; &nbsp; &nbsp; 17250| &nbsp; &nbsp; &nbsp; 17250<br>
&gt;&gt; RTD| &nbsp; &nbsp; &nbsp; 17250| &nbsp; &nbsp; &nbsp; 34500<br>
&gt;&gt; RTD| &nbsp; &nbsp; &nbsp; 17250| &nbsp; &nbsp; &nbsp; 51750<br>
&gt;&gt; RTD| &nbsp; &nbsp; &nbsp; 17250| &nbsp; &nbsp; &nbsp; 69000<br>
&gt;&gt; RTD| &nbsp; &nbsp; &nbsp; 17273| &nbsp; &nbsp; &nbsp; 86273<br>
&gt;&gt; RTD| &nbsp; &nbsp; &nbsp; 17273| &nbsp; &nbsp; &nbsp;103546<br>
&gt;&gt; RTD| &nbsp; &nbsp; &nbsp; 17273| &nbsp; &nbsp; &nbsp;120819<br>
&gt;&gt; RTD| &nbsp; &nbsp; &nbsp; 17250| &nbsp; &nbsp; &nbsp;138069<br>
&gt;&gt; RTD| &nbsp; &nbsp; &nbsp; 17250| &nbsp; &nbsp; &nbsp;155319<br>
&gt;&gt; RTD| &nbsp; &nbsp; &nbsp; 17273| &nbsp; &nbsp; &nbsp;172592<br>
&gt;&gt; RTD| &nbsp; &nbsp; &nbsp; 17250| &nbsp; &nbsp; &nbsp;189842<br>
&gt;&gt; RTD| &nbsp; &nbsp; &nbsp; 17250| &nbsp; &nbsp; &nbsp;207092<br>
&gt;&gt; RTD| &nbsp; &nbsp; &nbsp; 17273| &nbsp; &nbsp; &nbsp;224365<br>
&gt;&gt; RTD| &nbsp; &nbsp; &nbsp; 17273| &nbsp; &nbsp; &nbsp;241638<br>
&gt;&gt; RTD| &nbsp; &nbsp; &nbsp; 17273| &nbsp; &nbsp; &nbsp;258911<br>
&gt;&gt; RTD| &nbsp; &nbsp; &nbsp; 17250| &nbsp; &nbsp; &nbsp;276161<br>
&gt;&gt; RTD| &nbsp; &nbsp; &nbsp; 17250| &nbsp; &nbsp; &nbsp;293411<br>
&gt;&gt; RTD| &nbsp; &nbsp; &nbsp; 17250| &nbsp; &nbsp; &nbsp;310661<br>
&gt;&gt; RTD| &nbsp; &nbsp; &nbsp; 17273| &nbsp; &nbsp; &nbsp;327934<br>
&gt;&gt; RTD| &nbsp; &nbsp; &nbsp; 17273| &nbsp; &nbsp; &nbsp;345207<br>
&gt;&gt; RTD| &nbsp; &nbsp; &nbsp; 17250| &nbsp; &nbsp; &nbsp;362457<br>
&gt;&gt;<br>
&gt;&gt; Thanks in advance for any help.<br>
&gt;&gt;<br>
&gt;&gt; Mark Saiia<br>
&gt;<br>
&gt;<br>
&gt; Hi,<br>
&gt;<br>
&gt; It seems you do not get the same error with switchtest as you get with<br>
&gt; your test program. I had a look at linux fpu handling, and it seems to<br>
&gt; be very different from Xenomai fpu handling. I need to dig a little bit<br>
&gt; more, but will send you a patch soon.<br>
<br>
</div></div>Here comes the promised patch.<br>
<br>
Index: include/asm-x86/bits/pod_32.h<br>
===================================================================<br>
--- include/asm-x86/bits/pod_32.h &nbsp; &nbsp; &nbsp; (revision 4355)<br>
+++ include/asm-x86/bits/pod_32.h &nbsp; &nbsp; &nbsp; (working copy)<br>
@@ -194,16 +194,37 @@ static inline void xnarch_init_thread(xn<br>
&nbsp;static inline void xnarch_init_fpu(xnarchtcb_t * tcb)<br>
&nbsp;{<br>
 &nbsp; &nbsp; &nbsp; &nbsp;struct task_struct *task = tcb-&gt;user_task;<br>
+ &nbsp; &nbsp; &nbsp; x86_fpu_state *fpup = tcb-&gt;fpup;<br>
 &nbsp; &nbsp; &nbsp; &nbsp;/* Initialize the FPU for a task. This must be run on behalf of the<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; task. */<br>
<br>
- &nbsp; &nbsp; &nbsp; __asm__ __volatile__(&quot;clts; fninit&quot;);<br>
+ &nbsp; &nbsp; &nbsp; if (cpu_has_fxsr) {<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; struct i837_fxsave_struct *fx = &amp;fpup-&gt;fxsave;<br>
<br>
- &nbsp; &nbsp; &nbsp; if (cpu_has_xmm) {<br>
- &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; unsigned long __mxcsr = 0x1f80UL &amp; 0xffbfUL;<br>
- &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; __asm__ __volatile__(&quot;ldmxcsr %0&quot;::&quot;m&quot;(__mxcsr));<br>
- &nbsp; &nbsp; &nbsp; }<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; memset(fx, 0, sizeof(*fx));<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; fx-&gt;cwd = 0x37f;<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; if (cpu_has_xmm) {<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; unsigned long __mxcsr = 0x1f80UL &amp; 0xffbfUL;<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; fx-&gt;mxcsr = __mxcsr;<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; }<br>
+<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; clts();<br>
+<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; __asm__ __volatile__(&quot;fxrstor %0&quot;: /* no output */ :&quot;m&quot;(*fx));<br>
+ &nbsp; &nbsp; &nbsp; } else {<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; struct i387_fsave_struct *fp = &amp;fpup-&gt;fsave;<br>
+<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; memset(fp, 0, sizeof(*fp));<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; fp-&gt;cwd = 0xffff037fu;<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; fp-&gt;swd = 0xffff0000u;<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; fp-&gt;twd = 0xffffffffu;<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; fp-&gt;fos = 0xffff0000u;<br>
+<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; clts();<br>
<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; __asm__ __volatile__(&quot;frstor %0&quot;: /* no output */ :&quot;m&quot;(*fp));<br>
+ &nbsp; &nbsp; &nbsp; }<br>
+<br>
 &nbsp; &nbsp; &nbsp; &nbsp;if (task) {<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;/* Real-time shadow FPU initialization: tell Linux that this<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; thread initialized its FPU hardware. The fpu usage bit is<br>
<br>
<br>
<br>
--<br>
<font color="#888888"> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;Gilles.<br>
</font></blockquote></div><br>

------=_Part_114490_16543491.1226362040370--

