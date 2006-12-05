From: Sebastian Smolorz <ssm@domain.hid>
Subject: Re: [Adeos-main] [PATCH] I-pipe tracer for ARM
Date: Tue, 5 Dec 2006 15:09:25 +0100
References: <E1GrHXk-00023w-Oq@domain.hid>
	<E1GrWZ5-000089-Ou@domain.hid> <45753DAB.20207@domain.hid>
In-Reply-To: <45753DAB.20207@domain.hid>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_V2XdF7SVJK14yej"
Message-Id: <E1Graz2-0003MR-Gl@domain.hid>
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: adeos-main@gna.org

--Boundary-00=_V2XdF7SVJK14yej
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Jan Kiszka wrote:
> Sebastian Smolorz wrote:
> >>> <    +freeze  0xffffffff     0   97.444N __ipipe_frozen_ctrl+0x108
> >>> (vfs_write+0xc4)
> >>
> >> Hmm, takes quite a long time to complete the freeze though you only have
> >> 10 post-trace points (which defines its complexity). Unusual, also when
> >> comparing with other traced functions.
> >
> > It seems that it doesn't depend on post-trace-points. When I reduce them
> > to 2 the value for the freeze does not get smaller. Maybe it has
> > something to do with the following lines?
>
> Are you tracing into vmalloc'ed memory?

Yes, without CONFIG_IPIPE_TRACE_VMALLOC the system does not boot.

> And what results do you get with 
> latency -f?

These seem to be better (see attachment).

--
Sebastian

--Boundary-00=_V2XdF7SVJK14yej
Content-Type: text/plain; charset="iso-8859-15"; name="ipipe-trace-freeze"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="ipipe-trace-freeze"

I-pipe frozen back-tracing service on 2.6.15/ipipe-1.5-03
------------------------------------------------------------
Freeze: 8965886448 cycles, Trace Points: 30 (+10)

 +----- Hard IRQs ('|': locked)
 |+---- <unused>
 ||+--- <unused>
 |||+-- Xenomai
 ||||+- Linux ('*': domain stalled, '+': current, '#': current+stalled)
 |||||                        +---------- Delay flag ('+': > 1 us, '!': > 10 us)
 |||||                        |        +- NMI noise ('N')
 |||||                        |        |
      Type    User Val.   Time    Delay  Function (Parent)
