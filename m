Message-ID: <4B59E28B.1090101@domain.hid>
Date: Fri, 22 Jan 2010 18:38:19 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4B59D952.30202@domain.hid>
In-Reply-To: <4B59D952.30202@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] Domain switch during page fault handling
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>, Wolfgang Mauerer <wolfgang.mauerer@domain.hid>

Jan Kiszka wrote:
> Hi guys,
> 
> we are currently trying to catch an ugly Linux pipeline state corruption
> on x86-64.
> 
> Conceptual question: If a Xenomai task causes a fault, we enter
> ipipe_trap_notify over the primary domain and leave it over the root
> domain, right? Now, if the root domain happened to be stalled when the
> exception happened, where should it normally be unstalled again,
> *for_that_task*? Our problem is that we generate a code path where this
> does not happen.

I have spent a few hours on a similar problem on x86_32. The difference 
on x86_32 is that the stall bit is used as user-space interrupt flag, so
the effect is visible on latencies. I have to say that understanding 
__ipipe_handle_exception requires more time than I have currently spent,
but I intend to elucidate this sooner or later. Here are the kind of 
traces I get:

:|  #*event   tick@domain.hid   -188+   3.035  xntimer_next_local_shot+0x85 (xntimer_t
(...)
:    +func                -170+   1.797  up_read+0x3 (do_page_fault+0x136)
:    #func                -168    0.279  __ipipe_unstall_iret_root+0x4 (restore_ret+0x0)
:|   #begin   0x80000000  -168    0.326  __ipipe_unstall_iret_root+0x7b (restore_ret+0x0)
:|   #end     0x8000000d  -167+   1.572  __ipipe_unstall_iret_root+0x64 (restore_ret+0x0)
:|   #func                -166    0.239  __ipipe_syscall_root+0xf (system_call+0x2d)
:|   #func                -166    0.323  __ipipe_dispatch_event+0x9 (__ipipe_syscall_root+0x40)
:|  +*func                -165    0.859  hisyscall_event+0xf (__ipipe_dispatch_event+0xd3)
:|   #func                -164+   1.388  losyscall_event+0x9 (__ipipe_dispatch_event+0xd3)
:|   #func                -163    0.870  sys_time+0x11 (syscall_call+0x7)
:|   #func                -162    0.278  get_seconds+0x3 (sys_time+0x1e)
:    #func                -162    0.271  __ipipe_unstall_iret_root+0x4 (restore_ret+0x0)
:|   #begin   0x80000000  -162    0.575  __ipipe_unstall_iret_root+0x7b (restore_ret+0x0)
:|   #end     0x8000000d  -161!  64.984  __ipipe_unstall_iret_root+0x64 (restore_ret+0x0)
:|   #func                 -96    0.275  __ipipe_syscall_root+0xf (system_call+0x2d)
:|   #func                 -96    0.304  __ipipe_dispatch_event+0x9 (__ipipe_syscall_root+0x40)
:|  +*func                 -95    0.482  hisyscall_event+0xf (__ipipe_dispatch_event+0xd3)
:|   #func                 -95    0.758  losyscall_event+0x9 (__ipipe_dispatch_event+0xd3)
:|   #func                 -94    0.971  sys_write+0x8 (syscall_call+0x7)


:|  #*event   tick@domain.hid   -228    0.546  xntimer_next_local_shot+0x89 (xntimer_t
(...)
:    +func                -181    0.647  up_read+0x3 (do_page_fault+0x126)
:    #func                -181+   1.282  __ipipe_unstall_iret_root+0x3 (restore_ret+0x0)
:|   #func                -179    0.356  __ipipe_syscall_root+0x11 (system_call+0x2d)
:|   #func                -179    0.317  __ipipe_dispatch_event+0x9 (__ipipe_syscall_root+0x42)
:|  +*func                -179    0.712  hisyscall_event+0xf (__ipipe_dispatch_event+0xb7)
:|   #func                -178+   1.415  losyscall_event+0x9 (__ipipe_dispatch_event+0xb7)
:|   #func                -177    0.763  sys_time+0x11 (syscall_call+0x7)
:|   #func                -176    0.350  get_seconds+0x3 (sys_time+0x1e)
:    #func                -176!  71.098  __ipipe_unstall_iret_root+0x3 (restore_ret+0x0)
:|   #func                -104    0.309  __ipipe_syscall_root+0x11 (system_call+0x2d)
:|   #func                -104    0.839  __ipipe_dispatch_event+0x9 (__ipipe_syscall_root+0x42)
:|  +*func                -103    0.400  hisyscall_event+0xf (__ipipe_dispatch_event+0xb7)
:|   #func                -103+   1.362  losyscall_event+0x9 (__ipipe_dispatch_event+0xb7)
:|   #func                -102    0.520  sys_write+0x8 (syscall_call+0x7)


-- 
					    Gilles.

