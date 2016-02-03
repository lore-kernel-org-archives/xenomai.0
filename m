Date: Wed, 3 Feb 2016 16:33:41 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20160203153341.GG32138@hermes.click-hack.org>
References: <20160203145146.GB25464@deathstar>
 <20160203150448.GF32138@hermes.click-hack.org>
 <20160203151802.GC25464@deathstar>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160203151802.GC25464@deathstar>
Subject: Re: [Xenomai] RT FEC net driver for IMX6Q
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

On Wed, Feb 03, 2016 at 09:18:02AM -0600, Michael Welling wrote:
> On Wed, Feb 03, 2016 at 04:04:48PM +0100, Gilles Chanteperdrix wrote:
> > On Wed, Feb 03, 2016 at 08:51:46AM -0600, Michael Welling wrote:
> > > Is there any specific reason why the fec driver is restricted to the PPC
> > > arcitecture?
> > 
> > In its current state, the driver does not compile for IMX6. A broken
> > patch has been proposed, my idea is to work on RTnet core before
> > tackling the drivers, but if a patch fixing the build for imx6 is
> > proposed, it could be re-enabled.
> >
> 
> What are the issues with the RTnet core?

The main issue is that it predates many factorizations in the Linux
kernel code and so could be made simpler by relying on them. It open
codes linked lists for instance, this is just a random example.
Another issue is that keeping the drivers synchronized with their
mainline counter-part requires a big maintenance effort.

> 
> I just found out the hard way that the driver does not compile.
> I will try my best to update the IMX drivers so that they build
> with 3.18.20.

A patch has been posted here:
https://xenomai.org/pipermail/xenomai/2016-January/035756.html

-- 
					    Gilles.
https://click-hack.org

