Message-ID: <48723D5D.6020008@domain.hid>
Date: Mon, 07 Jul 2008 17:59:25 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <200807071745.31720@domain.hid>
In-Reply-To: <200807071745.31720@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Kernel panic: not syncing
Reply-To: rpm@xenomai.org
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Petr Cervenka <grugh@domain.hid>
Cc: xenomai@xenomai.org

Petr Cervenka wrote:
> Hello,
> I'm not sure if I'm not off topic.
> We use Linux 2.6.24 and Xenomai 2.4.1. Occasionally (once in few days) we get an kernel panic and I don't know If it's our fault or a problem of kernel/xenomai/adeos/configuration/hw/...
> If you have any questions, i'll try to answer them. Any help is welcome.

It is an I-pipe issue, probably. We have to somewhat forge the register frame
passed to the Linux tick handler, since we may delay that call. Some register
values the profiling code attempts to dereference to find the preempted code may
be wrong in our case.

Could you 1) send back a disassembly of the profile_tick routine in your kernel
image, then apply the following patch to check whether it improves the situation
as well? TIA,

--- 2.6.24-x86-2.0-03/arch/x86/kernel/ipipe.c~	2008-02-11 10:48:24.000000000 +0100
+++ 2.6.24-x86-2.0-03/arch/x86/kernel/ipipe.c	2008-07-07 17:55:36.000000000 +0200
@@ -933,12 +933,7 @@
 		tick_regs->eip = regs.eip;
 		tick_regs->ebp = regs.ebp;
 #else /* !CONFIG_X86_32 */
-		tick_regs->ss = regs->ss;
-		tick_regs->rsp = regs->rsp;
-		tick_regs->eflags = regs->eflags;
-		tick_regs->cs = regs->cs;
-		tick_regs->rip = regs->rip;
-		tick_regs->rbp = regs->rbp;
+		*tick_regs = *regs;
 #endif /* !CONFIG_X86_32 */
 	}

-- 
Philippe.

