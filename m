From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <22908039.1178707932628.JavaMail.ngmail@domain.hid>
References: <22908039.1178707932628.JavaMail.ngmail@domain.hid>
Content-Type: text/plain
Date: Wed, 09 May 2007 18:14:16 +0200
Message-Id: <1178727256.11688.35.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-help] Xenomai and futexes - Native API optimized
	for	user space only applications
Reply-To: rpm@xenomai.org
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "M. Koehrer" <mathias_koehrer@domain.hid>
Cc: xenomai@xenomai.org

On Wed, 2007-05-09 at 12:52 +0200, M. Koehrer wrote:
> Hi everybody,
> 
> I am using Xenomai for a high performance real time simulation system. 
> All of the simulation code is executed within user space. One application is running that consists
> of several Xenomai real time threads.
> For performance reasons I am always using the latest PC technology available (which is currently
> Pentium D or Core2Duo PCs, we are thinking even of using quad-core CPUs).
> There has to be a kind of thread synchronisation e.g. when accessing shared data.
> Hardware I/O is done via rtnet or via PCI I/O boards that work in user space aswell (PCI memory
> mapped into the user space).
> This is done e.g. by using semaphores, mutexes et.c
> I like the Xenomai-native skin as it provides a very clear API that is easy to use.
> However, for a user space only application it is a performance killer, that all API calls
> lead to a mode switch from user to kernel space. Each API call takes about 1-2 microseconds (us)
> on my PC which is really expensive.
> Especially when inter process communication is used to protect the access to shared data
> it is mostly the case that the calling thread does not have to wait. In this situation there is no
> need for a context switch. The API call did not lead to a rescheduling of the available tasks.
> And for this the required 1-2 us do really hurt.
> 
> Thus my question/proposal is if there is a plan to use a "variant" of the native API that is optimized for
> user space only applications. In this case e.g. futexes can be used. If there is a need to
> reschedule to another task it is fine to "invest" the 2us but it can be avoided mostly which should
> increase the overall performance dramatically.
> This would lead to a library where a big part of the functionality is handled directly in the library 
> (in user space). Currently the skin passes the (user space) API call via a Xenomai System call 
> to the kernel space to execute there the actual functionality.
> 
> Thanks for any feedback on this proposal.

Yes, this is the way to go. It's the kind of rework introduced by the
NPTL for the glibc, and there is no reason to pay the kernel/user space
transition when no contention exists on the synch object.

I'm not sure the cost is as much as 2 us, unless you don't use the
sysenter/sysexit protocol for syscalls Xenomai manages properly
(--enable-x86-sep). It seems you are going through the ancient 0x80
exception vector, but still, I agree that the point remains: no
contention should mean no transition to kernel.

We could not use futexes, because we don't want to depend on the vanilla
infrastructure, which would lead to unbounded latencies. The point is
about properly sharing a piece of data between both spaces for each
synch object, and have some user-space accessible atomic ops to operate
on them. That's the simplest part, the other, more complex one is to
invest the time needed to achieve this (for all archs that may run this
way, i.e. not all archs Xenomai supports do have atomic ops available
from user-space, but that's not the majority though).

> 
> Regards
> 
> Mathias
> 
> 
> 
> 
> 
-- 
Philippe.



