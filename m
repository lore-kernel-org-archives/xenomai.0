References: <eac52e41-5114-8535-1a7a-58d6927a7743@xenomai.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <dee5845e-45a9-6837-24b5-61a2ff8cf74d@siemens.com>
Date: Mon, 1 Aug 2016 15:31:09 +0200
MIME-Version: 1.0
In-Reply-To: <eac52e41-5114-8535-1a7a-58d6927a7743@xenomai.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [RFC] Switchless RTDM calls from SCHED_WEAK threads
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>, "Xenomai@xenomai.org" <Xenomai@xenomai.org>

On 2016-07-10 11:47, Philippe Gerum wrote:
> 
> This RFC is a follow up to
> http://xenomai.org/pipermail/xenomai/2016-May/036253.html.
> 
> To sum up the issue, calling Cobalt's ioctl() implementation on a file
> descriptor pointing at a RTDM named device, or pointing at a regular
> character device, may create overhead for SCHED_WEAK threads, when/as
> the ioctl request should be processed from the ioctl_nrt handler. This
> is due to extra mode switches, illustrated as follows (Cobalt syscalls
> are enclosed by __RT(), glibc services by __STD()):
> 
> [Secondary mode]           <== mode switch ==>       [Primary mode]
> 
> app:__RT(ioctl(fd, ...))
>          |
> 	 +-----------------------------------------> driver:ioctl_rt
> 	                                                   |
>    	                                   returns -ENOSYS |
>    	                                                   |
> driver:ioctl_nrt <-----------------------------------------+
> 
> Since SCHED_WEAK threads normally run in the Linux domain, and Cobalt
> always starts probing the ioctl_rt() routine for handling the request,
> a useless double mode switch happens in those particular cases.
> 
> The rationale behind probing the ioctl_rt() handler first, is that
> SCHED_WEAK threads are supposed to wait for events from, or share
> non-critical resources with real-time Cobalt threads and/or devices,
> and that normally happens with the help of the Cobalt scheduler, which
> requires the caller to run in primary mode. In short, this is the
> runtime scenario Cobalt favors because this the reason for running
> SCHED_WEAK threads in the first place.
> 
> This leads to some clarification: SCHED_WEAK is not meant to run plain
> regular POSIX threads that don't interface with the real-time
> sub-system; for such use case, one should call the regular
> __STD(pthread_create()) service to create the thread, not libcobalt's
> __RT(pthread_create()). Such thread would be able to issue RTDM
> ioctl() calls as well, ending up into the driver's ioctl_nrt() handler
> directly.
> 
> Back to the issue, we have three options for fixing the overhead
> described above for threads that actually need to run in the
> SCHED_WEAK class:
> 
> 1- Cobalt could figure out whether the incoming file descriptor is
>   actually managed by RTDM, before switching to primary mode if so.
>   This way, regular file descriptors would be rejected early, before
>   any mode switch is attempted, and libcobalt could hand over the
>   request to the (g)libc in such an event. The ioctl request that has
>   to be processed from a plain Linux context could then be handled by
>   a simple chardev driver.
> 
> 2- We could allow the application to tell Cobalt that RTDM I/O calls
>   issued on a given file descriptor are primarily directed to the
>   non-rt handler in the driver. Typically, an open mode flag such as
>   "O_WEAK" could do the job; such flag would affect requests issued
>   from SCHED_WEAK or regular threads unconditionally, or from
>   real-time threads provided no rt handler is defined by the
>   driver. In other cases, it would be ignored. This way, we would not
>   allow the application to shoot itself in the foot by bypassing the
>   RT handler inadvertently.
> 
>   e.g.:
> 
>     fd = open(some_rtdm_device, O_RDWR | O_WEAK);
>     ret = ioctl(fd, SOMEDEV_RTIOC_FOO, &opt_arg);
> 
>   Pros: Applicable to all RTDM I/O requests (ioctl/read/write).
> 
>   Cons: Breaks the ABI with the introduction of the O_WEAK open flag.
>   Complex semantics, given that SCHED_WEAK threads may behave
>   differently than members of real-time scheduling classes for the
>   same ioctl request on the same file descriptor.  Leaves the decision
>   about the best mode to run a request implemented by a driver to the
>   application, which seems odd.
> 
> 3- We could introduce a special tag for composing the RTIOC code of an
>   ioctl request, that a driver would use to state the preference for
>   running the request in relaxed mode. The existing adaptative switch
>   (ENOSYS) would still be available for handling requests for which no
>   preference has been defined.
> 
>   e.g.
> 
>   #define _IOC_RELAX			15U
>   #define _IOWRX(type, nr, size)	_IOWR(type, nr | (1U << _IOC_RELAX), size)
> 
>   #define SOMEDEV_RTIOC_FOO		_IOWRX(RTDM_CLASS_BAR, 10, &some_arg)
> 
>   Pros: Semantics is easy to grasp: the decision about the best mode
>   to run any given request is left to the driver. It also implies the
>   best practice of assigning an exclusive handler to each ioctl
>   request, i.e. either _rt or _nrt, but not both.
> 
>   Cons: Breaks the ABI, by consuming a bit normally used to encode the
>   ioctl number for the tag, restricting the namespace to 2^15 codes.
>   Would not enable the mechanism for other RTDM I/O calls such as
>   read/write(_nrt).

If option 3 helps to get this feature upstream, and we can drop related
patches here, we could live with it.

> 
> An implementation of option #1 is available from wip/handover in the
> xenomai-3 repo. It is planned to merge these changes in 3.0.3, since
> there is no reason for such overhead to exist with non-RTDM file
> descriptors. Besides, it has no impact on the ABI, this is purely a
> kernel-based optimization.
> 
> Options #2 and #3, or any other approach should be discussed if there
> is interest in them. Also, as a corollary to option #3, I would be
> interested to hear about real-world use cases involving any of the
> read_nrt, write_nrt, recvmsg_nrt and sendmsg_nrt handlers of RTDM.
> 

I don't have any for those entry points, only for IOCTLs.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA ITP SES-DE
Corporate Competence Center Embedded Linux

