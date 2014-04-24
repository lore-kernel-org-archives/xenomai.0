MIME-Version: 1.0
In-Reply-To: <CAPRPZsB8a=gN=U14qn_tpfksg3T8yW+M8pZGhOkT-jPDuU8L0w@mail.gmail.com>
References: <CAPRPZsBD_5ufxFAhPCFqRf9YZSm1FhqfcmL+MTbhJ=1Sb7ED_g@mail.gmail.com>
 <CAPRPZsBsOmiaWPJmPR9RK0uv_BXbw_s43rarKOvVoGfN2gWZjQ@mail.gmail.com>
 <CAPRPZsCnAJH_-070SbSMB+Q_dQwf+FYfKpmp1wzwtz=zMA2bcA@mail.gmail.com>
 <5357C92F.2060206@xenomai.org>
 <CAPRPZsAvxx9XVB5MYi65m1FPaz2p7Rgh7+M4U357exJBbo0kHQ@mail.gmail.com>
 <535828F6.6050308@xenomai.org>
 <CAPRPZsA4ZQEm1a+2TV6s2wvD2_M53RrL4zLz0sJgLKEF8ALo1w@mail.gmail.com>
 <53583DF7.3080700@xenomai.org>
 <CAPRPZsB8a=gN=U14qn_tpfksg3T8yW+M8pZGhOkT-jPDuU8L0w@mail.gmail.com>
Date: Thu, 24 Apr 2014 16:46:59 +0200
Message-ID: <CAPRPZsAyTQN936=phnT+NzvT7w_UxnY1ppQDucCjh39neOYn6g@mail.gmail.com>
From: Jeroen Van den Keybus <jeroen.vandenkeybus@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] Reading /proc/xenomai/stat causes high latencies
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

I've been hammering on this stat entry with various tracing options to
try and catch a trace.

I did eventually catch one, but the function tracing was off at the time:

:|  # [ 2738] samplin 99  -140    0.050  xnpod_resume_thread+0xe8
[xeno_nucleus] (xnthread_periodic_handler+0x35 [xeno_nucleus])
:|  # event   tick@-40    -140    0.181  xntimer_next_local_shot+0x63
[xeno_nucleus] (xntimer_tick_aperiodic+0x1b0 [xeno_nucleus])
:|  # [    0] -<?>-   -1  -140    0.275  __xnpod_schedule+0x11d
[xeno_nucleus] (xnintr_clock_handler+0x315 [xeno_nucleus])
:|  # [ 2738] samplin 99  -140    0.456  __xnpod_schedule+0x4e1
[xeno_nucleus] (xnpod_suspend_thread+0x44a [xeno_nucleus])
:|  # [ 2738] samplin 99  -139    0.307  __xnpod_schedule+0x11d
[xeno_nucleus] (xnpod_suspend_thread+0x44a [xeno_nucleus])
:|  # [    0] -<?>-   -1  -139! 105.640  __xnpod_schedule+0x4e1
[xeno_nucleus] (xnintr_clock_handler+0x315 [xeno_nucleus])
:|  # [ 2738] samplin 99   -33    0.081  xnpod_resume_thread+0xe8
[xeno_nucleus] (xnthread_periodic_handler+0x35 [xeno_nucleus])
:|  # event   tick@59      -33!  32.250  xntimer_next_local_shot+0x63
[xeno_nucleus] (xntimer_tick_aperiodic+0x1b0 [xeno_nucleus])
:|  # [    0] -<?>-   -1    -1    0.349  __xnpod_schedule+0x11d
[xeno_nucleus] (xnintr_clock_handler+0x315 [xeno_nucleus])
:|  # [ 2738] samplin 99     0    0.974  __xnpod_schedule+0x4e1
[xeno_nucleus] (xnpod_suspend_thread+0x44a [xeno_nucleus])
<   + freeze  0x00009088     0   45.490  xnshadow_sys_trace+0xed
[xeno_nucleus] (hisyscall_event+0x1a8 [xeno_nucleus])
 |  # [ 2738] samplin 99    45    0.350  __xnpod_schedule+0x11d
