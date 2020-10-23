Date: Fri, 23 Oct 2020 17:04:07 +0800
From: Fino Meng <fino.meng@linux.intel.com>
Subject: Re: build scripts for the WIP xenomai porting to kernel 5.4
Message-ID: <20201023090407.GA16088@linux.intel.com>
References: <20201016033638.GB5581@linux.intel.com>
 <0ba45dfa-4755-c627-e1fd-9f2c32ea8b8a@siemens.com>
 <9153481d-6df6-314f-c2c0-f413a34fb815@siemens.com>
 <20201021114329.GA4344@linux.intel.com>
 <88232cd0-0713-4e45-bad2-e22acdeb7632@siemens.com>
 <3a85c6c8-6792-40d1-5ef2-6ee634fc3c91@siemens.com>
 <20201022114938.GA8098@linux.intel.com>
 <39ccbc86-3f64-0941-241b-30e2431468cf@siemens.com>
 <20201022132522.GA9776@linux.intel.com>
 <ae889a3f-40c1-d22e-c97b-807fe2ab7b5f@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <ae889a3f-40c1-d22e-c97b-807fe2ab7b5f@siemens.com>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: xenomai@xenomai.org

On Thu, Oct 22, 2020 at 05:22:35PM +0200, Jan Kiszka wrote:
> On 22.10.20 15:25, Fino Meng wrote:
> > On Thu, Oct 22, 2020 at 02:15:23PM +0200, Jan Kiszka wrote:
> >> On 22.10.20 13:49, Fino Meng wrote:
> >>> On Thu, Oct 22, 2020 at 09:26:59AM +0200, Jan Kiszka wrote:
> >>>> On 22.10.20 08:27, Jan Kiszka via Xenomai wrote:
> >>>>> On 21.10.20 13:43, Fino Meng wrote:
> >>>>>> On Wed, Oct 21, 2020 at 08:36:04AM +0200, Jan Kiszka wrote:
> >>>>>>> On 18.10.20 23:41, Jan Kiszka via Xenomai wrote:
> >>>>>>>> On 16.10.20 05:36, Fino Meng wrote:
> >>>>>>>>> On Thu, Oct 15, 2020 at 04:20:11PM +0200, Jan Kiszka wrote:
> >>>>>>>>>> On 14.10.20 15:25, Fino Meng wrote:
> >>>>>>>>>>> hi team,
> >>>>>>>>>>>
> >>>>>>>>>>> I just updated the scripts to build the WIP version xenomai p=
orting to
> >>>>>>>>>>> kernel 5.4, just follow the steps:
> >>>>>>>>>>>
> >>>>>>>>>>> git clone https://github.com/finomeng/xenomai-mirror.git /tmp=
/xenomai-mirror.next-5.4
> >>>>>>>>>>> cd /tmp/xenomai-mirror.next-5.4
> >>>>>>>>>>> git checkout -t origin/wip/next-5.4-porting
> >>>>>>>>>>>
> >>>>>>>>>>> git clone https://github.com/intel/linux-stable-xenomai /tmp/=
kernel
> >>>>>>>>>>> cd /tmp/kernel
> >>>>>>>>>>> git checkout -t review/5.4.59/stable/ipipe-x86
> >>>>>>>>>>>
> >>>>>>>>>>> ./patching-xenomai2kernel.sh
> >>>>>>>>>>>
> >>>>>>>>>>> cp config_xenomai.kernel_debug .config
> >>>>>>>>>>> make olddefconfig
> >>>>>>>>>>> ./build-debpkg.sh
> >>>>>>>>>>>
> >>>>>>>>>>>
> >>>>>>>>>>> I didn't put it togethter with ISAR/Debian yet. I test it wit=
h a PC with Debian 10 installed.
> >>>>>>>>>>>
> >>>>>>>>>>> if no error, linux-image-*.deb and linux-headers-*.deb should=
 generated outside kernel folder,
> >>>>>>>>>>> copy them to your target test device with already installed a=
 Debian/Ubuntu,
