MIME-Version: 1.0
In-Reply-To: <1fcfcb68-0e15-0540-94fb-c8336515d984@siemens.com>
References: <CAM4-srAdaAYdVQkG2_a2StVLTTFggoB7vw4hM+CoyGO4hQHM3Q@mail.gmail.com>
 <1fcfcb68-0e15-0540-94fb-c8336515d984@siemens.com>
From: ritika agarwal <ritika.agarwal16@gmail.com>
Date: Fri, 25 Nov 2016 14:42:08 +0530
Message-ID: <CAM4-srCvSR_7SxnL8Eem10XZH9xWaXGeAF4POhZ4Mu7RiqwRzw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Xenomai] qemu-aarch64 smp support
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

On Thu, Nov 24, 2016 at 8:19 PM, Jan Kiszka <jan.kiszka@siemens.com> wrote:

> On 2016-11-24 14:55, ritika agarwal wrote:
> > Hello everyone,
> >
> > I am trying to install Xenomai with Soc based on ARM64 and
> > running it on qemu-system-aarch64  ipipe/xenomai.
> >
> > I am facing problem while trying to boot it with smp support(multi core)
> > and using following ipipe and kernel version:
> >
> > - ipipe:  ipipe-3.18-arm64
> > - Kernel: 3.18
> >
> > And when trying to launch qemu with the following command:
> >
> > qemu-system-aarch64 -M virt -cpu cortex-a57 -kernel -smp 4 Image -initrd
> > rootfs.img.gz -nographic -append "console=ttyAMA0 root=/dev/ram
> > rootfstype=ramfs init=/bin/sh" -snapshot
> >
> > I am getting the below Kernel Panic:
> >
> > ...
> > Freeing initrd memory: 2924K (ffffffc004000000 - ffffffc0042db000)
> > kvm [1]: HYP mode not available
> > futex hash table entries: 1024 (order: 4, 65536 bytes)
> > [Xenomai] scheduling class idle registered.
> > [Xenomai] scheduling class tp registered.
> > [Xenomai] scheduling class quota registered.
> > [Xenomai] scheduling class rt registered.
> > I-pipe: head domain Xenomai registered.
> > sched: RT throttling activated
> > INFO: rcu_preempt self-detected stall on CPU { 2}  (t=2100 jiffies g=5
> c=4
> > q=25)
> > Task dump for CPU 1:
> > swapper/0       R  running task        0     1      0 0x00000000
> > Call trace:
> > [<ffffffc000086754>] __switch_to+0x74/0x8c
> > [<ffffffc000096e58>] __ipipe_mach_get_tsc+0xc/0x34
> > [<ffffffc00013c7dc>] __ipipe_trace+0xf0/0x7a8
> > [<ffffffc00013dad4>] ipipe_trace_function+0x2c/0x38
> > [<ffffffc000140e44>] ftrace_ops_no_ops+0xa4/0x1e8
> > [<ffffffc0000910b0>] _mcount+0x30/0x3c
> > [<ffffffc0001374b0>] __ipipe_spin_unlock_irqrestore+0x1c/0xcc
> > [<ffffffc0003cd780>] gic_raise_softirq+0xa8/0xc4
> > [<ffffffc000091c9c>] smp_cross_call+0x54/0xcc
> > [<ffffffc000091d3c>] ipipe_send_ipi+0x28/0x38
> > [<ffffffc000137e94>] ipipe_critical_enter+0x120/0x1bc
> > [<ffffffc0000b4200>] mach_arm_calibrate+0x30/0xe4
> > [<ffffffc0008810ac>] xnclock_init+0x20/0x5c
> > [<ffffffc00088134c>] xenomai_init+0x264/0x4fc
> > [<ffffffc000081808>] do_one_initcall+0x90/0x1b4
> > [<ffffffc000871b04>] kernel_init_freeable+0x144/0x1e8
> > [<ffffffc000634d88>] kernel_init+0x14/0xdc
> >
>
> QEMU is only slowly gaining true SMP emulation support, thus you will
> still run those 4 vCPUs strictly serialized. And that can raise stall
> warnings already with plain Linux because 3 of the 4 cores are waiting
> for rather long times under high load conditions - or when they even
> busy-wait on each other (lock-holder preemption issue). Does single-core
> work?
>
>
- Yes, single core works fine for me.

Best Regards,
Ritika Agarwal
