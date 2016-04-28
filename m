MIME-Version: 1.0
Date: Thu, 28 Apr 2016 12:03:41 +0530
Message-ID: <CABUerAFN6zT_DPbF7uEU=2jLj5iE1K6RaTEJHYsbovGhuxW_WA@mail.gmail.com>
From: ravi kanth <xenomai412@gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [Xenomai] kernal2.6.38.8
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

when I am patching  linux kernal 2.6.38.8 with xenomai 2.6-2.2.6.3


 file kernel/signal.c
Hunk #1 FAILED at 686.
Hunk #2 succeeded at 794 (offset -139 lines).
1 out of 2 hunks FAILED
checking file kernel/spinlock.c
checking file kernel/time/clockevents.c
Hunk #1 FAILED at 17.
Hunk #2 FAILED at 282.
2 out of 2 hunks FAILED
checking file kernel/time/clocksource.c
Hunk #2 FAILED at 250.
Hunk #3 FAILED at 266.
Hunk #4 succeeded at 612 (offset -19 lines).
Hunk #5 succeeded at 714 with fuzz 1 (offset -19 lines).
2 out of 5 hunks FAILED
checking file kernel/time/tick-common.c
Hunk #1 succeeded at 73 with fuzz 1 (offset 1 line).
checking file kernel/time/tick-sched.c
Hunk #1 FAILED at 137.
1 out of 1 hunk FAILED
checking file kernel/timer.c
Hunk #1 succeeded at 1273 (offset -87 lines).
checking file kernel/trace/Kconfig
Hunk #1 succeeded at 389 with fuzz 1 (offset -30 lines).
checking file kernel/trace/ftrace.c
Hunk #1 succeeded at 29 (offset -3 lines).
Hunk #2 FAILED at 238.
Hunk #3 succeeded at 1157 (offset -807 lines).
Hunk #4 FAILED at 1985.
Hunk #5 FAILED at 3909.
Hunk #6 succeeded at 2809 (offset -1221 lines).
3 out of 6 hunks FAILED
checking file kernel/trace/trace.c
Hunk #1 FAILED at 1649.
Hunk #2 FAILED at 1663.
Hunk #3 FAILED at 1681.
3 out of 3 hunks FAILED
checking file kernel/trace/trace_clock.c
checking file kernel/trace/trace_functions.c
Hunk #1 succeeded at 91 (offset -10 lines).
Hunk #2 succeeded at 102 (offset -10 lines).
Hunk #3 succeeded at 122 (offset -11 lines).
Hunk #4 succeeded at 142 (offset -11 lines).
checking file kernel/trace/trace_functions_graph.c
Hunk #1 succeeded at 237 (offset -17 lines).
Hunk #2 succeeded at 249 (offset -17 lines).
Hunk #3 succeeded at 322 (offset -17 lines).
Hunk #4 succeeded at 331 (offset -17 lines).
checking file lib/Kconfig.debug
Hunk #1 succeeded at 136 with fuzz 2 (offset -20 lines).
checking file lib/atomic64.c
Hunk #1 FAILED at 29.
Hunk #2 FAILED at 49.
Hunk #3 FAILED at 62.
Hunk #4 FAILED at 73.
Hunk #5 FAILED at 84.
Hunk #6 FAILED at 97.
Hunk #7 FAILED at 108.
Hunk #8 FAILED at 121.
Hunk #9 FAILED at 136.
Hunk #10 FAILED at 151.
Hunk #11 FAILED at 165.
11 out of 11 hunks FAILED
checking file lib/bust_spinlocks.c
checking file lib/ioremap.c
checking file lib/smp_processor_id.c
checking file mm/Kconfig
Hunk #1 FAILED at 354.
1 out of 1 hunk FAILED
checking file mm/memory.c
Hunk #1 succeeded at 647 (offset -173 lines).
Hunk #2 succeeded at 681 (offset -173 lines).
Hunk #3 succeeded at 725 (offset -182 lines).
Hunk #4 succeeded at 777 (offset -182 lines).
Hunk #5 succeeded at 820 (offset -182 lines).
Hunk #6 FAILED at 2603.
Hunk #7 succeeded at 3867 (offset -493 lines).
1 out of 7 hunks FAILED
checking file mm/mlock.c
Hunk #1 succeeded at 614 (offset -3 lines).
checking file mm/mmap.c
Hunk #1 succeeded at 38 (offset -2 lines).
Hunk #2 succeeded at 2193 (offset -363 lines).
checking file mm/mmu_context.c
checking file mm/mprotect.c
Hunk #1 FAILED at 228.
1 out of 1 hunk FAILED
checking file mm/vmalloc.c
prepare-kernel.sh: Unable to patch kernel 2.6.38.8 with
ipipe-core-3.8.13-x86-4.patch