> >>>>>>>>>>> install the deb with "dpkg -i", update-grub should be called =
during install linux-image-*.deb
> >>>>>>>>>>> reboot and select to boot the new kernel in grub's menu
> >>>>>>>>>>>
> >>>>>>>>>>> the build steps also written in patching-xenomai2kernel.sh an=
d build-debpkg.sh
> >>>>>>>>>>>
> >>>>>>>>>>> switchtest will fail in current version, for example: "./swit=
chtest rtk_fp_ufpp0"
> >>>>>>>>>>> will print:
> >>>>>>>>>>>
> >>>>>>>>>>> r0: 2147483648 !=3D 1000
> >>>>>>>>>>> r1: 2147483648 !=3D 1000
> >>>>>>>>>>> r2: 2147483648 !=3D 1000
> >>>>>>>>>>> r3: 2147483648 !=3D 1000
> >>>>>>>>>>> r4: 2147483648 !=3D 1000
> >>>>>>>>>>> r5: 2147483648 !=3D 1000
> >>>>>>>>>>> r6: 2147483648 !=3D 1000
> >>>>>>>>>>> r7: 2147483648 !=3D 1000
> >>>>>>>>>>> ymm0: 2676586395008836901/0 !=3D 1000/1000
> >>>>>>>>>>> ymm1: 71776119061217280/0 !=3D 1000/1000
> >>>>>>>>>>> ymm2: 0/0 !=3D 1000/1000
> >>>>>>>>>>> ymm3: 1000/0 !=3D 1000/1000
> >>>>>>>>>>> ymm4: 1000/0 !=3D 1000/1000
> >>>>>>>>>>> ymm5: 1000/0 !=3D 1000/1000
> >>>>>>>>>>> ymm6: 1000/0 !=3D 1000/1000
> >>>>>>>>>>> ymm7: 1000/0 !=3D 1000/1000
> >>>>>>>>>>> Error after context switch from task 1(rtk_fp_ufpp0-1) to tas=
k 0(sleeper_ufps0-0),
> >>>>>>>>>>> FPU registers were set to 0 (maybe task sleeper_ufps0-0)
> >>>>>>>>>>>
> >>>>>>>>>>> if meet more questions just write to me, thanks!
> >>>>>>>>>>>
> >>>>>>>>>>> BR fino
> >>>>>>>>>>>
> >>>>>>>>>>
> >>>>>>>>>> I can reproduce in KVM and poked around a bit, though without =
finding
> >>>>>>>>>> the needle yet. Likely, there are multiple aspects. The change=
 in
> >>>>>>>>>> upstream to FPU switching on user-return is a hot lead, but it=
 takes a
> >>>>>>>>>> bit to fully grasp that and map it on our scenarios with Xenom=
ai.
> >>>>>>>>>>
> >>>>>>>>>> Jan
> >>>>>>>>>
> >>>>>>>>> it seems that, switch_fpu_prepare() and switch_fpu_finish() are
> >>>>>>>>> for kernel thread context switch (in __switch_to() )and switch_=
fpu_return() is needed
> >>>>>>>>> before return to userspace( in prepare_exit_to_usermode()).
> >>>>>>>>>
> >>>>>>>>
> >>>>>>>> Yes, we need explicit switch_fpu_return() (likely open-coded, to=
 skip
> >>>>>>>> the PF_KTHREAD check) at the end of xnarch_switch_to, at least a=
s long
> >>>>>>>> as we do not add that to all fast (primary-mode) return-to-user =
paths.
> >>>>>>>>
> >>>>>>>> But it's more complex. The removal of fpu_initialized changed the
> >>>>>>>> condition under which __switch_to() does FPU saving and restorin=
g: All
> >>>>>>>> kernel threads, also ours, are excluded. That needs to be compen=
sated.
> >>>>>>>>
> >>>>>>>> But I'm still facing corruptions - continuing to debug.
> >>>>>>>>
> >>>>>>>
> >>>>>>> Quick update:
> >>>>>>>
> >>>>>>> I made some progress with changes like below, but I'm still facin=
g=20
> >>>>>>> issues, not with weird AVX register corruptions. They confuse me =
because=20
> >>>>>>> classic FPU registers are updated and saved/restored the same way=
, but=20
> >>>>>>> they are currently unaffected.
> >>>>>>>
> >>>>>>> Jan
> >>>>>>
> >>>>>> in my current understand,=20
> >>>>>> a userspace Xenomai/Cobalt process's context switch always need FPU
> >>>>>> state save/restore; but how about the other case?
> >>>>>>
> >>>>>> in vanilla kernel, I see if a pure kernel thread want to use FPU, =
need
> >>>>>> manually call kernel_fpu_begin() and kernel_fpu_end(), like a crit=
ical
> >>>>>> area.
> >>>>>
> >>>>> Xenomai kernel threads can use the FPU, and that without
> >>>>> kernel_fpu_begin/end. That this works is also tested by switchtest,=
 and
