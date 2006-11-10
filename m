Message-ID: <4546494d0611100554h6dfee69boca6fa79978f1fac2@domain.hid>
Date: Fri, 10 Nov 2006 21:54:24 +0800
From: "Li Yi (Adam)" <liyiadam@domain.hid>
In-Reply-To: <45203E31.6050707@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_70650_5530952.1163166864733"
References: <4546494d0609300059p2879d7bcwb9bc898f279df140@domain.hid>
	<45203E31.6050707@domain.hid>
Subject: [Xenomai-core] Re: [Adeos-main] ipip tracer porting for blackfin
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: adeos-main@gna.org, xenomai@xenomai.org

------=_Part_70650_5530952.1163166864733
Content-Type: multipart/alternative; 
	boundary="----=_Part_70651_12947585.1163166864733"

------=_Part_70651_12947585.1163166864733
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Jan and Philippe,

I have tested the adeos-ipipe-bf53x-CVS-20061008-1.5-00.patch in
Xenomai-2.2.5 with latest Blackfin uclinux toolchain 06r2 release:
http://blackfin.uclinux.org/frs/download.php/1136/blackfin-toolchain-06r2-5.i386.rpm.
Since the toolchain changed a little for the "mcount" call, the ipipe-tracer
patch need to be updated a little.

Also I add trace for IRQ entry and exit as Jan suggested. Here is the
details of the patch (with my explanation)

diff -Nur linux-2.6.x-ipipe-orig/arch/blackfin/kernel/ipipe-mcount.S
linux-2.6.x-ipipe/arch/blackfin/kernel/ipipe-mcount.S
--- linux-2.6.x-ipipe-orig/arch/blackfin/kernel/ipipe-mcount.S  2006-11-10
21:04:21.000000000 +0800
+++ linux-2.6.x-ipipe/arch/blackfin/kernel/ipipe-mcount.S       2006-11-10
16:41:11.000000000 +0800
@@ -12,7 +12,7 @@

 .align 4       /* just in case */

-ENTRY(_mcount)
+ENTRY(__mcount)
        [--sp] = ( r7:0, p5:0 );
        [--sp] = ASTAT;
        p1.L = _ipipe_trace_enable;
diff -Nur linux-2.6.x-ipipe-orig/arch/blackfin/kernel/ipipe-root.c
linux-2.6.x-ipipe/arch/blackfin/kernel/ipipe-root.c
--- linux-2.6.x-ipipe-orig/arch/blackfin/kernel/ipipe- root.c    2006-11-10
21:04:21.000000000 +0800
+++ linux-2.6.x-ipipe/arch/blackfin/kernel/ipipe-root.c 2006-11-10 16:41:
59.000000000 +0800
@@ -281,6 +281,6 @@
 EXPORT_SYMBOL(show_stack);

 #ifdef CONFIG_IPIPE_TRACE_MCOUNT
-void notrace mcount(void);
-EXPORT_SYMBOL(mcount);
+void notrace _mcount(void);
+EXPORT_SYMBOL(_mcount);
 #endif /* CONFIG_IPIPE_TRACE_MCOUNT */

<Yi's note>: The  gcc  will add "Call _ _mcount" to each function entry when
there is "-pg" option

diff -Nur linux-2.6.x-ipipe-orig/arch/blackfin/mach-common/interrupt.S
linux-2.6.x-ipipe/arch/blackfin/mach-common/interrupt.S
--- linux-2.6.x-ipipe-orig/arch/blackfin/mach-common/interrupt.S
2006-11-10 21:04: 21.000000000 +0800
+++ linux-2.6.x-ipipe/arch/blackfin/mach-common/interrupt.S     2006-11-10
16:43:55.000000000 +0800
@@ -304,7 +304,10 @@
        p0.l = _irq_flags;
        p0.h = _irq_flags;
        r0 = [p0];
-       sti r0
+       sti r0;
+       /* Reenable interrupts */
+       [--sp] = reti;
+       r0 = [sp++];
        rts;

 #endif /* CONFIG_IPIPE */


<Yi's Note>: I used the ipipe-trace to trace the latency test case: "latency
-t2 -p200 -f". And found that "__ipipe_call_irqtail()" will disable global
interrupts, putting the Blackfin to a state like:
"IMASK: 0x0000FFFF, ILAT: 0x00000040, IPEND: 0x0000c010" - that is, Core
Timer irq latched, but since IPEND[4] is set, the irq handler cannot be
invoked - thus longer latency.


diff -Nur linux-2.6.x-ipipe-orig /arch/blackfin/mach-common/ints-
priority-sc.c linux-2.6.x-ipipe/arch/blackfin/mach-common/ints-priority-sc.c
--- linux-2.6.x-ipipe-orig/arch/blackfin/mach-common/ints-priority-sc.c2006-11-10
21:04:
21.000000000 +0800
+++ linux-2.6.x-ipipe/arch/blackfin/mach-common/ints-priority-sc.c
2006-11-10 16:45:44.000000000 +0800
@@ -1013,7 +1013,13 @@

 handle_irq:

+#ifdef CONFIG_IPIPE_TRACE_IRQSOFF
+       ipipe_trace_begin(irq);
+#endif /* CONFIG_IPIPE_TRACE_IRQSOFF */
        __ipipe_handle_irq(irq, regs);
+#ifdef CONFIG_IPIPE_TRACE_IRQSOFF
+       ipipe_trace_end(irq);
+#endif /* CONFIG_IPIPE_TRACE_IRQSOFF */
diff -Nur linux-2.6.x-ipipe-orig /kernel/ipipe/Kconfig linux-2.6.x-ipipe
/kernel/ipipe/Kconfig
--- linux-2.6.x-ipipe-orig/kernel/ipipe/Kconfig 2006-11-10 21:04:
21.000000000 +0800
+++ linux-2.6.x-ipipe/kernel/ipipe/Kconfig      2006-11-10 16:39:
44.000000000 +0800
@@ -4,3 +4,5 @@
        ---help---
          Activate this option if you want the interrupt pipeline to be
          compiled in.
+
+source kernel/ipipe/Kconfig.debug

Also attached the new ipiper-tracer log.

Could you please have a review? The ipipe-tracer is a useful tool. I am now
using it to track the maxium interrupt latency of "latency -t2", hoping to
improve the worst cast interrupt latency.

Thanks,

-Yi



On 10/2/06, Jan Kiszka <jan.kiszka@domain.hid > wrote:
>
> Li Yi (Adam) wrote:
> > Hi,
> >
> > Attached ipipe-tracer ported to blackfin. The patch is based on
> >
> http://download.gna.org/adeos/patches/v2.6/blackfin/adeos-ipipe-bf53x-R06R1RC2-1.4-03.patch
> .
>
> Great!
>
> >
> > But it requires a little hack to Blackfin GCC-R06R1 to  make the "-pg"
> > option work.  The latest release of bfin-gcc (06r2) has supported this
> > feature. And I will update the ipipe tracer patch to the latest kernel
> > release (r06r2).
> >
> > Also attached the ipipe tracer log.
>
> It looks like a few instrumentation issues are remaining, see comments
> below.
>
> > Hoping for your comments.
> >
> > Best Regards,
> >
> > -Yi
> >
> >
> > ------------------------------------------------------------------------
> >
> > root:~> ./latency -t0 -p 300 -f
> >
> >
> > root:~> cat /proc/ipipe/trace/max
> > I-pipe worst-case tracing service on 2.6.16.11.ADI-2006R1blackfin/ipipe-
> 1.4-03
> > ------------------------------------------------------------
> > Begin: 240373976502 cycles, Trace Points: 24 (-10/+1), Length: 270 us
> >
> >  +----- Hard IRQs ('|': locked)
> >  |+---- <unused>
> >  ||+--- <unused>
> >  |||+-- Xenomai
> >  ||||+- Linux ('*': domain stalled, '+': current, '#': current+stalled)
> >  |||||                        +---------- Delay flag ('+': > 1 us, '!':
> > 10 us)
> >  |||||                        |        +- NMI noise ('N')
> >  |||||                        |        |
> >       Type    User Val.   Time    Delay  Function (Parent)
> >  |  + begin   0x80000001   -20     0.910  ___ipipe_dispatch_event+0xb4
> (__start+0xfffff000)
> >  |  + end     0x80000001   -19    6.360  ___ipipe_dispatch_event+0x11a
> (__start+0xfffff000)
> >     + func                 -13    1.440  ___ipipe_syscall_root+0xe
> (system_call+0x2e)
> >     + func                 -11    0.890  ___ipipe_dispatch_event+0xa
> (___ipipe_syscall_root+0x24)
> >  |  + begin   0x80000001   -10    1.280  ___ipipe_dispatch_event+0x20
> (__start+0xfffff000)
> >  |  + end     0x80000001    -9     1.530  ___ipipe_dispatch_event+0x88
> (__start+0xfffff000)
> >     + func                  -7    2.730  _hisyscall_event+0x10
> (___ipipe_dispatch_event+0xa0)
> >     + func                  -5    1.440  ___rt_task_wait_period+0xc
> (_hisyscall_event+0x134)
> >     + func                  -3    1.820  _rt_task_wait_period+0xc
> (___rt_task_wait_period+0x4c)
> >     + func                  -1    0.950  _xnpod_wait_thread_period+0xa
> (_rt_task_wait_period+0x4c)
> >> |  + begin   0x80000001     1+   1.900  _xnpod_wait_thread_period+0x30
> (__start+0xfffff000)
> > :|  # func                   2+   1.640  _xnpod_suspend_thread+0xa
> (_xnpod_wait_thread_period+0x78)
> > :|  # func                   4    0.892  _xnpod_schedule+0xa
> (_xnpod_suspend_thread+0x168)
> > :|  # [   50] -<?>-   99     5+   1.658  _xnpod_schedule+0x112
> (__start+0xfffff000)
> > :|  # [    1] init    -1     7+   2.350  _xnpod_schedule+0x270
> (__start+0xfffff000)
> > :    +func                   9! 235.540  ___ipipe_walk_pipeline+0x1e
> (___ipipe_handle_irq+0x14c)
>
> Looks like there are some inconsistencies in the IRQ state tracing: You
> schedule from latency (PID 50, now of unknown name "-<?>-", priority 99)
> to the init process under Linux (PID 1, "init", ROOT thread priority
> -1). After that switch the IRQs are very likely earlier reenabled, e.g.
> on interrupt return. Compare the instrumentation of x86 with your version.
>
>
> Moreover, IRQ entry and exit should also be traced. This doesn't seem to
> happen yet, otherwise we would see some "begin" entry with the IRQ
> number as user value. Again, check the x86 code for
> ipipe_trace_begin/end passages.
>
> > :|   +func                 244+   1.330  ___ipipe_grab_irq+0x10
> (_evt_timer+0x7c)
> > :|   +func                 246+   1.560  ___ipipe_handle_irq+0x10
> (___ipipe_grab_irq+0x32)
> > :|   +func                 247+   2.120  _rthal_timer_ack+0x8
> (___ipipe_handle_irq+0x174)
> > :|   +func                 249+   1.680  ___ipipe_dispatch_wired+0x14
> (___ipipe_handle_irq+0x74)
> > :|  # func                 251+   1.270  _xnintr_clock_handler+0x10
> (___ipipe_dispatch_wired+0xa6)
> > :|  # func                 252+   1.090  _xnintr_irq_handler+0x18
> (_xnintr_clock_handler+0x18)
> > :|  # func                 254+   1.380  _xnpod_announce_tick+0xc
> (_xnintr_irq_handler+0x2e)
> > :|  # func                 255+   1.470  _xntimer_do_tick_aperiodic+0x14
> (_xnpod_announce_tick+0x16)
> > :|  # func                 256+   1.400  _xnthread_periodic_handler+0xa
> (_xntimer_do_tick_aperiodic+0x1d6)
> > :|  # func                 258     0.790  _xnpod_resume_thread+0xa
> (_xnthread_periodic_handler+0x1e)
> > :|  # [   50] -<?>-   99   259+   2.510  _xnpod_resume_thread+0x4a
> (__start+0xfffff000)
> > :|  # func                 261+   1.890  _xnpod_schedule+0xa
> (_xnintr_irq_handler+0x82)
> > :|  # func                 263+   1.380  _xnpod_schedule_deferred+0xc
> (___ipipe_call_irqtail+0x1e)
> > :|  # func                 264    0.970  _xnpod_schedule+0xa
> (_xnpod_schedule_deferred+0x28)
> > :|  # [    1] init    -1   265+   1.950  _xnpod_schedule+0x112
> (__start+0xfffff000)
> > :|  # [   50] -<?>-   99   267+   1.560  _xnpod_schedule+0x270
> (__start+0xfffff000)
> > :|  # func                 269    0.690  ___ipipe_restore_pipeline_head+0xa
> (_xnpod_wait_thread_period+0xfa)
> > <|  + end     0x80000000   270    2.340  ___ipipe_restore_pipeline_head+0x90
> (__start+0xfffff000)
> >  |  + begin   0x80000001   272    0.000  ___ipipe_dispatch_event+0xb4
> (__start+0xfffff000)
> >
> >
> > root:~> cat /proc/ipipe/trace/frozen
> > I-pipe frozen back-tracing service on 2.6.16.11.ADI-2006R1blackfin
> /ipipe-1.4-03
> > ------------------------------------------------------------
> > Freeze: 234204981352 cycles, Trace Points: 30 (+10)
> >
> >  +----- Hard IRQs ('|': locked)
> >  |+---- <unused>
> >  ||+--- <unused>
> >  |||+-- Xenomai
> >  ||||+- Linux ('*': domain stalled, '+': current, '#': current+stalled)
> >  |||||                        +---------- Delay flag ('+': > 1 us, '!':
> > 10 us)
> >  |||||                        |        +- NMI noise ('N')
> >  |||||                        |        |
> >       Type    User Val.   Time    Delay  Function (Parent)
> > :|  #*func                 -58     0.990  _xnpod_schedule+0xa
> (_xnpod_schedule_deferred+0x28)
> > :|  #*[    1] init    -1   -57+   2.210  _xnpod_schedule+0x112
> (__start+0xfffff000)
> > :|  #*[   50] -<?>-   99   -55+   2.380  _xnpod_schedule+0x270
> (__start+0xfffff000)
> > :|  #*func                 -52    0.710  ___ipipe_restore_pipeline_head+0xa
> (_xnpod_wait_thread_period+0xfa)
> > :|  +*end     0x80000000   -52+   3.020  ___ipipe_restore_pipeline_head+0x90
> (__start+0xfffff000)
> > :|  +*begin   0x80000001   -49+   1.610  ___ipipe_dispatch_event+0xb4
> (__start+0xfffff000)
> > :|  +*end     0x80000001   -47+   6.900  ___ipipe_dispatch_event+0x11a
> (__start+0xfffff000)
> > :   +*func                 -40+   1.330  ___ipipe_syscall_root+0xe
> (system_call+0x2e)
> > :   +*func                 -39    0.700  ___ipipe_dispatch_event+0xa
> (___ipipe_syscall_root+0x24)
> > :|  +*begin   0x80000001   -38+   1.340  ___ipipe_dispatch_event+0x20
> (__start+0xfffff000)
> > :|  +*end     0x80000001   -37+   1.360  ___ipipe_dispatch_event+0x88
> (__start+0xfffff000)
> > :   +*func                 -36+   2.080  _hisyscall_event+0x10
> (___ipipe_dispatch_event+0xa0)
> > :   +*func                 -33+   2.530  ___rt_timer_tsc2ns+0x14
> (_hisyscall_event+0x134)
> > :   +*func                 -31+   1.490  _rt_timer_tsc2ns+0xa
> (___rt_timer_tsc2ns+0x5e)
> > :   +*func                 -29+   1.370  ___muldi3+0x14
> (_rt_timer_tsc2ns+0x58)
> > :   +*func                 -28+   2.330  ___muldi3+0x14
> (_rt_timer_tsc2ns+0x6a)
> > :   +*func                 -26+   4.460  ___div64_32+0xe
> (_rt_timer_tsc2ns+0x1d8)
> > :|  +*begin   0x80000001   -21+   1.320  ___ipipe_dispatch_event+0xb4
> (__start+0xfffff000)
> > :|  +*end     0x80000001   -20+   3.380  ___ipipe_dispatch_event+0x11a
> (__start+0xfffff000)
> > :   +*func                 -17+   1.330  ___ipipe_syscall_root+0xe
> (system_call+0x2e)
> > :   +*func                 -15    0.700  ___ipipe_dispatch_event+0xa
> (___ipipe_syscall_root+0x24)
> > :|  +*begin   0x80000001   -15+   1.340  ___ipipe_dispatch_event+0x20
> (__start+0xfffff000)
> > :|  +*end     0x80000001   -13+   1.360  ___ipipe_dispatch_event+0x88
> (__start+0xfffff000)
> > :   +*func                 -12+   2.100  _hisyscall_event+0x10
> (___ipipe_dispatch_event+0xa0)
> > :   +*func                 -10+   2.230  _xnshadow_sys_trace+0xc
> (_hisyscall_event+0x134)
> > :   +*func                  -8+   1.470  _ipipe_trace_frozen_reset+0xa
> (_xnshadow_sys_trace+0xb2)
> > :   +*func                  -6+   1.110  ___ipipe_global_path_lock+0xa
> (_ipipe_trace_frozen_reset+0xe)
> > :|  +*begin   0x80000001    -5+   3.260  ___ipipe_global_path_lock+0x1a
> (__start+0xfffff000)
> > :|  +*end     0x80000001    -2+   1.160  ___ipipe_global_path_unlock+0x44
> (__start+0xfffff000)
> > <   +*freeze  0x0001ecf6     1     1.180  _xnshadow_sys_trace+0x9c
> (__start+0xfffff000)
>
> 126 us (the user value of "freeze"), that looks ok given the overhead of
> the tracer. If you extend your backtrace in this case to cover that
> whole period, you can analyse what blocked the timer IRQ from waking up
> earlier.
>
> >  |  +*begin   0x80000001     2    0.930  ___ipipe_dispatch_event+0xb4
> (__start+0xfffff000)
> >  |  +*end     0x80000001     3    4.320  ___ipipe_dispatch_event+0x11a
> (__start+0xfffff000)
> >     +*func                   7     1.160  ___ipipe_syscall_root+0xe
> (system_call+0x2e)
> >     +*func                   8    0.910  ___ipipe_dispatch_event+0xa
> (___ipipe_syscall_root+0x24)
> >  |  +*begin   0x80000001     9    0.950  ___ipipe_dispatch_event+0x20
> (__start+0xfffff000)
> >  |  +*end     0x80000001    10    1.350  ___ipipe_dispatch_event+0x88
> (__start+0xfffff000)
> >     +*func                  11    1.910  _hisyscall_event+0x10
> (___ipipe_dispatch_event+0xa0)
> >     +*func                  13     1.310  ___rt_task_wait_period+0xc
> (_hisyscall_event+0x134)
> >     +*func                  15    1.930  _rt_task_wait_period+0xc
> (___rt_task_wait_period+0x4c)
> >     +*func                  16    0.000  _xnpod_wait_thread_period+0xa
> (_rt_task_wait_period+0x4c)
> >
>
> Jan
>
>
>
>