:|  +*begin   0x80000001   -80+   3.222  __ipipe_dispatch_event+0x44 (__ipipe_syscall_root+0x88)
:|  +*end     0x80000001   -77+   1.666N __ipipe_dispatch_event+0xc4 (__ipipe_syscall_root+0x88)
:   +*func                 -75+   5.444N hisyscall_event+0x14 [xeno_nucleus] (__ipipe_dispatch_event+0xe0)
:   +*func                 -70+   2.000N __rt_timer_tsc+0x14 [xeno_native] (hisyscall_event+0x160 [xeno_nucleus])
:   +*func                 -68+   1.555N rt_timer_tsc+0x10 [xeno_native] (__rt_timer_tsc+0x1c [xeno_native])
:   +*func                 -66+   1.666N __ipipe_mach_get_tsc+0x10 (rt_timer_tsc+0x14 [xeno_native])
:|  +*begin   0x80000001   -65+   1.777  __ipipe_mach_get_tsc+0x30 (rt_timer_tsc+0x14 [xeno_native])
:|  +*end     0x80000001   -63+   2.666N __ipipe_mach_get_tsc+0x6c (rt_timer_tsc+0x14 [xeno_native])
:|  +*begin   0x80000001   -60+   1.888  __ipipe_dispatch_event+0x10c (__ipipe_syscall_root+0x88)
:|  +*end     0x80000001   -58+   6.333N __ipipe_dispatch_event+0x1b0 (__ipipe_syscall_root+0x88)
:   +*func                 -52+   1.333N __ipipe_syscall_root+0x10 (vector_swi+0x64)
:   +*func                 -51+   1.777N __ipipe_dispatch_event+0x14 (__ipipe_syscall_root+0x88)
:|  +*begin   0x80000001   -49+   2.222  __ipipe_dispatch_event+0x44 (__ipipe_syscall_root+0x88)
:|  +*end     0x80000001   -47+   1.666N __ipipe_dispatch_event+0xc4 (__ipipe_syscall_root+0x88)
:   +*func                 -45+   2.444N hisyscall_event+0x14 [xeno_nucleus] (__ipipe_dispatch_event+0xe0)
:   +*func                 -43+   4.666N __rt_timer_tsc2ns+0x14 [xeno_native] (hisyscall_event+0x160 [xeno_nucleus])
:   +*func                 -38+   5.888N rt_timer_tsc2ns+0x14 [xeno_native] (__rt_timer_tsc2ns+0x38 [xeno_native])
:|  +*begin   0x80000001   -32+   2.444  __ipipe_dispatch_event+0x10c (__ipipe_syscall_root+0x88)
:|  +*end     0x80000001   -30+   3.000N __ipipe_dispatch_event+0x1b0 (__ipipe_syscall_root+0x88)
:   +*func                 -27+   1.777N __ipipe_syscall_root+0x10 (vector_swi+0x64)
:   +*func                 -25+   1.777N __ipipe_dispatch_event+0x14 (__ipipe_syscall_root+0x88)
:|  +*begin   0x80000001   -23+   2.333  __ipipe_dispatch_event+0x44 (__ipipe_syscall_root+0x88)
:|  +*end     0x80000001   -21+   1.444N __ipipe_dispatch_event+0xc4 (__ipipe_syscall_root+0x88)
:   +*func                 -19+   2.555N hisyscall_event+0x14 [xeno_nucleus] (__ipipe_dispatch_event+0xe0)
:   +*func                 -17+   3.777N xnshadow_sys_trace+0x10 [xeno_nucleus] (hisyscall_event+0x160 [xeno_nucleus])
:   +*func                 -13+   2.000N ipipe_trace_frozen_reset+0x10 (xnshadow_sys_trace+0x98 [xeno_nucleus])
:   +*func                 -11+   1.666N __ipipe_global_path_lock+0x10 (ipipe_trace_frozen_reset+0x14)
:|  +*begin   0x80000001    -9+   6.444  __ipipe_global_path_lock+0x30 (ipipe_trace_frozen_reset+0x14)
:|  +*end     0x80000001    -3+   3.333N __ipipe_global_path_unlock+0x68 (ipipe_trace_frozen_reset+0x68)
<   +*freeze  0x00032178     0    2.444N xnshadow_sys_trace+0xa4 [xeno_nucleus] (hisyscall_event+0x160 [xeno_nucleus])
 |  +*begin   0x80000001     2    1.444N __ipipe_dispatch_event+0x10c (__ipipe_syscall_root+0x88)
 |  +*end     0x80000001     3    3.888N __ipipe_dispatch_event+0x1b0 (__ipipe_syscall_root+0x88)
    +*func                   7    1.666N __ipipe_syscall_root+0x10 (vector_swi+0x64)
    +*func                   9    2.000N __ipipe_dispatch_event+0x14 (__ipipe_syscall_root+0x88)
 |  +*begin   0x80000001    11    1.888N __ipipe_dispatch_event+0x44 (__ipipe_syscall_root+0x88)
 |  +*end     0x80000001    13    1.666N __ipipe_dispatch_event+0xc4 (__ipipe_syscall_root+0x88)
    +*func                  15    2.333N hisyscall_event+0x14 [xeno_nucleus] (__ipipe_dispatch_event+0xe0)
    +*func                  17    2.333N __rt_task_wait_period+0x14 [xeno_native] (hisyscall_event+0x160 [xeno_nucleus])
    +*func                  19    2.888N rt_task_wait_period+0x10 [xeno_native] (__rt_task_wait_period+0x54 [xeno_native])
 |  +*func                  22    0.000N __ipipe_grab_irq+0x10 (__irq_svc+0x24)

--Boundary-00=_V2XdF7SVJK14yej--

