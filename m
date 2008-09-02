Resent-To: xenomai-core <xenomai@xenomai.org>
Resent-Message-Id: <48BD2472.4030509@domain.hid>
Message-ID: <48BCF4D9.8030100@domain.hid>
Date: Tue, 02 Sep 2008 10:10:01 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <200808312323.29665.berlemont.hauw@domain.hid>
In-Reply-To: <200808312323.29665.berlemont.hauw@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] skin RTDM in user mode
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Alexis Berlemont <berlemont.hauw@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

Hi Alexis,

Alexis Berlemont wrote:
> Hi,
> 
> In ksrc/skins/rtdm/API.CHANGES text file, the TODO list indicates that someone 
> may be working on the development of the user-side RTDM skin (for user-space 
> drivers).
> 
> Is anyone working on that ?

Not that I know.

> 
> I was wondering what was to be done:
> 
> - Is it just the porting of the kernel RTDM API (rtdm_task_*, etc.) ?

Nope.

> - Or do you expect a more complete solution like fuse or fusd ? 

There are a few tricky parts when you want a seamless driver API,
allowing to test or even use RTDM drivers in userspace:

 - IRQ handling (means: forwarding, acknowledging, sharing).
   You won't be able to achieve 100% equivalent functionality here, of
   course.

 - Managing the driver context.
   When in kernel space, driver code can run in RTDM tasks (that trivial
   to port), in IRQ context (=> probably some carrier task then) or
   caller context - and here the problem starts. Single-user drivers
   could simply run as library within the context of the user, but for
   shared drivers we need some framework that deals with accessing user
   data which we could easily in kernel space, but not when the driver
   has its own process or should run within multiple user space
   contexts.

 - Providing a framework for required Linux kernel services (e.g. DMA
   handling - yet not even addressed for uio...).

 - <things I do not remember anymore>

> 
> The last few weeks, I was thinking on a complete solution which would allow to 
> compile and execute an RTDM driver seamlessly on both mode (user and kernel).
> 
> That would imply:
> - the porting of the kernel RTDM API on user mode;
> - the development of a specific layer so as to redirect the RTDM syscalls 
> (open, read, write, close, ioctl) to a user-space process. For that point, I 
> think there are two alternatives: either extending the RTDM skin API (with 
> hidden syscalls for the user-space driver to retrieve the syscalls to 
> execute) or developing a kernel RTDM driver + a library.
> - the development of an external library (or header) to implement the minimal 
> Linux API which is used in common RTDM drivers (like vmalloc, kmalloc, 
> ioremap). (And for PCI, USB, DMA, etc. API, ???)

USB does not belong into this list (we rather need an RTDM-based USB
stack for realtime use cases), but the rest is exactly the point.

> 
> Compared to fuse or fusd, which I consider as user-specific frameworks. The 
> main advantage of such a solution would be the ability to (nearly) seamlessly 
> execute the driver on both spaces. The main issue would be to keep in mind 
> the performance aspect (especially for rtdm_copy_*_user, on that point there 
> are many possibilities I began to investigate).

At least single-user drivers (which are only accessed by one process at
a time) should not suffer from too much systematical overhead. But I
would not focus too much on performance, because critical drivers belong
into the kernel anyway, but rather on seamless portability (=>
recompilation without modifications, except for the makefile). If you
were able to test the full functionality of some RTDM driver in user
space, at _lot_ would already be gained!

> 
> Do you consider such a work as interesting ?

Definitely, yes! I just postponed this long-planned topic due to shifted
priorities. Any contribution, even if just addressing parts of the
ultimate goal, would be highly appreciated!

Jan

-- 
Siemens AG, Corporate Technology, CT SE 2
Corporate Competence Center Embedded Linux


