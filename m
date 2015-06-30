From: "Giorgio Buffa" <giorgiobuffa.work@gmail.com>
References: <000a01d0b270$6c0e6b70$442b4250$@gmail.com>
 <20150629202243.GE10993@hermes.click-hack.org>
In-Reply-To: <20150629202243.GE10993@hermes.click-hack.org>
Date: Tue, 30 Jun 2015 10:04:41 +0200
Message-ID: <00c401d0b30b$6bc243d0$4346cb70$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Language: it
Subject: [Xenomai] R: Device drivers and networking stack (RTnet) on Xenomai
	3
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hi Gilles,
thank you for your reply!

> Your comprehension of why threads must remain in primary mode is flawed.
> Low priority threads having to let high priority threads run before is
always
> the case in a real-time system, and is not a problem to be able to meet
> deadline, or if it is, it means you did not choose your priorities
correctly. The
> whole point of using a real-time extension such as Xenomai dual-kernel or
> PREEMPT_RT is that the Linux kernel is not deterministic, it does not
provide
> any guarantee in terms of scheduling latency. The time it takes for the
Linux
> kernel to schedule the highest priority task when an interrupt happens is
not
> bounded by design. So, that is the reason why a Xenomai thread running in
> secondary mode (with a kernel that is not patched with a combo of
> PREEMPT_RT and I-pipe that is) can not be used in a real-time system, not
> the fact that higher priority threads run before it.

I'm fine with the fact that higher priority threads run before lower
priority ones! :) I was just asking a confirmation for a different thing;
let me explain with an example. Suppose we have two Xenomai threads: T1
with RT priority 90, and T2 with RT priority 80. When both threads are in
primary mode, T1 will run before T2, as you pointed out. Now, suppose that
T1 switches to secondary mode; in that case, T2 (which is still in primary
mode) can run before T1. Right?

One more question: what do you mean when you say to "patch a kernel with a
combo of PREEMPT_RT and I-pipe"? Is it really possible to patch a Linux
kernel with both PREEMPT_RT and I-pipe? Can these two solutions co-exist?
 
> If you want to use Xenomai to implement a real-time system, using Xenomai
> 3.x mercury core, the simplest way is to use a Linux kernel patched with
the
> PREEMPT_RT patch, but the PREEMPT_RT patch does not automatically turn
> any driver in a driver that can be used in an application trying to meet
> deadlines. The driver code needs to be inspected. When porting a Linux
> driver to RTDM, this inspection was already done, and RTDM does not
> provide services that can cause trouble for real-time applications (for
> instance, mutexes without priority inheritance). So, using an RTDM driver
is a
> shortcut to that. But the main reason to try and use RTDM drivers with
> Mercury is for people that developed custom drivers for Xenomai 2.x, to be
> able to use these drivers with mercury without rewriting them.

So RTDM-enabled device drivers are the best option, even with Xenomai 3.x
Mercury core, but at the moment we have the limitation that these
RTDM-enabled device drivers cannot be used with the Mercury core (as for
RTnet), since RTDM has not been ported to Xenomai 3 yet, right?

When do you think the first stable version of Xenomai 3 will be released?
It will include a native implementation of RTDM for the Mercury core? I'm
just asking out of curiosity: I appreciate very much the effort you do to
move the project forward, for the wealth of documentation available and for
your support through this mailing list! :)

> No, the reason to integrate RTnet in Xenomai 3, is because it makes sense,
> and makes its maintenance easier. And no, RTnet is not already usable with
> Mercury for the simple reason that RTDM has not been ported to Xenomai 3
> yet.

I don't know exactly which are the problems of the Linux networking stack
with respect to real-time guarantees, but I imagine that RTnet is the way
to go when you have to deal with networking in a real-time application,
both in single- and dual-kernel configurations. Is it correct?

Thank you and kind regards,
Giorgio Buffa


