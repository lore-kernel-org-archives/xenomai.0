Date: Mon, 29 Jun 2015 22:22:43 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20150629202243.GE10993@hermes.click-hack.org>
References: <000a01d0b270$6c0e6b70$442b4250$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000a01d0b270$6c0e6b70$442b4250$@gmail.com>
Subject: Re: [Xenomai] Device drivers and networking stack (RTnet) on
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

On Mon, Jun 29, 2015 at 03:35:03PM +0200, Giorgio Buffa wrote:
> Hello list!
> I'm new to the Xenomai architecture, so I would like to receive a feedback
> regarding my (little) understanding on device drivers and the RTnet stack.
> 
> In dual-kernel configurations (both Xenomai 2.x and Xenomai 3.x Cobalt
> core), device drivers need to be ported to the RTDM model: it allows a
> Xenomai thread not to leave the primary mode when accessing these device
> drivers. This is good because a Xenomai thread in secondary mode is
> scheduled by the Linux scheduler, hence it can run only when there are no
> other runnable Xenomay thread in primary mode (even with a lower priority),
> nor other runnable Linux threads / Xenomai threads in secondary mode with
> higher priority.

Your comprehension of why threads must remain in primary mode is
flawed. Low priority threads having to let high priority threads run
before is always the case in a real-time system, and is not a
problem to be able to meet deadline, or if it is, it means you did
not choose your priorities correctly. The whole point of using a
real-time extension such as Xenomai dual-kernel or PREEMPT_RT is
that the Linux kernel is not deterministic, it does not provide any
guarantee in terms of scheduling latency. The time it takes for the
Linux kernel to schedule the highest priority task when an interrupt
happens is not bounded by design. So, that is the reason why a
Xenomai thread running in secondary mode (with a kernel that is not
patched with a combo of PREEMPT_RT and I-pipe that is) can not be
used in a real-time system, not the fact that higher priority
threads run before it.

> 
> Porting a Linux driver to the RTDM model basically means to replace any
> call to Linux services within the driver itself (e.g. to register the
> driver, the IRQ handlers, the open/close/ioctl handlers, ...) to the
> equivalent services provided by the RTDM API.
> 
> In single-kernel configurations (Xenomai 3.x Mercury core) there is only
> the Linux scheduler, hence there is no such distinction of
> primary/secondary mode. A device driver can be used as is (i.e. as it is
> provided by the stock Linux kernel), even without porting it to the RTDM
> model. By the way, it is also possible to use a RTDM-based device driver
> (in that case, RTDM API calls are translated into Linux service calls at
> compile time).

If you want to use Xenomai to implement a real-time system, using
Xenomai 3.x mercury core, the simplest way is to use a Linux kernel
patched with the PREEMPT_RT patch, but the PREEMPT_RT patch does not
automatically turn any driver in a driver that can be used in an
application trying to meet deadlines. The driver code needs to be
inspected. When porting a Linux driver to RTDM, this inspection was
already done, and RTDM does not provide services that can cause
trouble for real-time applications (for instance, mutexes without
priority inheritance). So, using an RTDM driver is a shortcut to
that. But the main reason to try and use RTDM drivers with Mercury
is for people that developed custom drivers for Xenomai 2.x, to be
able to use these drivers with mercury without rewriting them.

> 
> Are there some good "rules of thumb" when looking at a stock Linux driver
> to be used in a Xenomai application with the Mercury core
> underneath?

Yes, see above.

> 
> My last point is related to RTnet. I've seen that RTnet has been integrated
> into Xenomai 3 because some sort of API changes. Is RTnet needed in both
> dual-kernel and single-kernel configurations?

No, the reason to integrate RTnet in Xenomai 3, is because it makes
sense, and makes its maintenance easier. And no, RTnet is not
already usable with Mercury for the simple reason that RTDM has not
been ported to Xenomai 3 yet.

-- 
					    Gilles.
https://click-hack.org

