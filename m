Message-ID: <50CC6730.6060308@xenomai.org>
Date: Sat, 15 Dec 2012 13:04:00 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <1355499196.2190.23.camel@herbert.er.corscience.de>
In-Reply-To: <1355499196.2190.23.camel@herbert.er.corscience.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Question about IPIPE_IRQF_NOSYNC
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Tim Niemeyer <tim.niemeyer@corscience.de>
Cc: xenomai <xenomai@xenomai.org>

On 12/14/2012 04:33 PM, Tim Niemeyer wrote:

> Hi
> 
> I'm using Xenomai 2.6.1 with linux 3.4.14 (with latest 'for-core-3.4'
> Adeos) on an omap3 board.


The latest Adeos is the core-3.4 branch from the git.denx.de/ipipe.git
repository, not the 'for-core-3.4' branch from the
git.xenomai.org/ipipe-gch.git.

Anyway, you can not use Xenomai 2.6.1 with linux 3.4, you also have to
use xenomai from its git repository git.xenomai.og/xenomai-2.6.git

> 
> While hunting a gpio-irq latency i tried to understand the adeos chained


How high a latency are we talking about?

Anyway, the way we track down this kind of issues is the I-pipe tracer.
http://www.xenomai.org/index.php/I-pipe:Tracer

You will have to trigger the freeze yourself if you find a too high latency.

-- 
                                                                Gilles.

