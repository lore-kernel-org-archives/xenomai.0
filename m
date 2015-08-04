Date: Tue, 4 Aug 2015 15:48:00 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20150804134759.GA22015@hermes.click-hack.org>
References: <BLU437-SMTP62CAA597299A3591E31BB9F0760@phx.gbl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BLU437-SMTP62CAA597299A3591E31BB9F0760@phx.gbl>
Subject: Re: [Xenomai] Raspberry Pi 2 patch - BCM2709
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Mathieu <mathieu_rondonneau@hotmail.com>
Cc: xenomai@xenomai.org

On Tue, Aug 04, 2015 at 06:30:57AM -0700, Mathieu wrote:
> Some status on RPI2: kernel is now booting with CONFIG_IPIPE (only) (at
> least passing the interrupt issue).
> 
> The part I was missing is the interrupt binding in
> arch_irq_handler_default().
> 
> I also used the system timer instead of the arm timer.

The arm architected timer is used on cortex A15 Processors. So, it
can definitely work.

> I am not sure the reason but I have the feeling it is because ipipe needs a
> oneshot timer.

I-pipe does not need a timer. Xenomai does. The ARM architected
timer is a oneshot timer, so can be used by Xenomai (and once again,
is used on cortex A15). And a periodic timer is not an issue either,
provided that you reprogram it at every shot.

For details about timers and clocks, once again, see the porting guide.

> 
> I also got the rpi2 connected to a jtag and debugging using eclipse but it
> did not help much for this particular issue (and it is rather slow and not
> really stable).

Yes, in theory JTAG is great, in practice, debug tools are always
buggy. Note however that you may have better chances using gdb
directly than using eclipse.

> 
> There is a (major) issue: the mmc can not get the clock.
> [    4.108224] mmc-bcm2835 3f300000.mmc: could not get clk
> 
> I am guessing this is due to the switch from ARM timer to system timer.
> I will have to fix this eventually (any suggestion welcome).

Probable wrong guess. The clock referred to here is a hardware clock
(in the sense, an electronic wire which gives a periodic signal),
and has nothing to do with the system timer.

-- 
					    Gilles.
https://click-hack.org

