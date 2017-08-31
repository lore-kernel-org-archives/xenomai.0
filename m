References: <CAF06wtj2YM_Ue0Hzw5+LChWtve_3ta390aAu0CixsCQd+12bwg@mail.gmail.com>
 <CAO460__o2krnbVrxCtkh3dT8Li3yUnyxm3N7T+tonPsZdq_1Gw@mail.gmail.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <fa961a8b-01b6-6268-6ba4-5747c3c78513@xenomai.org>
Date: Thu, 31 Aug 2017 17:35:25 +0200
MIME-Version: 1.0
In-Reply-To: <CAO460__o2krnbVrxCtkh3dT8Li3yUnyxm3N7T+tonPsZdq_1Gw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] Two Minor Issues with Patches
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Stephen D. Cohen" <steve@uscohens.com>, xenomai@xenomai.org

On 08/30/2017 04:38 AM, Stephen D. Cohen wrote:
> Dear Xenomai Team,
> 
> I have run into a couple of issues recently and have finally gotten around
> to reporting them with my associated patches to correct them. These may be
> of interest to others so I am posting them to the list. I am pretty sure
> this is the correct way to submit them anyway.
> 
> The first issue is with debug backtrace handler and slackspot. The
> backtrace handler in the kernel code is removing the virtual-memory offset
> from all backtrace PCs regardless of origin. This is not appropriate for
> executable files, and so addr2line (and thus slackspot) cannot report the
> line numbers for these spots.

Ack. This bug was introduced some time before Xenomai 3.0-rc1 was
released, after Linux mainline dropped the VM_EXECUTABLE flag [1], which
Cobalt used to rely upon for identifying an exec mapping.

The initial code that worked (originally on ppc32) read as:

		pc = backtrace[n];

		vma = find_vma(mm, pc);
		if (vma == NULL)
			continue;

		if (!(vma->vm_flags & VM_EXECUTABLE))
			pc -= vma->vm_start;

		spot.backtrace[depth].pc = pc;

It looks like the issue of replacing the initial check for execs was
left pending since then.

> 
> The simple solution is to check the backtrace section to see if it is from
> an executable file and act accordingly. Here is the patch:
> 
> ----- Start Patch -----
> --- a/xenomai-3.0.5/kernel/cobalt/debug.c
> +++ b/xenomai-3.0.5/kernel/cobalt/debug.c
> @@ -23,6 +23,7 @@
> #include <linux/mm.h>
> #include <linux/signal.h>
> #include <linux/vmalloc.h>
> +#include <linux/elf.h>
> #include <cobalt/kernel/sched.h>
> #include <cobalt/kernel/heap.h>
> #include <cobalt/kernel/clock.h>
> @@ -246,7 +247,11 @@
> if (vma == NULL)
> continue;
> 
> - spot.backtrace[depth].pc = pc - vma->vm_start;
> + if (!memcmp((u8 *)vma->vm_start, ELFMAG, SELFMAG) &&
> + ((struct elfhdr *)vma->vm_start)->e_type == ET_EXEC)
> + spot.backtrace[depth].pc = pc;
> + else
> + spot.backtrace[depth].pc = pc - vma->vm_start;
>

Although this would probably work with both ELF and ELF_FDPIC
(blackfin), maybe there is a better way to detect an exec mapping;
peeking at the vma contents for this purpose makes me nervous.

Maybe there is a way to relate MAP_EXECUTABLE - as passed to vm_mmap()
when called by the binfmt loaders - to the vmas, this needs to be
investigated.

> /\/\/\ Begin Patch /\/\/\
> --- a/xenomai-3.0.5/scripts/wrap-link.sh
> +++ b/xenomai-3.0.5/scripts/wrap-link.sh
> @@ -203,8 +203,13 @@
> done
> 
> if $stage2; then
> + if gcc --verbose 2>&1 | grep --quiet default-pie ; then
> + no_pie="-no-pie"
> + else
> + no_pie=""
> + fi
> $verbose && set -x
> - $dryrun $cc -o "$output.tmp" -Wl,-Ur -nostdlib $stage1_args
> + $dryrun $cc -o "$output.tmp" -Wl,-Ur $no_pie -nostdlib $stage1_args
> $dryrun $cc -o "$output" "$output.tmp" $stage2_args
> $dryrun rm -f $output.tmp
> else
> /\/\/\ End Patch /\/\/\
> 

We should move that to xeno-config*.in instead, as not everyone uses
wrap-link.sh. xeno-config would emit -no-pie, based on the detection
done in configure.ac, of a compiler enabling PIE by default.

IOW, configure.ac figures out whether $CC has default-pie, setting a
substitution variable which xeno-config*.in emits when dumping the CFLAGS.

> I hope these are helpful for others. Thanks for all the hard work on
> Xenomai.
> 

Thanks,

[1] commit e9714acf8c439688884234dcac2bfc38bb607d38
Author: Konstantin Khlebnikov <khlebnikov@openvz.org>
Date:   Mon Oct 8 16:28:54 2012 -0700

    mm: kill vma flag VM_EXECUTABLE and mm->num_exe_file_vmas
-- 
Philippe.

