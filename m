MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17467.54032.226274.987236@domain.hid>
Date: Tue, 11 Apr 2006 18:02:24 +0200
Subject: Re: [Xenomai-core] latency -t 1 crashes on SMP.
In-Reply-To: <4439791B.7060003@domain.hid>
References: <17465.8101.106079.634470@domain.hid>
	<4439791B.7060003@domain.hid>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

Philippe Gerum wrote:
 > Gilles Chanteperdrix wrote:
 > > I tried latency -t 1 on an SMP machines, and observed a very
 > > reproducible crash. Most of the time, the machine locks up
 > > completely. The rest of the time, I get :
 > > 
 > > Xenomai: suspending kernel thread e7559044 ('timerbench') at 0xb01051f2 after ex
 > > ception #14
 > > 
 > > And the system remains runnable, but 0xb01051f2 is not a valid kernel
 > > module text address.
 > 
 > Looks like a kernel-based task stack address on x86.

Actually, this address really is a kernel text address, because I use
the CONFIG_VMSPLIT_3G_OPT, which seems a way to configure a machine with
1GB RAM. The crash also happens with CONFIG_VMSPLIT_3G, but the text
address is 0xc01051f2.

I tried adding a call to show_stack() in xnpod_fault_handler, and it
shows that the crash happens right after the call to rthal_nmi_arm in
xnarch_program_timer_shot:
Xenomai: suspending kernel thread eeed5044 ('timerbench') at 0xc01051f2 after ex
ception #14
ee8c1768 c02d24c1 ee8c1798 f8ff868c 00000000 00000000 eeed53b0 c01051f2
       0000000e bfa49f69 58454e4f 0000000e ee8c17a4 f900aca1 ee8c17b0 ee8c17c0
       f8ff57b3 ee8c17b0 0000000e ffffffff ee8c183c 00000082 ee8c17dc c0259df0
Call Trace:
 [<c0103f6a>] show_stack_log_lvl+0xaa/0xe0
 [<c0103fc1>] show_stack+0x21/0x30
 [<f8ff868c>] xnpod_fault_handler+0x8c/0x220 [xeno_nucleus]
 [<f900aca1>] xnpod_trap_fault+0x61/0x70 [xeno_nucleus]
 [<f8ff57b3>] xnarch_trap_fault+0x23/0x30 [xeno_nucleus]
 [<c0259df0>] exception_event+0x70/0x80
 [<c0142103>] __ipipe_dispatch_event+0x103/0x130
 [<c01140ea>] __ipipe_handle_exception+0x2a/0xf0
 [<c0103b7c>] error_code+0x54/0x64
 [<c0103c42>] nmi_stack_correct+0x1d/0x22
 [<f9015141>] xntimer_do_start_aperiodic+0x441/0x560 [xeno_nucleus]
 [<f901a380>] xntimer_start+0x130/0x350 [xeno_nucleus]
 [<f8ffe4ed>] xnpod_suspend_thread+0x7ad/0xd40 [xeno_nucleus]
 [<f8f82749>] rtdm_task_sleep_until+0x179/0x3d0 [xeno_rtdm]
 [<f8e83456>] timer_task_proc+0x1c6/0x450 [xeno_timerbench]
 [<f8ff7f5d>] xnarch_thread_redirect+0x5d/0x80 [xeno_nucleus]
 [<00000000>] _stext+0x3feffd68/0x8

And now the most interesting: when compiling Xenomai in the kernel,
(which moves Xenomai code out of vmalloc'ed memory) the bug disappears.

-- 


					    Gilles Chanteperdrix.