------=_Part_70651_12947585.1163166864733
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Jan and Philippe,<br><br>I have tested the adeos-ipipe-bf53x-CVS-20061008-1.5-00.patch in Xenomai-2.2.5 with latest Blackfin uclinux toolchain 06r2 release: <a href="http://blackfin.uclinux.org/frs/download.php/1136/blackfin-toolchain-06r2-5.i386.rpm" target="_blank" onclick="return top.js.OpenExtLink(window,event,this)">

http://blackfin.uclinux.org/frs/download.php/1136/blackfin-toolchain-06r2-5.i386.rpm</a>. Since the toolchain changed a little for the &quot;mcount&quot; call, the ipipe-tracer patch need to be updated a little.<br><br>Also I add trace for IRQ entry and exit as Jan suggested. Here is the details of the patch (with my explanation)
<br><br>diff -Nur linux-2.6.x-ipipe-orig/arch/blackfin/kernel/ipipe-mcount.S linux-2.6.x-ipipe/arch/blackfin/kernel/ipipe-mcount.S<br>--- linux-2.6.x-ipipe-orig/arch/blackfin/kernel/ipipe-mcount.S&nbsp; 2006-11-10 21:04:21.000000000

 +0800<br>+++ linux-2.6.x-ipipe/arch/blackfin/kernel/ipipe-mcount.S&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2006-11-10 16:41:11.000000000 +0800<br>@@ -12,7 +12,7 @@<br><br>&nbsp;.align 4&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* just in case */<br><br>-ENTRY(_mcount)<br>+ENTRY(__mcount)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; [--sp] = ( r7:0, p5:0 );
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; [--sp] = ASTAT;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; p1.L = _ipipe_trace_enable;<br>diff -Nur linux-2.6.x-ipipe-orig/arch/blackfin/kernel/ipipe-root.c linux-2.6.x-ipipe/arch/blackfin/kernel/ipipe-root.c<br>--- linux-2.6.x-ipipe-orig/arch/blackfin/kernel/ipipe-
root.c&nbsp;&nbsp;&nbsp; 2006-11-10 21:04:21.000000000 +0800<br>+++ linux-2.6.x-ipipe/arch/blackfin/kernel/ipipe-root.c 2006-11-10 16:41:59.000000000 +0800<br>@@ -281,6 +281,6 @@<br>&nbsp;EXPORT_SYMBOL(show_stack);<br><br>&nbsp;#ifdef CONFIG_IPIPE_TRACE_MCOUNT
<br>-void notrace mcount(void);<br>-EXPORT_SYMBOL(mcount);<br>+void notrace _mcount(void);<br>+EXPORT_SYMBOL(_mcount);<br>&nbsp;#endif /* CONFIG_IPIPE_TRACE_MCOUNT */<br><br>&lt;Yi's note&gt;: The&nbsp; gcc&nbsp; will add &quot;Call _ _mcount&quot; to each function  entry when there is &quot;-pg&quot; option
<br><br>diff -Nur linux-2.6.x-ipipe-orig/arch/blackfin/mach-common/interrupt.S linux-2.6.x-ipipe/arch/blackfin/mach-common/interrupt.S<br>--- linux-2.6.x-ipipe-orig/arch/blackfin/mach-common/interrupt.S&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2006-11-10 21:04:
21.000000000 +0800<br>+++ linux-2.6.x-ipipe/arch/blackfin/mach-common/interrupt.S&nbsp;&nbsp;&nbsp;&nbsp; 2006-11-10 16:43:55.000000000 +0800<br>@@ -304,7 +304,10 @@<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; p0.l = _irq_flags;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; p0.h = _irq_flags;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r0 = [p0];
<br>-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sti r0<br>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sti r0;<br>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Reenable interrupts */<br>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; [--sp] = reti;<br>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r0 = [sp++];<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rts;<br><br>&nbsp;#endif /* CONFIG_IPIPE */<br><br><br>&lt;Yi's Note&gt;: I used the ipipe-trace to trace the latency test case: &quot;latency -t2 -p200 -f&quot;. And found that &quot;__ipipe_call_irqtail()&quot; will disable global interrupts, putting the Blackfin to a state like:
<br>&quot;IMASK: 0x0000FFFF, ILAT: 0x00000040, IPEND: 0x0000c010&quot; - that is, Core Timer irq latched, but since IPEND[4] is set, the irq handler cannot be invoked - thus longer latency.<br><br><br>diff -Nur linux-2.6.x-ipipe-orig

/arch/blackfin/mach-common/ints-priority-sc.c linux-2.6.x-ipipe/arch/blackfin/mach-common/ints-priority-sc.c<br>--- linux-2.6.x-ipipe-orig/arch/blackfin/mach-common/ints-priority-sc.c 2006-11-10 21:04:21.000000000 +0800<br>

+++ linux-2.6.x-ipipe/arch/blackfin/mach-common/ints-priority-sc.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2006-11-10 16:45:44.000000000 +0800<br>@@ -1013,7 +1013,13 @@<br><br>&nbsp;handle_irq:<br><br>+#ifdef CONFIG_IPIPE_TRACE_IRQSOFF<br>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ipipe_trace_begin(irq);
<br>+#endif /* CONFIG_IPIPE_TRACE_IRQSOFF */<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __ipipe_handle_irq(irq, regs);<br>+#ifdef CONFIG_IPIPE_TRACE_IRQSOFF<br>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ipipe_trace_end(irq);<br>+#endif /* CONFIG_IPIPE_TRACE_IRQSOFF */<br>diff -Nur linux-2.6.x-ipipe-orig

/kernel/ipipe/Kconfig linux-2.6.x-ipipe/kernel/ipipe/Kconfig<br>--- linux-2.6.x-ipipe-orig/kernel/ipipe/Kconfig 2006-11-10 21:04:21.000000000 +0800<br>+++ linux-2.6.x-ipipe/kernel/ipipe/Kconfig&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2006-11-10 16:39:44.000000000

 +0800<br>@@ -4,3 +4,5 @@<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ---help---<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Activate this option if you want the interrupt pipeline to be<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; compiled in.<br>+<br>+source kernel/ipipe/Kconfig.debug<br><br>Also attached the new ipiper-tracer log.
