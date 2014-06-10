Resent-Message-ID: <20140612074411.GF18962@lukather>
Resent-To: xenomai@xenomai.org
Date: Tue, 10 Jun 2014 11:40:57 +0200
From: Maxime Ripard <maxime.ripard@free-electrons.com>
Message-ID: <20140610094057.GJ9791@lukather>
References: <20140606135912.GJ5765@lukather> <20140606140031.GK5765@lukather>
 <539322FA.5030004@xenomai.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <539322FA.5030004@xenomai.org>
Content-Type: text/plain; charset="us-ascii"
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
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Michael Opdenacker <michael@free-electrons.com>, Thomas Petazzoni <thomas@free-electrons.com>, Boris Brezillon <boris@free-electrons.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, xenomai@xenomai.org, Antoine =?iso-8859-1?Q?T=E9nart?= <antoine@free-electrons.com>

On Sat, Jun 07, 2014 at 04:34:34PM +0200, Gilles Chanteperdrix wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> On 06/06/2014 04:00 PM, Maxime Ripard wrote:
> > On Fri, Jun 06, 2014 at 03:59:12PM +0200, Maxime Ripard wrote:
> >> Hi Gilles,
> >> 
> >> I've been experimenting these days with the i-pipe 3.14 kernel, 
> >> and current xenomai master branch on the Atmel SAMA5D3 SoC.
> >> 
> >> There's a few issues there, the first one being that 
> >> at91_ipipe_early_init crashes because of a NULL pointer 
> >> dereference. This is due to the clk_get_rate call on the clock 
> >> returned by clk_get(NULL, "mck").
> >> 
> >> This clk_get call cannot since 3.14 because the clock code has 
> >> been rewritten, and you can't use clkdev anymore.
> >> 
> >> This is quite simple to fix, and after actually fixing it, you 
> >> get a more interesting issue: either the timers or the
> >> interrupts don't work at all.
> >> 
> >> The first symptom is that it get stuck at the delay loop 
> >> calibration. Setting the loops per jiffy in the command line
> >> make the boot go further, until the switch to the ipipe_tsc 
> >> clocksource. This actually makes me think that it's more the 
> >> timers that are broken rather than the interrupts. Changing the 
> >> timer counter block doesn't solve anything.
> >> 
> >> Do you have an idea of what could be going on?
> > 
> > 
> > Actually, the boot seem just to be *much* slower, so maybe the 
> > timers are working after all, but it's just yet another issue with 
> > the clocks.
> > 
> Does __ipipe_tsc_update get called in Linux timer interrupt?

Here is what's happening: http://pastebin.com/m2mz66pU

You can see that at line 35, the timer interrupt (a spurious one?)
gets called, and calls __ipipe_tsc_update. At that point,
ipipe_tsc_value seems to be NULL, and hence __ipipe_tsc_update
returns.

The thing is, the timer interrupt doesn't seem to be called again. The
fact that it was actually called once makes me think that it's rather
the timer clock that is not running... I will dig into it.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://www.xenomai.org/pipermail/xenomai/attachments/20140610/74ddf006/attachment.sig>
