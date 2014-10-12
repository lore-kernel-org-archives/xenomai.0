Date: Sun, 12 Oct 2014 10:29:29 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20141012082929.GC13181@sisyphus.hd.free.fr>
References: <DUB121-W77031E5D3C1CE7CEB386981B90@phx.gbl>
 <542D65B0.3080002@xenomai.org>
 <20141010132552.GA13501@localhost.localdomain>
 <5437F6ED.8030102@xenomai.org> <20141011185402.GA5265@netboy>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20141011185402.GA5265@netboy>
Subject: Re: [Xenomai] Xenomai on Cortex R (or Rreal Time) family
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Richard Cochran <richardcochran@gmail.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On Sat, Oct 11, 2014 at 08:54:04PM +0200, Richard Cochran wrote:
> On Fri, Oct 10, 2014 at 05:10:37PM +0200, Gilles Chanteperdrix wrote:
> > Well, if it is someone's (other than Linus') tree, it is not mainline :-)
> 
> Just to be clear: I think most everything has gone main line.  But if
> anything is missing, check Uwe's tree.  Also, you still need a simple
> boot loader and user land, so try this:
> 
> http://git-public.pengutronix.de/?p=OSELAS.BSP-EnergyMicro-Gecko.git;a=summary
> 
> Anyhow, about Cortex-R, I can offer this:
> 
> 1. Cortex-M is now working in main line for efm32.
> 2. No one is interested in Linux Cortex-M (seems to me)

Well, a lot of Cortex M are running code from very small NOR
flashes, with very little RAM as well. So, they definitely can not
run Linux. Having worked with such processors, and with FreeRTOS, let
us just say I was motivated by a port of Xenomai POSIX skin on bare
metal. But this has probably become a little harder with Xenomai 3
than with Xenomai 2. And I never found time to do it anyway.

> 3. Cortex-R is not supported in any Linux at all (AFAICT)

I thought so, but mobin seems to say a uCLinux port exists.

This page:
http://elinux.org/Processors

mentions it.

-- 
					    Gilles.