<br><br>Could you please have a review? The ipipe-tracer is a useful tool. I am now using it to track the maxium interrupt latency of &quot;latency -t2&quot;, hoping to improve the worst cast interrupt latency.<br><br>Thanks,
<br><br>-Yi<br><br><br><br><div><span class="gmail_quote">On 10/2/06, <b class="gmail_sendername">Jan Kiszka</b> &lt;<a href="mailto:jan.kiszka@domain.hid" target="_blank" onclick="return top.js.OpenExtLink(window,event,this)">
jan.kiszka@domain.hid
</a>&gt; wrote:</span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">Li Yi (Adam) wrote:<br>&gt; Hi,<br>&gt;<br>&gt; Attached ipipe-tracer ported to blackfin. The patch is based on
<br>&gt; <a href="http://download.gna.org/adeos/patches/v2.6/blackfin/adeos-ipipe-bf53x-R06R1RC2-1.4-03.patch" target="_blank" onclick="return top.js.OpenExtLink(window,event,this)">http://download.gna.org/adeos/patches/v2.6/blackfin/adeos-ipipe-bf53x-R06R1RC2-1.4-03.patch
</a>.<br><br>Great!
<br><br>&gt;<br>&gt; But it requires a little hack to Blackfin GCC-R06R1 to&nbsp;&nbsp;make the &quot;-pg&quot;<br>&gt; option work.&nbsp;&nbsp;The latest release of bfin-gcc (06r2) has supported this<br>&gt; feature. And I will update the ipipe tracer patch to the latest kernel
<br>&gt; release (r06r2).<br>&gt;<br>&gt; Also attached the ipipe tracer log.<br><br>It looks like a few instrumentation issues are remaining, see comments<br>below.<br><br>&gt; Hoping for your comments.<br>&gt;<br>&gt; Best Regards,
<br>&gt;<br>&gt; -Yi<br>&gt;<br>&gt;<br>&gt; ------------------------------------------------------------------------<br>&gt;<br>&gt; root:~&gt; ./latency -t0 -p 300 -f<br>&gt;<br>&gt;<br>&gt; root:~&gt; cat /proc/ipipe/trace/max
<br>&gt; I-pipe worst-case tracing service on 2.6.16.11.ADI-2006R1blackfin/ipipe-1.4-03<br>&gt; ------------------------------------------------------------<br>&gt; Begin: 240373976502 cycles, Trace Points: 24 (-10/+1), Length: 270 us
<br>&gt;<br>&gt;&nbsp;&nbsp;+----- Hard IRQs ('|': locked)<br>&gt;&nbsp;&nbsp;|+---- &lt;unused&gt;<br>&gt;&nbsp;&nbsp;||+--- &lt;unused&gt;<br>&gt;&nbsp;&nbsp;|||+-- Xenomai<br>&gt;&nbsp;&nbsp;||||+- Linux ('*': domain stalled, '+': current, '#': current+stalled)<br>&gt;&nbsp;&nbsp;|||||&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;+---------- Delay flag ('+': &gt; 1 us, '!': &gt; 10 us)
<br>&gt;&nbsp;&nbsp;|||||&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;+- NMI noise ('N')<br>&gt;&nbsp;&nbsp;|||||&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Type&nbsp;&nbsp;&nbsp;&nbsp;User Val.&nbsp;&nbsp; Time&nbsp;&nbsp;&nbsp;&nbsp;Delay&nbsp;&nbsp;Function (Parent)<br>&gt;&nbsp;&nbsp;|&nbsp;&nbsp;+ begin&nbsp;&nbsp; 0x80000001&nbsp;&nbsp; -20&nbsp;&nbsp;&nbsp;&nbsp;
0.910&nbsp;&nbsp;___ipipe_dispatch_event+0xb4 (__start+0xfffff000)<br>&gt;&nbsp;&nbsp;|&nbsp;&nbsp;+ end&nbsp;&nbsp;&nbsp;&nbsp; 0x80000001&nbsp;&nbsp; -19&nbsp;&nbsp;&nbsp;&nbsp;6.360&nbsp;&nbsp;___ipipe_dispatch_event+0x11a (__start+0xfffff000)<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; + func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -13&nbsp;&nbsp;&nbsp;&nbsp;1.440&nbsp;&nbsp;___ipipe_syscall_root+0xe (system_call+0x2e)
<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; + func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -11&nbsp;&nbsp;&nbsp;&nbsp;0.890&nbsp;&nbsp;___ipipe_dispatch_event+0xa (___ipipe_syscall_root+0x24)<br>&gt;&nbsp;&nbsp;|&nbsp;&nbsp;+ begin&nbsp;&nbsp; 0x80000001&nbsp;&nbsp; -10&nbsp;&nbsp;&nbsp;&nbsp;1.280&nbsp;&nbsp;___ipipe_dispatch_event+0x20 (__start+0xfffff000)<br>&gt;&nbsp;&nbsp;|&nbsp;&nbsp;+ end&nbsp;&nbsp;&nbsp;&nbsp; 0x80000001&nbsp;&nbsp;&nbsp;&nbsp;-9&nbsp;&nbsp;&nbsp;&nbsp;
1.530&nbsp;&nbsp;___ipipe_dispatch_event+0x88 (__start+0xfffff000)<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; + func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;-7&nbsp;&nbsp;&nbsp;&nbsp;2.730&nbsp;&nbsp;_hisyscall_event+0x10 (___ipipe_dispatch_event+0xa0)<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; + func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;-5&nbsp;&nbsp;&nbsp;&nbsp;1.440&nbsp;&nbsp;___rt_task_wait_period+0xc (_hisyscall_event+0x134)
<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; + func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;-3&nbsp;&nbsp;&nbsp;&nbsp;1.820&nbsp;&nbsp;_rt_task_wait_period+0xc (___rt_task_wait_period+0x4c)<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; + func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;-1&nbsp;&nbsp;&nbsp;&nbsp;0.950&nbsp;&nbsp;_xnpod_wait_thread_period+0xa (_rt_task_wait_period+0x4c)<br>&gt;&gt; |&nbsp;&nbsp;+ begin&nbsp;&nbsp; 0x80000001&nbsp;&nbsp;&nbsp;&nbsp; 1+&nbsp;&nbsp; 
1.900&nbsp;&nbsp;_xnpod_wait_thread_period+0x30 (__start+0xfffff000)<br>&gt; :|&nbsp;&nbsp;# func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2+&nbsp;&nbsp; 1.640&nbsp;&nbsp;_xnpod_suspend_thread+0xa (_xnpod_wait_thread_period+0x78)<br>&gt; :|&nbsp;&nbsp;# func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 4&nbsp;&nbsp;&nbsp;&nbsp;0.892&nbsp;&nbsp;_xnpod_schedule+0xa (_xnpod_suspend_thread+0x168)
<br>&gt; :|&nbsp;&nbsp;# [&nbsp;&nbsp; 50] -&lt;?&gt;-&nbsp;&nbsp; 99&nbsp;&nbsp;&nbsp;&nbsp; 5+&nbsp;&nbsp; 1.658&nbsp;&nbsp;_xnpod_schedule+0x112 (__start+0xfffff000)<br>&gt; :|&nbsp;&nbsp;# [&nbsp;&nbsp;&nbsp;&nbsp;1] init&nbsp;&nbsp;&nbsp;&nbsp;-1&nbsp;&nbsp;&nbsp;&nbsp; 7+&nbsp;&nbsp; 2.350&nbsp;&nbsp;_xnpod_schedule+0x270 (__start+0xfffff000)<br>&gt; :&nbsp;&nbsp;&nbsp;&nbsp;+func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 9! 
235.540&nbsp;&nbsp;___ipipe_walk_pipeline+0x1e (___ipipe_handle_irq+0x14c)<br><br>Looks like there are some inconsistencies in the IRQ state tracing: You<br>schedule from latency (PID 50, now of unknown name &quot;-&lt;?&gt;-&quot;, priority 99)
<br>to the init process under Linux (PID 1, &quot;init&quot;, ROOT thread priority<br>-1). After that switch the IRQs are very likely earlier reenabled, e.g.<br>on interrupt return. Compare the instrumentation of x86 with your version.
<br><br>Moreover, IRQ entry and exit should also be traced. This doesn't seem to<br>happen yet, otherwise we would see some &quot;begin&quot; entry with the IRQ<br>number as user value. Again, check the x86 code for<br>ipipe_trace_begin/end passages.
<br><br>&gt; :|&nbsp;&nbsp; +func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 244+&nbsp;&nbsp; 1.330&nbsp;&nbsp;___ipipe_grab_irq+0x10 (_evt_timer+0x7c)<br>&gt; :|&nbsp;&nbsp; +func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 246+&nbsp;&nbsp; 1.560&nbsp;&nbsp;___ipipe_handle_irq+0x10 (___ipipe_grab_irq+0x32)<br>&gt; :|&nbsp;&nbsp; +func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 247+&nbsp;&nbsp; 
2.120&nbsp;&nbsp;_rthal_timer_ack+0x8 (___ipipe_handle_irq+0x174)<br>&gt; :|&nbsp;&nbsp; +func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 249+&nbsp;&nbsp; 1.680&nbsp;&nbsp;___ipipe_dispatch_wired+0x14 (___ipipe_handle_irq+0x74)<br>&gt; :|&nbsp;&nbsp;# func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 251+&nbsp;&nbsp; 1.270&nbsp;&nbsp;_xnintr_clock_handler+0x10 (___ipipe_dispatch_wired+0xa6)
<br>&gt; :|&nbsp;&nbsp;# func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 252+&nbsp;&nbsp; 1.090&nbsp;&nbsp;_xnintr_irq_handler+0x18 (_xnintr_clock_handler+0x18)<br>&gt; :|&nbsp;&nbsp;# func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 254+&nbsp;&nbsp; 1.380&nbsp;&nbsp;_xnpod_announce_tick+0xc (_xnintr_irq_handler+0x2e)<br>&gt; :|&nbsp;&nbsp;# func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 255+&nbsp;&nbsp; 
1.470&nbsp;&nbsp;_xntimer_do_tick_aperiodic+0x14 (_xnpod_announce_tick+0x16)<br>&gt; :|&nbsp;&nbsp;# func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 256+&nbsp;&nbsp; 1.400&nbsp;&nbsp;_xnthread_periodic_handler+0xa (_xntimer_do_tick_aperiodic+0x1d6)<br>&gt; :|&nbsp;&nbsp;# func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 258&nbsp;&nbsp;&nbsp;&nbsp;
0.790&nbsp;&nbsp;_xnpod_resume_thread+0xa (_xnthread_periodic_handler+0x1e)<br>&gt; :|&nbsp;&nbsp;# [&nbsp;&nbsp; 50] -&lt;?&gt;-&nbsp;&nbsp; 99&nbsp;&nbsp; 259+&nbsp;&nbsp; 2.510&nbsp;&nbsp;_xnpod_resume_thread+0x4a (__start+0xfffff000)<br>&gt; :|&nbsp;&nbsp;# func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 261+&nbsp;&nbsp; 1.890&nbsp;&nbsp;_xnpod_schedule+0xa (_xnintr_irq_handler+0x82)
<br>&gt; :|&nbsp;&nbsp;# func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 263+&nbsp;&nbsp; 1.380&nbsp;&nbsp;_xnpod_schedule_deferred+0xc (___ipipe_call_irqtail+0x1e)<br>&gt; :|&nbsp;&nbsp;# func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 264&nbsp;&nbsp;&nbsp;&nbsp;0.970&nbsp;&nbsp;_xnpod_schedule+0xa (_xnpod_schedule_deferred+0x28)<br>&gt; :|&nbsp;&nbsp;# [&nbsp;&nbsp;&nbsp;&nbsp;1] init&nbsp;&nbsp;&nbsp;&nbsp;-1&nbsp;&nbsp; 265+&nbsp;&nbsp; 
1.950&nbsp;&nbsp;_xnpod_schedule+0x112 (__start+0xfffff000)<br>&gt; :|&nbsp;&nbsp;# [&nbsp;&nbsp; 50] -&lt;?&gt;-&nbsp;&nbsp; 99&nbsp;&nbsp; 267+&nbsp;&nbsp; 1.560&nbsp;&nbsp;_xnpod_schedule+0x270 (__start+0xfffff000)<br>&gt; :|&nbsp;&nbsp;# func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 269&nbsp;&nbsp;&nbsp;&nbsp;0.690&nbsp;&nbsp;___ipipe_restore_pipeline_head+0xa (_xnpod_wait_thread_period+0xfa)
<br>&gt; &lt;|&nbsp;&nbsp;+ end&nbsp;&nbsp;&nbsp;&nbsp; 0x80000000&nbsp;&nbsp; 270&nbsp;&nbsp;&nbsp;&nbsp;2.340&nbsp;&nbsp;___ipipe_restore_pipeline_head+0x90 (__start+0xfffff000)<br>&gt;&nbsp;&nbsp;|&nbsp;&nbsp;+ begin&nbsp;&nbsp; 0x80000001&nbsp;&nbsp; 272&nbsp;&nbsp;&nbsp;&nbsp;0.000&nbsp;&nbsp;___ipipe_dispatch_event+0xb4 (__start+0xfffff000)<br>&gt;<br>
&gt;
<br>&gt; root:~&gt; cat /proc/ipipe/trace/frozen<br>&gt; I-pipe frozen back-tracing service on 2.6.16.11.ADI-2006R1blackfin/ipipe-1.4-03<br>&gt; ------------------------------------------------------------<br>&gt; Freeze: 234204981352 cycles, Trace Points: 30 (+10)
<br>&gt;<br>&gt;&nbsp;&nbsp;+----- Hard IRQs ('|': locked)<br>&gt;&nbsp;&nbsp;|+---- &lt;unused&gt;<br>&gt;&nbsp;&nbsp;||+--- &lt;unused&gt;<br>&gt;&nbsp;&nbsp;|||+-- Xenomai<br>&gt;&nbsp;&nbsp;||||+- Linux ('*': domain stalled, '+': current, '#': current+stalled)<br>&gt;&nbsp;&nbsp;|||||&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;+---------- Delay flag ('+': &gt; 1 us, '!': &gt; 10 us)
<br>&gt;&nbsp;&nbsp;|||||&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;+- NMI noise ('N')<br>&gt;&nbsp;&nbsp;|||||&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Type&nbsp;&nbsp;&nbsp;&nbsp;User Val.&nbsp;&nbsp; Time&nbsp;&nbsp;&nbsp;&nbsp;Delay&nbsp;&nbsp;Function (Parent)<br>&gt; :|&nbsp;&nbsp;#*func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -58&nbsp;&nbsp;&nbsp;&nbsp;
0.990&nbsp;&nbsp;_xnpod_schedule+0xa (_xnpod_schedule_deferred+0x28)<br>&gt; :|&nbsp;&nbsp;#*[&nbsp;&nbsp;&nbsp;&nbsp;1] init&nbsp;&nbsp;&nbsp;&nbsp;-1&nbsp;&nbsp; -57+&nbsp;&nbsp; 2.210&nbsp;&nbsp;_xnpod_schedule+0x112 (__start+0xfffff000)<br>&gt; :|&nbsp;&nbsp;#*[&nbsp;&nbsp; 50] -&lt;?&gt;-&nbsp;&nbsp; 99&nbsp;&nbsp; -55+&nbsp;&nbsp; 2.380&nbsp;&nbsp;_xnpod_schedule+0x270 (__start+0xfffff000)
<br>&gt; :|&nbsp;&nbsp;#*func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -52&nbsp;&nbsp;&nbsp;&nbsp;0.710&nbsp;&nbsp;___ipipe_restore_pipeline_head+0xa (_xnpod_wait_thread_period+0xfa)<br>&gt; :|&nbsp;&nbsp;+*end&nbsp;&nbsp;&nbsp;&nbsp; 0x80000000&nbsp;&nbsp; -52+&nbsp;&nbsp; 3.020&nbsp;&nbsp;___ipipe_restore_pipeline_head+0x90 (__start+0xfffff000)
<br>&gt; :|&nbsp;&nbsp;+*begin&nbsp;&nbsp; 0x80000001&nbsp;&nbsp; -49+&nbsp;&nbsp; 1.610&nbsp;&nbsp;___ipipe_dispatch_event+0xb4 (__start+0xfffff000)<br>&gt; :|&nbsp;&nbsp;+*end&nbsp;&nbsp;&nbsp;&nbsp; 0x80000001&nbsp;&nbsp; -47+&nbsp;&nbsp; 6.900&nbsp;&nbsp;___ipipe_dispatch_event+0x11a (__start+0xfffff000)<br>&gt; :&nbsp;&nbsp; +*func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -40+&nbsp;&nbsp; 
1.330&nbsp;&nbsp;___ipipe_syscall_root+0xe (system_call+0x2e)<br>&gt; :&nbsp;&nbsp; +*func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -39&nbsp;&nbsp;&nbsp;&nbsp;0.700&nbsp;&nbsp;___ipipe_dispatch_event+0xa (___ipipe_syscall_root+0x24)<br>&gt; :|&nbsp;&nbsp;+*begin&nbsp;&nbsp; 0x80000001&nbsp;&nbsp; -38+&nbsp;&nbsp; 1.340&nbsp;&nbsp;___ipipe_dispatch_event+0x20 (__start+0xfffff000)
<br>&gt; :|&nbsp;&nbsp;+*end&nbsp;&nbsp;&nbsp;&nbsp; 0x80000001&nbsp;&nbsp; -37+&nbsp;&nbsp; 1.360&nbsp;&nbsp;___ipipe_dispatch_event+0x88 (__start+0xfffff000)<br>&gt; :&nbsp;&nbsp; +*func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -36+&nbsp;&nbsp; 2.080&nbsp;&nbsp;_hisyscall_event+0x10 (___ipipe_dispatch_event+0xa0)<br>&gt; :&nbsp;&nbsp; +*func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -33+&nbsp;&nbsp; 
2.530&nbsp;&nbsp;___rt_timer_tsc2ns+0x14 (_hisyscall_event+0x134)<br>&gt; :&nbsp;&nbsp; +*func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -31+&nbsp;&nbsp; 1.490&nbsp;&nbsp;_rt_timer_tsc2ns+0xa (___rt_timer_tsc2ns+0x5e)<br>&gt; :&nbsp;&nbsp; +*func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -29+&nbsp;&nbsp; 1.370&nbsp;&nbsp;___muldi3+0x14 (_rt_timer_tsc2ns+0x58)
<br>&gt; :&nbsp;&nbsp; +*func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -28+&nbsp;&nbsp; 2.330&nbsp;&nbsp;___muldi3+0x14 (_rt_timer_tsc2ns+0x6a)<br>&gt; :&nbsp;&nbsp; +*func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -26+&nbsp;&nbsp; 4.460&nbsp;&nbsp;___div64_32+0xe (_rt_timer_tsc2ns+0x1d8)<br>&gt; :|&nbsp;&nbsp;+*begin&nbsp;&nbsp; 0x80000001&nbsp;&nbsp; -21+&nbsp;&nbsp; 
1.320&nbsp;&nbsp;___ipipe_dispatch_event+0xb4 (__start+0xfffff000)<br>&gt; :|&nbsp;&nbsp;+*end&nbsp;&nbsp;&nbsp;&nbsp; 0x80000001&nbsp;&nbsp; -20+&nbsp;&nbsp; 3.380&nbsp;&nbsp;___ipipe_dispatch_event+0x11a (__start+0xfffff000)<br>&gt; :&nbsp;&nbsp; +*func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -17+&nbsp;&nbsp; 1.330&nbsp;&nbsp;___ipipe_syscall_root+0xe (system_call+0x2e)
<br>&gt; :&nbsp;&nbsp; +*func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -15&nbsp;&nbsp;&nbsp;&nbsp;0.700&nbsp;&nbsp;___ipipe_dispatch_event+0xa (___ipipe_syscall_root+0x24)<br>&gt; :|&nbsp;&nbsp;+*begin&nbsp;&nbsp; 0x80000001&nbsp;&nbsp; -15+&nbsp;&nbsp; 1.340&nbsp;&nbsp;___ipipe_dispatch_event+0x20 (__start+0xfffff000)<br>&gt; :|&nbsp;&nbsp;+*end&nbsp;&nbsp;&nbsp;&nbsp; 0x80000001&nbsp;&nbsp; -13+&nbsp;&nbsp; 
1.360&nbsp;&nbsp;___ipipe_dispatch_event+0x88 (__start+0xfffff000)<br>&gt; :&nbsp;&nbsp; +*func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -12+&nbsp;&nbsp; 2.100&nbsp;&nbsp;_hisyscall_event+0x10 (___ipipe_dispatch_event+0xa0)<br>&gt; :&nbsp;&nbsp; +*func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -10+&nbsp;&nbsp; 2.230&nbsp;&nbsp;_xnshadow_sys_trace+0xc (_hisyscall_event+0x134)
<br>&gt; :&nbsp;&nbsp; +*func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;-8+&nbsp;&nbsp; 1.470&nbsp;&nbsp;_ipipe_trace_frozen_reset+0xa (_xnshadow_sys_trace+0xb2)<br>&gt; :&nbsp;&nbsp; +*func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;-6+&nbsp;&nbsp; 1.110&nbsp;&nbsp;___ipipe_global_path_lock+0xa (_ipipe_trace_frozen_reset+0xe)<br>

