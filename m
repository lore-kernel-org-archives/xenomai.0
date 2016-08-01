Date: Mon, 1 Aug 2016 13:29:46 +0200
From: Henning Schild <henning.schild@siemens.com>
Message-ID: <20160801132946.368f30eb@md1em3qc>
In-Reply-To: <20160709132949.GA22236@hermes.click-hack.org>
References: <20160709132949.GA22236@hermes.click-hack.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [Announce] Xenomai 2.6.5
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Xenomai <xenomai@xenomai.org>

Hey Gilles,

i just checked out the new release, which came as a surprise. Thanks
for publishing that!

Some of the patches prepare for kernel 4.0+ but one specifically makes
sure the combination 4.0+ and 2.6.5 wont work.

Am Sat, 9 Jul 2016 15:29:49 +0200
schrieb Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>:

...
>       hal/x86: forbid compilation with Linux 4.0+
...

Could you please provide details on how the FPU support is broken. I am
successfully using xenomai 2.6 with 4.1.18 for some time now. I am not
sure whether the applications on top use the FPU and if so, if there
are multiple FPU-users per core.

Henning

>       switchtest: clarify the mode switch
>       x86/fptest: add missing asm constraints
>       switchtest: align kernel-space fpu register values
>       posix/mutex,cond: allow static initializer
>       doc: adapt to different installations of asciidoc and doxygen
>       doc: fix generate-doc script after removal of docbook
> documentation posix/clock: remove documentation of internal function
>       doc/sched: move sched documentation under nucleus section
>       bump version number and bootstrap
>       hal/arm: update patches
>       hal/blackfin: update I-pipe patches
>       hal/powerpc: update I-pipe patches
>       hal/x86: update I-pipe patches
>       doc: regenerate
> 
> Jeffrey Melville (2):
>       posix/doc: Fix sched_get_priority(min|max) doc
>       posix: fix pthread_mutex_timedlock for recursive mutexes.
> 
> Jorge Ramirez-Ortiz (2):
>       drivers/analogy: fix detach logic
>       drivers/analogy: remove unnecessary spinlock
> 
> Matthew Lindner (1):
>       drivers/can: Properly initialize bittime
> 
> Philippe Gerum (14):
>       native: fix user-space interrupt syscalls
>       hal/arm: add specific calibration value for imx6q
>       can/flexcan: fixup for kernel release >= 3.11
>       arm/hal: silence C89 warning
>       nucleus/pipe: care for spurious wakeups waiting for events
>       nucleus: add default calibration value for imx7
>       nucleus: fix calibration return for imx7
>       nucleus/pod: fix missed rescheduling in SMP
>       rtipc/bufp: fix wrong TX timeout
>       hal/generic: add backward wrappers for legacy cpu mask ops
>       scripts/prepare-kernel: allow building over 4.x kernel series
>       ksrc, include: cope with introduction of user_msghdr
>       testsuite/xeno-test-run: requesting /bin/sh is enough
>       cobalt/x86: fix missing early clobber in asm
> 
> Stefan Roese (1):
>       hal/arm: Add Zynq v3.14.17 patches
> 


