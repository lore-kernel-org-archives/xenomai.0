Date: Fri, 24 Sep 2021 15:31:20 +0200
From: Henning Schild <henning.schild@siemens.com>
Subject: Re: "switchtest" problem with recent 5.10 dovetail and distro-like
 kernel config
Message-ID: <20210924153120.649e583f@md1za8fc.ad001.siemens.net>
In-Reply-To: <20210922162154.495db035@md1za8fc.ad001.siemens.net>
References: <20210922122519.73e772a3@md1za8fc.ad001.siemens.net>
 <877df823dq.fsf@xenomai.org>
 <20210922162154.495db035@md1za8fc.ad001.siemens.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Henning Schild via Xenomai <xenomai@xenomai.org>

Am Wed, 22 Sep 2021 16:21:54 +0200
schrieb Henning Schild via Xenomai <xenomai@xenomai.org>:

> Am Wed, 22 Sep 2021 14:36:49 +0200
> schrieb Philippe Gerum <rpm@xenomai.org>:
> 
> > Henning Schild via Xenomai <xenomai@xenomai.org> writes:
> >   
> > > Hi,
> > >
> > > getting sick of maintaining a "small" kernel config i wanted to
> > > switch to a config derived from the debian11 5.10 kernel.
> > > Basically that config plus the few switches coming in with
> > > dovetail.
> > >
> > > That passed all tests in qemu but on a real machine (big xeon with
> > > raid0) the "switchtest" has an issue.
> > >
> > > # /lib/xenomai/testsuite/switchtest 
> > > == Testing FPU check routines...
> > > r0: 1 != 2
> > > r1: 1 != 2
> > > r2: 1 != 2
> > > r3: 1 != 2
> > > r4: 1 != 2
> > > r5: 1 != 2
> > > r6: 1 != 2
> > > r7: 1 != 2
> > > ymm0: 1/1 != 2/2
> > > ymm1: 1/1 != 2/2
> > > ymm2: 1/1 != 2/2
> > > ymm3: 1/1 != 2/2
> > > ymm4: 1/1 != 2/2
> > > ymm5: 1/1 != 2/2
> > > ymm6: 1/1 != 2/2
> > > ymm7: 1/1 != 2/2
> > > == FPU check routines: OK.
> > > == Threads: ... a lot of threads ...
> > > 30-16 rtuo_ufpp30-17 rtuo_ufpp30-18 rtuo_ufps30-19 rtuo_ufps30-20
> > > rtuo_ufpp_ufps30-21 rtuo_ufpp_ufps30-22 sleeper_ufpthread_create:
> > > Resource temporarily unavailable ps31-0 rtk31-1 rtk31-2 rtk_fp31-3
> > > rtk_fp31-4 rtk_fp_ufpp31-5 rtk_fp_ufpp31-6 rtup31-7 rtup31-8
> > > rtup_ufpp31-9 rtup_ufpp31-10 rtus
> > >
> > > followed by only 0s
> > >
> > > RTH|---------cpu|ctx switches|-------total
> > > RTD|           0|           0|           0
> > > RTD|           1|           0|           0
> > > RTD|           2|           0|           0
> > > RTD|           3|           0|           0
> > > RTD|           4|           0|           0
> > > RTD|           5|           0|           0
> > > RTD|           6|           0|           0
> > >
> > > So it gets a 
> > >
> > > sleeper_ufpthread_create: Resource temporarily unavailable
> > >
> > > but swallows that and keeps going. I think there might be a first
> > > issue with that error return not being dealt with.
> > >
> > > A second run get the "switchtest" stuck after crtl+c while the
> > > kernel starts complaining.
> > >
> > > [ 1229.072052] list_del corruption. prev->next should be
> > > ffffb24e46fb0548, but was ffffffff9a7356b0 [ 1229.072053]
> > > ------------[ cut here ]------------ [ 1229.072054] kernel BUG at
> > > lib/list_debug.c:51! [ 1229.072054] invalid opcode: 0000 [#1] SMP
> > > PTI IRQ_PIPELINE [ 1229.072054] CPU: 31 PID: 1857 Comm: switchtest
> > > Tainted: G            E     5.10.61-xenomai-1 #1 [ 1229.072055]
> > > Hardware name: secret [ 1229.072055] IRQ stage: Linux
> > > [ 1229.072055] RIP: 0010:__list_del_entry_valid.cold+0x31/0x47
> > > [ 1229.072056] Code: 99 32 9a e8 5f 0d ff ff 0f 0b 48 c7 c7 00 9a
> > > 32 9a e8 51 0d ff ff 0f 0b 48 89 b [ 1229.072057] RSP:
> > > 0018:ffffb24e4b5f7e30 EFLAGS: 00010046 [ 1229.072061] RAX:
> > > 0000000000000057 RBX: ffffb24e46fb04b0 RCX: 0000000000000000 [
> > > 1229.072062] RDX: 0000000000000000 RSI: ffffa10e9fd9bba0 RDI:
> > > ffffa10e9fd97b68 [ 1229.072064] RBP: 0000000000000000 R08:
> > > 0000000000000001 R09: 000000000000000f [ 1229.072066] R10:
> > > 000000000000000f R11: ffffa10e9fd97bd6 R12: 0000000000000000 [
> > > 1229.072069] R13: ffffa0ff488c7380 R14: 0000000000000000 R15:
> > > 0000000000000000 [ 1229.072072] FS:  00007f57e687bb80(0000)
> > > GS:ffffa10e9fd80000(0000) knlGS:0000000000000000 [ 1229.072074]
> > > CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033 [ 1229.072076]
> > > CR2: 000055921bfa921c CR3: 00000001062fe002 CR4: 00000000001706e0
> > > [ 1229.072078] Call Trace: [ 1229.072080]
> > > xntimer_destroy+0x81/0x150 [ 1229.072082]
> > > __xnthread_cleanup+0x1e/0x2a0 [ 1229.072084]
> > > cobalt_handle_taskexit_event+0x1d/0x40 [ 1229.072086]
> > > do_exit+0xe1/0xab0 [ 1229.072088]  ?
> > > signal_wake_up_state+0x23/0x40 [ 1229.072090]
> > > do_group_exit+0x33/0xa0 [ 1229.072092]
> > > __x64_sys_exit_group+0x14/0x20 [ 1229.072111]
> > > do_syscall_64+0x3f/0x90 [ 1229.072113]
> > > entry_SYSCALL_64_after_hwframe+0x44/0xa9 [ 1229.072115] RIP:
> > > 0033:0x7f57e6948699 [ 1229.072117] Code: 00 4c 8b 05 f9 27 0f 00
> > > be e7 00 00 00 ba 3c 00 00 00 eb 12 0f 1f 44 00 00 89 0 [
> > > 1229.072119] RSP: 002b:00007ffcfbda0078 EFLAGS: 00000246
> > > ORIG_RAX: 00000000000000e7 [ 1229.072128] RAX: ffffffffffffffda
> > > RBX: 00007f57e6a3d610 RCX: 00007f57e6948699 [ 1229.072130] RDX:
> > > 000000000000003c RSI: 00000000000000e7 RDI: 0000000000000001 [
> > > 1229.072132] RBP: 0000000000000001 R08: ffffffffffffff70 R09:
> > > 0000000000000001 [ 1229.072134] R10: 0000000000000005 R11:
> > > 0000000000000246 R12: 00007f57e6a3d610 [ 1229.072136] R13:
> > > 0000000000000002 R14: 00007f57e6a3dae8 R15: 0000000000000000 [
> > > 1229.072138] Modules linked in: md4(E) sha512_ssse3(E)
> > > sha512_generic(E) cmac(E) nls_utf8(E) cifs) [ 1229.072169]
> > > mei(E) soundcore(E) sysimgblt(E) sg(E) evdev(E) ioatdma(E)
> > > joydev(E) watchdog(E) ac) [ 1229.072185] ---[ end trace
> > > a1d1ac68468e74f0 ]--- [ 1229.072186] RIP:
> > > 0010:__list_del_entry_valid.cold+0x31/0x47 [ 1229.072187] Code:
> > > 99 32 9a e8 5f 0d ff ff 0f 0b 48 c7 c7 00 9a 32 9a e8 51 0d ff ff
> > > 0f 0b 48 89 b [ 1229.072187] RSP: 0018:ffffb24e4b5f7e30 EFLAGS:
> > > 00010046 [ 1229.072188] RAX: 0000000000000057 RBX:
> > > ffffb24e46fb04b0 RCX: 0000000000000000 [ 1229.072188] RDX:
> > > 0000000000000000 RSI: ffffa10e9fd9bba0 RDI: ffffa10e9fd97b68 [
> > > 1229.072189] RBP: 0000000000000000 R08: 0000000000000001 R09:
> > > 000000000000000f [ 1229.072189] R10: 000000000000000f R11:
> > > ffffa10e9fd97bd6 R12: 0000000000000000 [ 1229.072190] R13:
> > > ffffa0ff488c7380 R14: 0000000000000000 R15: 0000000000000000 [
> > > 1229.072190] FS:  00007f57e687bb80(0000)
> > > GS:ffffa10e9fd80000(0000) knlGS:0000000000000000 [ 1229.072190]
> > > CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033 [ 1229.072191]
> > > CR2: 000055921bfa921c CR3: 00000001062fe002 CR4: 00000000001706e0
> > > [ 1229.072191] Fixing recursive fault but reboot is needed!
> > >
> > > I will look into that eventually. For now i just wanted to share
> > > what i have so far, maybe someone knows what is going on or can
> > > give a hint. function tracing was way too verbose to find the
> > > rootcause of that EBUSY.
> > >    
> > 
> > EAGAIN, switchtest triggers this when many CPUs are available but
> > the system heap is too small (not enough space there to create
> > thread TCBs and other core objects). Normally, switchtest exits
> > properly after a while.  
> 
> Ok maybe that changed kernel config did shrink the available heap,
> thanks for the hint.
> 
> If it is an EAGAIN because of too little resources, maybe it should
> keep trying with less and less CPUs. And spit a warning like "could
> only run on 20 out of 32 cores".
> At least that would be my first idea for a patch in case it is that.

The test runs just fine when reducing the number of cores to run on. In
fact it was one too many ;)

good
./switchtest -T 5 --cpu-affinity=0-30
bad (where affinity includes all cpus)
./switchtest -T 5 --cpu-affinity=0-31

> > The kernel splat looks like some issue on the error path which might
> > not have been observed yet (maybe triggered by ^C while switchtest
> > was unwinding).  
> 
> I saw exactly that in probably three attempts. First switchtest killed
> with ctrl+c when the 0s come ... never any fun kernel message. But
> always fun kernel message when the second run was interrupted. So i
> would be tempted to call that reproducible and not a one-time bad
> timing.

But when running the bad case two times in a row, it will always

kernel BUG at lib/list_debug.c:51!

Even when none of the two runs was interrupted by ctrl+c.

Henning

> Henning
> 
> 
> 


