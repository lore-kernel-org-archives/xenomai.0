Message-ID: <505EBD61.1050009@wanadoo.fr>
Date: Sun, 23 Sep 2012 09:42:25 +0200
From: Thierry Bultel <thierry.bultel@wanadoo.fr>
MIME-Version: 1.0
References: <505EB99F.7050705@wanadoo.fr>
In-Reply-To: <505EB99F.7050705@wanadoo.fr>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] Target frozen with rtcan_virt
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hi,

My configuration is linux-3.2.21+ipipe-core-3.2.21-arm-1.patch, running in qemu 1.2.0 for versatile express.
I have CONFIG_SMP but qemu is launched with 1 core only (else it does not boot, keeps hung just after "booting the kernel",
but that is not the point here).

-->

I have 2 processes using rtcan0 & rtcan1 respectively, with rtcan_virt

Apparently, as soons 2nd process receives data, the target freezes.

I have attached a gbd to qemu monitor, and it seems that I am stuck in rtcan_raw_recvmsg,

on the

     rtdm_lock_get_irqsave(&rtcan_socket_lock, lock_ctx);

call.

Here is my backtrace:

(gdb) target remote localhost:1234
Remote debugging using localhost:1234
0x802e9288 in ?? ()
(gdb) bt
#0  0x802e9288 in ?? ()
Cannot access memory at address 0x2b0
(gdb) symbol-file workspace/Buildroot/output/build/linux-3.2.21/vmlinux
Reading symbols from /home/thierry/workspace/Buildroot/output/build/linux-3.2.21/vmlinux...done.
(gdb) bt
#0  0x802e9288 in arch_spin_lock (lock=<optimized out>)
     at /home/thierry/workspace/Buildroot/output/build/linux-3.2.21/arch/arm/include/asm/spinlock.h:83
#1  rtcan_raw_recvmsg (context=0xb4eec800, user_info=0xbf8b95c0,
     msg=0x8a691f0c, flags=0) at drivers/xenomai/can/rtcan_raw.c:655
#2  0x800fdc64 in __rt_dev_recvmsg (user_info=0xbf8b95c0, fd=<optimized out>,
     msg=0x8a691f0c, flags=0) at kernel/xenomai/skins/rtdm/core.c:575
#3  0x80105528 in sys_rtdm_recvmsg (regs=0x8a691fb0)
     at kernel/xenomai/skins/rtdm/syscall.c:91
#4  0x8009e3d8 in do_hisyscall_event (data=<optimized out>,
     stage=<optimized out>, event=<optimized out>)
     at kernel/xenomai/nucleus/shadow.c:2342
#5  hisyscall_event (event=<optimized out>, ipd=0x8053d0c0,
     data=<optimized out>) at kernel/xenomai/nucleus/shadow.c:2454
#6  0x80072940 in ipipe_syscall_hook (ipd=<optimized out>, regs=0x1)
     at kernel/ipipe/compat.c:237
#7  0x80070788 in __ipipe_notify_syscall (regs=<optimized out>)
     at kernel/ipipe/core.c:972
#8  0x80018314 in __ipipe_syscall_root (scno=983106, regs=0x8a691fb0)
     at arch/arm/kernel/ipipe.c:384
#9  0x8000e818 in vector_swi () at arch/arm/kernel/entry-common.S:446
#10 0x8000e818 in vector_swi () at arch/arm/kernel/entry-common.S:446
#11 0x8000e818 in vector_swi () at arch/arm/kernel/entry-common.S:446

(these goes to infinite)

---Type <return> to continue, or q <return> to quit---

Commenting out the irqsave / restore calls in rtcan_raw_recvmsg  routine, (that is obviuously not right thing to do), makes the freeze not happen
and the communication run fine.

I have honestly serious doubts on my receive process, there is a lot of chance that it has gone in an infinite loop, and moreover the freeze is not
reproducible with the rtcanrecv in place of it.

What I do not understand is that I have CONFIG_XENO_OPT_WATCHDOG and XENO_OPT_WATCHDOG_TIMEOUT = 4, and it is not triggered
(but I have validated it on a separate test case and it works)

How can I debug that issue ?

Thanks
Thierry



