From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <20100118175113.GF24305@domain.hid>
References: <20100108105925.GA14163@domain.hid>
	<1262949018.2455.5.camel@domain.hid>
	<1263312199.2455.169.camel@domain.hid>
	<20100112172443.GP8605@domain.hid>
	<1263318551.2455.188.camel@domain.hid>
	<20100112185012.GQ8605@domain.hid>
	<1263324215.2455.293.camel@domain.hid>
	<20100112221802.GR8605@domain.hid>
	<20100114075343.GA5179@domain.hid>
	<1263765606.2428.908.camel@domain.hid>
	<20100118175113.GF24305@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 20 Jan 2010 23:42:17 +0100
Message-ID: <1264027337.2350.59.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [Adeos-main] I-pipe for 2.6.32 PPC
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Lennart Sorensen <lsorense@domain.hid>
Cc: adeos-main@gna.org, xenomai@xenomai.org

On Mon, 2010-01-18 at 12:51 -0500, Lennart Sorensen wrote:
> On Sun, Jan 17, 2010 at 11:00:06PM +0100, Philippe Gerum wrote:
> > As I explained earlier in my reply to Lennart, the DENX tree is not a
> > pre-requisite for having the pipeline run on each and every hw platform,
> > but this is still the case for some, because they are not
> > stable/complete/good enough in mainline yet. The reason to stick with it
> > stems from this fact.
> > 
> > What has to be reassessed, is the number of platforms Xenomai supports
> > that still need DENX bits today; if only a few of them remain in this
> > category, then it's probably sound to start maintaining the pipeline
> > support for them in a separate tree, rebasing I-pipe mainline over Linux
> > mainline for ppc as well. I have no issue with that.
> 
> Sounds great to me.
> 
> > What we may be aiming at, if workable, is something like:
> > 
> > ipipe-*-mainline
> > ipipe-*-amcc
> > ipipe-*-512x
> > 
> > Maybe one for the PA6T as well, if we want to keep supporting the old A2
> > board rev. I'm unsure right now, since B0 is fine in mainline already.
> > 
> > A mainline pipeline branch for everything that directly works over
> > mainline, and platform-specific branches for those that do not. Those
> > special branches would then disappear as soon as mainline is fine for
> > the platforms they host as well.
> 
> I also noticed on Friday that applying both x86 and powerpc ipipe
> patches to one kernel tree is a bit problematic.  Obviously both
> include the noarch section, but dealing with that is simple.
> The only actual problem that had to be solved is that both xenomai
> architectures try to include arch/<archname>/xenomai/Kconfig which
> conflict with each other.  Merging the x86 and powerpc Kconfig bits
> together in one file isn't hard and allows both to work with a single
> included file.
> 
> The reason I want this is that I very much intend to have a single 2.6.32
> kernel source build with the same patches on both our x86 based embedded
> systems and our powerpc based embedded systems.
> 
> Is there any interest in getting such cleanup done to make the code
> just apply all together?  If so I will try to finish adding the other
> architectures together too.
> 

If you can make this work cleanly, while keeping the ability to separate
arch-dep sections in different patches, I'm a taker. Even if having
separate per-architecture patches is better for decoupling their release
cycle (issuing a jumbo patch each time minor updates appear only in a
single arch-dep section is not suitable), we could also provide an
integrated patch by combining all per-arch bits and a single no-arch
section.


-- 
Philippe.