[xeno_nucleus] (xnpod_suspend_thread+0x44a [xeno_nucleus])
 |  # [    0] -<?>-   -1    45   52.196  __xnpod_schedule+0x4e1
[xeno_nucleus] (xnintr_clock_handler+0x315 [xeno_nucleus])
 |  # [ 2738] samplin 99    98    0.078  xnpod_resume_thread+0xe8
[xeno_nucleus] (xnthread_periodic_handler+0x35 [xeno_nucleus])
 |  # event   tick@159      98    1.790  xntimer_next_local_shot+0x63
[xeno_nucleus] (xntimer_tick_aperiodic+0x1b0 [xeno_nucleus])
 |  # [    0] -<?>-   -1    99    0.283  __xnpod_schedule+0x11d
[xeno_nucleus] (xnintr_clock_handler+0x315 [xeno_nucleus])
 |  # [ 2738] samplin 99   100    0.676  __xnpod_schedule+0x4e1
[xeno_nucleus] (xnpod_suspend_thread+0x44a [xeno_nucleus])
    + freeze  0x00009515   100    0.321  xnshadow_sys_trace+0xed
[xeno_nucleus] (hisyscall_event+0x1a8 [xeno_nucleus])
 |  # [ 2738] samplin 99   101    0.323  __xnpod_schedule+0x11d
[xeno_nucleus] (xnpod_suspend_thread+0x44a [xeno_nucleus])
 |  # [    0] -<?>-   -1   101  166.050  __xnpod_schedule+0x4e1
[xeno_nucleus] (xnintr_clock_handler+0x315 [xeno_nucleus])
 |  # [ 2738] samplin 99   267    0.137  xnpod_resume_thread+0xe8
[xeno_nucleus] (xnthread_periodic_handler+0x35 [xeno_nucleus])
 |  # event   tick@359     267   84.425  xntimer_next_local_shot+0x63
[xeno_nucleus] (xntimer_tick_aperiodic+0x1b0 [xeno_nucleus])
 |  # [    0] -<?>-   -1   352    0.335  __xnpod_schedule+0x11d
[xeno_nucleus] (xnintr_clock_handler+0x315 [xeno_nucleus])
 |  # [ 2738] samplin 99   352    0.672  __xnpod_schedule+0x4e1
[xeno_nucleus] (xnpod_suspend_thread+0x44a [xeno_nucleus])
    + freeze  0x0002e7eb   353  130.030  xnshadow_sys_trace+0xed
[xeno_nucleus] (hisyscall_event+0x1a8 [xeno_nucleus])
 |  # event   tick@559     483    0.715  xntimer_next_local_shot+0x63
[xeno_nucleus] (xntimer_tick_aperiodic+0x1b0 [xeno_nucleus])
 |  # [ 2738] samplin 99   483    0.315  __xnpod_schedule+0x11d
[xeno_nucleus] (xnpod_suspend_thread+0x44a [xeno_nucleus])
 |  # [    0] -<?>-   -1   484   87.028  __xnpod_schedule+0x4e1
[xeno_nucleus] (xnintr_clock_handler+0x315 [xeno_nucleus])
 |  # [ 2738] samplin 99   571    0.050  xnpod_resume_thread+0xe8
[xeno_nucleus] (xnthread_periodic_handler+0x35 [xeno_nucleus])
 |  # event   tick@659     571    1.335  xntimer_next_local_shot+0x63
[xeno_nucleus] (xntimer_tick_aperiodic+0x1b0 [xeno_nucleus])
 |  # [    0] -<?>-   -1   572    0.283  __xnpod_schedule+0x11d
[xeno_nucleus] (xnintr_clock_handler+0x315 [xeno_nucleus])
 |  # [ 2738] samplin 99   572    3.602  __xnpod_schedule+0x4e1
