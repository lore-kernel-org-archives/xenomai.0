MIME-Version: 1.0
From: Andy Tannenbaum <trb@bioniklabs.com>
Date: Thu, 19 Nov 2020 15:34:31 -0500
Message-ID: <CAHcYe6mzT2Tu9bWz14Fa8nGGb9ZAoqJ+XPZQf5RoHDduVLMWSQ@mail.gmail.com>
Subject: error compiling patched 5.4.77 Linux kernel on x86
Content-Type: text/plain; charset="UTF-8"
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

I am having trouble building a kernel with the new
ipipe-core-5.4.77-x86-2.patch.

Before this, I am successfully running Xenomai 3.1 and Linux 4.19 cip24:on x86
https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/snapshot/linux-cip-4.19.114-cip24.tar.gz

I am trying to upgrade to Linux 5.4 with the recent ipipe patch:

https://cdn.kernel.org/pub/linux/kernel/v5.x/linux-5.4.77.tar.xz
https://xenomai.org/downloads/ipipe/v5.x/x86/ipipe-core-5.4.77-x86-2.patch

I was able to apply the new ipipe patch with Xenomai 3.1, but my
compile failed with an args mismatch in
xenomai/thread.c, calling switch_fpu_finish()
I see that the internal.h definition is different from the thread.c code.
(compile error output below)

This was after I turned off the suggested list of Linux kernel .config
options like ACPI_PROCESSOR, CPU_FREQ, etc.
Please advise.
Should I post my kernel .config file?

-Andy

<<<<

  CC      arch/x86/entry/vdso/vdso32/vclock_gettime.o
  CC [M]  arch/x86/crypto/aesni-intel_glue.o
arch/x86/xenomai/thread.c: In function 'xnarch_leave_root':
arch/x86/xenomai/thread.c:475:2: error: too many arguments to function
'switch_fpu_finish'
  475 |  switch_fpu_finish(&current->thread.fpu, smp_processor_id());
      |  ^~~~~~~~~~~~~~~~~
In file included from arch/x86/xenomai/include/asm/xenomai/wrappers.h:44,
                 from include/xenomai/cobalt/kernel/timer.h:28,
                 from include/xenomai/cobalt/kernel/thread.h:27,
                 from arch/x86/xenomai/thread.c:25:
./arch/x86/include/asm/fpu/internal.h:594:20: note: declared here
  594 | static inline void switch_fpu_finish(struct fpu *new_fpu)
      |                    ^~~~~~~~~~~~~~~~~
make[1]: *** [scripts/Makefile.build:266: arch/x86/xenomai/thread.o] Error 1
make: *** [Makefile:1729: arch/x86/xenomai] Error 2
make: *** Waiting for unfinished jobs....
  AS [M]  arch/x86/crypto/aesni-intel_avx-x86_64.o
  CC      arch/x86/events/amd/core.o
  AS      arch/x86/entry/vdso/vdso32/note.o
...

>>>>

