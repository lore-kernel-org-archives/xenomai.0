Message-ID: <5249C2A0.7030204@xenomai.org>
Date: Mon, 30 Sep 2013 20:27:44 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <5249A8D5.4070401@axelsw.it>
In-Reply-To: <5249A8D5.4070401@axelsw.it>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] xenomai smp - how it works
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Roberto Bielli <roberto.bielli@axelsw.it>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 09/30/2013 06:37 PM, Roberto Bielli wrote:
> Hi,
> 
> i would like to know how works in theory xenomai on smp system (with 
> local timers, imx6q for example).

On mx6q specifically, it seems the framebuffer is a latency killer,
probably because of cache effects, the L2 full cache flush seems also to
need splitting, but it may be a side effect of the framebuffer driver. I
would recommend to try and map the framebuffer uncached to avoid
disturbing the cache when writing to the framebuffer. At the expense of
course of the graphic performance. I did not experience this first hand,
it was only reported to me, so I am not sure of my diagnosis. What I
could observe on other cortex A9 (OMAP4) is that the L2 cache spinlock
creates large latencies as well, but the latest versions of the I-pipe
patch should avoid this issue.

-- 
                                                                Gilles.

