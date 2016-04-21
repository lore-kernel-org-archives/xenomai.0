Date: Thu, 21 Apr 2016 09:07:49 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20160421070749.GB1780@hermes.click-hack.org>
References: <57155DFC.9000606@sigmatek.at>
 <20160419191052.GE29711@hermes.click-hack.org>
 <20160419193006.GG29711@hermes.click-hack.org>
 <5717554B.1090905@sigmatek.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5717554B.1090905@sigmatek.at>
Subject: Re: [Xenomai] rt task & stack overflow
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Johann Obermayr <johann.obermayr@sigmatek.at>
Cc: xenomai@xenomai.org

On Wed, Apr 20, 2016 at 12:09:15PM +0200, Johann Obermayr wrote:
> Am 19.04.2016 um 21:30 schrieb Gilles Chanteperdrix:
> > On Tue, Apr 19, 2016 at 09:10:52PM +0200, Gilles Chanteperdrix wrote:
> >> On Tue, Apr 19, 2016 at 12:21:48AM +0200, Johann Obermayr wrote:
> >>> Hello,
> >>>
> >>> is there a way to handle a stack overflow with a xenomai  rt_task ?
> >>>
> >>> this example work for a standard linux
> >> This example does not handle stack overflows. It handles the SIGSEGV
> >> signal, which may happen in case of stack overflow or for many other
> >> reasons. In order to handle properly a stack overflow, you would
> >> have to:
> >> - use the SA_SIGINFO flag and setup an sa_sigaction handler instead
> >> of sa_handler with additional arguments
> >> - in the handler, use the additional arguments to extract the fault
> >> address and architecture specific stack pointer and check that the
> >> fault address is "near" the stack pointer (and in fact it may not be
> >> at all)
> >> - or walk /proc/self/maps to find the mapping where the fault
> >> address is and check if it is "near" a thread stack.
> >> - or check that the fault program counter is an operation involving
> >> a store or read relative to the stack pointer.
> >>
> >> But I do not think there is a reliable way to detect stack
> >> overflows. It is even possible to overflow the stack so much that
> >> the code appears to work by writing to another thread stack (if the
> >> overflow length is larger than the glibc guard size).
> >>
> >>> #define _XOPEN_SOURCE 700
> >>> #include <stdio.h>
> >>> #include <signal.h>
> >>> #include <unistd.h>
> >>> void handler(int sig)
> >>> {
> >>>       printf("stack overflow: %d\n", sig);
> >>>       _exit(1);
> >>> }
> >> Also, using printf in a signal handler is bad. printf is not async
> >> signal safe.
> > And on my platform at least, SIGSTKSZ is something like 8192 or
> > 16384 which may be too small for a printf, so printf could cause a
> > stack overflow (depending on the length of the printed string).
> >
> Hello,
> 
> Thanks you for answer.
> 
> i have refactoring the example.
> Here is the source
> -------------------------------------------------- begin source
> #define __USE_BSD
> 
> #include <stdio.h>
> #include <malloc.h>
> #include <memory.h>
> #include <signal.h>
> #include <unistd.h>
> #include <sys/types.h>
> #include <sys/mman.h> //mloockall
> 
> #ifdef USE_XENOMAI
> #include <native/task.h>
> #endif
> 
> #define SIGSTACKSIZE    32*1024
> 
> void dohandler(const char *name, int sig, siginfo_t *info, void *ptr)
> {
>      char buf[256];
> 
>      int len = sprintf(buf, "%s: signal_handler: %d\n", name, sig);
>      write(STDOUT_FILENO, buf, len) ;
>      _exit(1);
> }

Your signal handler is still wrong: it assumes that any segmentation
fault is due to a stack overflow, which is far from being true.

Have you tried replacing the call to _exit with something that
would not exit from an alternate stack. Like longjmp in your test.

>
> for a standard linux thread the function sigaltstack will work correct.
> But not with xenomai (rt_task_shadow)
> 
> we use kernel 3.0.53 & xenomai 2.6.2.1.

I had not noticed that, do you reproduce the issue with Xenomai
3.0.2 or at least 2.6.4 (or the tip of Xenomai 2.6 git)?

Also, you do not tell us on what exact processor you get this issue.
This might be relevant.

-- 
					    Gilles.
https://click-hack.org

