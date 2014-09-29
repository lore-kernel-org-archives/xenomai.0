Message-ID: <5429CE00.9020208@xenomai.org>
Date: Mon, 29 Sep 2014 23:24:16 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <1CDD098F4EDCFE4790DD5E4B0D5FFC5A01CECAF9EF@exchmbx1.int.pason.com>
In-Reply-To: <1CDD098F4EDCFE4790DD5E4B0D5FFC5A01CECAF9EF@exchmbx1.int.pason.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Xenomai 2.6 Kernel Panic Caused by IO Permissions
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Brian Eley <Brian.Eley@pason.com>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 09/29/2014 10:57 PM, Brian Eley wrote:
> Hi All,
> 
> I've been trying out Xenomai 2.6 for several weeks for use in an
> embedded system. Xenomai has been working great, but I can make it
> crash (Kernel Panic) in a repeatable way by starting and stopping
> processes that use IO Permissions (for directly accessing IO ports
> from user space). Interestingly, the process with IO permissions
> doesn't need to use Xenomai to cause the panic.
> 
> I believe I have found the root cause, and I have come up with a
> potential fix for the issue, but because I am an embedded systems
> designer with very little kernel programming experience, I would
> really like to leave it to the Xenomai team to decide on and
> implement a proper fix.
> 
> Following is a description of my setup along with crash dumps,
> instructions for reproducing, my analysis of the crash, and a patch I
> used to fix the problem on my test system.
> 
> Hardware platform: - COM express based system with quad-core Intel
> Atom E3845 (BayTrail system-on-chip) - Also reproduced on desktop PC
> with dual-core Intel Pentium D (Celeron) processor
> 
> Xenomai Config - Linux 3.14.17, 64-bit, with corresponding IPipe
> patch and latest Xenomai development updates (commit
> 85bfdeda7176cf3233aab57848e5a136e2875e64) - Xenomai configured with
>> scripts/prepare-kernel.sh --arch=x86 \
> --linux=/home/beley/sandbox/linux-3.14.17 \ 
> --adeos=/home/beley/sandbox/ipipe-core-3.14.17-x86-2.patch - Also
> produced with Linux 3.10.32, 64-bit, with corresponding IPipe patch
> and Xenomai 2.6.3 release
> 
> I am providing detailed information for the Linux 3.14.17 build 
> Attachments: - kernel command line args - kernel .config file - dump
> showing kernel panic with 3.14.17 kernel - dump showing kernel panic
> with 3.10.32 kernel (because the same issue is highlighted with less
> clutter) - patch that fixed the issue on my test systems - a trivial
> program using a fast periodic timer to help trigger the crash - a
> trivial program that requests IO permissions in order to demonstrate
> the problem - a shell script to run the IO program to demonstrate the
> crash - a Makefile to build the test programs
> 
> To reproduce: - Use the attached Makefile to compile the two test
> programs - fastPeriodic is a trivial native Xenomai program that uses
> one real-time thread with a fast periodic timer - ioBreakKernel is a
> trivial program that requests IO permissions, then terminates
> (without doing IO) - Run fastPeriodic - Run ioBugPanic.sh as root.
> It will quickly run many instances of ioBreakKernel - Wait for the
> kernel to panic. My test systems crashes in under 10 seconds.
> 
> My understanding of the problem from the console output and code
> tracing: - CPU #0 is running a process with IO permissions. - This
> process begins shutting down - It calls exit_thread() in
> arch/x86/kernel/process.c.  This function normally uses get_cpu() to
>  disable pre-emption, but pre-emption is still performed under
> Xenomai. - exit_thread() sets the thread_struct  io_bitmap_ptr =
> NULL - exit_thread() hasn't yet cleared the TIF_IO_BITMAP flag - A
> timer interrupt pre-empts this this thread. - Later, when we try to
> switch back to this thread,  __switch_to_xtra() is called (also in
> arch/x86/kernel/process.c). It sees that the thread's TIF_IO_BITMAP
> flag is still set, so it tries to memcpy() the the IO bitmap from
> io_bitmap_ptr.  But this pointer has been set to NULL. - Kernel
> panics - CPUs 1, 2, & 3 get stuck trying to access the spin-lock
> because CPU 0 died
> 
> One possible fix may be to have exit_thread() clear the TIF_IO_BITMAP
> flag before setting the bitmap pointer to NULL. The provided patch
> accomplishes this. I have verified that this fixes the problem on my
> system, but I am unsure whether additional steps are needed to make
> this SMP safe. I'm also unsure whether the fix belongs in Xenomai,
> IPipe, or the vanilla kernel. The order of operations in the kernel
> is what ultimately lead to the panic, but arguably the code was
> correct since pre-emption was disabled.

This looks to me like an I-pipe bug. I would protect the whole section
from preemption by Xenomai by using __ipipe_get_cpu/__ipipe_put_cpu.

-- 
                                                                Gilles.

