Date: Mon, 24 Aug 2015 20:36:47 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20150824183646.GB21893@hermes.click-hack.org>
References: <20150824181426.GA21893@hermes.click-hack.org>
 <55DB6151.8050003@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <55DB6151.8050003@siemens.com>
Subject: Re: [Xenomai] perf nmi on x86
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Xenomai <xenomai@xenomai.org>

On Mon, Aug 24, 2015 at 08:24:17PM +0200, Jan Kiszka wrote:
> On 2015-08-24 20:14, Gilles Chanteperdrix wrote:
> > Hi Jan,
> > 
> > running Xenomai on an x86 machine, I noticed that the perf NMI was
> > ticking. It seems CONFIG_PERF can not be disabled in the kernel
> > configuration.
> > 
> > So, the first question is: 
> > is there a way of disabling the NMI ?
> > second question is: 
> > if not, what do we do about it? 
> > 
> > I mean, on the one hand, disabling the NMI is probably mandatory on
> > a system where latency matters, but on the other hand, some users
> > may want it enabled and do not care for the additional latency.
> 
> Does "echo 0 > /proc/sys/kernel/nmi_watchdog" change the picture? It did
> so for me on a distro kernel, though re-enabling it again didn't make
> the PMIs reappear.

Works for me, and writing 1 seems to re-enable it. Thanks. This
should really be documented somewhere, though.

-- 
					    Gilles.
https://click-hack.org