> >>>>> there were several issues, possibly there are still more.
> >>>>>
> >>>>> One step further: My weird avx register corruption is understand. I=
t was
> >>>>> the local instrumentation. xnftrace_printf likely uses xmm regs
> >>>>> internally, and I had such an output after setting up the test patt=
ern.
> >>>>> Fixing that, I still have a corruption, but not a "normal one" agai=
n,
> >>>>> ie. of the legacy FPU regs.
> >>>>>
> >>>>> Jan
> >>>>>
> >>>>
> >>>> Got it working:
> >>>>
> >>>> diff --git a/kernel/cobalt/arch/x86/thread.c b/kernel/cobalt/arch/x8=
6/thread.c
> >>>> index aa7b5d19d8..9a014818ef 100644
> >>>> --- a/kernel/cobalt/arch/x86/thread.c
> >>>> +++ b/kernel/cobalt/arch/x86/thread.c
> >>>> @@ -215,6 +215,15 @@ void xnarch_switch_to(struct xnthread *out, str=
uct xnthread *in)
> >>>>  		 */
> >>>>  		clts();
> >>>>  #endif /* ! IPIPE_X86_FPU_EAGER */
> >>>> +	if (!xnthread_test_state(out, XNROOT | XNUSER) &&
> >>>> +	    !test_thread_flag(TIF_NEED_FPU_LOAD)) {
> >>>> +		struct fpu *prev_fpu =3D &prev->thread.fpu;
> >>>> +
> >>>> +		if (!copy_fpregs_to_fpstate(prev_fpu))
> >>>> +			prev_fpu->last_cpu =3D -1;
> >>>> +		else
> >>>> +			prev_fpu->last_cpu =3D smp_processor_id();
> >>>> +	}
> >>>> =20
> >>>>  	next =3D in_tcb->core.host_task;
> >>>>  #ifndef IPIPE_X86_FPU_EAGER
> >>>> @@ -260,6 +269,19 @@ void xnarch_switch_to(struct xnthread *out, str=
uct xnthread *in)
> >>>>  #ifndef IPIPE_X86_FPU_EAGER
> >>>>  	stts();
> >>>>  #endif /* ! IPIPE_X86_FPU_EAGER */
> >>>> +	if (xnthread_current() &&
> >>>> +	    !xnthread_test_state(xnthread_current(), XNROOT) &&
> >>>> +	    test_thread_flag(TIF_NEED_FPU_LOAD)) {
> >>>> +		struct fpu *fpu =3D &current->thread.fpu;
> >>>> +		int cpu =3D smp_processor_id();
> >>>> +
> >>>> +		if (!fpregs_state_valid(fpu, cpu)) {
> >>>> +			copy_kernel_to_fpregs(&fpu->state);
> >>>> +			fpregs_activate(fpu);
> >>>> +			fpu->last_cpu =3D cpu;
> >>>> +		}
> >>>> +		clear_thread_flag(TIF_NEED_FPU_LOAD);
> >>>> +	}
> >>>>  }
> >>>> =20
> >>>>  #ifndef IPIPE_X86_FPU_EAGER
> >>>> @@ -488,6 +510,7 @@ void xnarch_switch_fpu(struct xnthread *from, st=
ruct xnthread *to)
> >>>>  		return;
> >>>> =20
> >>>>  	copy_kernel_to_fpregs(&to_tcb->kfpu->state);
> >>>> +	__cpu_invalidate_fpregs_state();
> >>>>  	kernel_fpu_disable();
> >>>>  }
> >>>>  #endif /* ! IPIPE_X86_FPU_EAGER */
> >>>> @@ -541,7 +564,8 @@ void xnarch_init_shadow_tcb(struct xnthread *thr=
ead)
> >>>>  #if LINUX_VERSION_CODE < KERNEL_VERSION(4,14,0)
> >>>>  	fpu__activate_fpstate_read(&p->thread.fpu);
> >>>>  #else
> >>>> -	fpu__clear(&p->thread.fpu);
> >>>> +	set_thread_flag(TIF_NEED_FPU_LOAD);
> >>>> +	fpstate_init(&p->thread.fpu.state);
> >>>>  #endif
> >>>>  #endif /* ! IPIPE_X86_FPU_EAGER */
> >>>>  }
> >>>>
> >>>>
> >>>> This still requires proper wrapping for the different kernel version=
s=20
> >>>> and some comments. But maybe you can continue testing from there.
> >>>>
> >>>>
> >>>> BTW, there are more to-dos:
> >>>>
> >>>> [    0.182466] Freeing SMP alternatives memory: 44K
> >>>> [    0.182656] ------------[ cut here ]------------
> >>>> [    0.183038] WARNING: CPU: 0 PID: 0 at ../kernel/ipipe/core.c:1968=
 __ipipe_spin_unlock_debug+0x14/0x20