&gt; :|&nbsp;&nbsp;+*begin&nbsp;&nbsp; 0x80000001&nbsp;&nbsp;&nbsp;&nbsp;-5+&nbsp;&nbsp; 3.260&nbsp;&nbsp;___ipipe_global_path_lock+0x1a (__start+0xfffff000)<br>&gt; :|&nbsp;&nbsp;+*end&nbsp;&nbsp;&nbsp;&nbsp; 0x80000001&nbsp;&nbsp;&nbsp;&nbsp;-2+&nbsp;&nbsp; 1.160&nbsp;&nbsp;___ipipe_global_path_unlock+0x44 (__start+0xfffff000)<br>&gt; &lt;&nbsp;&nbsp; +*freeze&nbsp;&nbsp;0x0001ecf6&nbsp;&nbsp;&nbsp;&nbsp; 1&nbsp;&nbsp;&nbsp;&nbsp;
1.180&nbsp;&nbsp;_xnshadow_sys_trace+0x9c (__start+0xfffff000)<br><br>126 us (the user value of &quot;freeze&quot;), that looks ok given the overhead of<br>the tracer. If you extend your backtrace in this case to cover that<br>whole period, you can analyse what blocked the timer IRQ from waking up
<br>earlier.<br><br>&gt;&nbsp;&nbsp;|&nbsp;&nbsp;+*begin&nbsp;&nbsp; 0x80000001&nbsp;&nbsp;&nbsp;&nbsp; 2&nbsp;&nbsp;&nbsp;&nbsp;0.930&nbsp;&nbsp;___ipipe_dispatch_event+0xb4 (__start+0xfffff000)<br>&gt;&nbsp;&nbsp;|&nbsp;&nbsp;+*end&nbsp;&nbsp;&nbsp;&nbsp; 0x80000001&nbsp;&nbsp;&nbsp;&nbsp; 3&nbsp;&nbsp;&nbsp;&nbsp;4.320&nbsp;&nbsp;___ipipe_dispatch_event+0x11a (__start+0xfffff000)<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; +*func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 7&nbsp;&nbsp;&nbsp;&nbsp;
1.160&nbsp;&nbsp;___ipipe_syscall_root+0xe (system_call+0x2e)<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; +*func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 8&nbsp;&nbsp;&nbsp;&nbsp;0.910&nbsp;&nbsp;___ipipe_dispatch_event+0xa (___ipipe_syscall_root+0x24)<br>&gt;&nbsp;&nbsp;|&nbsp;&nbsp;+*begin&nbsp;&nbsp; 0x80000001&nbsp;&nbsp;&nbsp;&nbsp; 9&nbsp;&nbsp;&nbsp;&nbsp;0.950&nbsp;&nbsp;___ipipe_dispatch_event+0x20 (__start+0xfffff000)
<br>&gt;&nbsp;&nbsp;|&nbsp;&nbsp;+*end&nbsp;&nbsp;&nbsp;&nbsp; 0x80000001&nbsp;&nbsp;&nbsp;&nbsp;10&nbsp;&nbsp;&nbsp;&nbsp;1.350&nbsp;&nbsp;___ipipe_dispatch_event+0x88 (__start+0xfffff000)<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; +*func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;11&nbsp;&nbsp;&nbsp;&nbsp;1.910&nbsp;&nbsp;_hisyscall_event+0x10 (___ipipe_dispatch_event+0xa0)<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; +*func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;13&nbsp;&nbsp;&nbsp;&nbsp;
1.310&nbsp;&nbsp;___rt_task_wait_period+0xc (_hisyscall_event+0x134)<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; +*func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;15&nbsp;&nbsp;&nbsp;&nbsp;1.930&nbsp;&nbsp;_rt_task_wait_period+0xc (___rt_task_wait_period+0x4c)<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; +*func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;16&nbsp;&nbsp;&nbsp;&nbsp;0.000&nbsp;&nbsp;_xnpod_wait_thread_period+0xa (_rt_task_wait_period+0x4c)
<br>&gt;<br><br>Jan<br><br><br><br></blockquote></div><br>


------=_Part_70651_12947585.1163166864733--

------=_Part_70650_5530952.1163166864733
Content-Type: text/x-log; name=ipipe-tracer-new.log; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: base64
X-Attachment-Id: f_eucnedr5
Content-Disposition: attachment; filename="ipipe-tracer-new.log"

