Date: Thu, 18 Dec 2014 12:08:58 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20141218110858.GL2012@hermes.click-hack.org>
References: <D89759E6-FF44-40AC-82AE-7381A82BA5C7@tuebingen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D89759E6-FF44-40AC-82AE-7381A82BA5C7@tuebingen.mpg.de>
Subject: Re: [Xenomai] Latency spikes
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Alexander Herzog <aherzog@tuebingen.mpg.de>
Cc: xenomai@xenomai.org

On Thu, Dec 18, 2014 at 09:39:31AM +0100, Alexander Herzog wrote:
> Hi all,
> 
> We see latency spikes on our xenomai install whenever we open a
> window, take a screenshot or perform similar actions. The spikes
> are especially high (~2000) the moment an opengl window is opened
> (e.g. glxgears). Outside of these events (e.g. once a window is
> open) the latencies seem to be stable. The issue remains even, if
> we switch graphics cards (and graphics drivers) from a nvidia to a
> radeon card.

For nvidia, have you tried the "nouveau" driver?

> 
> We are running Xenomai 2.6.3 on an Intel Xeon E5-2687W v3 310GHz
> processor and Ubuntu 12.04 (linux kernel version 3.8.13). I went
> through the troubleshooting section and made sure that the
> deprecated config flags (CONFIG_CPU_FREQ, CONFIG_CPU_IDLE,
> CONFIG_KGDB, CONFIG_CONTEXT_TRACKING_FORCE) are disabled. We see
> the warning 'SMI-enabled chipset found, but SMI workaround
> disabled', but passing 'xenomai.smi=-1' to the kernel does not fix
> our issue.

As explained in the following document:
https://xenomai.org//2014/06/dealing-with-x86-smi-troubles/

Passing xenomai.smi=-1 disables the SMI message. You should try
passing
xenomai.smi=1 if you want to enable the SMI workaround (with
caution, please read the document)

> 
> I would be thankful for any hint on how I could further debug this issue.

The only generic advices we have for this case are: 
- use an intel processor with on board graphic chip, with a recent
version of Xenomai and I-pipe patches (some things have been fixed
in this area, I believe since xenomai 2.6.3)
- as explained in the troubleshooting guide, 
https://xenomai.org/troubleshooting-a-dual-kernel-configuration/#the_latency_test_shows_high_latencies
you can disable hardware acceleration

-- 
					    Gilles.