> >>>> [    0.183600] Modules linked in:
> >>>> [    0.183600] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.4.59-xeno=
mai+ #64
> >>>> [    0.183600] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), B=
IOS rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
> >>>> [    0.183600] I-pipe domain: Linux
> >>>> [    0.183600] RIP: 0010:__ipipe_spin_unlock_debug+0x14/0x20
> >>>> [    0.183600] Code: 8b 07 5b e9 0e d5 c7 00 5b c3 66 66 2e 0f 1f 84=
 00 00 00 00 00 90 e8 bb de a7 00 f7 c7 00 02 00 00 74 09 9c 58 f6 c4 02 75=
 02 <0f> 0b c3 66 0f 1f 84 00 00 00 00 00 e8 9b de a7 00 41 54 55 53 9c
> >>>> [    0.183600] RSP: 0000:ffffffff82403d68 EFLAGS: 00010046
> >>>> [    0.183600] RAX: 0000000000000006 RBX: b74e512d1320154d RCX: ffff=
88803e6f2cc0
> >>>> [    0.183600] RDX: 0000000000000001 RSI: ffffffff810c1c9e RDI: 0000=
000000000200
> >>>> [    0.183600] RBP: ffff88803ea3afe4 R08: 0000000000000000 R09: ffff=
88803dd0e540
> >>>> [    0.183600] R10: 0000000000000002 R11: 0000000000000001 R12: 0000=
000000000200
> >>>> [    0.183600] R13: ffff88803dd0da00 R14: ffffffff82403eb0 R15: 0000=
000000000000
> >>>> [    0.183600] FS:  0000000000000000(0000) GS:ffff88803ea00000(0000)=
 knlGS:0000000000000000