cm9vdDp+PiAuL2xhdGVuY3kgLXQyIC1wMjAwIC1mCgpyb290On4+IGNhdCAvcHJvYy9pcGlwZS90
cmFjZS9mcm96ZW4KSS1waXBlIGZyb3plbiBiYWNrLXRyYWNpbmcgc2VydmljZSBvbiAyLjYuMTYu
MjctQURJLTIwMDZSMi9pcGlwZS0xLjUtMDAKLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCkZyZWV6ZTogMTQ0ODc5MTAyODMyIGN5Y2xl
cywgVHJhY2UgUG9pbnRzOiAyMDAgKCs1MCkKCiArLS0tLS0gSGFyZCBJUlFzICgnfCc6IGxvY2tl
ZCkKIHwrLS0tLSA8dW51c2VkPgogfHwrLS0tIDx1bnVzZWQ+CiB8fHwrLS0gWGVub21haQogfHx8
fCstIExpbnV4ICgnKic6IGRvbWFpbiBzdGFsbGVkLCAnKyc6IGN1cnJlbnQsICcjJzogY3VycmVu
dCtzdGFsbGVkKQogfHx8fHwgICAgICAgICAgICAgICAgICAgICAgICArLS0tLS0tLS0tLSBEZWxh
eSBmbGFnICgnKyc6ID4gMSB1cywgJyEnOiA+IDEwIHVzKQogfHx8fHwgICAgICAgICAgICAgICAg
ICAgICAgICB8ICAgICAgICArLSBOTUkgbm9pc2UgKCdOJykKIHx8fHx8ICAgICAgICAgICAgICAg
ICAgICAgICAgfCAgICAgICAgfAogICAgICBUeXBlICAgIFVzZXIgVmFsLiAgIFRpbWUgICAgRGVs
YXkgIEZ1bmN0aW9uIChQYXJlbnQpCjogICAgI2Z1bmMgICAgICAgICAgICAgICAgLTM4NSAgICAw
LjcyOCAgX19faXBpcGVfdW5zdGFsbF9yb290KzB4OCAoX19faXBpcGVfcmVzdG9yZV9yb290KzB4
MWEpCjogICAgI2JlZ2luICAgMHg4MDAwMDAwMCAgLTM4NSsgICAxLjMyMiAgX19faXBpcGVfdW5z
dGFsbF9yb290KzB4MWEgKF9fc3RhcnQrMHhmZmZmZjAwMCkKOnwgICArZW5kICAgICAweDgwMDAw
MDAwICAtMzgzKyAgIDEuNjgwICBfX19pcGlwZV91bnN0YWxsX3Jvb3QrMHg1OCAoX19zdGFydCsw
eGZmZmZmMDAwKQo6ICAgICtmdW5jICAgICAgICAgICAgICAgIC0zODIrICAgMS43MjAgIF9fX3Nj
aGVkX3RleHRfc3RhcnQrMHhlIChfd29ya2VyX3RocmVhZCsweDExNikKOiAgICArZnVuYyAgICAg
ICAgICAgICAgICAtMzgwKyAgIDEuMzc4ICBfcHJvZmlsZV9oaXQrMHhlIChfX19zY2hlZF90ZXh0
X3N0YXJ0KzB4NGMpCjogICAgK2Z1bmMgICAgICAgICAgICAgICAgLTM3OSsgICAxLjUyMiAgX3Nj
aGVkX2Nsb2NrKzB4YyAoX19fc2NoZWRfdGV4dF9zdGFydCsweDdjKQo6ICAgICtmdW5jICAgICAg
ICAgICAgICAgIC0zNzcrICAgMi42MjAgIF9fX211bGRpMysweGMgKF9zY2hlZF9jbG9jaysweDI2
KQo6ICAgICtmdW5jICAgICAgICAgICAgICAgIC0zNzQgICAgMC44NzAgIF9fX2lwaXBlX3N0YWxs
X3Jvb3QrMHhlIChfX19zY2hlZF90ZXh0X3N0YXJ0KzB4ZWMpCjp8ICAgK2JlZ2luICAgMHg4MDAw
MDAwMSAgLTM3NCsgICAxLjEwOCAgX19faXBpcGVfc3RhbGxfcm9vdCsweDIyIChfX3N0YXJ0KzB4
ZmZmZmYwMDApCjp8ICAgI2VuZCAgICAgMHg4MDAwMDAwMSAgLTM3MisgICAxLjgyMiAgX19faXBp
cGVfc3RhbGxfcm9vdCsweDMwIChfX3N0YXJ0KzB4ZmZmZmYwMDApCjogICAgI2Z1bmMgICAgICAg
ICAgICAgICAgLTM3MSsgICAxLjgwMCAgX2RlYWN0aXZhdGVfdGFzaysweGUgKF9fX3NjaGVkX3Rl
eHRfc3RhcnQrMHg0NjQpCjogICAgI2Z1bmMgICAgICAgICAgICAgICAgLTM2OSsgICAyLjU2MCAg
X2RlcXVldWVfdGFzaysweGUgKF9kZWFjdGl2YXRlX3Rhc2srMHgxYykKOnwgICAjYmVnaW4gICAw
eDgwMDAwMDAxICAtMzY2KyAgIDEuMzc4ICBfX19zY2hlZF90ZXh0X3N0YXJ0KzB4MWU2IChfX3N0
YXJ0KzB4ZmZmZmYwMDApCjp8ICAgI2VuZCAgICAgMHg4MDAwMDAwMSAgLTM2NSsgICAzLjcxMiAg
X19fc2NoZWRfdGV4dF9zdGFydCsweDFmNCAoX19zdGFydCsweGZmZmZmMDAwKQo6ICAgICNmdW5j
ICAgICAgICAgICAgICAgIC0zNjEgICAgMC45NDAgIF9fX2lwaXBlX2Rpc3BhdGNoX2V2ZW50KzB4
YSAoX19fc2NoZWRfdGV4dF9zdGFydCsweDJkZSkKOnwgICAjYmVnaW4gICAweDgwMDAwMDAxICAt
MzYwKyAgIDEuNDYwICBfX19pcGlwZV9kaXNwYXRjaF9ldmVudCsweDIwIChfX3N0YXJ0KzB4ZmZm
ZmYwMDApCjp8ICAgI2VuZCAgICAgMHg4MDAwMDAwMSAgLTM1OSsgICAxLjUwOCAgX19faXBpcGVf
ZGlzcGF0Y2hfZXZlbnQrMHhjYyAoX19zdGFydCsweGZmZmZmMDAwKQo6ICAgICNmdW5jICAgICAg
ICAgICAgICAgIC0zNTcrICAgMS40NDIgIF9zY2hlZHVsZV9ldmVudCsweDE2IChfX19pcGlwZV9k
aXNwYXRjaF9ldmVudCsweGUyKQo6fCAgICNiZWdpbiAgIDB4ODAwMDAwMDEgIC0zNTYrICAgMi4z
NjAgIF9zY2hlZHVsZV9ldmVudCsweDdlIChfX3N0YXJ0KzB4ZmZmZmYwMDApCjp8ICAqI2Z1bmMg
ICAgICAgICAgICAgICAgLTM1MysgICAxLjEwMCAgX3hucG9kX3NjaGVkdWxlX3J1bm5hYmxlKzB4
YyAoX3NjaGVkdWxlX2V2ZW50KzB4YTgpCjp8ICAqI1sgICAgMF0gc3dhcHBlciAgMCAgLTM1Misg
ICAxLjc4OCAgX3hucG9kX3NjaGVkdWxlX3J1bm5hYmxlKzB4MjggKF9fc3RhcnQrMHhmZmZmZjAw
MCkKOnwgICojZnVuYyAgICAgICAgICAgICAgICAtMzUxKyAgIDEuMjYyICBfX19pcGlwZV9yZXN0
b3JlX3BpcGVsaW5lX2hlYWQrMHhhIChfc2NoZWR1bGVfZXZlbnQrMHgxMDApCjp8ICAgI2VuZCAg
ICAgMHg4MDAwMDAwMCAgLTM0OSsgICAxLjA1MCAgX19faXBpcGVfcmVzdG9yZV9waXBlbGluZV9o
ZWFkKzB4OTQgKF9fc3RhcnQrMHhmZmZmZjAwMCkKOnwgICAjYmVnaW4gICAweDgwMDAwMDAxICAt
MzQ4KyAgIDEuNDAwICBfX19pcGlwZV9kaXNwYXRjaF9ldmVudCsweGZhIChfX3N0YXJ0KzB4ZmZm
ZmYwMDApCjp8ICAgI2VuZCAgICAgMHg4MDAwMDAwMSAgLTM0NyAgICAwLjgxOCAgX19faXBpcGVf
ZGlzcGF0Y2hfZXZlbnQrMHgxN2EgKF9fc3RhcnQrMHhmZmZmZjAwMCkKOiAgICAjYmVnaW4gICAw
eDgwMDAwMDAwICAtMzQ2KyAgIDQuMjYyICBfX19zY2hlZF90ZXh0X3N0YXJ0KzB4MmYwIChfX3N0
YXJ0KzB4ZmZmZmYwMDApCjp8ICAgI2VuZCAgICAgMHg4MDAwMDAwMCAgLTM0MisgICAxLjM0MCAg
X19fc2NoZWRfdGV4dF9zdGFydCsweDVjYSAoX19zdGFydCsweGZmZmZmMDAwKQo6ICAgICNmdW5j
ICAgICAgICAgICAgICAgIC0zNDAgICAgMC45ODAgIF9fX2lwaXBlX3Vuc3RhbGxfcm9vdCsweDgg
KF9fX3NjaGVkX3RleHRfc3RhcnQrMHgzY2UpCjogICAgI2JlZ2luICAgMHg4MDAwMDAwMCAgLTMz
OSsgICAxLjEyOCAgX19faXBpcGVfdW5zdGFsbF9yb290KzB4MWEgKF9fc3RhcnQrMHhmZmZmZjAw
MCkKOnwgICArZW5kICAgICAweDgwMDAwMDAwICAtMzM4KyAgIDEuMzUyICBfX19pcGlwZV91bnN0
YWxsX3Jvb3QrMHg1OCAoX19zdGFydCsweGZmZmZmMDAwKQo6ICAgICtmdW5jICAgICAgICAgICAg
ICAgIC0zMzcgICAgMC44NzAgIF9fX2lwaXBlX3Rlc3RfYW5kX3N0YWxsX3Jvb3QrMHhlIChfX19z
Y2hlZF90ZXh0X3N0YXJ0KzB4M2Q4KQo6fCAgICtiZWdpbiAgIDB4ODAwMDAwMDEgIC0zMzYrICAg
MS4yNzAgIF9fX2lwaXBlX3Rlc3RfYW5kX3N0YWxsX3Jvb3QrMHgyMiAoX19zdGFydCsweGZmZmZm
MDAwKQo6fCAgICNlbmQgICAgIDB4ODAwMDAwMDEgIC0zMzUrICAgMS4xOTggIF9fX2lwaXBlX3Rl
c3RfYW5kX3N0YWxsX3Jvb3QrMHgzNiAoX19zdGFydCsweGZmZmZmMDAwKQo6ICAgICNmdW5jICAg
ICAgICAgICAgICAgIC0zMzQrICAgMS4yNTIgIF9fX2lwaXBlX3Jlc3RvcmVfcm9vdCsweGEgKF9f
X3NjaGVkX3RleHRfc3RhcnQrMHg0ZWMpCjogICAgI2Z1bmMgICAgICAgICAgICAgICAgLTMzMiAg
ICAwLjk4MCAgX19faXBpcGVfdW5zdGFsbF9yb290KzB4OCAoX19faXBpcGVfcmVzdG9yZV9yb290
KzB4MWEpCjogICAgI2JlZ2luICAgMHg4MDAwMDAwMCAgLTMzMSsgICAxLjI5MCAgX19faXBpcGVf
dW5zdGFsbF9yb290KzB4MWEgKF9fc3RhcnQrMHhmZmZmZjAwMCkKOnwgICArZW5kICAgICAweDgw
MDAwMDAwICAtMzMwISAgMjAuMTY4ICBfX19pcGlwZV91bnN0YWxsX3Jvb3QrMHg1OCAoX19zdGFy
dCsweGZmZmZmMDAwKQo6ICAgICtmdW5jICAgICAgICAgICAgICAgIC0zMTArICAgMS43NDIgIF9f
X2lwaXBlX3N5c2NhbGxfcm9vdCsweDE0IChfc3lzdGVtX2NhbGwrMHgyZSkKOiAgICArZnVuYyAg
ICAgICAgICAgICAgICAtMzA4ICAgIDAuOTMwICBfX19pcGlwZV9kaXNwYXRjaF9ldmVudCsweGEg
KF9fX2lwaXBlX3N5c2NhbGxfcm9vdCsweDQwKQo6fCAgICtiZWdpbiAgIDB4ODAwMDAwMDEgIC0z
MDcrICAgMS42NzAgIF9fX2lwaXBlX2Rpc3BhdGNoX2V2ZW50KzB4MjAgKF9fc3RhcnQrMHhmZmZm
ZjAwMCkKOnwgICsgZW5kICAgICAweDgwMDAwMDAxICAtMzA2KyAgIDEuNjQ4ICBfX19pcGlwZV9k
aXNwYXRjaF9ldmVudCsweGNjIChfX3N0YXJ0KzB4ZmZmZmYwMDApCjogICArIGZ1bmMgICAgICAg
ICAgICAgICAgLTMwNCsgICAyLjA5MiAgX2hpc3lzY2FsbF9ldmVudCsweDEwIChfX19pcGlwZV9k
aXNwYXRjaF9ldmVudCsweGUyKQo6ICAgKyBmdW5jICAgICAgICAgICAgICAgIC0zMDIrICAgMS43
NzAgIF94bnBvZF9zY2hlZHVsZSsweGEgKF9oaXN5c2NhbGxfZXZlbnQrMHhiZSkKOnwgICsgYmVn
aW4gICAweDgwMDAwMDAxICAtMzAwKyAgIDEuMjcwICBfeG5wb2Rfc2NoZWR1bGUrMHg2NCAoX19z
dGFydCsweGZmZmZmMDAwKQo6fCAgKyBlbmQgICAgIDB4ODAwMDAwMDEgIC0yOTkrICAgMS4xNzgg
IF94bnBvZF9zY2hlZHVsZSsweDcyIChfX3N0YXJ0KzB4ZmZmZmYwMDApCjp8ICArIGJlZ2luICAg
MHg4MDAwMDAwMSAgLTI5OCsgICAxLjMyMiAgX3hucG9kX3NjaGVkdWxlKzB4YzQgKF9fc3RhcnQr
MHhmZmZmZjAwMCkKOnwgICMgWyAgICAwXSBzd2FwcGVyICAwICAtMjk2KyAgIDIuMzMwICBfeG5w
b2Rfc2NoZWR1bGUrMHgxMDQgKF9fc3RhcnQrMHhmZmZmZjAwMCkKOnwgICMgZnVuYyAgICAgICAg
ICAgICAgICAtMjk0KyAgIDEuMDUwICBfX19pcGlwZV9yZXN0b3JlX3BpcGVsaW5lX2hlYWQrMHhh
IChfeG5wb2Rfc2NoZWR1bGUrMHgyYjApCjp8ICArIGVuZCAgICAgMHg4MDAwMDAwMCAgLTI5Mysg
ICAyLjI1OCAgX19faXBpcGVfcmVzdG9yZV9waXBlbGluZV9oZWFkKzB4OTQgKF9fc3RhcnQrMHhm
ZmZmZjAwMCkKOnwgICsgZnVuYyAgICAgICAgICAgICAgICAtMjkxICAgIDAuOTAyICBfX19pcGlw
ZV9ncmFiX2lycSsweDIyIChfX2NvbW1vbl9pbnRfZW50cnkrMHg3MikKOnwgICsgYmVnaW4gICAw
eDAwMDAwMDA2ICAtMjkwKyAgIDIuMTMwICBfX19pcGlwZV9ncmFiX2lycSsweDM0IChfX3N0YXJ0
KzB4ZmZmZmYwMDApCjp8ICArIGZ1bmMgICAgICAgICAgICAgICAgLTI4OCsgICAxLjUxMCAgX19f
aXBpcGVfaGFuZGxlX2lycSsweDFlIChfX19pcGlwZV9ncmFiX2lycSsweDNjKQo6fCAgKyBmdW5j
ICAgICAgICAgICAgICAgIC0yODYrICAgMS4yMDggIF9ydGhhbF90aW1lcl9hY2srMHg4IChfX19p
cGlwZV9oYW5kbGVfaXJxKzB4MTc4KQo6fCAgKyBmdW5jICAgICAgICAgICAgICAgIC0yODUrICAg
Mi4zMDIgIF9fX2lwaXBlX2Rpc3BhdGNoX3dpcmVkKzB4MTQgKF9fX2lwaXBlX2hhbmRsZV9pcnEr
MHgxOTApCjp8ICAjIGZ1bmMgICAgICAgICAgICAgICAgLTI4MysgICAxLjk4MCAgX3huaW50cl9j
bG9ja19oYW5kbGVyKzB4MTAgKF9fX2lwaXBlX2Rpc3BhdGNoX3dpcmVkKzB4YjYpCjp8ICAjIGZ1
bmMgICAgICAgICAgICAgICAgLTI4MSsgICAxLjQ0MCAgX3huaW50cl9pcnFfaGFuZGxlcisweDE4
IChfeG5pbnRyX2Nsb2NrX2hhbmRsZXIrMHgxOCkKOnwgICMgZnVuYyAgICAgICAgICAgICAgICAt
Mjc5KyAgIDEuMjc4ICBfeG5wb2RfYW5ub3VuY2VfdGljaysweGMgKF94bmludHJfaXJxX2hhbmRs
ZXIrMHgyYSkKOnwgICMgZnVuYyAgICAgICAgICAgICAgICAtMjc4KyAgIDEuOTMyICBfeG50aW1l
cl9kb190aWNrX2FwZXJpb2RpYysweDE0IChfeG5wb2RfYW5ub3VuY2VfdGljaysweDE2KQo6fCAg
IyBmdW5jICAgICAgICAgICAgICAgIC0yNzYrICAgMS41OTAgIF90aW1lcl9wcm9jKzB4YyAoX3hu
dGltZXJfZG9fdGlja19hcGVyaW9kaWMrMHgxYjIpCjp8ICAjIGZ1bmMgICAgICAgICAgICAgICAg
LTI3NCsgICAxLjg4MCAgX3hucG9kX2dldF90aW1lKzB4YSAoX3RpbWVyX3Byb2MrMHgxMCkKOnwg
ICMgZnVuYyAgICAgICAgICAgICAgICAtMjczKyAgIDEuNDg4ICBfX19tdWxkaTMrMHhjIChfeG5w
b2RfZ2V0X3RpbWUrMHg1MikKOnwgICMgZnVuYyAgICAgICAgICAgICAgICAtMjcxKyAgIDIuNDEy
ICBfX19tdWxkaTMrMHhjIChfeG5wb2RfZ2V0X3RpbWUrMHg2ZSkKOnwgICMgZnVuYyAgICAgICAg
ICAgICAgICAtMjY5KyAgIDQuMTMwICBfX19kaXY2NF8zMisweDEwIChfeG5wb2RfZ2V0X3RpbWUr
MHgxZjApCjp8ICAjIGZ1bmMgICAgICAgICAgICAgICAgLTI2NSsgICA2Ljc4MCAgX19fZGl2NjRf
MzIrMHgxMCAoX3hucG9kX2dldF90aW1lKzB4MWU0KQo6fCAgIyBmdW5jICAgICAgICAgICAgICAg
IC0yNTgrICAgMS40NjggIF9ldmFsX2lubmVyX2xvb3ArMHhlIChfdGltZXJfcHJvYysweDI0KQo6
fCAgIyBmdW5jICAgICAgICAgICAgICAgIC0yNTYrICAgMS42MTIgIF94bnBvZF9nZXRfdGltZSsw
eGEgKF90aW1lcl9wcm9jKzB4MmEpCjp8ICAjIGZ1bmMgICAgICAgICAgICAgICAgLTI1NSsgICAx
LjQwMCAgX19fbXVsZGkzKzB4YyAoX3hucG9kX2dldF90aW1lKzB4NTIpCjp8ICAjIGZ1bmMgICAg
ICAgICAgICAgICAgLTI1MysgICAxLjUzMCAgX19fbXVsZGkzKzB4YyAoX3hucG9kX2dldF90aW1l
KzB4NmUpCjp8ICAjIGZ1bmMgICAgICAgICAgICAgICAgLTI1MisgICAyLjc1OCAgX19fZGl2NjRf
MzIrMHgxMCAoX3hucG9kX2dldF90aW1lKzB4MWYwKQo6fCAgIyBmdW5jICAgICAgICAgICAgICAg
IC0yNDkrICAgNS41ODIgIF9fX2RpdjY0XzMyKzB4MTAgKF94bnBvZF9nZXRfdGltZSsweDFlNCkK
OnwgICMgYmVnaW4gICAweDAwMDI3YjgwICAtMjQzKyAgIDEuMzcwICBfdGltZXJfcHJvYysweDQ0
IChfX3N0YXJ0KzB4ZmZmZmYwMDApCjp8ICAjIGZ1bmMgICAgICAgICAgICAgICAgLTI0MisgICAx
LjQ4MCAgX3hudGltZXJfc3RhcnQrMHhhIChfdGltZXJfcHJvYysweDc0KQo6fCAgIyBmdW5jICAg
ICAgICAgICAgICAgIC0yNDErICAgMS45MjggIF94bnRpbWVyX2RvX3N0YXJ0X2FwZXJpb2RpYysw
eGEgKF94bnRpbWVyX3N0YXJ0KzB4NjIpCjp8ICAjIGZ1bmMgICAgICAgICAgICAgICAgLTIzOSsg
ICAxLjQ1MiAgX19fbXVsZGkzKzB4YyAoX3hudGltZXJfZG9fc3RhcnRfYXBlcmlvZGljKzB4ZDYp
Cjp8ICAjIGZ1bmMgICAgICAgICAgICAgICAgLTIzNysgICAyLjE4MCAgX19fbXVsZGkzKzB4YyAo
X3hudGltZXJfZG9fc3RhcnRfYXBlcmlvZGljKzB4ZWUpCjp8ICAjIGZ1bmMgICAgICAgICAgICAg
ICAgLTIzNSsgICA0LjEyMCAgX19fZGl2NjRfMzIrMHgxMCAoX3hudGltZXJfZG9fc3RhcnRfYXBl
cmlvZGljKzB4NWFlKQo6fCAgIyBmdW5jICAgICAgICAgICAgICAgIC0yMzErICAgMS4yNzggIF9f
X211bGRpMysweGMgKF94bnRpbWVyX2RvX3N0YXJ0X2FwZXJpb2RpYysweDFiYykKOnwgICMgZnVu
YyAgICAgICAgICAgICAgICAtMjMwKyAgIDQuMjIyICBfX19tdWxkaTMrMHhjIChfeG50aW1lcl9k
b19zdGFydF9hcGVyaW9kaWMrMHgxZDApCjp8ICAjIGZ1bmMgICAgICAgICAgICAgICAgLTIyNSsg
ICAyLjAzMCAgX3hucG9kX3NjaGVkdWxlX2RlZmVycmVkKzB4YyAoX19faXBpcGVfY2FsbF9pcnF0
YWlsKzB4MWUpCjogICArIGZ1bmMgICAgICAgICAgICAgICAgLTIyMysgICAxLjE0MCAgX19faXBp
cGVfd2Fsa19waXBlbGluZSsweDE4IChfX19pcGlwZV9oYW5kbGVfaXJxKzB4MTI2KQo6ICAgKyBl
bmQgICAgIDB4MDAwMDAwMDYgIC0yMjIrICAgMy40NDggIF9fX2lwaXBlX2dyYWJfaXJxKzB4NDIg
KF9fc3RhcnQrMHhmZmZmZjAwMCkKOnwgICsgYmVnaW4gICAweDgwMDAwMDAxICAtMjE5KyAgIDEu
NTAyICBfX19pcGlwZV9kaXNwYXRjaF9ldmVudCsweGZhIChfX3N0YXJ0KzB4ZmZmZmYwMDApCjp8
ICAgK2VuZCAgICAgMHg4MDAwMDAwMSAgLTIxNysgICAxLjkzMCAgX19faXBpcGVfZGlzcGF0Y2hf
ZXZlbnQrMHhjYyAoX19zdGFydCsweGZmZmZmMDAwKQo6ICAgICtmdW5jICAgICAgICAgICAgICAg
IC0yMTUrICAgMi42NTAgIF9sb3N5c2NhbGxfZXZlbnQrMHgxNCAoX19faXBpcGVfZGlzcGF0Y2hf
ZXZlbnQrMHhlMikKOiAgICArZnVuYyAgICAgICAgICAgICAgICAtMjEzKyAgIDEuNjA4ICBfc3lz
X3J0ZG1faW9jdGwrMHhhIChfbG9zeXNjYWxsX2V2ZW50KzB4OTQpCjogICAgK2Z1bmMgICAgICAg
ICAgICAgICAgLTIxMSsgICAxLjc2MiAgX19ydGRtX2lvY3RsKzB4YSAoX3N5c19ydGRtX2lvY3Rs
KzB4MWMpCjogICAgK2Z1bmMgICAgICAgICAgICAgICAgLTIwOSsgICAxLjI4MCAgX3J0ZG1fY29u
dGV4dF9nZXQrMHgxMCAoX19ydGRtX2lvY3RsKzB4MjApCjp8ICAgK2JlZ2luICAgMHg4MDAwMDAw
MSAgLTIwOCsgICAyLjUwMCAgX3J0ZG1fY29udGV4dF9nZXQrMHgyNCAoX19zdGFydCsweGZmZmZm
MDAwKQo6fCAgKitmdW5jICAgICAgICAgICAgICAgIC0yMDYrICAgMS45MjggIF9fX2lwaXBlX3Rl
c3RfYW5kX3N0YWxsX3Jvb3QrMHhlIChfcnRkbV9jb250ZXh0X2dldCsweDU4KQo6fCAgKiNmdW5j
ICAgICAgICAgICAgICAgIC0yMDQrICAgMS4yNjIgIF9fX2lwaXBlX3Jlc3RvcmVfcm9vdCsweGEg
KF9ydGRtX2NvbnRleHRfZ2V0KzB4NmUpCjp8ICAqI2Z1bmMgICAgICAgICAgICAgICAgLTIwMiAg
ICAwLjk4MCAgX19faXBpcGVfdW5zdGFsbF9yb290KzB4OCAoX19faXBpcGVfcmVzdG9yZV9yb290
KzB4MWEpCjp8ICAqK2VuZCAgICAgMHg4MDAwMDAwMCAgLTIwMSsgICAxLjQ5MCAgX19faXBpcGVf
dW5zdGFsbF9yb290KzB4NTggKF9fc3RhcnQrMHhmZmZmZjAwMCkKOiAgICorZnVuYyAgICAgICAg
ICAgICAgICAtMjAwICAgIDAuNzI4ICBfX19pcGlwZV9yZXN0b3JlX3BpcGVsaW5lX2hlYWQrMHhh
IChfcnRkbV9jb250ZXh0X2dldCsweDgyKQo6fCAgKitiZWdpbiAgIDB4ODAwMDAwMDEgIC0xOTkr
ICAgMS4zMjIgIF9fX2lwaXBlX3Jlc3RvcmVfcGlwZWxpbmVfaGVhZCsweDFlIChfX3N0YXJ0KzB4
ZmZmZmYwMDApCjp8ICAgK2VuZCAgICAgMHg4MDAwMDAwMCAgLTE5OCsgICAyLjk2MCAgX19faXBp
cGVfcmVzdG9yZV9waXBlbGluZV9oZWFkKzB4OTQgKF9fc3RhcnQrMHhmZmZmZjAwMCkKOiAgICAr
ZnVuYyAgICAgICAgICAgICAgICAtMTk1KyAgIDEuNjkwICBfcnRfdG1iZW5jaF9pb2N0bF9ucnQr
MHgxNiAoX19ydGRtX2lvY3RsKzB4NGEpCjogICAgK2Z1bmMgICAgICAgICAgICAgICAgLTE5MyAg
ICAwLjgwOCAgX19faXBpcGVfdGVzdF9hbmRfc3RhbGxfcm9vdCsweGUgKF9fcnRkbV9pb2N0bCsw
eDUwKQo6fCAgICtiZWdpbiAgIDB4ODAwMDAwMDEgIC0xOTIrICAgMS4zMDIgIF9fX2lwaXBlX3Rl
c3RfYW5kX3N0YWxsX3Jvb3QrMHgyMiAoX19zdGFydCsweGZmZmZmMDAwKQo6fCAgICNlbmQgICAg
IDB4ODAwMDAwMDEgIC0xOTErICAgMS41OTAgIF9fX2lwaXBlX3Rlc3RfYW5kX3N0YWxsX3Jvb3Qr
MHgzNiAoX19zdGFydCsweGZmZmZmMDAwKQo6ICAgICNmdW5jICAgICAgICAgICAgICAgIC0xODkr
ICAgMS4yMjAgIF9fX2lwaXBlX3Jlc3RvcmVfcm9vdCsweGEgKF9fcnRkbV9pb2N0bCsweDY0KQo6
ICAgICNmdW5jICAgICAgICAgICAgICAgIC0xODggICAgMC43MjggIF9fX2lwaXBlX3Vuc3RhbGxf
cm9vdCsweDggKF9fX2lwaXBlX3Jlc3RvcmVfcm9vdCsweDFhKQo6ICAgICNiZWdpbiAgIDB4ODAw
MDAwMDAgIC0xODcrICAgMS4zMjIgIF9fX2lwaXBlX3Vuc3RhbGxfcm9vdCsweDFhIChfX3N0YXJ0
KzB4ZmZmZmYwMDApCjp8ICAgK2VuZCAgICAgMHg4MDAwMDAwMCAgLTE4NisgICAyLjE4MCAgX19f
aXBpcGVfdW5zdGFsbF9yb290KzB4NTggKF9fc3RhcnQrMHhmZmZmZjAwMCkKOiAgICArZnVuYyAg
ICAgICAgICAgICAgICAtMTg0KyAgIDEuNjkwICBfeG5zaGFkb3dfaGFyZGVuKzB4MTIgKF9sb3N5
c2NhbGxfZXZlbnQrMHhiMikKOiAgICArZnVuYyAgICAgICAgICAgICAgICAtMTgyICAgIDAuNzA4
ICBfX19pcGlwZV90ZXN0X2FuZF9zdGFsbF9yb290KzB4ZSAoX3huc2hhZG93X2hhcmRlbisweDNl
KQo6fCAgICtiZWdpbiAgIDB4ODAwMDAwMDEgIC0xODIrICAgMS4zMDIgIF9fX2lwaXBlX3Rlc3Rf
YW5kX3N0YWxsX3Jvb3QrMHgyMiAoX19zdGFydCsweGZmZmZmMDAwKQo6fCAgICNlbmQgICAgIDB4
ODAwMDAwMDEgIC0xODArICAgMS43OTAgIF9fX2lwaXBlX3Rlc3RfYW5kX3N0YWxsX3Jvb3QrMHgz
NiAoX19zdGFydCsweGZmZmZmMDAwKQo6ICAgICNmdW5jICAgICAgICAgICAgICAgIC0xNzkrICAg
MS4zMzAgIF9fX2lwaXBlX3Jlc3RvcmVfcm9vdCsweGEgKF94bnNoYWRvd19oYXJkZW4rMHg1NikK
OiAgICAjZnVuYyAgICAgICAgICAgICAgICAtMTc3ICAgIDAuNzI4ICBfX19pcGlwZV91bnN0YWxs
X3Jvb3QrMHg4IChfX19pcGlwZV9yZXN0b3JlX3Jvb3QrMHgxYSkKOiAgICAjYmVnaW4gICAweDgw
MDAwMDAwICAtMTc2KyAgIDEuMzIyICBfX19pcGlwZV91bnN0YWxsX3Jvb3QrMHgxYSAoX19zdGFy
dCsweGZmZmZmMDAwKQo6fCAgICtlbmQgICAgIDB4ODAwMDAwMDAgIC0xNzUrICAgMS4yMDAgIF9f
X2lwaXBlX3Vuc3RhbGxfcm9vdCsweDU4IChfX3N0YXJ0KzB4ZmZmZmYwMDApCjp8ICAgK2JlZ2lu
ICAgMHg4MDAwMDAwMSAgLTE3NCsgICAxLjUyMCAgX3huc2hhZG93X2hhcmRlbisweDc2IChfX3N0
YXJ0KzB4ZmZmZmYwMDApCjp8ICAgK2VuZCAgICAgMHg4MDAwMDAwMSAgLTE3MisgICAxLjYzOCAg
X3huc2hhZG93X2hhcmRlbisweDhjIChfX3N0YXJ0KzB4ZmZmZmYwMDApCjogICAgK2Z1bmMgICAg
ICAgICAgICAgICAgLTE3MSsgICAxLjYxMiAgX19fd2FrZV91cF9zeW5jKzB4YyAoX3huc2hhZG93
X2hhcmRlbisweGE0KQo6ICAgICtmdW5jICAgICAgICAgICAgICAgIC0xNjkgICAgMC44NDAgIF9f
X2lwaXBlX3Rlc3RfYW5kX3N0YWxsX3Jvb3QrMHhlIChfX193YWtlX3VwX3N5bmMrMHgxOCkKOnwg
ICArYmVnaW4gICAweDgwMDAwMDAxICAtMTY4KyAgIDEuMjcwICBfX19pcGlwZV90ZXN0X2FuZF9z
dGFsbF9yb290KzB4MjIgKF9fc3RhcnQrMHhmZmZmZjAwMCkKOnwgICAjZW5kICAgICAweDgwMDAw
MDAxICAtMTY3KyAgIDEuNTk4ICBfX19pcGlwZV90ZXN0X2FuZF9zdGFsbF9yb290KzB4MzYgKF9f
c3RhcnQrMHhmZmZmZjAwMCkKOiAgICAjZnVuYyAgICAgICAgICAgICAgICAtMTY1KyAgIDEuNzgy
ICBfX193YWtlX3VwX2NvbW1vbisweGMgKF9fX3dha2VfdXBfc3luYysweDM4KQo6ICAgICNmdW5j
ICAgICAgICAgICAgICAgIC0xNjQrICAgMi4xNjAgIF9kZWZhdWx0X3dha2VfZnVuY3Rpb24rMHhh
IChfX193YWtlX3VwX2NvbW1vbisweDM4KQo6ICAgICNmdW5jICAgICAgICAgICAgICAgIC0xNjIr
ICAgMS40NjAgIF90cnlfdG9fd2FrZV91cCsweGEgKF9kZWZhdWx0X3dha2VfZnVuY3Rpb24rMHgx
MCkKOiAgICAjZnVuYyAgICAgICAgICAgICAgICAtMTYwICAgIDAuNzI4ICBfX19pcGlwZV90ZXN0
X2FuZF9zdGFsbF9yb290KzB4ZSAoX3RyeV90b193YWtlX3VwKzB4MTQpCjp8ICAgI2JlZ2luICAg
MHg4MDAwMDAwMSAgLTE1OSsgICAxLjMyMiAgX19faXBpcGVfdGVzdF9hbmRfc3RhbGxfcm9vdCsw
eDIyIChfX3N0YXJ0KzB4ZmZmZmYwMDApCjp8ICAgI2VuZCAgICAgMHg4MDAwMDAwMSAgLTE1OCsg
ICAxLjc2MCAgX19faXBpcGVfdGVzdF9hbmRfc3RhbGxfcm9vdCsweDM2IChfX3N0YXJ0KzB4ZmZm
ZmYwMDApCjogICAgI2Z1bmMgICAgICAgICAgICAgICAgLTE1NisgICAxLjMwMCAgX3NjaGVkX2Ns
b2NrKzB4YyAoX3RyeV90b193YWtlX3VwKzB4N2UpCjogICAgI2Z1bmMgICAgICAgICAgICAgICAg
LTE1NSsgICAyLjA4OCAgX19fbXVsZGkzKzB4YyAoX3NjaGVkX2Nsb2NrKzB4MjYpCjogICAgI2Z1
bmMgICAgICAgICAgICAgICAgLTE1MysgICAyLjE0MiAgX2VucXVldWVfdGFzaysweGUgKF90cnlf
dG9fd2FrZV91cCsweGQyKQo6ICAgICNmdW5jICAgICAgICAgICAgICAgIC0xNTErICAgMS4yNTAg
IF9fX2lwaXBlX3Jlc3RvcmVfcm9vdCsweGEgKF90cnlfdG9fd2FrZV91cCsweDNjKQo6ICAgICNm
dW5jICAgICAgICAgICAgICAgIC0xNDkgICAgMC44OTAgIF9fX2lwaXBlX3N0YWxsX3Jvb3QrMHhl
IChfX19pcGlwZV9yZXN0b3JlX3Jvb3QrMHgxMCkKOnwgICAjYmVnaW4gICAweDgwMDAwMDAxICAt
MTQ5KyAgIDEuMTI4ICBfX19pcGlwZV9zdGFsbF9yb290KzB4MjIgKF9fc3RhcnQrMHhmZmZmZjAw
MCkKOnwgICAjZW5kICAgICAweDgwMDAwMDAxICAtMTQ3KyAgIDEuNTkyICBfX19pcGlwZV9zdGFs
bF9yb290KzB4MzAgKF9fc3RhcnQrMHhmZmZmZjAwMCkKOiAgICAjZnVuYyAgICAgICAgICAgICAg
ICAtMTQ2KyAgIDEuMTkwICBfX19pcGlwZV9yZXN0b3JlX3Jvb3QrMHhhIChfX193YWtlX3VwX3N5
bmMrMHgzZSkKOiAgICAjZnVuYyAgICAgICAgICAgICAgICAtMTQ1ICAgIDAuODkwICBfX19pcGlw
ZV91bnN0YWxsX3Jvb3QrMHg4IChfX19pcGlwZV9yZXN0b3JlX3Jvb3QrMHgxYSkKOiAgICAjYmVn
aW4gICAweDgwMDAwMDAwICAtMTQ0KyAgIDEuMTI4ICBfX19pcGlwZV91bnN0YWxsX3Jvb3QrMHgx
YSAoX19zdGFydCsweGZmZmZmMDAwKQo6fCAgICtlbmQgICAgIDB4ODAwMDAwMDAgIC0xNDMrICAg
MS40OTIgIF9fX2lwaXBlX3Vuc3RhbGxfcm9vdCsweDU4IChfX3N0YXJ0KzB4ZmZmZmYwMDApCjog
ICAgK2Z1bmMgICAgICAgICAgICAgICAgLTE0MSsgICAxLjUxMCAgX19fc2NoZWRfdGV4dF9zdGFy
dCsweGUgKF94bnNoYWRvd19oYXJkZW4rMHhhOCkKOiAgICArZnVuYyAgICAgICAgICAgICAgICAt
MTQwKyAgIDEuNjUwICBfcHJvZmlsZV9oaXQrMHhlIChfX19zY2hlZF90ZXh0X3N0YXJ0KzB4NGMp
CjogICAgK2Z1bmMgICAgICAgICAgICAgICAgLTEzOCsgICAxLjExOCAgX3NjaGVkX2Nsb2NrKzB4
YyAoX19fc2NoZWRfdGV4dF9zdGFydCsweDdjKQo6ICAgICtmdW5jICAgICAgICAgICAgICAgIC0x
MzcrICAgMi44MDIgIF9fX211bGRpMysweGMgKF9zY2hlZF9jbG9jaysweDI2KQo6ICAgICtmdW5j
ICAgICAgICAgICAgICAgIC0xMzQgICAgMC44NzAgIF9fX2lwaXBlX3N0YWxsX3Jvb3QrMHhlIChf
X19zY2hlZF90ZXh0X3N0YXJ0KzB4ZWMpCjp8ICAgK2JlZ2luICAgMHg4MDAwMDAwMSAgLTEzMysg
ICAxLjI3MCAgX19faXBpcGVfc3RhbGxfcm9vdCsweDIyIChfX3N0YXJ0KzB4ZmZmZmYwMDApCjp8
ICAgI2VuZCAgICAgMHg4MDAwMDAwMSAgLTEzMisgICAxLjYyOCAgX19faXBpcGVfc3RhbGxfcm9v
dCsweDMwIChfX3N0YXJ0KzB4ZmZmZmYwMDApCjogICAgI2Z1bmMgICAgICAgICAgICAgICAgLTEz
MCsgICAxLjQ5MiAgX2RlYWN0aXZhdGVfdGFzaysweGUgKF9fX3NjaGVkX3RleHRfc3RhcnQrMHg0
NjQpCjogICAgI2Z1bmMgICAgICAgICAgICAgICAgLTEyOSsgICAyLjg2MCAgX2RlcXVldWVfdGFz
aysweGUgKF9kZWFjdGl2YXRlX3Rhc2srMHgxYykKOnwgICAjYmVnaW4gICAweDgwMDAwMDAxICAt
MTI2KyAgIDEuNTQwICBfX19zY2hlZF90ZXh0X3N0YXJ0KzB4MWU2IChfX3N0YXJ0KzB4ZmZmZmYw
MDApCjp8ICAgI2VuZCAgICAgMHg4MDAwMDAwMSAgLTEyNCsgICAzLjIzOCAgX19fc2NoZWRfdGV4
dF9zdGFydCsweDFmNCAoX19zdGFydCsweGZmZmZmMDAwKQo6ICAgICNmdW5jICAgICAgICAgICAg
ICAgIC0xMjEgICAgMC45NTIgIF9fX2lwaXBlX2Rpc3BhdGNoX2V2ZW50KzB4YSAoX19fc2NoZWRf
dGV4dF9zdGFydCsweDJkZSkKOnwgICAjYmVnaW4gICAweDgwMDAwMDAxICAtMTIwKyAgIDEuNDcw
ICBfX19pcGlwZV9kaXNwYXRjaF9ldmVudCsweDIwIChfX3N0YXJ0KzB4ZmZmZmYwMDApCjp8ICAg
I2VuZCAgICAgMHg4MDAwMDAwMSAgLTExOSsgICAxLjYxMCAgX19faXBpcGVfZGlzcGF0Y2hfZXZl
bnQrMHhjYyAoX19zdGFydCsweGZmZmZmMDAwKQo6ICAgICNmdW5jICAgICAgICAgICAgICAgIC0x
MTcrICAgMS4wNzggIF9zY2hlZHVsZV9ldmVudCsweDE2IChfX19pcGlwZV9kaXNwYXRjaF9ldmVu
dCsweGUyKQo6fCAgICNiZWdpbiAgIDB4ODAwMDAwMDEgIC0xMTYrICAgMS42MzIgIF9fX2lwaXBl
X2Rpc3BhdGNoX2V2ZW50KzB4ZmEgKF9fc3RhcnQrMHhmZmZmZjAwMCkKOnwgICAjZW5kICAgICAw
eDgwMDAwMDAxICAtMTE0ICAgIDAuOTgwICBfX19pcGlwZV9kaXNwYXRjaF9ldmVudCsweDE3YSAo
X19zdGFydCsweGZmZmZmMDAwKQo6ICAgICNiZWdpbiAgIDB4ODAwMDAwMDAgIC0xMTMrICAgMi4x
MjAgIF9fX3NjaGVkX3RleHRfc3RhcnQrMHgyZjAgKF9fc3RhcnQrMHhmZmZmZjAwMCkKOnwgICAj
ZnVuYyAgICAgICAgICAgICAgICAtMTExKyAgIDEuMzk4ICBfX19pcGlwZV90ZXN0X2FuZF9zdGFs
bF9yb290KzB4ZSAoX19fc2NoZWRfdGV4dF9zdGFydCsweDY3OCkKOnwgICAjZnVuYyAgICAgICAg
ICAgICAgICAtMTEwKyAgIDEuMjcyICBfX19pcGlwZV9yZXN0b3JlX3Jvb3QrMHhhIChfX19zY2hl
ZF90ZXh0X3N0YXJ0KzB4NjhjKQo6fCAgICNmdW5jICAgICAgICAgICAgICAgIC0xMDkrICAgNC4x
MTAgIF9fX2lwaXBlX3N0YWxsX3Jvb3QrMHhlIChfX19pcGlwZV9yZXN0b3JlX3Jvb3QrMHgxMCkK
OnwgICAjZW5kICAgICAweDgwMDAwMDAwICAtMTA1KyAgIDEuNzQwICBfX19zY2hlZF90ZXh0X3N0
YXJ0KzB4NWNhIChfX3N0YXJ0KzB4ZmZmZmYwMDApCjogICAgI2Z1bmMgICAgICAgICAgICAgICAg
LTEwMyAgICAwLjcyOCAgX19faXBpcGVfdW5zdGFsbF9yb290KzB4OCAoX19fc2NoZWRfdGV4dF9z
dGFydCsweDNjZSkKOiAgICAjYmVnaW4gICAweDgwMDAwMDAwICAtMTAyKyAgIDEuMzIyICBfX19p
cGlwZV91bnN0YWxsX3Jvb3QrMHgxYSAoX19zdGFydCsweGZmZmZmMDAwKQo6fCAgICtlbmQgICAg
IDB4ODAwMDAwMDAgIC0xMDErICAgMi41OTAgIF9fX2lwaXBlX3Vuc3RhbGxfcm9vdCsweDU4IChf
X3N0YXJ0KzB4ZmZmZmYwMDApCjogICAgK2Z1bmMgICAgICAgICAgICAgICAgIC05OCsgICAxLjU1
MCAgX2t0aHJlYWRfc2hvdWxkX3N0b3ArMHgxMCAoX2dhdGVrZWVwZXJfdGhyZWFkKzB4ZWMpCjp8
ICAgK2JlZ2luICAgMHg4MDAwMDAwMSAgIC05NysgICAyLjg5OCAgX2dhdGVrZWVwZXJfdGhyZWFk
KzB4MTAwIChfX3N0YXJ0KzB4ZmZmZmYwMDApCjp8ICAqK2Z1bmMgICAgICAgICAgICAgICAgIC05
NCsgICAxLjQzMiAgX3hucG9kX3Jlc3VtZV90aHJlYWQrMHhhIChfZ2F0ZWtlZXBlcl90aHJlYWQr
MHgxODYpCjp8ICAqK1sgICA1MV0gLTw/Pi0gICAgMCAgIC05MisgICA1LjQ1MCAgX3hucG9kX3Jl
c3VtZV90aHJlYWQrMHg0YSAoX19zdGFydCsweGZmZmZmMDAwKQo6fCAgKitmdW5jICAgICAgICAg
ICAgICAgICAtODcrICAgMS4xMDAgIF94bnBvZF9zY2hlZHVsZV9ydW5uYWJsZSsweGMgKF9nYXRl
a2VlcGVyX3RocmVhZCsweDFiZSkKOnwgICorWyAgICAwXSBzd2FwcGVyIC0xICAgLTg2KyAgIDIu
Nzg4ICBfeG5wb2Rfc2NoZWR1bGVfcnVubmFibGUrMHgyOCAoX19zdGFydCsweGZmZmZmMDAwKQo6
fCAgKitmdW5jICAgICAgICAgICAgICAgICAtODMrICAgMi44NTIgIF94bnBvZF9zY2hlZHVsZSsw
eGEgKF9nYXRla2VlcGVyX3RocmVhZCsweDFjZSkKOnwgICorZnVuYyAgICAgICAgICAgICAgICAg
LTgwKyAgIDIuOTcwICBfaXBpcGVfdHJpZ2dlcl9pcnErMHgxMiAoX3hucG9kX3NjaGVkdWxlKzB4
MmU2KQo6fCAgKitmdW5jICAgICAgICAgICAgICAgICAtNzcrICAgMi4xMjAgIF9fX2lwaXBlX2hh
bmRsZV9pcnErMHgxZSAoX2lwaXBlX3RyaWdnZXJfaXJxKzB4ODYpCjp8ICAqK2Z1bmMgICAgICAg
ICAgICAgICAgIC03NSsgICAyLjA1OCAgX19faXBpcGVfZGlzcGF0Y2hfd2lyZWQrMHgxNCAoX19f
aXBpcGVfaGFuZGxlX2lycSsweDE5MCkKOnwgICorZnVuYyAgICAgICAgICAgICAgICAgLTczKyAg
IDEuNzIyICBfX19pcGlwZV9yZXN0b3JlX3BpcGVsaW5lX2hlYWQrMHhhIChfZ2F0ZWtlZXBlcl90
aHJlYWQrMHgxMzgpCjp8ICAgK2Z1bmMgICAgICAgICAgICAgICAgIC03MSsgICAyLjEzMCAgX19f
aXBpcGVfd2Fsa19waXBlbGluZSsweDE4IChfX19pcGlwZV9yZXN0b3JlX3BpcGVsaW5lX2hlYWQr
MHhkMCkKOnwgICsgZnVuYyAgICAgICAgICAgICAgICAgLTY5KyAgIDIuNDEwICBfaXBpcGVfc3Vz
cGVuZF9kb21haW4rMHhhIChfX19pcGlwZV93YWxrX3BpcGVsaW5lKzB4YWMpCjp8ICArIGZ1bmMg
ICAgICAgICAgICAgICAgIC02NysgICA1LjA0OCAgX19faXBpcGVfc3luY19zdGFnZSsweGUgKF9p
cGlwZV9zdXNwZW5kX2RvbWFpbisweDRlKQo6fCAgIyBmdW5jICAgICAgICAgICAgICAgICAtNjIr
ICAgMi40NTIgIF94bnBvZF9zY2hlZHVsZV9oYW5kbGVyKzB4ZSAoX19faXBpcGVfc3luY19zdGFn
ZSsweDE4NikKOnwgICMgZnVuYyAgICAgICAgICAgICAgICAgLTU5KyAgIDIuMTMwICBfeG5wb2Rf
c2NoZWR1bGUrMHhhIChfeG5wb2Rfc2NoZWR1bGVfaGFuZGxlcisweDVjKQo6fCAgIyBbICAgIDBd
IHN3YXBwZXIgLTEgICAtNTcrICAgNy4xODAgIF94bnBvZF9zY2hlZHVsZSsweDEwNCAoX19zdGFy
dCsweGZmZmZmMDAwKQo6fCAgIyBlbmQgICAgIDB4ODAwMDAwMDAgICAtNTArICAgMi4yNzggIF9f
X3NjaGVkX3RleHRfc3RhcnQrMHg1Y2EgKF9fc3RhcnQrMHhmZmZmZjAwMCkKOnwgICMgZnVuYyAg
ICAgICAgICAgICAgICAgLTQ4ICAgIDAuOTIyICBfX19pcGlwZV9ncmFiX2lycSsweDIyIChfX2Nv
bW1vbl9pbnRfZW50cnkrMHg3MikKOnwgICMgYmVnaW4gICAweDAwMDAwMDA2ICAgLTQ3KyAgIDEu
ODIwICBfX19pcGlwZV9ncmFiX2lycSsweDM0IChfX3N0YXJ0KzB4ZmZmZmYwMDApCjp8ICAjIGZ1
bmMgICAgICAgICAgICAgICAgIC00NSsgICAxLjUzMCAgX19faXBpcGVfaGFuZGxlX2lycSsweDFl
IChfX19pcGlwZV9ncmFiX2lycSsweDNjKQo6fCAgIyBmdW5jICAgICAgICAgICAgICAgICAtNDMr
ICAgMS4xNjggIF9ydGhhbF90aW1lcl9hY2srMHg4IChfX19pcGlwZV9oYW5kbGVfaXJxKzB4MTc4
KQo6fCAgIyBmdW5jICAgICAgICAgICAgICAgICAtNDIrICAgMS4xMDIgIF9fX2lwaXBlX2Rpc3Bh
dGNoX3dpcmVkKzB4MTQgKF9fX2lwaXBlX2hhbmRsZV9pcnErMHgxOTApCjp8ICAjIGVuZCAgICAg
MHgwMDAwMDAwNiAgIC00MSsgICAyLjAxMCAgX19faXBpcGVfZ3JhYl9pcnErMHg0MiAoX19zdGFy
dCsweGZmZmZmMDAwKQo6ICAgIyBmdW5jICAgICAgICAgICAgICAgICAtMzkrICAgMS4wOTAgIF9p
cGlwZV91bnN0YWxsX3BpcGVsaW5lX2hlYWQrMHg4IChfeG5zaGFkb3dfaGFyZGVuKzB4Y2UpCjp8
ICAjIGJlZ2luICAgMHg4MDAwMDAwMSAgIC0zOCsgICAyLjMwOCAgX2lwaXBlX3Vuc3RhbGxfcGlw
ZWxpbmVfaGVhZCsweDE4IChfX3N0YXJ0KzB4ZmZmZmYwMDApCjp8ICArIGZ1bmMgICAgICAgICAg
ICAgICAgIC0zNisgICAxLjg5MiAgX19faXBpcGVfc3luY19zdGFnZSsweGUgKF9pcGlwZV91bnN0
YWxsX3BpcGVsaW5lX2hlYWQrMHg3NCkKOnwgICMgZnVuYyAgICAgICAgICAgICAgICAgLTM0KyAg
IDEuNTgwICBfeG5pbnRyX2Nsb2NrX2hhbmRsZXIrMHgxMCAoX19faXBpcGVfc3luY19zdGFnZSsw
eDE4NikKOnwgICMgZnVuYyAgICAgICAgICAgICAgICAgLTMyKyAgIDEuNDYwICBfeG5pbnRyX2ly
cV9oYW5kbGVyKzB4MTggKF94bmludHJfY2xvY2tfaGFuZGxlcisweDE4KQo6fCAgIyBmdW5jICAg
ICAgICAgICAgICAgICAtMzErICAgMS43MjggIF94bnBvZF9hbm5vdW5jZV90aWNrKzB4YyAoX3hu
aW50cl9pcnFfaGFuZGxlcisweDJhKQo6fCAgIyBmdW5jICAgICAgICAgICAgICAgICAtMjkrICAg
Mi40NDIgIF94bnRpbWVyX2RvX3RpY2tfYXBlcmlvZGljKzB4MTQgKF94bnBvZF9hbm5vdW5jZV90
aWNrKzB4MTYpCjp8ICAjIGZ1bmMgICAgICAgICAgICAgICAgIC0yNysgICAxLjU5MCAgX3RpbWVy
X3Byb2MrMHhjIChfeG50aW1lcl9kb190aWNrX2FwZXJpb2RpYysweDFiMikKOnwgICMgZnVuYyAg
ICAgICAgICAgICAgICAgLTI1KyAgIDEuODgwICBfeG5wb2RfZ2V0X3RpbWUrMHhhIChfdGltZXJf
cHJvYysweDEwKQo6fCAgIyBmdW5jICAgICAgICAgICAgICAgICAtMjMrICAgMS41OTggIF9fX211
bGRpMysweGMgKF94bnBvZF9nZXRfdGltZSsweDUyKQo6fCAgIyBmdW5jICAgICAgICAgICAgICAg
ICAtMjErICAgMi40MzIgIF9fX211bGRpMysweGMgKF94bnBvZF9nZXRfdGltZSsweDZlKQo6fCAg
IyBmdW5jICAgICAgICAgICAgICAgICAtMTkrICAgNC4xMzAgIF9fX2RpdjY0XzMyKzB4MTAgKF94
bnBvZF9nZXRfdGltZSsweDFmMCkKOnwgICMgZnVuYyAgICAgICAgICAgICAgICAgLTE1KyAgIDYu
NzcwICBfX19kaXY2NF8zMisweDEwIChfeG5wb2RfZ2V0X3RpbWUrMHgxZTQpCjp8ICAjIGZ1bmMg
ICAgICAgICAgICAgICAgICAtOCsgICAxLjgwOCAgX2V2YWxfaW5uZXJfbG9vcCsweGUgKF90aW1l
cl9wcm9jKzB4MjQpCjp8ICAjIGZ1bmMgICAgICAgICAgICAgICAgICAtNisgICAxLjQzMiAgX2lw
aXBlX3RyYWNlX2Zyb3plbl9yZXNldCsweGEgKF9ldmFsX2lubmVyX2xvb3ArMHhlMCkKOnwgICMg
ZnVuYyAgICAgICAgICAgICAgICAgIC01KyAgIDQuNDAwICBfX19pcGlwZV9nbG9iYWxfcGF0aF9s
b2NrKzB4YSAoX2lwaXBlX3RyYWNlX2Zyb3plbl9yZXNldCsweGUpCjx8ICAjIGZyZWV6ZSAgMHgw
MDAxMGJhOCAgICAgMSAgICAyLjM3MCAgX2V2YWxfaW5uZXJfbG9vcCsweGU2IChfX3N0YXJ0KzB4
ZmZmZmYwMDApCiB8ICAjIGZ1bmMgICAgICAgICAgICAgICAgICAgMyAgICAxLjMwOCAgX3hucG9k
X2dldF90aW1lKzB4YSAoX3RpbWVyX3Byb2MrMHgyYSkKIHwgICMgZnVuYyAgICAgICAgICAgICAg
ICAgICA0ICAgIDEuNDgyICBfX19tdWxkaTMrMHhjIChfeG5wb2RfZ2V0X3RpbWUrMHg1MikKIHwg
ICMgZnVuYyAgICAgICAgICAgICAgICAgICA2ICAgIDEuNTQwICBfX19tdWxkaTMrMHhjIChfeG5w
b2RfZ2V0X3RpbWUrMHg2ZSkKIHwgICMgZnVuYyAgICAgICAgICAgICAgICAgICA3ICAgIDMuMDIw
ICBfX19kaXY2NF8zMisweDEwIChfeG5wb2RfZ2V0X3RpbWUrMHgxZjApCiB8ICAjIGZ1bmMgICAg
ICAgICAgICAgICAgICAxMCAgICA1LjcwOCAgX19fZGl2NjRfMzIrMHgxMCAoX3hucG9kX2dldF90
aW1lKzB4MWU0KQogfCAgIyBiZWdpbiAgIDB4MDAwMTk5MmEgICAgMTYgICAgMS44NDIgIF90aW1l
cl9wcm9jKzB4NDQgKF9fc3RhcnQrMHhmZmZmZjAwMCkKIHwgICMgZnVuYyAgICAgICAgICAgICAg
ICAgIDE4ICAgIDEuOTQwICBfeG50aW1lcl9zdGFydCsweGEgKF90aW1lcl9wcm9jKzB4NzQpCiB8
ICAjIGZ1bmMgICAgICAgICAgICAgICAgICAyMCAgICAyLjQyMCAgX3hudGltZXJfZG9fc3RhcnRf
YXBlcmlvZGljKzB4YSAoX3hudGltZXJfc3RhcnQrMHg2MikKIHwgICMgZnVuYyAgICAgICAgICAg
ICAgICAgIDIyICAgIDEuNDk4ICBfX19tdWxkaTMrMHhjIChfeG50aW1lcl9kb19zdGFydF9hcGVy
aW9kaWMrMHhkNikKIHwgICMgZnVuYyAgICAgICAgICAgICAgICAgIDI0ICAgIDIuOTcyICBfX19t
dWxkaTMrMHhjIChfeG50aW1lcl9kb19zdGFydF9hcGVyaW9kaWMrMHhlZSkKIHwgICMgZnVuYyAg
ICAgICAgICAgICAgICAgIDI3ICAgIDQuNTYwICBfX19kaXY2NF8zMisweDEwIChfeG50aW1lcl9k
b19zdGFydF9hcGVyaW9kaWMrMHg1YWUpCiB8ICAjIGZ1bmMgICAgICAgICAgICAgICAgICAzMSAg
ICAxLjY2MCAgX19fbXVsZGkzKzB4YyAoX3hudGltZXJfZG9fc3RhcnRfYXBlcmlvZGljKzB4MWJj
KQogfCAgIyBmdW5jICAgICAgICAgICAgICAgICAgMzMgICAgNS44MTggIF9fX211bGRpMysweGMg
KF94bnRpbWVyX2RvX3N0YXJ0X2FwZXJpb2RpYysweDFkMCkKIHwgICsgZW5kICAgICAweDgwMDAw
MDAwICAgIDM5ICAgIDEuOTIyICBfaXBpcGVfdW5zdGFsbF9waXBlbGluZV9oZWFkKzB4NTIgKF9f
c3RhcnQrMHhmZmZmZjAwMCkKICAgICsgZnVuYyAgICAgICAgICAgICAgICAgIDQxICAgIDEuOTUw
ICBfc3lzX3J0ZG1faW9jdGwrMHhhIChfbG9zeXNjYWxsX2V2ZW50KzB4OTQpCiAgICArIGZ1bmMg
ICAgICAgICAgICAgICAgICA0MyAgICAxLjczMCAgX19ydGRtX2lvY3RsKzB4YSAoX3N5c19ydGRt
X2lvY3RsKzB4MWMpCiAgICArIGZ1bmMgICAgICAgICAgICAgICAgICA0NCAgICAwLjkxOCAgX3J0
ZG1fY29udGV4dF9nZXQrMHgxMCAoX19ydGRtX2lvY3RsKzB4MjApCiB8ICArIGJlZ2luICAgMHg4
MDAwMDAwMSAgICA0NSAgICAxLjUyMiAgX3J0ZG1fY29udGV4dF9nZXQrMHgyNCAoX19zdGFydCsw
eGZmZmZmMDAwKQogfCAgIyBmdW5jICAgICAgICAgICAgICAgICAgNDcgICAgMi4wNDAgIF9fX2lw
aXBlX3Rlc3RfYW5kX3N0YWxsX3Jvb3QrMHhlIChfcnRkbV9jb250ZXh0X2dldCsweDU4KQogfCAg
IypmdW5jICAgICAgICAgICAgICAgICAgNDkgICAgMS4yNDAgIF9fX2lwaXBlX3Jlc3RvcmVfcm9v
dCsweGEgKF9ydGRtX2NvbnRleHRfZ2V0KzB4NmUpCiB8ICAjKmZ1bmMgICAgICAgICAgICAgICAg
ICA1MCAgICAwLjgyOCAgX19faXBpcGVfdW5zdGFsbF9yb290KzB4OCAoX19faXBpcGVfcmVzdG9y
ZV9yb290KzB4MWEpCiB8ICAjIGVuZCAgICAgMHg4MDAwMDAwMCAgICA1MSAgICAxLjQwMiAgX19f
aXBpcGVfdW5zdGFsbF9yb290KzB4NTggKF9fc3RhcnQrMHhmZmZmZjAwMCkKICAgICMgZnVuYyAg
ICAgICAgICAgICAgICAgIDUyICAgIDAuODkwICBfX19pcGlwZV9yZXN0b3JlX3BpcGVsaW5lX2hl
YWQrMHhhIChfcnRkbV9jb250ZXh0X2dldCsweDgyKQogfCAgIyBiZWdpbiAgIDB4ODAwMDAwMDEg
ICAgNTMgICAgMC45NjAgIF9fX2lwaXBlX3Jlc3RvcmVfcGlwZWxpbmVfaGVhZCsweDFlIChfX3N0
YXJ0KzB4ZmZmZmYwMDApCiB8ICArIGVuZCAgICAgMHg4MDAwMDAwMCAgICA1NCAgICAyLjIyOCAg
X19faXBpcGVfcmVzdG9yZV9waXBlbGluZV9oZWFkKzB4OTQgKF9fc3RhcnQrMHhmZmZmZjAwMCkK
ICAgICsgZnVuYyAgICAgICAgICAgICAgICAgIDU2ICAgIDIuMTIyICBfcnRfdG1iZW5jaF9pb2N0
bF9ydCsweDE0IChfX3J0ZG1faW9jdGwrMHg0YSkKICAgICsgZnVuYyAgICAgICAgICAgICAgICAg
IDU4ICAgIDIuMDUwICBfcnRkbV9ldmVudF93YWl0KzB4OCAoX3J0X3RtYmVuY2hfaW9jdGxfcnQr
MHg1OCkKICAgICsgZnVuYyAgICAgICAgICAgICAgICAgIDYwICAgIDEuMDgwICBfcnRkbV9ldmVu
dF90aW1lZHdhaXQrMHhhIChfcnRkbV9ldmVudF93YWl0KzB4MTQpCiB8ICArIGJlZ2luICAgMHg4
MDAwMDAwMSAgICA2MiAgICAyLjI4OCAgX3J0ZG1fZXZlbnRfdGltZWR3YWl0KzB4MjIgKF9fc3Rh
cnQrMHhmZmZmZjAwMCkKIHwgICMgZnVuYyAgICAgICAgICAgICAgICAgIDY0ICAgIDMuNjkyICBf
eG5zeW5jaF9zbGVlcF9vbisweDE0IChfcnRkbV9ldmVudF90aW1lZHdhaXQrMHhhOCkKIHwgICMg
ZnVuYyAgICAgICAgICAgICAgICAgIDY4ICAgIDMuNDcwICBfeG5wb2Rfc3VzcGVuZF90aHJlYWQr
MHhhIChfeG5zeW5jaF9zbGVlcF9vbisweDI4MikKIHwgICMgZnVuYyAgICAgICAgICAgICAgICAg
IDcxICAgIDEuODkwICBfeG5wb2Rfc2NoZWR1bGUrMHhhIChfeG5wb2Rfc3VzcGVuZF90aHJlYWQr
MHgxNzQpCiB8ICAjIFsgICA1MV0gLTw/Pi0gICAgMCAgICA3MyAgICAzLjI3OCAgX3hucG9kX3Nj
aGVkdWxlKzB4MTA0IChfX3N0YXJ0KzB4ZmZmZmYwMDApCiB8ICAjIFsgICAgOF0gZ2F0ZWtlZSAt
MSAgICA3NiAgICAzLjM5MiAgX3hucG9kX3NjaGVkdWxlKzB4NDRlIChfX3N0YXJ0KzB4ZmZmZmYw
MDApCiB8ICAgK2VuZCAgICAgMHg4MDAwMDAwMCAgICA4MCAgICAxLjMyMCAgX19faXBpcGVfcmVz
dG9yZV9waXBlbGluZV9oZWFkKzB4OTQgKF9fc3RhcnQrMHhmZmZmZjAwMCkKIHwgICArYmVnaW4g
ICAweDgwMDAwMDAxICAgIDgxICAgIDEuMTUwICBfZ2F0ZWtlZXBlcl90aHJlYWQrMHhhYyAoX19z
dGFydCsweGZmZmZmMDAwKQogfCAgICtlbmQgICAgIDB4ODAwMDAwMDEgICAgODIgICAgMS4yOTgg
IF9nYXRla2VlcGVyX3RocmVhZCsweGMwIChfX3N0YXJ0KzB4ZmZmZmYwMDApCiAgICAgK2Z1bmMg
ICAgICAgICAgICAgICAgICA4MyAgICAwLjkwMiAgX19faXBpcGVfdGVzdF9hbmRfc3RhbGxfcm9v
dCsweGUgKF9nYXRla2VlcGVyX3RocmVhZCsweGQwKQogfCAgICtiZWdpbiAgIDB4ODAwMDAwMDEg
ICAgODQgICAgMC45NDAgIF9fX2lwaXBlX3Rlc3RfYW5kX3N0YWxsX3Jvb3QrMHgyMiAoX19zdGFy
dCsweGZmZmZmMDAwKQogfCAgICNlbmQgICAgIDB4ODAwMDAwMDEgICAgODUgICAgMS41MTAgIF9f
X2lwaXBlX3Rlc3RfYW5kX3N0YWxsX3Jvb3QrMHgzNiAoX19zdGFydCsweGZmZmZmMDAwKQogICAg
ICNmdW5jICAgICAgICAgICAgICAgICAgODcgICAgMS4xNTggIF9fX2lwaXBlX3Jlc3RvcmVfcm9v
dCsweGEgKF9nYXRla2VlcGVyX3RocmVhZCsweDE1NCkKICAgICAjZnVuYyAgICAgICAgICAgICAg
ICAgIDg4ICAgIDAuOTIyICBfX19pcGlwZV91bnN0YWxsX3Jvb3QrMHg4IChfX19pcGlwZV9yZXN0
b3JlX3Jvb3QrMHgxYSkKICAgICAjYmVnaW4gICAweDgwMDAwMDAwICAgIDg5ICAgIDAuOTUwICBf
X19pcGlwZV91bnN0YWxsX3Jvb3QrMHgxYSAoX19zdGFydCsweGZmZmZmMDAwKQogfCAgICtlbmQg
ICAgIDB4ODAwMDAwMDAgICAgOTAgICAgMS42MDAgIF9fX2lwaXBlX3Vuc3RhbGxfcm9vdCsweDU4
IChfX3N0YXJ0KzB4ZmZmZmYwMDApCiAgICAgK2Z1bmMgICAgICAgICAgICAgICAgICA5MSAgICAx
LjU1OCAgX19fc2NoZWRfdGV4dF9zdGFydCsweGUgKF9nYXRla2VlcGVyX3RocmVhZCsweGU4KQog
ICAgICtmdW5jICAgICAgICAgICAgICAgICAgOTMgICAgMS40NTIgIF9wcm9maWxlX2hpdCsweGUg
KF9fX3NjaGVkX3RleHRfc3RhcnQrMHg0YykKICAgICArZnVuYyAgICAgICAgICAgICAgICAgIDk0
ICAgIDEuNDAwICBfc2NoZWRfY2xvY2srMHhjIChfX19zY2hlZF90ZXh0X3N0YXJ0KzB4N2MpCiAg
ICAgK2Z1bmMgICAgICAgICAgICAgICAgICA5NiAgICAyLjI4MCAgX19fbXVsZGkzKzB4YyAoX3Nj
aGVkX2Nsb2NrKzB4MjYpCiAgICAgK2Z1bmMgICAgICAgICAgICAgICAgICA5OCAgICAwLjcwOCAg
X19faXBpcGVfc3RhbGxfcm9vdCsweGUgKF9fX3NjaGVkX3RleHRfc3RhcnQrMHhlYykKIHwgICAr
YmVnaW4gICAweDgwMDAwMDAxICAgIDk5ICAgIDAuMDAwICBfX19pcGlwZV9zdGFsbF9yb290KzB4
MjIgKF9fc3RhcnQrMHhmZmZmZjAwMCkK
------=_Part_70650_5530952.1163166864733--

