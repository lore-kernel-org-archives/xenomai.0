Date: Mon, 8 Feb 2016 21:42:58 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20160208204258.GC5654@hermes.click-hack.org>
References: <20160202205945.GC29937@hermes.click-hack.org>
 <20160203003212.GE27804@deathstar>
 <20160203004307.GA18030@hermes.click-hack.org>
 <20160203012135.GF27804@deathstar>
 <20160203013118.GC18030@hermes.click-hack.org>
 <20160203013615.GG27804@deathstar>
 <20160203013752.GD18030@hermes.click-hack.org>
 <20160203014247.GH27804@deathstar>
 <20160203015139.GE18030@hermes.click-hack.org>
 <20160203144724.GA25464@deathstar>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160203144724.GA25464@deathstar>
Subject: Re: [Xenomai] IMX6 Quad inconsistent lock state
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Michael Welling <mwelling@ieee.org>
Cc: xenomai@xenomai.org

On Wed, Feb 03, 2016 at 08:47:24AM -0600, Michael Welling wrote:
> On Wed, Feb 03, 2016 at 02:51:40AM +0100, Gilles Chanteperdrix wrote:
> > Indeed, I even looked at it. Sorry. It is late here, I will try and
> > use it tomorrow.
> >
> 
> Any luck replicating the build error?

Hi,

I replicate the build error with your .config. The reason why the
build tests do not have the build error is that they enable
CONFIG_XENO_OPT_DEBUG_LOCKING, which disables the "smp-on-up"
optimization for Xenomai locks.

So, we are missing an EXPORT_SYMBOL, or more likely
EXPORT_SYMBOL_GPL in the I-pipe code.

Regards.

-- 
					    Gilles.
https://click-hack.org