> >>>> [    0.183600] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> >>>> [    0.183600] CR2: ffff888003201000 CR3: 000000000240a001 CR4: 0000=
000000360ef0
> >>>> [    0.183600] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000=
000000000000
> >>>> [    0.183600] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000=
000000000400
> >>>> [    0.183600] Call Trace:
> >>>> [    0.183600]  get_random_u64+0x68/0x80
> >>>> [    0.183600]  copy_process+0x37e/0x1ae0
> >>>> [    0.183600]  _do_fork+0x92/0x340
> >>>> [    0.183600]  ? acpi_hw_register_read+0x93/0x123
> >>>> [    0.183600]  kernel_thread+0x55/0x70
> >>>> [    0.183600]  ? rest_init+0xc0/0xc0
> >>>> [    0.183600]  rest_init+0x1e/0xc0
> >>>> [    0.183600]  start_kernel+0x4d4/0x4f9
> >>>> [    0.183600]  secondary_startup_64+0xa4/0xb0
> >>>> [    0.183600] ---[ end trace 9d5e39ac2de18173 ]---
> >>>>
> >>>> This is with I-pipe debugging enabled. Could you have a look?
> >>>>
> >>>
> >>> I cannot reproduce it,
> >>>
> >>> I use this config with IPIPE_DEBUG
> >>> https://github.com/intel/linux-stable-xenomai/blob/review/5.4.59/stab=
le/ipipe-x86/config_xenomai.xeno_debug
> >>>
> >>> test on a real WHL-U board (UP Xtreme), kernel boot OK and swtichtest
> >>> runs continously without error.
> >>>
> >>> another config also have no error:
> >>> https://github.com/intel/linux-stable-xenomai/blob/review/5.4.59/stab=
le/ipipe-x86/config_xenomai.kernel_debug
> >>>
> >>> am I missing something? need to test the image inside QEMU/KVM? and t=
his issue happens
> >>> during boot or after launch the switchtest?=20
> >>
> >> This comes once during boot (in QEMU/KVM, but that should not matter -
> >> famous last words). I have this set here:
> >>
> >> CONFIG_IPIPE_DEBUG=3Dy
> >> CONFIG_IPIPE_DEBUG_CONTEXT=3Dy
> >> CONFIG_IPIPE_DEBUG_INTERNAL=3Dy
> >> CONFIG_HAVE_IPIPE_TRACER_SUPPORT=3Dy
> >> CONFIG_IPIPE_TRACE=3Dy
> >> # CONFIG_IPIPE_TRACE_ENABLE is not set
> >> CONFIG_IPIPE_TRACE_MCOUNT=3Dy
> >> # CONFIG_IPIPE_TRACE_IRQSOFF is not set
> >> CONFIG_IPIPE_TRACE_SHIFT=3D14
> >> CONFIG_IPIPE_TRACE_VMALLOC=3Dy
> >> CONFIG_IPIPE_TRACE_PANIC=3Dy
> >>
> >> If you look at the source of the warning, you can see that
> >> CONFIG_IPIPE_DEBUG_INTERNAL=3Dy makes the difference.
> >>
> >> Jan
> >=20
> > well I still boot OK with IPIPE_DEBUG_INTERNAL. Will check source code
> > tomorrow.
> >=20
>=20
> Found, not yet fixed though:
>=20
> fpregs_unlock does not use the flags that fpregs_lock saves. That can
> kill kittens. We likely need to change the signature of that functions
> AND patch all callers. Examining...
>=20
> Jan
>=20
> --=20
> Siemens AG, T RDA IOT
> Corporate Competence Center Embedded Linux

in this version, xeno-test can successfully run until finish, log as
below.

be aware of RTNET and RTIPC part still have compile error, I didn't
enable them in .config yet. hope can fix them next week.

BR fino


cmd: xeno-test -k -l "dohell -m /tmp 300" -p 1000

log:

Started child 541: /bin/bash /opt/xenomai-next/bin/xeno-test-run-wrapper ./=
xenomai-next/bin/xeno-test -k -p 1000
++ echo 0
++ testdir=3D/opt/xenomai-next/bin
++ /opt/xenomai-next/bin/smokey --run --keep-going random_alloc_rounds=3D64=
 pattern_check_rounds=3D64
   0"011.434| WARNING: [main] Xenomai compiled with partial debug enabled,
                              high latencies expected [--enable-debug=3Dpar=
tial]
arith OK
bufp skipped (no kernel support)
cpu_affinity skipped (no kernel support)
fpu_stress OK
gdb OK
iddp skipped (no kernel support)
arith OK
bufp skipped (no kernel support)
cpu_affinity skipped (no kernel support)
fpu_stress OK
gdb OK
iddp skipped (no kernel support)
leaks OK
memory_coreheap OK
memory_heapmem OK
memory_tlsf OK
net_packet_dgram skipped (no kernel support)
net_packet_raw skipped (no kernel support)
net_udp skipped (no kernel support)
posix_clock OK
posix_cond OK
posix_fork OK
posix_mutex OK
posix_select OK
rtdm OK
sched_quota skipped (no kernel support)
sched_tp skipped (no kernel support)
setsched OK
sigdebug "SIGDEBUG_MIGRATE_PRIOINV" skipped (no kernel support)
sigdebug OK
timerfd OK
tsc OK
vdso_access OK
xddp skipped (no kernel support)
memory_pshared OK
++ /opt/xenomai-next/bin/clocktest -D -T 30 -C CLOCK_HOST_REALTIME
   0"000.010| WARNING: [main] Xenomai compiled with partial debug enabled,
                              high latencies expected [--enable-debug=3Dpar=
tial]
hostrt data area is live
sequence counter : 198402
wall_time_sec    : 1603441960
wall_time_nsec   : 184011905
wall_to_monotonic_sec    : -1603441702
wall_to_monotonic_nsec   : 551834706
cycle_last       : 498486537583
mask             : 0xffffffffffffffff
mult             : 9320676
shift            : 24

