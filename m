Message-ID: <50741C5B.4060206@wanadoo.fr>
Date: Tue, 09 Oct 2012 14:45:15 +0200
From: Thierry Bultel <thierry.bultel@wanadoo.fr>
MIME-Version: 1.0
References: <505EB99F.7050705@wanadoo.fr> <505EBD61.1050009@wanadoo.fr>
	<505F0D40.9030105@xenomai.org>
In-Reply-To: <505F0D40.9030105@xenomai.org>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] Target frozen with rtcan_virt
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

Hi, I would like to re-open this thread

I have reproduced the same target freeze, on another configuration.
linux-3.2.21+ipipe-core-3.2.21-x86-1.patch

running on kvm (only one core)

rtcan0 and rtcan1 are devices of the unmodifed "rtcan_virt" rtdm driver.

The test sample is the unmodified 
"xenomai-2.6.1/examples/rtdm/profiles/can/rtcan_rtt.c"

[root@buildroot ~]# ./rtcan_rtt rtcan0 rtcan1
1 3
RX rxsock=896, ifr_name=rtcan1
TX txsock=897, ifr_name=rtcan0
Round-Trip-Time test rtcan0 -> rtcan1 with CAN ID 0x1
Cycle time: 10000 us
All RTT timing figures are in us.


---> FROZEN

#


Here's my backtrace, with gdb on qemu's gdbserver:

(gdb) l
58
59        for (;;) {
60            if (inc.head == inc.tail)
61                break;
62            cpu_relax();
63            inc.head = ACCESS_ONCE(lock->tickets.head);
64        }
65        barrier();        /* make sure nothing creeps before the lock 
is taken */
66    }
67
(gdb) bt
#0  __ticket_spin_lock (lock=<optimized out>) at 
/home/thierry/workspace/Buildroot/output/build/linux-3.2.21/arch/x86/include/asm/spinlock.h:63
#1  arch_spin_lock (lock=<optimized out>) at 
/home/thierry/workspace/Buildroot/output/build/linux-3.2.21/arch/x86/include/asm/spinlock.h:129
#2  rtcan_raw_recvmsg (context=0xc7ff0000, user_info=0xd00b2290, 
msg=0xd796df04, flags=<optimized out>) at 
drivers/xenomai/can/rtcan_raw.c:655
#3  0xc111f205 in __rt_dev_recvmsg (user_info=<optimized out>, 
fd=<optimized out>,
     msg=<error reading variable: DWARF-2 expression error: DW_OP_reg 
operations must be used either alone or in conjunction with DW_OP_piece 
or DW_OP_bit_piece.>, flags=0) at kernel/xenomai/skins/rtdm/core.c:575
#4  0xc11241e7 in sys_rtdm_recvmsg (regs=0xd796dfb4) at 
kernel/xenomai/skins/rtdm/syscall.c:91
#5  0xc10d6dfb in do_hisyscall_event (data=<optimized out>, 
stage=<optimized out>, event=<optimized out>) at 
kernel/xenomai/nucleus/shadow.c:2342
#6  hisyscall_event (event=<optimized out>, ipd=<optimized out>, 
data=<optimized out>) at kernel/xenomai/nucleus/shadow.c:2454
#7  0xc109ced6 in ipipe_syscall_hook (ipd=<optimized out>, 
regs=<optimized out>) at kernel/ipipe/compat.c:237
#8  0xc109b51f in __ipipe_notify_syscall (regs=<optimized out>) at 
kernel/ipipe/core.c:972
#9  0xc101afb4 in __ipipe_syscall_root (regs=0xd796dfb4) at 
arch/x86/kernel/ipipe.c:556
#10 0xc1684738 in ?? () at arch/x86/kernel/entry_32.S:479
#11 0xb76ea424 in ?? ()
Backtrace stopped: previous frame inner to this frame (corrupt stack?)


In my previous configuration, disabling CONFIG_SMP was enough to 
workaround it, but in that new case
I have other bad side-effects (console and X server frozen at startup) 
that prevent me to work correctly.

Regards
Thierry

Le 23/09/2012 15:23, Gilles Chanteperdrix a écrit :
> On 09/23/2012 09:42 AM, Thierry Bultel wrote:
>
>> Hi,
>>
>> My configuration is linux-3.2.21+ipipe-core-3.2.21-arm-1.patch,
>> running in qemu 1.2.0 for versatile express. I have CONFIG_SMP but
>> qemu is launched with 1 core only (else it does not boot, keeps hung
>> just after "booting the kernel", but that is not the point here).
>
> Basically, versatile express is not a board supported by the I-pipe
> patch, so, the first thing is to check that the I-pipe port is working
> correctly. For instance, I would run tsc -w first to see if the tsc
> emulation is working correctly. Then you can use this document:
>
> http://www.xenomai.org/index.php/I-pipe-core:ArmPorting
>
> As a check list.
>
> Also, some modifications would be needed to get it working in SMP mode.
> This should be much easier to start with the I-pipe kernel for 3.4,
> except for the "global timer" which seems not to be present on versatile
> express, so, some code would be needed to skip the initialization in
> gt_setup when we detect a processor that does not have a global timer.
>


