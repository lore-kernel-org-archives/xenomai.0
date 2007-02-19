From: Jeff Weber <jweber@domain.hid>
Subject: Re: [Xenomai-help] tracer from user space
Date: Mon, 19 Feb 2007 16:54:32 -0600
References: <45D6C540.9020707@domain.hid>
In-Reply-To: <45D6C540.9020707@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Message-Id: <200702191654.32541.jweber@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: Xenomai Help <xenomai@xenomai.org>

Ok,  here's the trace I captured from user space code when rt_task_wait_nex=
t_period() overran by 10s of milliseconds, which
should "never happen" , and is the latency I'm hunting down.

 |||+-- Xenomai
 ||||+- Linux ('*': domain stalled, '+': current, '#': current+stalled)
 |||||                        +---------- Delay flag ('+': > 1 us, '!': > 1=
0 us)
 |||||                        |        +- NMI noise ('N')
 |||||                        |        |
      Type    User Val.   Time    Delay  Function (Parent)
:|  # func                 -61    0.573  xnpod_schedule+0xe [xeno_nucleus] =
(xnpod_suspend_thread+0x118 [xeno_nucleus])
:|  # [   -1] -<?>-   90   -60    0.833  xnpod_schedule+0x97 [xeno_nucleus]=
 (xnpod_suspend_thread+0x118 [xeno_nucleus])
:|  # func                 -59+   1.624  __switch_to+0xe (xnpod_schedule+0x=
646 [xeno_nucleus])
:|  # [12906] -<?>-   35   -58+   1.110  xnpod_schedule+0x6c0 [xeno_nucleus=
] (xnintr_irq_handler+0x9a [xeno_nucleus])
:|  + func                 -56    0.565  __ipipe_walk_pipeline+0xe (__ipipe=
_handle_irq+0x88)
:|  + end     0xffffff05   -56!  38.026  common_interrupt+0x34 (<080fb1a7>)
:   + func                 -18    0.543  __ipipe_syscall_root+0x11 (sysente=
r_past_esp+0x3b)
:   + func                 -17    0.456  __ipipe_dispatch_event+0xe (__ipip=
e_syscall_root+0x59)
:|  + begin   0x80000001   -17    0.706  __ipipe_dispatch_event+0x1e1 (__ip=
ipe_syscall_root+0x59)
:|  + end     0x80000001   -16    0.539  __ipipe_dispatch_event+0x1cf (__ip=
ipe_syscall_root+0x59)
:   + func                 -16+   1.446  hisyscall_event+0xe [xeno_nucleus]=
 (__ipipe_dispatch_event+0xd3)
:   + func                 -14    0.454  __rt_task_set_mode+0x11 [xeno_nati=
ve] (hisyscall_event+0x162 [xeno_nucleus])
:   + func                 -14    0.535  rt_task_set_mode+0xe [xeno_native]=
 (__rt_task_set_mode+0x5b [xeno_native])
:   + func                 -13    0.458  xnpod_set_thread_mode+0xe [xeno_nu=
cleus] (rt_task_set_mode+0x9b [xeno_native])
:|  + begin   0x80000001   -13    0.936  xnpod_set_thread_mode+0x18d [xeno_=
nucleus] (rt_task_set_mode+0x9b [xeno_native])
:|  # func                 -12    0.556  __ipipe_restore_pipeline_head+0x11=
 (xnpod_set_thread_mode+0xca [xeno_nucleus])
:|  + end     0x80000000   -11    0.800  __ipipe_restore_pipeline_head+0x53=
 (xnpod_set_thread_mode+0xca [xeno_nucleus])
:|  + begin   0x80000001   -10    0.628  __ipipe_dispatch_event+0x1be (__ip=
ipe_syscall_root+0x59)
:|  + end     0x80000001   -10+   3.944  __ipipe_dispatch_event+0x18f (__ip=
ipe_syscall_root+0x59)
:   + func                  -6    0.443  __ipipe_syscall_root+0x11 (sysente=
r_past_esp+0x3b)
:   + func                  -5    0.434  __ipipe_dispatch_event+0xe (__ipip=
e_syscall_root+0x59)
:|  + begin   0x80000001    -5    0.722  __ipipe_dispatch_event+0x1e1 (__ip=
ipe_syscall_root+0x59)
:|  + end     0x80000001    -4    0.553  __ipipe_dispatch_event+0x1cf (__ip=
ipe_syscall_root+0x59)
:   + func                  -4    0.609  hisyscall_event+0xe [xeno_nucleus]=
 (__ipipe_dispatch_event+0xd3)
:   + func                  -3    0.887  xnshadow_sys_trace+0x14 [xeno_nucl=
eus] (hisyscall_event+0x162 [xeno_nucleus])
:   + func                  -2    0.597  ipipe_trace_frozen_reset+0xe (xnsh=
adow_sys_trace+0x94 [xeno_nucleus])
:   + func                  -2    0.467  __ipipe_global_path_lock+0xe (ipip=
e_trace_frozen_reset+0x13)
:|  + begin   0x80000001    -1+   1.084  __ipipe_global_path_lock+0x4d (ipi=
pe_trace_frozen_reset+0x13)
:|  + end     0x80000001     0    0.581  __ipipe_global_path_unlock+0x5c (i=
pipe_trace_frozen_reset+0x3b)
<   + freeze  0x0000001f     0    0.617  xnshadow_sys_trace+0x8b [xeno_nucl=
eus] (hisyscall_event+0x162 [xeno_nucleus])
 |  + begin   0x80000001     0    0.559  __ipipe_dispatch_event+0x1be (__ip=
ipe_syscall_root+0x59)
 |  + end     0x80000001     1    1.956  __ipipe_dispatch_event+0x18f (__ip=
ipe_syscall_root+0x59)

I'm new to interpreting the trace output, and haven't yet been able to unde=
rstand the line by line output.  However, I'm curious
about the timing "lump" at time -56  (common_interrupt+0x34 ).. What is goi=
ng on there?

	thanks,
	Jeff

On Saturday 17 February 2007 03:05, Jan Kiszka wrote:
> Jeff Weber wrote:
> > I need to isolate an unacceptable latency resuming a primary mode
>
> task, by
>
> > determining the events the events that preceeded the delay, preferably
>
> from
>
> > userspace. =A0I cannot rule out a userspace coding error contributing to
>
> the
>
> > latency.
> >
> > Is this a job better suited to task switch hooks, or the ipipe tracer,
>
> or
>
> > perhaps yet another tool?
>
> Hard to say, but often the tracer is a good starting point, at least to
> rule out certain causes.

=2D-=20
Jeff Weber
American Superconductor Corp.

