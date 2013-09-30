From: "Lennart Sorensen" <lsorense@csclub.uwaterloo.ca>
Date: Mon, 30 Sep 2013 12:41:24 -0400
Message-ID: <20130930164124.GY13097@csclub.uwaterloo.ca>
References: <5249A8D5.4070401@axelsw.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5249A8D5.4070401@axelsw.it>
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

On Mon, Sep 30, 2013 at 06:37:41PM +0200, Roberto Bielli wrote:
> i would like to know how works in theory xenomai on smp system (with
> local timers, imx6q for example).
> For example linux is always on one cpu and xenomai on other ?
> Or is there a complex algorithm to determine who is in a processor
> in a instance ?
> Linux can disturb xenomai more than single processor ?
> Is better (jitter, latency, etc...) xenomai on a multi-core than to
> single core ?

Well on a single core xenomai always does whatever it wants, and linux
gets whatever CPU is leftover.  So xenomai can cause a lot of trouble
for linux if your realtime code isn't nice to it.  So xenomai runs fine,
linux gets all the extra delays and jitter though.

I have no idea how it works with multiple cores yet (although I am sure
I will learn soon).

-- 
Len Sorensen