[xeno_nucleus] (xnpod_suspend_thread+0x44a [xeno_nucleus])
 |  # [ 2738] samplin 99   576    0.307  __xnpod_schedule+0x11d
[xeno_nucleus] (xnpod_suspend_thread+0x44a [xeno_nucleus])
 |  # [    0] -<?>-   -1   576  556.825  __xnpod_schedule+0x4e1
[xeno_nucleus] (xnintr_clock_handler+0x315 [xeno_nucleus])
 |  # [ 2738] samplin 99  1133    0.196  xnpod_resume_thread+0xe8
[xeno_nucleus] (xnthread_periodic_handler+0x35 [xeno_nucleus])
 |  # event   tick@1159   1133    4.925  xntimer_next_local_shot+0x63
[xeno_nucleus] (xntimer_tick_aperiodic+0x1b0 [xeno_nucleus])


When I configured with 'Instrument function entries', it is possible
to trigger the bug when the trace is disabled. If I enable it, it
cannot be triggered anymore, but I also noticed that the function
tracing, which worked correctly before , no longer worked properly and
a warning is issued:

[  497.121124] ------------[ cut here ]------------
[  497.121131] WARNING: at kernel/trace/ftrace.c:386
register_ftrace_function+0x1e4/0x230()
[  497.121132] Modules linked in: xeno_native xeno_nucleus i915
drm_kms_helper drm coretemp ghash_clmulni_intel aesni_intel aes_x86_64
lrw gf128mul glue_helper ablk_helper cryptd ehci_pci ehci_hcd video
lpc_ich rtc_cmos backlight mfd_core e1000e xhci_hcd igb usbcore
firewire_ohci firewire_core i2c_algo_bit hwmon ptp crc_itu_t pps_core
usb_common
[  497.121152] CPU: 0 PID: 2259 Comm: bash Tainted: G        W
3.10.18-ipipe-test-14 #82
[  497.121153] Hardware name: Supermicro X10SAE/X10SAE, BIOS 1.1a 01/03/201=
4
[  497.121154]  0000000000000009 ffff88020e9afe28 ffffffff8148ed1e
ffff88020e9afe60
[  497.121156]  ffffffff8103c071 00000000fffffff0 0000000000000002
0000000001eb0008
[  497.121158]  0000000000000002 0000000000000000 ffff88020e9afe70
ffffffff8103c14a
[  497.121160] Call Trace:
[  497.121164]  [<ffffffff8148ed1e>] dump_stack+0x19/0x1b
[  497.121167]  [<ffffffff8103c071>] warn_slowpath_common+0x61/0x80
[  497.121169]  [<ffffffff8103c14a>] warn_slowpath_null+0x1a/0x20
[  497.121171]  [<ffffffff810c85b4>] register_ftrace_function+0x1e4/0x230
[  497.121173]  [<ffffffff810c2afc>] __ipipe_wr_enable+0x10c/0x120
[  497.121177]  [<ffffffff81231911>] ? security_file_permission+0x21/0xa0
[  497.121180]  [<ffffffff811ae56d>] proc_reg_write+0x3d/0x80
[  497.121182]  [<ffffffff8114d17d>] vfs_write+0xbd/0x1e0
[  497.121184]  [<ffffffff8114db49>] SyS_write+0x49/0xa0
[  497.121187]  [<ffffffff8149c866>] system_call_fastpath+0x16/0x1b
[  497.121188] ---[ end trace 4c5426aeef218be7 ]---


When it is still working, the traces rather read like:

