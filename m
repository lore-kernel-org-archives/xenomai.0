Message-ID: <50FD2D03.4090306@xenomai.org>
Date: Mon, 21 Jan 2013 12:56:51 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4D4F8D1B-022E-47F8-A579-EBF2A3427C5D@mah.priv.at>	<50F6D940.3040406@xs4all.nl>	<F1ACE4FC-3E71-4498-B683-81F5C40CB6E3@mah.priv.at>	<50F7AF53.2090800@xs4all.nl>	<50F7BC13.50009@xenomai.org>	<50F7FCD8.7020105@xs4all.nl>	<50FA9FA0.7020400@xenomai.org>	<F995AEC4-6B7E-4DB9-9C64-A5ED3F01DCFA@mah.priv.at>	<50FAAE9A.2060705@xenomai.org>
	<1C475D27-61D9-41F9-98D8-476556B485C4@mah.priv.at>
In-Reply-To: <1C475D27-61D9-41F9-98D8-476556B485C4@mah.priv.at>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [Emc-developers] "new RTOS"
 status:	Scheduler	(?)	lockup on ARM
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Michael Haberler <mail17@mah.priv.at>
Cc: xenomai@xenomai.org

On 01/21/2013 12:43 PM, Michael Haberler wrote:

> the suspicion now turned to the DHCP lease setting and RTC time warp
> issues - the Beaglebone doesnt have an RTC so it starts up at
> 1-1-1970
> 
> the first DHCP lease still has 1970 timestamps, but eventually the
> RTC is set with ntpdate and it could be this causes confusion
> 
> the thing which is hard to believe for me: loss of IP connectivity -
> conceivable; kernel hang - why?
> 
> question: does a RTC time warp have any possible bearing on Xenomai
> operations?


No, it should not, Xenomai uses its own clock, which is set only once
upon boot, so, is unaffected by Linux wallclock time changes... or
should be.

-- 
                                                                Gilles.