=3D=3D Testing built-in CLOCK_HOST_REALTIME (32)
CPU      ToD offset [us] ToD drift [us/s]      warps max delta [us]
--- -------------------- ---------------- ---------- --------------
  0                  1.1            0.000          0            0.0
  1                  1.1            0.000          0            0.0
  2                  0.0            0.000          0            0.0
  3                  0.0            0.000          0            0.0
=2E..
  1                  1.0           -0.003          0            0.0
  2                  1.1           -0.002          0            0.0
  3                  1.1           -0.003          0            0.0
++ /opt/xenomai-next/bin/switchtest -T 30
   0"000.011| WARNING: [main] Xenomai compiled with partial debug enabled,
                              high latencies expected [--enable-debug=3Dpar=
tial]
=3D=3D Testing FPU check routines...
r0: 1 !=3D 2
r1: 1 !=3D 2
r2: 1 !=3D 2
r3: 1 !=3D 2
r4: 1 !=3D 2
r5: 1 !=3D 2
r6: 1 !=3D 2
r7: 1 !=3D 2
ymm0: 1/1 !=3D 2/2
ymm1: 1/1 !=3D 2/2
ymm2: 1/1 !=3D 2/2
ymm3: 1/1 !=3D 2/2
ymm4: 1/1 !=3D 2/2
ymm5: 1/1 !=3D 2/2
ymm6: 1/1 !=3D 2/2
ymm7: 1/1 !=3D 2/2
=3D=3D FPU check routines: OK.
=3D=3D Threads: sleeper_ufps0-0 rtk0-1 rtk0-2 rtk_fp0-3 rtk_fp0-4 rtk_fp_uf=
pp0-5 rtk_fp_ufpp0-6 rtup0-7 rtup0-8 rtup_ufpp0-9 rtup_ufpp0-10 rtus0-11 rt=
us0-12 rtus_ufps0-13 rtus_ufps0-14 rtuo0-15 rtuo0-16 rtuo_ufpp0-17 rtuo_ufp=
p0-18 rtuo_ufps0-19 rtuo_ufps0-20 rtuo_ufpp_ufps0-21 rtuo_ufpp_ufps0-22 sle=
eper_ufps1-0 rtk1-1 rtk1-2 rtk_fp1-3 rtk_fp1-4 rtk_fp_ufpp1-5 rtk_fp_ufpp1-=
6 rtup1-7 rtup1-8 rtup_ufpp1-9 rtup_ufpp1-10 rtus1-11 rtus1-12 rtus_ufps1-1=
3 rtus_ufps1-14 rtuo1-15 rtuo1-16 rtuo_ufpp1-17 rtuo_ufpp1-18 rtuo_ufps1-19=
 rtuo_ufps1-20 rtuo_ufpp_ufps1-21 rtuo_ufpp_ufps1-22 sleeper_ufps2-0 rtk2-1=
 rtk2-2 rtk_fp2-3 rtk_fp2-4 rtk_fp_ufpp2-5 rtk_fp_ufpp2-6 rtup2-7 rtup2-8 r=