:   + func                -130    0.058  __rt_task_wait_period+0x0
[xeno_native] (hisyscall_event+0x1a8 [xeno_nucleus])
:   + func                -130    0.070  rt_task_wait_period+0x0
[xeno_native] (__rt_task_wait_period+0x1a [xeno_native])
:   + func                -130    0.109  xnpod_wait_thread_period+0x0
[xeno_nucleus] (rt_task_wait_period+0x4f [xeno_native])
:|  # func                -130    0.115  xnpod_suspend_thread+0x0
[xeno_nucleus] (xnpod_wait_thread_period+0x115 [xeno_nucleus])
:|  # func                -130    0.068  __xnpod_schedule+0x0
[xeno_nucleus] (xnpod_suspend_thread+0x44a [xeno_nucleus])
:|  # [ 2271] samplin 99  -130    0.056  __xnpod_schedule+0x11d
[xeno_nucleus] (xnpod_suspend_thread+0x44a [xeno_nucleus])
:|  # func                -130    0.470  xnsched_pick_next+0x0
[xeno_nucleus] (__xnpod_schedule+0x272 [xeno_nucleus])
:|  # [30287] -<?>-   -1  -129    0.245  __xnpod_schedule+0x4e1
[xeno_nucleus] (xnintr_clock_handler+0x315 [xeno_nucleus])
:|   +func                -129+   1.082  __ipipe_do_sync_pipeline+0x0
(__ipipe_dispatch_irq+0x1c0)
:|   +func                -128    0.097  __ipipe_handle_exception+0x0
(device_not_available+0x1f)
:|   #func                -128    0.105  __ipipe_notify_trap+0x0
(__ipipe_handle_exception+0x75)
:|   #func                -128    0.062  do_device_not_available+0x0
(__ipipe_handle_exception+0xf7)
:|   #func                -128    0.087  user_exit+0x0
(do_device_not_available+0x17)
:|   #func                -128    0.056  ipipe_restore_root+0x0 (user_exit+=
0xb2)
:|   #func                -128    0.161  math_state_restore+0x0
(do_device_not_available+0x25)
:|   #func                -128!  93.612
__ipipe_restore_root_nosync+0x0 (__ipipe_handle_exception+0x106)
:|   +func                 -34    0.142  __ipipe_handle_irq+0x0
(apic_timer_interrupt+0x60)
:|   +func                 -34    0.081  __ipipe_dispatch_irq+0x0
(__ipipe_handle_irq+0x65)
:|   +func                 -34    0.090  __ipipe_ack_hrtimer_irq+0x0
(__ipipe_dispatch_irq+0x70)
:|   +func                 -34    0.131  lapic_itimer_ack+0x0
(__ipipe_ack_hrtimer_irq+0x3b)
:|  # func                 -33    0.164  xnintr_clock_handler+0x0
[xeno_nucleus] (__ipipe_dispatch_irq+0x171)
:|  # func                 -33    0.088  xntimer_tick_aperiodic+0x0
[xeno_nucleus] (xnintr_clock_handler+0x142 [xeno_nucleus])
:|  # func                 -33    0.077  xnthread_periodic_handler+0x0
[xeno_nucleus] (xntimer_tick_aperiodic+0xd5 [xeno_nucleus])
:|  # func                 -33    0.076  xnpod_resume_thread+0x0
[xeno_nucleus] (xnthread_periodic_handler+0x35 [xeno_nucleus])
:|  # [ 2271] samplin 99   -33    0.175  xnpod_resume_thread+0xe8
[xeno_nucleus] (xnthread_periodic_handler+0x35 [xeno_nucleus])
:|  # func                 -33    0.063  xntimer_next_local_shot+0x0
[xeno_nucleus] (xntimer_tick_aperiodic+0x1b0 [xeno_nucleus])
:|  # event   tick@65      -33    0.041  xntimer_next_local_shot+0x63
[xeno_nucleus] (xntimer_tick_aperiodic+0x1b0 [xeno_nucleus])
:|  # func                 -33    0.057  ipipe_timer_set+0x0
(xntimer_next_local_shot+0x6b [xeno_nucleus])
:|  # func                 -33    0.231  lapic_next_deadline+0x0
(ipipe_timer_set+0x5c)
:|  # func                 -32    0.103  __xnpod_schedule+0x0
[xeno_nucleus] (xnintr_clock_handler+0x315 [xeno_nucleus])
:|  # [30287] -<?>-   -1   -32    0.078  __xnpod_schedule+0x11d
[xeno_nucleus] (xnintr_clock_handler+0x315 [xeno_nucleus])
:|  # func                 -32!  27.879  xnsched_pick_next+0x0
[xeno_nucleus] (__xnpod_schedule+0x272 [xeno_nucleus])
:|  # func                  -4    0.580
__ipipe_notify_vm_preemption+0x0 (__xnpod_schedule+0x71d
[xeno_nucleus])
:|  # [ 2271] samplin 99    -4    0.301  __xnpod_schedule+0x4e1
[xeno_nucleus] (xnpod_suspend_thread+0x44a [xeno_nucleus])
:|  # func                  -4    0.114  xntimer_get_overruns+0x0
[xeno_nucleus] (xnpod_wait_thread_period+0x13c [xeno_nucleus])
:|  # func                  -3+   1.210  __ipipe_restore_head+0x0
(xnpod_wait_thread_period+0x182 [xeno_nucleus])
:   + func                  -2    0.084  __ipipe_syscall_root+0x0
(__ipipe_syscall_root_thunk+0x35)
:   + func                  -2    0.068  __ipipe_notify_syscall+0x0
(__ipipe_syscall_root+0x35)
:   + func                  -2    0.058  ipipe_syscall_hook+0x0
(__ipipe_notify_syscall+0xbf)


