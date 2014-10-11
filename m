Date: Sat, 11 Oct 2014 20:54:04 +0200
From: Richard Cochran <richardcochran@gmail.com>
Message-ID: <20141011185402.GA5265@netboy>
References: <DUB121-W77031E5D3C1CE7CEB386981B90@phx.gbl>
 <542D65B0.3080002@xenomai.org>
 <20141010132552.GA13501@localhost.localdomain>
 <5437F6ED.8030102@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5437F6ED.8030102@xenomai.org>
Subject: Re: [Xenomai] Xenomai on Cortex R (or Rreal Time) family
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On Fri, Oct 10, 2014 at 05:10:37PM +0200, Gilles Chanteperdrix wrote:
> Well, if it is someone's (other than Linus') tree, it is not mainline :-)

Just to be clear: I think most everything has gone main line.  But if
anything is missing, check Uwe's tree.  Also, you still need a simple
boot loader and user land, so try this:

http://git-public.pengutronix.de/?p=OSELAS.BSP-EnergyMicro-Gecko.git;a=summary

Anyhow, about Cortex-R, I can offer this:

1. Cortex-M is now working in main line for efm32.
2. No one is interested in Linux Cortex-M (seems to me)
3. Cortex-R is not supported in any Linux at all (AFAICT)

Thanks,
Richard

