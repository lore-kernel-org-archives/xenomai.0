Date: Tue, 30 Jun 2015 11:10:18 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20150630091018.GC2038@hermes.click-hack.org>
References: <000a01d0b270$6c0e6b70$442b4250$@gmail.com>
 <20150629202243.GE10993@hermes.click-hack.org>
 <00c401d0b30b$6bc243d0$4346cb70$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00c401d0b30b$6bc243d0$4346cb70$@gmail.com>
Subject: Re: [Xenomai] R: Device drivers and networking stack (RTnet) on
 Xenomai 3
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Giorgio Buffa <giorgiobuffa.work@gmail.com>
Cc: xenomai@xenomai.org

On Tue, Jun 30, 2015 at 10:04:41AM +0200, Giorgio Buffa wrote:
> Hi Gilles,
> thank you for your reply!
> 
> > Your comprehension of why threads must remain in primary mode is flawed.
> > Low priority threads having to let high priority threads run before is
> always
> > the case in a real-time system, and is not a problem to be able to meet
> > deadline, or if it is, it means you did not choose your priorities
> correctly. The
> > whole point of using a real-time extension such as Xenomai dual-kernel or
> > PREEMPT_RT is that the Linux kernel is not deterministic, it does not
> provide
> > any guarantee in terms of scheduling latency. The time it takes for the
> Linux
> > kernel to schedule the highest priority task when an interrupt happens is
> not
> > bounded by design. So, that is the reason why a Xenomai thread running in
> > secondary mode (with a kernel that is not patched with a combo of
> > PREEMPT_RT and I-pipe that is) can not be used in a real-time system, not
> > the fact that higher priority threads run before it.
> 
> I'm fine with the fact that higher priority threads run before lower
> priority ones! :) I was just asking a confirmation for a different thing;
> let me explain with an example. Suppose we have two Xenomai threads: T1
> with RT priority 90, and T2 with RT priority 80. When both threads are in
> primary mode, T1 will run before T2, as you pointed out. Now, suppose that
> T1 switches to secondary mode; in that case, T2 (which is still in primary
> mode) can run before T1. Right?

Yes, but that is not the reason why a task going to secondary mode
is a problem. The reason why a task going to secondary mode is a
problem is that when it does so, it is scheduled by a kernel which
offers no real-time guarantees. This is much worse.

> 
> One more question: what do you mean when you say to "patch a kernel with a
> combo of PREEMPT_RT and I-pipe"? Is it really possible to patch a Linux
> kernel with both PREEMPT_RT and I-pipe? Can these two solutions
> co-exist?*

Yes, it has been already done. In that case, when a task goes in
secondary mode, it is scheduled by the PREEMPT_RT kernel, and thus
keeps real-time guarantees (though supposedly less stringent), if
it is running with a real-time scheduling policy, of course.

>  
> > If you want to use Xenomai to implement a real-time system, using Xenomai
> > 3.x mercury core, the simplest way is to use a Linux kernel patched with
> the
> > PREEMPT_RT patch, but the PREEMPT_RT patch does not automatically turn
> > any driver in a driver that can be used in an application trying to meet
> > deadlines. The driver code needs to be inspected. When porting a Linux
> > driver to RTDM, this inspection was already done, and RTDM does not
> > provide services that can cause trouble for real-time applications (for
> > instance, mutexes without priority inheritance). So, using an RTDM driver
> is a
> > shortcut to that. But the main reason to try and use RTDM drivers with
> > Mercury is for people that developed custom drivers for Xenomai 2.x, to be
> > able to use these drivers with mercury without rewriting them.
> 
> So RTDM-enabled device drivers are the best option, even with Xenomai 3.x
> Mercury core, but at the moment we have the limitation that these
> RTDM-enabled device drivers cannot be used with the Mercury core (as for
> RTnet), since RTDM has not been ported to Xenomai 3 yet, right?
> 
> When do you think the first stable version of Xenomai 3 will be released?
> It will include a native implementation of RTDM for the Mercury core? I'm
> just asking out of curiosity: I appreciate very much the effort you do to
> move the project forward, for the wealth of documentation available and for
> your support through this mailing list! :)

Xenomai 3 will be released... when it is ready.

> 
> > No, the reason to integrate RTnet in Xenomai 3, is because it makes sense,
> > and makes its maintenance easier. And no, RTnet is not already usable with
> > Mercury for the simple reason that RTDM has not been ported to Xenomai 3
> > yet.
> 
> I don't know exactly which are the problems of the Linux networking stack
> with respect to real-time guarantees, but I imagine that RTnet is the way
> to go when you have to deal with networking in a real-time application,
> both in single- and dual-kernel configurations. Is it correct?

Well there are several problems: 

1- the ethernet hardware protocol, with the "sleep a random time then
try again" behaviour upon collision is not deterministic, a
collision causes an unknown delay, because in a very worst case, the
collision could happen again an infinite number of times if the two
colliding nodes retry transmitting systematically at the same time,
this should not be a problem with full duplex point to point
ethernet connections, but is still in other cases;

2- in order to occupy the full network bandwidth, NIC hardware allows
queuing packets in advance (so that when sending the current packet
is done, the NIC can start sending the next packet immediately,
without even having to wait for the driver to have handled the irq,
if even there is one), the problem is then that when you program a
packet to be sent, it causes a latency: the NIC will not start
sending your packet before it has sent all the packets queued
before.

3- upon high packet rate, the Linux kernel moves handling of the
NIC driver interrupts to a kernel thread without a real-time
scheduling policy, so even with PREEMPT_RT it can cause the handling
of the NIC driver to not be real-time.

4- using the Linux networking stack from a thread running in primary
mode causes the thread to go to secondary mode, which cause it to
loose any real-time guarantees.

Problem 3 does not exist with Xenomai, though a high interrupt rate
will cause the real-time guarantees to deteriorate. To avoid this,
some NICs allow to aggregate RX interrupts, which is still a
trade-off in terms of latencies, but better than getting tasks
delayed for long by a network burst of packets. I believe TX
completion interrupts to be evil, and I plan to try and implement
something which would avoid them.

Anyway, RTnet TDMA policy avoids all these problems, but is heavy to
set up, all nodes on the network must use RTnet TDMA. Using RTDM
nomac policy essentially avoid only avoid issue 3 and 4, but still
requires all the nodes to use it if you want Linux to channel non
real-time communications on the same link.

I plan to implement an alternative that would avoid issues 2, 3, and
4 (I believe issue 1 to not be that much of a problem in practice on
switched networks, if the switches do some deterministic FIFO
queuing) and not require RTnet on non real-time nodes. But that is a
long term plan, I have other things to do first. But to be
completely frank, I have worked on this in my past work experience,
and the fact that I wanted to implement that was also a reason for
merging RTnet into Xenomai 3.

-- 
					    Gilles.
https://click-hack.org