tup_ufpp2-9 rtup_ufpp2-10 rtus2-11 rtus2-12 rtus_ufps2-13 rtus_ufps2-14 rtu=
o2-15 rtuo2-16 rtuo_ufpp2-17 rtuo_ufpp2-18 rtuo_ufps2-19 rtuo_ufps2-20 rtuo=
_ufpp_ufps2-21 rtuo_ufpp_ufps2-22 sleeper_ufps3-0 rtk3-1 rtk3-2 rtk_fp3-3 r=
tk_fp3-4 rtk_fp_ufpp3-5 rtk_fp_ufpp3-6 rtup3-7 rtup3-8 rtup_ufpp3-9 rtup_uf=
pp3-10 rtus3-11 rtus3-12 rtus_ufps3-13 rtus_ufps3-14 rtuo3-15 rtuo3-16 rtuo=
_ufpp3-17 rtuo_ufpp3-18 rtuo_ufps3-19 rtuo_ufps3-20 rtuo_ufpp_ufps3-21 rtuo=
_ufpp_ufps3-22
RTT|  00:00:01
RTH|---------cpu|ctx switches|-------total
RTD|           3|       31624|       31624
RTD|           2|       31174|       31174
RTD|           1|       31077|       31077
RTD|           0|       31336|       31336
RTD|           2|       31268|       62442
RTD|           3|       31056|       62680
RTD|           1|       31073|       62150
RTD|           0|       31115|       62451
RTD|           2|       32703|       95145
RTD|           3|       32622|       95302
RTD|           1|       32623|       94773
RTD|           0|       32755|       95206
RTD|           3|       31947|      127249
RTD|           2|       31928|      127073
RTD|           1|       31985|      126758
RTD|           0|       31958|      127164
RTD|           3|       30482|      157731
RTD|           2|       30615|      157688
RTD|           1|       30759|      157517
RTD|           0|       30575|      157739
RTD|           3|       32057|      189788
RTT|  00:00:06
=2E..
RTT|  00:00:27
RTH|---------cpu|ctx switches|-------total
RTD|           1|       31405|      856739
RTD|           2|       31348|      856615
RTD|           0|       30600|      855751
RTD|           3|       30886|      886331
RTD|           1|       30991|      887730
RTD|           2|       31057|      887672
RTD|           0|       30736|      886487
RTD|           3|       31382|      917713
RTD|           1|       31645|      919375
RTD|           2|       31421|      919093
RTD|           0|       31579|      918066
RTD|           0|       29847|      947913
RTD|           1|       29701|      949076
RTD|           2|       29236|      948329
RTD|           3|       29701|      947414
++ start_load
++ echo start_load
++ false
++ check_alive /opt/xenomai-next/bin/latency -p 1000
++ echo check_alive /opt/xenomai-next/bin/latency -p 1000
++ wait_load
++ read rc
Started child 701: dohell -m /tmp 300
Started child 702: /opt/xenomai-next/bin/latency -p 1000
   0"000.018| WARNING: [main] Xenomai compiled with partial debug enabled,
                              high latencies expected [--enable-debug=3Dpar=
tial]
=3D=3D Sampling period: 1000 us
=3D=3D Test mode: periodic user-mode task
=3D=3D All results in microseconds
warming up...
100+0 records in
100+0 records out
102400000 bytes (102 MB, 98 MiB) copied, 0.60339 s, 170 MB/s
RTT|  00:00:01  (periodic user-mode task, 1000 us period, priority 99)
RTH|----lat min|----lat avg|----lat max|-overrun|---msw|---lat best|--lat w=
orst
RTD|      3.497|      4.146|      7.005|       0|     0|      3.497|      7=
=2E005
100+0 records in
100+0 records out
102400000 bytes (102 MB, 98 MiB) copied, 1.01165 s, 101 MB/s
RTD|      3.449|      4.021|      6.308|       0|     0|      3.449|      7=
=2E005
RTD|      3.507|      5.268|     11.206|       0|     0|      3.449|     11=
=2E206
100+0 records in
100+0 records out
=2E..
102400000 bytes (102 MB, 98 MiB) copied, 2.31145 s, 44.3 MB/s
RTD|      2.749|      3.700|      7.169|       0|     0|      2.749|     13=
=2E376
RTD|      2.922|      3.489|      6.241|       0|     0|      2.749|     13=
=2E376
RTD|      2.983|      3.485|      5.000|       0|     0|      2.749|     13=
=2E376
child 701 returned: exited with status 127
Load script terminated, terminating checked scripts
---|-----------|-----------|-----------|--------|------|-------------------=
------
RTS|      2.749|      4.585|     13.376|       0|     0|    00:05:04/00:05:=
04
child 702 returned: exited with status 0
pipe_in: /tmp/xeno-test-in-541
child 541 returned: exited with status 0


