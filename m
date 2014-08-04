Message-ID: <53DFB87A.7060304@xenomai.org>
Date: Mon, 04 Aug 2014 18:44:42 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <431b7669858a4c3584ec344ec4b5a752@CVEX13.valentin-carl.de>
In-Reply-To: <431b7669858a4c3584ec344ec4b5a752@CVEX13.valentin-carl.de>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] RTNet, CONFIG_XENO_DRIVERS_16550A, Kernel 3.14,
 preempt_rt patch
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Reitinger, Peter" <preitinger@carl-valentin.de>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 08/04/2014 02:42 PM, Reitinger, Peter wrote:
> Dear Xenomai people,
> 
> I read about RTNet 0.9.13 that it supports only Linux Kernels up to 3.2.
> Is this still up-to-date? Or is there a new version (maybe not yet released) that is compatible with a newer Linux kernel, preferrable 3.14 or above?
> 
> I had problems to use rt_dev_send and receive, but now I noticed that in my kernel config CONFIG_XENO_DRIVERS_16550A has not been set. Is CONFIG_XENO_DRIVERS_16550A required for usage of rt_dev_send? If yes, is CONFIG_XENO_DRIVERS_16550A compatible with kernel 3.14.0?

This driver does not depend on the linux driver stack, but on RTDM which
is fine over 3.14, provided you pull the Xenomai code from our
maintenance git tree (git.xenomai.org/xenomai-2.6) since this is a
recent kernel for which Xenomai 2.6.3 had no support.

> 
> Is there a relation between RTNet and CONFIG_XENO_DRIVERS_16550A?

This driver controls a common 8250/16650 UART, not a NIC. It represents
a named/character device, not a protocol device exposing a socket-based
access point, so CONFIG_XENO_DRIVERS_16550A is unrelated to
rt_dev_send() either.

> 
> I also wonder if it is possible to use the RT_PREEMPT patch on 3.14 together with xenomai? Do I have to do a 3-way merge to achieve this goal? I mean patch xenomai onto vanilla kernel 3.14. and then merge the patch for preempt_rt or in the other order?

Yes, that's perfectly possible and some projects are already running
such combos with success. The best approach for merging is preempt-rt
first, then I-pipe. You may want to search for older posts on this
mailing list which discuss this issue.

> 
> Many thanks in advance also for former help...
> 
> Kind regards
> Peter Reitinger
> _______________________________________________
> Xenomai mailing list
> Xenomai@xenomai.org
> http://www.xenomai.org/mailman/listinfo/xenomai
> 


-- 
Philippe.

