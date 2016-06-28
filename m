Date: Tue, 28 Jun 2016 14:01:19 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20160628120119.GT18662@hermes.click-hack.org>
References: <20160628091747.GK18662@hermes.click-hack.org>
 <57724333.6010608@sigmatek.at>
 <20160628092955.GL18662@hermes.click-hack.org>
 <577248AB.5070601@sigmatek.at>
 <20160628095543.GM18662@hermes.click-hack.org>
 <57724CFE.2050401@sigmatek.at>
 <20160628101957.GO18662@hermes.click-hack.org>
 <5772520E.8010407@sigmatek.at>
 <20160628103925.GP18662@hermes.click-hack.org>
 <577265AF.9080300@sigmatek.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <577265AF.9080300@sigmatek.at>
Subject: Re: [Xenomai] Performance impact after switching from 2.6.2.1 to
 2.6.4
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Wolfgang Netbal <wolfgang.netbal@sigmatek.at>
Cc: xenomai@xenomai.org

On Tue, Jun 28, 2016 at 01:55:27PM +0200, Wolfgang Netbal wrote:
> 
> 
> Am 2016-06-28 um 12:39 schrieb Gilles Chanteperdrix:
> > On Tue, Jun 28, 2016 at 12:31:42PM +0200, Wolfgang Netbal wrote:
> >>
> >> Am 2016-06-28 um 12:19 schrieb Gilles Chanteperdrix:
> >> min: 10, max: 677, avg: 10.5048 -> 0.0265273 us
> >>
> >> Here are the output for Kernel 3.0.43 and Xenomai 2.6.2.1
> >>
> >> #> ./tsc
> >> min: 10, max: 667, avg: 11.5755 -> 0.029231 us
> > Ok. So, first it confirms that the two configurations are running
> > the processor at the same frequency. But we seem to see a pattern,
> > the maxima in the case of the new kernel seems consistently higher.
> > Which would suggest that there is some difference in the cache. What
> > is the status of the two configurations with regard to the L2 cache
> > write allocate policy?
> Do you mean the configuration we checked in this request
> https://xenomai.org/pipermail/xenomai/2016-June/036390.html

This answer is based on a kernel message, which may happen before
or after the I-pipe patch has changed the value passed to the
register, so, essentially, it is useless. I would not call that
checking the L2 cache configuration differences.

-- 
					    Gilles.
https://click-hack.org

