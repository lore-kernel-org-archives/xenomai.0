Message-ID: <53205346.6020605@xenomai.org>
Date: Wed, 12 Mar 2014 13:29:58 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <3F7844F7-FC18-44C3-A946-528C28CB81AC@gatech.edu>
In-Reply-To: <3F7844F7-FC18-44C3-A946-528C28CB81AC@gatech.edu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Build Xenomai Lib native on the Beaglebone Black
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Yogi A. Patel" <yapatel@gatech.edu>
Cc: xenomai@xenomai.org

On 03/12/2014 12:59 AM, Yogi A. Patel wrote:
> Flavio -
> 
> Would you mind sharing what latencies you are seeing on your Beaglebone black with xenomai?

Some results which might be interesting, the results for the IGEPv2
board, using an omap3630 processor, close to the beaglebone black
processor, are in the 40-45us range, if the kernel is compiled with the
right options, that is:
- kernel built using thumb2 and optimized for size
- preemption set to CONFIG_PREEMPT_NONE
- CONFIG_SMP disabled
- stack unwinding enabled
- xenomai unlocked switch disabled
- all xenomai/ipipe debugs off, except maybe "watchdog support" and
"detect mutexes held in relaxed sections", as they should not incur an
increase in latency.

Since the I-pipe core series (so since linux 3.2), I have started
recording the results I get on the test platforms I have, see, to show
the improvements over time (most improvements are due to configurations
changes):

http://xenomai.org/~gch/core-3.2-latencies/
http://xenomai.org/~gch/core-3.4-latencies/
http://xenomai.org/~gch/core-3.5-latencies/
http://xenomai.org/~gch/core-3.8-latencies/
http://xenomai.org/~gch/core-3.10-latencies/

Note that we recently discovered that disabling the L2 cache
"write-allocate" bit on imx6 and omap4, so probably on any multi-core
cortex a9, improved latencies considerably, and that moving the
spinlocks code out-of-line did too, see:
http://sisyphus.hd.free.fr/~gilles/panda-test/inline-spinlocks.png

The change of the L2 write-allocate bit will be in the next Xenomai 2.x
release, whereas the change of spinlock code will only appear in xenomai
3.0.

Anyway, I would like to also try disabling the L2 cache write-allocate
on omap3, but IGEPv2 is running in secure mode, so I can not change this
configuration, I would probably need an "smc" call, but I have not found
a documentation for these calls, so if anyone knows where to find this
info, I am interested.

Regards.


-- 
                                                                Gilles.

