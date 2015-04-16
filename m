Date: Thu, 16 Apr 2015 21:15:08 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20150416191508.GJ1589@hermes.click-hack.org>
References: <552faa6bf2d134.92118662@wp.pl>
 <tencent_2DCE8D1A1206C27E7BBEB0F4@qq.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_2DCE8D1A1206C27E7BBEB0F4@qq.com>
Subject: Re: [Xenomai] Rtnet e1000e 82583: slow writel(tx_ring->tail),
 takes above 1us?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Zhoupeng <zhoupeng1982@qq.com>
Cc: xenomai <xenomai@xenomai.org>

On Thu, Apr 16, 2015 at 10:39:59PM +0800, Zhoupeng wrote:
> &gt;&gt; This is just MMIO write to 82583, of course MMIO is uncache.
> &gt;&gt; And PCIE ASPM is disabled, so L0s is not the problem.
> &gt;&gt; 
> &gt;&gt; I think PCIE Memory Write TLPs is fast enough, but why spend so much time?
> 
> &gt;There is an interesting article that may be relevant to this issue
> &gt;
> &gt;"PCI Express as a Killer of Software-based Real-Time Ethernet"
> 
> I have read the article carefully.
> The author don't mention PCIE ASPM, Latency will be better by disable it.
> 
> Every rt_dev_sendmsg will trigger one writel(tx_ring-&gt;tail) in Rtnet.
> As the "writel" is time expensive, improvement may be done to Rtnet:
> using rtskb to buffer multiple packets, and using one IOCTL to trigger "writel".

This optimization increases bandwidth at the expense of latency,
exactly the contrary to what RTnet is trying to achieve. So, patch
not welcome in fact. Or would be welcome a very careful patch which
does sends lone packets immediately, not queue them for sending them
later with a timeout or something.

-- 
					    Gilles.

