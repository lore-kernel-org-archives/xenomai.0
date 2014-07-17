Date: Thu, 17 Jul 2014 13:59:15 +0200
From: Maxime Ripard <maxime.ripard@free-electrons.com>
Message-ID: <20140717115915.GD20328@lukather>
References: <20140707160239.GF13423@lukather> <53BAC5C4.5060704@xenomai.org>
 <20140708125505.GN13423@lukather> <53BC2AB5.4050801@xenomai.org>
 <20140710150540.GE27469@lukather> <53BEC794.6090208@xenomai.org>
 <20140716161801.GA20328@lukather> <53C6D6DA.3060303@xenomai.org>
 <20140717101807.GC20328@lukather> <53C7AB52.609@xenomai.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <53C7AB52.609@xenomai.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [PATCH] AT91: SAMA5D3: Adapt Ipipe for AIC5
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Thomas Petazzoni <thomas@free-electrons.com>, Nicolas Ferre <nicolas.ferre@atmel.com>, Boris Brezillon <boris@free-electrons.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, xenomai@xenomai.org

On Thu, Jul 17, 2014 at 12:54:10PM +0200, Gilles Chanteperdrix wrote:
> > Which brings an extra question about this. Is the timer
> > calibration supposed to get a minimum latency to 0 (meaning that
> > with a properly calibrated timer, we would only get positive
> > latencies), or that the average latency should be around 0 (which
> > would mean that negative latencies would actually be frequent, but
> > would break the clock_nanosleep documented behaviour).
> > 
> > I'm actually seeing the former, but trying the latter only brings
> > us quite close to having the calibration disabled entirely.
> 
> The calibration is left entirely to the user, so, you choose what is
> best for your application. But indeed, if your application relies on
> clock_nanosleep documented behaviour (should never wake-up early
> except in case of signal), you want to set /proc/xenomai/latency value
> to the minimum value measured by the latency test, minus a safety margin.

Ok, thanks!

I guess you can add my Tested-by tag to your patch, if that makes any
sense for Xenomai.

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
URL: <http://www.xenomai.org/pipermail/xenomai/attachments/20140717/7bb489d7/attachment.sig>
