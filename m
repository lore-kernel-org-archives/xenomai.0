Date: Mon, 14 Dec 2015 07:42:53 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20151214064253.GC7035@hermes.click-hack.org>
References: <44cb82ce.15337.151812ff429.Coremail.ericvic@163.com>
 <20151208112320.GA24418@hermes.click-hack.org>
 <5d8dd3ae.5ccc.1519e440866.Coremail.ericvic@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5d8dd3ae.5ccc.1519e440866.Coremail.ericvic@163.com>
Subject: Re: [Xenomai] ipipe-gch-ipipe-3.0-imx6q latency
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: eric <ericvic@163.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On Mon, Dec 14, 2015 at 10:13:57AM +0800, eric wrote:
> It is much better with 3.18.20 ,it is  the test result with xenomai-3.0.1   500us cycle ,still a little big ,thanks!
> -sh-2.05b# [  154.812032] pmax: 0.597303 ms
> [  245.216863] pmax: 0.600940 ms
> [  249.992395] pmax: 0.603288 ms
> [  277.280006] pmax: 0.610470 ms

I am not sure about what you measure, but if you observe a 500us
latency, you have a problem.

What latency does Xenomai latency test give?

-- 
					    Gilles.
https://click-hack.org

