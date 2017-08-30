MIME-Version: 1.0
References: <CAF06wtj2YM_Ue0Hzw5+LChWtve_3ta390aAu0CixsCQd+12bwg@mail.gmail.com>
In-Reply-To: <CAF06wtj2YM_Ue0Hzw5+LChWtve_3ta390aAu0CixsCQd+12bwg@mail.gmail.com>
From: "Stephen D. Cohen" <steve@uscohens.com>
Date: Wed, 30 Aug 2017 02:38:34 +0000
Message-ID: <CAO460__o2krnbVrxCtkh3dT8Li3yUnyxm3N7T+tonPsZdq_1Gw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Xenomai] Two Minor Issues with Patches
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Dear Xenomai Team,

I have run into a couple of issues recently and have finally gotten around
to reporting them with my associated patches to correct them. These may be
of interest to others so I am posting them to the list. I am pretty sure
this is the correct way to submit them anyway.

The first issue is with debug backtrace handler and slackspot. The
backtrace handler in the kernel code is removing the virtual-memory offset
from all backtrace PCs regardless of origin. This is not appropriate for
executable files, and so addr2line (and thus slackspot) cannot report the
line numbers for these spots.

The simple solution is to check the backtrace section to see if it is from
an executable file and act accordingly. Here is the patch:

----- Start Patch -----
--- a/xenomai-3.0.5/kernel/cobalt/debug.c
+++ b/xenomai-3.0.5/kernel/cobalt/debug.c
@@ -23,6 +23,7 @@
#include <linux/mm.h>
#include <linux/signal.h>
#include <linux/vmalloc.h>
+#include <linux/elf.h>
#include <cobalt/kernel/sched.h>
#include <cobalt/kernel/heap.h>
#include <cobalt/kernel/clock.h>
@@ -246,7 +247,11 @@
if (vma == NULL)
continue;

- spot.backtrace[depth].pc = pc - vma->vm_start;
+ if (!memcmp((u8 *)vma->vm_start, ELFMAG, SELFMAG) &&
+ ((struct elfhdr *)vma->vm_start)->e_type == ET_EXEC)
+ spot.backtrace[depth].pc = pc;
+ else
+ spot.backtrace[depth].pc = pc - vma->vm_start;

/*
* Even in case we can't fetch the map name, we still
----- End Patch -----

One caveat - this issue does not appear to show up in the example on the
web page describing slackspot, and I am at a loss to explain how that can
be. Perhaps the ARM backtrace routines behave slightly differently and so
this is not an issue? I tried to investigate this on ARM but was unable to
make Xenomai on my Raspberry Pi produce ANY backtraces at all. It certainly
holds true for both 32 and 64-bit x86.

The other minor issue is the "-no-pie" problem that others have reported.
My investigation suggests that this can be resolved by simply having the
stage1 phase of wrap-link include the "-no-pie" flag. The following patch
handles that issue when necessary, without breaking PIE in general:

/\/\/\ Begin Patch /\/\/\
--- a/xenomai-3.0.5/scripts/wrap-link.sh
+++ b/xenomai-3.0.5/scripts/wrap-link.sh
@@ -203,8 +203,13 @@
done

if $stage2; then
+ if gcc --verbose 2>&1 | grep --quiet default-pie ; then
+ no_pie="-no-pie"
+ else
+ no_pie=""
+ fi
$verbose && set -x
- $dryrun $cc -o "$output.tmp" -Wl,-Ur -nostdlib $stage1_args
+ $dryrun $cc -o "$output.tmp" -Wl,-Ur $no_pie -nostdlib $stage1_args
$dryrun $cc -o "$output" "$output.tmp" $stage2_args
$dryrun rm -f $output.tmp
else
/\/\/\ End Patch /\/\/\

I hope these are helpful for others. Thanks for all the hard work on
Xenomai.

Warmest Regards,

Steve Cohen
