From: "Giorgio Buffa" <giorgiobuffa.work@gmail.com>
Date: Mon, 13 Jul 2015 10:28:46 +0200
Message-ID: <000201d0bd45$f08167b0$d1843710$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Language: it
Subject: [Xenomai] Xenomai 2.6.4 on Linux w/ PREEMPT_RT
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hello list!
Have you ever set up a dual-kernel system using Xenomai 2 and a Linux
kernel patched with PREEMPT_RT?

I was trying with Linux 3.14.39 on x86_64 using "patch-3.14.39-rt37.patch"
and "ipipe-core-3.14.39-x86-9.patch". First I've applied the PREEMPT_RT
patch, then I've tried to apply the i-pipe patch. The latter does not apply
cleanly, because 14 hooks failed to apply (see an extract of the output I
got below).

    me@devel-vm:~/workspace/rt/xenomai-2.6.4$ scripts/prepare-kernel.sh
        --linux=~/workspace/rt/linux-3.14.39-rt37-xenomai-2.6.4-ipipe9
        --adeos=~/software/ipipe-core-3.14.39-x86-9.patch
        --arch=x86_64
    checking file arch/x86/Kconfig
    Hunk #2 FAILED at 22.
    checking file arch/x86/kernel/apic/io_apic.c
    Hunk #11 FAILED at 2439.
    checking file arch/x86/kernel/asm-offsets.c
    Hunk #1 FAILED at 32.
    checking file arch/x86/kernel/entry_64.S
    Hunk #9 FAILED at 731.
    checking file arch/x86/kernel/traps.c
    Hunk #1 FAILED at 102.
    checking file include/linux/sched.h
    Hunk #1 FAILED at 24.
    checking file kernel/power/hibernate.c
    Hunk #2 FAILED at 429.
    Hunk #3 FAILED at 550.
    checking file kernel/sched/core.c
    Hunk #3 FAILED at 1596.
    Hunk #14 FAILED at 2823.
    Hunk #16 FAILED at 4612.
    checking file kernel/trace/trace_irqsoff.c
    Hunk #1 FAILED at 486.
    checking file mm/Kconfig
    Hunk #1 FAILED at 397.
    checking file mm/mmu_context.c
    Hunk #1 FAILED at 21.
    prepare-kernel.sh: Unable to patch kernel 3.14.39 with
ipipe-core-3.14.39-x86-9.patch.

Is it an "expected" behaviour? I guess the only way to go in that case is
to manually resolve these conflicts, right? Do you have any pointer on how
to approach them?

Thank you for the support and kind regards,
Giorgio Buffa.


