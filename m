Date: Tue, 19 Apr 2016 21:30:06 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20160419193006.GG29711@hermes.click-hack.org>
References: <57155DFC.9000606@sigmatek.at>
 <20160419191052.GE29711@hermes.click-hack.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160419191052.GE29711@hermes.click-hack.org>
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

On Tue, Apr 19, 2016 at 09:10:52PM +0200, Gilles Chanteperdrix wrote:
> On Tue, Apr 19, 2016 at 12:21:48AM +0200, Johann Obermayr wrote:
> > Hello,
> > 
> > is there a way to handle a stack overflow with a xenomai  rt_task ?
> > 
> > this example work for a standard linux
> 
> This example does not handle stack overflows. It handles the SIGSEGV
> signal, which may happen in case of stack overflow or for many other
> reasons. In order to handle properly a stack overflow, you would
> have to:
> - use the SA_SIGINFO flag and setup an sa_sigaction handler instead
> of sa_handler with additional arguments
> - in the handler, use the additional arguments to extract the fault
> address and architecture specific stack pointer and check that the
> fault address is "near" the stack pointer (and in fact it may not be
> at all)
> - or walk /proc/self/maps to find the mapping where the fault
> address is and check if it is "near" a thread stack.
> - or check that the fault program counter is an operation involving
> a store or read relative to the stack pointer.
> 
> But I do not think there is a reliable way to detect stack
> overflows. It is even possible to overflow the stack so much that
> the code appears to work by writing to another thread stack (if the
> overflow length is larger than the glibc guard size).
> 
> > #define _XOPEN_SOURCE 700
> > #include <stdio.h>
> > #include <signal.h>
> > #include <unistd.h>
> > void handler(int sig)
> > {
> >      printf("stack overflow: %d\n", sig);
> >      _exit(1);
> > }
> 
> Also, using printf in a signal handler is bad. printf is not async
> signal safe.

And on my platform at least, SIGSTKSZ is something like 8192 or
16384 which may be too small for a printf, so printf could cause a
stack overflow (depending on the length of the printed string).

-- 
					    Gilles.
https://click-hack.org

