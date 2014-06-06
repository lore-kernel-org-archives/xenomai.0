Message-ID: <5391FFCD.3010505@xenomai.org>
Date: Fri, 06 Jun 2014 19:52:13 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <20140606135912.GJ5765@lukather>
In-Reply-To: <20140606135912.GJ5765@lukather>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Xenomai on Atmel SAMA5D3 with a 3.14 kernel
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: Michael Opdenacker <michael@free-electrons.com>, Thomas Petazzoni <thomas@free-electrons.com>, Boris Brezillon <boris@free-electrons.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, xenomai@xenomai.org, =?UTF-8?B?QW50b2luZSBUw6luYXJ0?= <antoine@free-electrons.com>

On 06/06/2014 03:59 PM, Maxime Ripard wrote:
> Hi Gilles,
> 
> I've been experimenting these days with the i-pipe 3.14 kernel,
> and current xenomai master branch on the Atmel SAMA5D3 SoC.
> 
> There's a few issues there, the first one being that 
> at91_ipipe_early_init crashes because of a NULL pointer 
> dereference. This is due to the clk_get_rate call on the clock 
> returned by clk_get(NULL, "mck").
> 
> This clk_get call cannot since 3.14 because the clock code has
> been rewritten, and you can't use clkdev anymore.

Well, it works on AT91. (RM9200 and SMA9263). What you are doing with
SAMA5D3 here is actually a port to a new platform.

> 
> This is quite simple to fix, and after actually fixing it, you get
> a more interesting issue: either the timers or the interrupts don't
> work at all.
> 
> The first symptom is that it get stuck at the delay loop 
> calibration. Setting the loops per jiffy in the command line make
> the boot go further, until the switch to the ipipe_tsc clocksource.
> This actually makes me think that it's more the timers that are
> broken rather than the interrupts. Changing the timer counter block
> doesn't solve anything.
> 
> Do you have an idea of what could be going on?

See:
http://www.xenomai.org/index.php/I-pipe-core:ArmPorting


-- 
                                                                Gilles.

