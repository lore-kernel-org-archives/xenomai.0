Message-ID: <51061D27.3010004@zultron.com>
Date: Mon, 28 Jan 2013 00:39:35 -0600
From: John Morris <john@zultron.com>
MIME-Version: 1.0
References: <5102FC88.1070000@xenomai.org>
In-Reply-To: <5102FC88.1070000@xenomai.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [Announce] Xenomai 2.6.2.1
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Xenomai <xenomai@xenomai.org>



On 01/25/2013 03:43 PM, Gilles Chanteperdrix wrote:
> Hi,
> 
> After "a few" issues in the 2.6.2 release, please find Xenomai 2.6.2.1 at 
> the following address:
> http://download.gna.org/xenomai/stable/xenomai-2.6.2.1.tar.bz2

Congratulations Gilles, Jan, Philippe, and other contributors!

I have built Ubuntu 12.04 and EL6 packages for xenomai and kernel 3.5.7
based on the release tarball, and have already had news of successful
tests.  (Specifics in another thread to avoid clutter.)

	John


> 
> The following issues were fixed in Xenomai codebase:
> - debian packages not building;
> - warnings triggered by the /proc code;
> - failure of mutex "trylock" services to properly cause threads running 
> with the SCHED_OTHER policy to stay in primary mode;
> - compilation error with stdio.h in C++
> - deadlocks with scheduler lock modifications introduced in 2.6.2
> - newly mapped regions with rtdm_iomap_to_user causing faults
> - rthal_supported_cpus resulting in more cpus selected than specified
> 
> The latest Linux kernel supported was updated from 3.5.3 to 3.5.7, 
> also fixing the following issues:
> - zero page corruption
> - I-pipe warning when registering an IRQ handler
> - migrations in IRQ handlers
> - transparent huge pages broken with I-pipe kernel
> - disappeared warning about AMD workaround for C1E state
> 
> Thanks all for testing, reporting bugs, contributing documentation, 
> submitting patches, which helped making this release (and the 
> previous).
> 
> Regards.
> 
> Shortlog follows.
> Jan Kiszka (9):
>       can: Flexcan driver depends on open firmware
>       nucleus: Fix iteration over IRQs for /proc/xenomai/stat output
>       intr: Fix output of timer interrupts in /proc/xenomai/{irq,stat}
>       testsuite: Enhance mprotect regression test with r/w after access enable
>       posix/native: Increment resource counter on successful mutex_trylock
>       nucleus: Avoid bool type to please 2.4 kernels
>       nucleus: Fix migration race in schedule_linux_call
>       nucleus: Move XNINLOCK to xnsched::lflags
>       nucleus: Fix xnpod_schedule with nucleus debugging enabled
> 
> Mariusz Janiak (1):
>       doc: add doc about C1E option with AMD processors
> 
> Paul Corner (1):
>       doc: fix typos
> 
> Philippe Gerum (6):
>       x86: upgrade I-pipe support to 3.2.21 core release 3
>       x86/include: fix dist rule
>       x86: upgrade I-pipe support
>       arm: upgrade I-pipe support
>       blackfin: upgrade I-pipe support
>       powerpc: upgrade I-pipe support
> 
> Wolfgang Grandegger (1):
>       rtdm_iomap_to_user: fix caching and page fault issues
> 
> Wolfgang Mauerer (1):
>       hal: Fix cpu bitmap handling
> 
> Gilles Chanteperdrix (14):
>       debian: adapt to latest I-pipe core patches
>       posix: include stddef.h in stdio.h to get size_t defined
>       x86/include: add missing Makefile
>       build: bootstrap
>       debian: remove now useless configure options
>       arm/hal: move detection of SMP with unsupported architectures
>       doc: fix line breaks in README.INSTALL footnotes breaking html TOC
>       doc: cosmetic fix
>       doc: document the default values for configure options
>       doc: do not rely on the default latency path, use the xeno wrapper instead
>       posix/native: do not increment resource counter for recursive mutexes
>       arm: take more architectures into account
>       build: bump version number and bootstrap
>       doc: regenerate
> 
> 


