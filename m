MIME-Version: 1.0
Date: Mon, 23 Sep 2013 23:52:59 -0400
Message-ID: <CAK4EZFSLBBOs174xP+JAsqgJgG-MJ5UxMsj_FD5Pzjh1BHz7gw@mail.gmail.com>
From: Adam Vaughan <vaughana@umich.edu>
Content-Type: text/plain; charset=ISO-8859-1
Subject: [Xenomai] Raspberry Pi patch issue?
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

I'm trying to build with the most recent xenomai-head in git for the
Raspberry Pi, and I'm encountering an issue (see below) when I
try to run prepare-kernel.sh .  I'm very new to this whole process
(so it definitely could be user error), but it would seem that
there's a problem with the patch.

Any ideas?

-Adam

P.S.  Thank you for putting together this great project!

===================================================
// Here are the relevant references I followed:
===================================================

The original email http://www.xenomai.org/pipermail/xenomai
/2013-September/029172.html says:
    Checkout kernel sources from git://github.com/raspberrypi/linux.git
    and use the rpi-3.8.y branch - d996a1b is the SHA-1 hash used, but
    later revisions should work.

The readme xenomai-head/ksrc/arch/arm/patches/README says:
    ...
    70 ---- Raspberry Pi
    71
    72 From [5]:
    73 1- Checkout the "rpi-3.8.y" branch in the repository [4]
    74 2- Apply raspberry/ipipe-core-3.8.13-raspberry-pre.patch
    75 3- Apply ipipe-core-3.8.13-arm patch
    76 2- apply raspberry/ipipe-core-3.8.13-raspberry-post.patch
    77 3- you can resume to generic installation instructions.
    ...
    93 [4] git://github.com/raspberrypi/linux.git
    94 [5] http://www.xenomai.org/pipermail/xenomai
    /2013-September/029172.html
    ...

===================================================
// Here are the steps I took:
===================================================

Xenomai-RPi $ git clone -b rpi-3.8.y git://github.com/raspberrypi/linux.git
Xenomai-RPi $ cd linux
Xenomai-RPi/linux $ git checkout d996a1b
Xenomai-RPi/linux $ patch -p1 < ../xenomai-head/ksrc/arch/arm/patches/\
raspberry/ipipe-core-3.8.13-raspberry-pre.patch

    patching file arch/arm/include/asm/mmu.h
    patching file arch/arm/include/asm/mmu_context.h
    patching file arch/arm/mach-omap2/io.c
    patching file arch/arm/mm/context.c
    patching file fs/proc/array.c
    patching file include/linux/sched.h
    patching file include/linux/spinlock_up.h
    patching file kernel/trace/ftrace.c

Xenomai-RPi/linux $ ../xenomai-head/scripts/./prepare-kernel.sh \
--linux=./ --arch=arm \
--adeos=../xenomai-head/ksrc/arch/arm/patches/ipipe-core-3.8.13-arm-1.patch

    patching file arch/arm/Kconfig
    ...
    Hunk #1 FAILED at 7.
    1 out of 1 hunk FAILED -- saving rejects to file
    arch/arm/include/asm/mmu.h.rej
    patching file arch/arm/include/asm/mmu_context.h
    Hunk #1 FAILED at 19.
    1 out of 4 hunks FAILED -- saving rejects to file
    arch/arm/include/asm/mmu_context.h.rej
    ...
    Hunk #2 FAILED at 470.
    Hunk #3 FAILED at 508.
    2 out of 3 hunks FAILED -- saving rejects to file
    arch/arm/mach-omap2/io.c.rej
    ...
    Hunk #2 FAILED at 181.
    Hunk #3 succeeded at 200 (offset -1 lines).
    Hunk #4 FAILED at 218.
    2 out of 4 hunks FAILED -- saving rejects to file
    arch/arm/mm/context.c.rej
    ...
    Hunk #1 FAILED at 144.
    1 out of 1 hunk FAILED -- saving rejects to file fs/proc/array.c.rej
    ...
    patching file include/linux/sched.h
    Hunk #2 FAILED at 165.
    Hunk #3 succeeded at 279 (offset -1 lines).
    Hunk #4 succeeded at 425 (offset -1 lines).
    Hunk #5 succeeded at 1549 (offset -1 lines).
    Hunk #6 succeeded at 1844 (offset -1 lines).
    Hunk #7 succeeded at 2506 (offset -1 lines).
    Hunk #8 succeeded at 2539 (offset -1 lines).
    1 out of 8 hunks FAILED -- saving rejects to file
    include/linux/sched.h.rej
    patching file include/linux/spinlock.h
    patching file include/linux/spinlock_api_smp.h
    patching file include/linux/spinlock_up.h
    Hunk #1 FAILED at 58.
    1 out of 2 hunks FAILED -- saving rejects to file
    include/linux/spinlock_up.h.rej
    ...
    prepare-kernel.sh: Unable to patch kernel 3.8.13 with
    ipipe-core-3.8.13-arm-1.patch.
