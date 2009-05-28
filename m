From: Andreas Glatz <andreasglatz@domain.hid>
In-Reply-To: <1243528798.22173.3.camel@domain.hid>
References: <1243526358.898.21.camel@domain.hid>
	<1243528798.22173.3.camel@domain.hid>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 28 May 2009 14:23:07 -0400
Message-Id: <1243534987.898.44.camel@domain.hid>
Mime-Version: 1.0
Subject: Re: [Xenomai-help] Running out of stack memory in kernel-space
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>, xenomai@xenomai.org

On Thu, 2009-05-28 at 18:39 +0200, Philippe Gerum wrote:
> On Thu, 2009-05-28 at 11:59 -0400, Andreas Glatz wrote:
> > Hi,
> > 
> > We have to start 40+ Xenomai tasks in kernel space.
> > We want to allocate at least 4kbyte of stack memory
> > for each of them. So we need the stack heap size 
> > to be more than 160kbyte. 
> > 
> > In the documentation it says that the total 
> > stack heap size cannot be more than 128kbyte
> > (the limit of kmalloc).
> 
> Could you point me at that doc? TIA,
> 
> > 
> > Now my idea is to modify the Xenomai code to have 
> > more than one stack heaps. So when I'm running out
> > of space in one heap I can switch to the next heap...
> > 
> > Is there an easier way to increase the max. stack heap size?
> > 
> 
> See CONFIG_XENO_OPT_SYS_STACKPOOLSZ, nucleus configuration menu.

I found this in kernel/xenomai/nucleus/Kconfig :

config XENO_OPT_SYS_STACKPOOLSZ
        depends on XENO_GENERIC_STACKPOOL
    int "Size of the private stack pool (Kb)"
    default 32
    range 0 128
    help

    On this architecture, kernel-based Xenomai threads get the
    stack space they need from a private memory pool.  If you
    don't start any kernel-based thread (i.e. no RTDM driver
    thread, and no real-time task created from an application
    embodied into a kernel module), you may leave a zero value for
    this option. The size is expressed in Kilobytes.


And if you follow the CONFIG_XENO_OPT_SYS_STACKPOOLSZ macro 
you eventually end up at this comment in kernel/xenomai/nucleus/pod.c :

    /*
     * We have to differentiate the system heap memory from the
     * pool the kernel thread stacks will be obtained from,
     * because on some architectures, vmalloc memory may not be
     * accessed while running in physical addressing mode
     * (e.g. exception trampoline code on powerpc with standard
     * MMU support - CONFIG_PPC_STD_MMU). Meanwhile, since we want
     * to allow the system heap to be larger than 128Kb in
     * contiguous memory, we can't restrict to using kmalloc()
     * memory for it either.  Therefore, we manage a private stack
     * pool for kernel-based threads which will be populated with
     * the kind of memory the underlying arch requires, still
     * allowing the system heap to rely on a vmalloc'ed segment.
     */
    heapaddr = xnarch_alloc_stack_mem(CONFIG_XENO_OPT_SYS_STACKPOOLSZ *
1024);



Andreas


