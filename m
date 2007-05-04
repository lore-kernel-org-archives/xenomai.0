Message-ID: <463B086B.6060402@domain.hid>
Date: Fri, 04 May 2007 12:18:19 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <1178268043.5391.47.camel@domain.hid>
In-Reply-To: <1178268043.5391.47.camel@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Latencies while ethernet access
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: CAMUS Benoit <benoit.camus@domain.hid>
Cc: xenomai@xenomai.org

CAMUS Benoit wrote:
> Hi,
> 
> I'm using Xenomai 2.3.1 with a 2.6.19.2 kernel (from ELDK) on a custom
> board based on Xscale PXA processor and with smc91c111 ethernet chip. 
> I did modifications on Linux kernel to port it on board and then just
> applied Adeos's patch following Xenomai's proceedings.
> Http and telnet servers are running on and i notice that latencies get
> really worse while i access any of them (see traces below).
> 
> I understood that Adeos might avoid that kind of behavior due to its
> architecture. So i infer that the ethernet driver might access the
> hardware by-passing Adeos ?

Despite Adeos architecture, latency with Xenomai is known to depend on
the non real-time workload, because there are some low-level ressources
such as busses and processor cache that the real-time and non real-time
processes need to share.

Nevertheless, the latencies you show us are a bit high, this may have
several reasons:
- maybe you enabled some debugging/statistics options, they have an
impact on performance;
- the latency of your system may not be properly calibrated, try:
echo 25000 > /proc/xenomai/latency
- 10ms is a period a bit high, this makes plenty of time for Linux to
refill the cache, with a lower period you should observe a lower latency.

> In this way and before modificate the driver, i decided to try RT driver
> thanks to Rtnet project and get an oops error at device probing due to
> memory mapping wich i still don't resolve.
> I don't have experience with Xenomai and would apreciate any advice on
> that phenomenum.

Note that using a real-time driver should rather increase the latency
than decrease it, since there will be more unpreemptible critical sections.

> I'm a bit surprised too about gap between best and worst latencies so
> i'm asking question to myself about my porting, does this gap seam
> strange for you  too?


-- 
                                                 Gilles Chanteperdrix

