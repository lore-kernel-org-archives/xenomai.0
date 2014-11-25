Message-ID: <5474DB89.2070401@siemens.com>
Date: Tue, 25 Nov 2014 20:42:01 +0100
From: Jan Kiszka <jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] __cobalt_thread_create: cleanup after failing
	cobalt_map_user
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai <xenomai@xenomai.org>

Hi,

I ran into an oops (bt below) when (for yet unknown reasons)
cobalt_map_user fails. The reason is that we then call xnthread_cancel,
but on a thread that has no user space task assigned yet.

Which functions rolls only pthread_create back?

The issue should apply to cobalt_thread_shadow as well.

Jan

(gdb) bt
#0  dump_stack () at /data/linux-ipipe/lib/dump_stack.c:27
#1  0xffffffff810e75ad in ipipe_root_only () at /data/linux-ipipe/kernel/ipipe/core.c:1685
#2  0xffffffff810e86b1 in ipipe_unstall_root () at /data/linux-ipipe/kernel/ipipe/core.c:419
#3  0xffffffff8168a51a in arch_local_irq_enable () at /data/linux-ipipe/arch/x86/include/asm/irqflags.h:114
#4  __do_page_fault (regs=0xffff88003a4a7cc8, error_code=0, address=732) at /data/linux-ipipe/arch/x86/mm/fault.c:1134
#5  0xffffffff8168a7b2 in do_page_fault (regs=<optimized out>, error_code=<optimized out>) at /data/linux-ipipe/arch/x86/mm/fault.c:1277
#6  0xffffffff8102ea1a in __ipipe_handle_exception (regs=0xffff88003a4a7cc8, error_code=-131940329925848, vector=14) at /data/linux-ipipe/arch/x86/kernel/ipipe.c:438
#7  <signal handler called>
#8  0xffffffff81133902 in xnthread_host_pid (thread=<optimized out>) at /data/linux-ipipe/include/xenomai/cobalt/kernel/thread.h:249
#9  xnthread_resume (thread=0xffff88003c204040, mask=<optimized out>) at /data/linux-ipipe/kernel/xenomai/thread.c:1038
#10 0xffffffff81137a5f in xnthread_cancel (thread=0xffff88003c204040) at /data/linux-ipipe/kernel/xenomai/thread.c:1463
#11 0xffffffff81179f45 in __cobalt_thread_create (pth=140597174187776, policy=<optimized out>, param_ex=0xffff88003a4a7e80, xid=<optimized out>, u_winoff=<optimized out>) at /data/linux-ipipe/kernel/xenomai/posix/thread.c:586
#12 0xffffffff8117a164 in cobalt_thread_create (pth=140597174187776, policy=0, u_param=<optimized out>, xid=0, u_winoff=0x7fdf549fae94) at /data/linux-ipipe/kernel/xenomai/posix/thread.c:604
#13 0xffffffff8117031a in handle_root_syscall (ipd=<optimized out>, regs=<optimized out>) at /data/linux-ipipe/kernel/xenomai/posix/syscall.c:950
#14 ipipe_syscall_hook (ipd=<optimized out>, regs=0xffff88003a4a7f58) at /data/linux-ipipe/kernel/xenomai/posix/syscall.c:999
#15 0xffffffff810e97a7 in __ipipe_notify_syscall (regs=<optimized out>) at /data/linux-ipipe/kernel/ipipe/core.c:1045
#16 <signal handler called>
#17 0x00007fdf5591caff in ?? ()
#18 0xffff88003b9ef220 in ?? ()
#19 0xffffffff819a75a0 in ?? ()
#20 0x0000000000000000 in ?? ()

-- 
Siemens AG, Corporate Technology, CT RTC ITP SES-DE
Corporate Competence Center Embedded Linux