Jeroen.

2014-04-24 10:57 GMT+02:00 Jeroen Van den Keybus
<jeroen.vandenkeybus@gmail.com>:
>> Could you put a printk in the function vfile_stat_rewind to see if it
>> gets called (more than once) when the problem happens?
>
> I patched as follows:
>
> static int vfile_stat_rewind(struct xnvfile_snapshot_iterator *it)
> {
>     struct vfile_stat_priv *priv =3D xnvfile_iterator_priv(it);
>     int irqnr;
>     int ret, irq;
>
>     /*
>      * The activity numbers on each valid interrupt descriptor are
>      * grouped under a pseudo-thread.
>      */
>     priv->curr =3D getheadq(&nkpod->threadq);
>     irq =3D priv->irq;
>     priv->irq =3D 0;
>     irqnr =3D xnintr_query_init(&priv->intr_it) * XNARCH_NR_CPUS;
>
>     ret =3D irqnr + countq(&nkpod->threadq);
>
>     printk(KERN_DEBUG "%s: priv=3D%p, ->curr=3D%p, ->irq=3D(%d), irqnr=3D=
%d, ret=3D%d\n",
>            __FUNCTION__, priv, priv->curr, irq, irqnr, ret);
>
>     return ret;
> }
>
>
> The result (3 first accesses are without latency running, the 2 last
> ones with latency running - each time 120 =C2=B5s delay)
>
> [  173.098667] vfile_stat_rewind: priv=3Dffff880211863228,
> ->curr=3Dffffffffa06b1110, ->irq=3D(0), irqnr=3D256, ret=3D264
> [  181.547424] vfile_stat_rewind: priv=3Dffff880211863b28,
> ->curr=3Dffffffffa06b1110, ->irq=3D(0), irqnr=3D256, ret=3D264
> [  183.002400] vfile_stat_rewind: priv=3Dffff880211863228,
> ->curr=3Dffffffffa06b1110, ->irq=3D(0), irqnr=3D256, ret=3D264
> [  201.475071] vfile_stat_rewind: priv=3Dffff880211863228,
> ->curr=3Dffffffffa06b1110, ->irq=3D(0), irqnr=3D256, ret=3D266
> [  209.432070] vfile_stat_rewind: priv=3Dffff8802118631a8,
> ->curr=3Dffffffffa06b1110, ->irq=3D(0), irqnr=3D256, ret=3D266
>
>
> So vfile... is called exactly once upon issuing 'cat /proc/xenomai/stat'.
>
>
> Jeroen.

