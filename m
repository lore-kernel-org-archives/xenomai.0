From: Alexis Berlemont <berlemont.hauw@domain.hid>
Date: Wed, 3 Sep 2008 01:48:05 +0200
References: <200808312323.29665.berlemont.hauw@domain.hid>
	<48BCF4D9.8030100@domain.hid>
In-Reply-To: <48BCF4D9.8030100@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200809030148.06130.berlemont.hauw@domain.hid>
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
To: xenomai-core <xenomai@xenomai.org>

Hi,

> > - Or do you expect a more complete solution like fuse or fusd ?
>
> There are a few tricky parts when you want a seamless driver API,
> allowing to test or even use RTDM drivers in userspace:
>
>  - IRQ handling (means: forwarding, acknowledging, sharing).
>    You won't be able to achieve 100% equivalent functionality here, of
>    course.


On that point I thought about some hidden dedicated task(s) / thread(s): 
either one task per interrupt or one task per CPU for all interrupt (the 
second alternative may seem better).

The issue is to be as close as possible from the functioning in kernel mode:
-> This task must work with the highest priority as an IRQ handler cannot be 
preempted (yet...).
-> The spinlock mechanism could be emulated thanks to an "interrupt" lock (to 
emulate irq masking and a common mutex. Thus, by taking the "interrupt" lock, 
any RT task can indirectly prevent the IRQ user-handler execution.

>  - Managing the driver context.
>    When in kernel space, driver code can run in RTDM tasks (that trivial
>    to port), in IRQ context (=> probably some carrier task then) or
>    caller context - and here the problem starts. Single-user drivers
>    could simply run as library within the context of the user, but for
>    shared drivers we need some framework that deals with accessing user
>    data which we could easily in kernel space, but not when the driver
>    has its own process or should run within multiple user space
>    contexts.

The driver code would be executed by a process but this driver context would 
be hidden behind the context of the application which uses the driver. 

Here are the cases, I have in my head:
-> one application uses one device managed by one kernel module (like misc 
device); => the simplest case: with one thread inside the driver 
user-process, we emulate the application context;
-> many applications uses the same device managed by one kernel module => if 
we are on a SMP config, we might need one thread per CPU-core inside the 
driver user-process;
-> many applications uses many devices managed by the the same kernel module 
(common char devices) => In this configuration, a driver thread must wait for 
commands coming many contexts; however, this issue could easily be handled by 
the kernel module devoted to redirect syscall.

Therefore I think such a development could be divided in two steps:
-> the first one would be the extension of a part of the RTDM API in user-mode 
(most of the functions located in drvlib.c)
-> the second one would be the syscall redirection. 

The second part can be implemented in two ways:
-> the RTDM kernel skin is extended;
-> an RTDM kernel driver is developed (this driver would handle ioctl coming 
from the user-driver (copy_from_user, register_device, wait_command, etc.) 
and the user-application (open, read, write, close).

Which one do you think is the best?

On my side, I started the first alternative (kernel skin extension) so as to 
check that my ideas could be translated in code lines (it is just a POC which 
does not work yet).

Alexis.

P.S.: I sent the first mail sunday night, I don't know why it took more than 
one day to reach its destination.


