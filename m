From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <20100115161415.GA24305@domain.hid>
References: <4B209B9C.7010309@domain.hid>
	<20100108105925.GA14163@domain.hid>
	<1262949018.2455.5.camel@domain.hid>
	<1263312199.2455.169.camel@domain.hid>
	<20100112172443.GP8605@domain.hid>
	<1263318551.2455.188.camel@domain.hid>
	<20100112185012.GQ8605@domain.hid>
	<1263324215.2455.293.camel@domain.hid>
	<20100112221802.GR8605@domain.hid>
	<1263567811.2428.487.camel@domain.hid>
	<20100115161415.GA24305@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 15 Jan 2010 18:22:24 +0100
Message-ID: <1263576144.2428.527.camel@domain.hid>
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
Cc: Bernhard Pfund <bernhard@domain.hid>, xenomai@xenomai.org, adeos-main@gna.org

On Fri, 2010-01-15 at 11:14 -0500, Lennart Sorensen wrote:
> On Fri, Jan 15, 2010 at 04:03:31PM +0100, Philippe Gerum wrote:
> > To get a complete pipeline, you need the -noarch side, and the -powerpc
> > side. ipipe-2.6.32-powerpc is based on ipipe-2.6.32-noarch, which is
> > based on v2.6.32 mainline. From the official I-pipe tree located there:
> > git://git.denx.de/ipipe-2.6.git
> > 
> > $ git log --abbrev-commit --oneline -4 ipipe-2.6.32-powerpc
> 
> rceng02:/data/git-trees/ipipe-2.6# git log --abbrev-commit --oneline -4 ipipe-2.6.32-powerpc
> fatal: ambiguous argument 'ipipe-2.6.32-powerpc': unknown revision or path not in the working tree.
> Use '--' to separate paths from revisions
> 

>From your end, the ipipe branches you care of are remote ones available
from the "origin" namespace, so you should try
origin/ipipe-2.6.32-powerpc, and origin/ipipe-2.6.32-noarch is specs.

> Hmm, is my git version too old?
> 

No, I think it's fine.

<snip>

> > x86 does not qualify for this discussion; with a x86-based system, even
> > if the kernel at hand does not support the very latest fancy device you
> > have on board, your kernel will likely still boot and run properly. On
> > the other hand, you would not even try booting your mpc8360 over a
> > kernel built for 44x. But given you want to support both, if either of
> > both happen to be in a poor state in your reference tree, things start
> > hitting the crapper. The DENX tree saved my day so far, because it
> > allowed me to work on all powerpc platforms from a single code base.
> 
> Certainly kernels for embedded systems often are only menat for one
> system.  That doesn't mean you couldn't build a kernel with support for
> multiple systems.
> 

Sure, but for that, you need to have a single source tree that works for
both. This is the gist of the issue I'm facing.

> > The Blackfin uClinux distro was still shipping 2.4.7 in their latest
> > 2009R1 release, albeit they merged the Blackfin-specific bits from the
> > pipeline into their official kernel tree, many moons ago. Incidentally,
> > I'm maintaining those bits for their development kernel directly feeding
> > mainline, so I don't think your reasoning should be generalized.
> > 
> > This said, if you have first hand information from the Debian team
> > regarding this, maybe you should tell them to drop us a note; we would
> > be happy to help.
> 
> No I don't.  Just speculation.  I just remember trying to use the package
> and finding that it simply could not apply to the released kernel sources.
> 
> > I understand your point from your perspective. But maintaining our code
> > base for mpc8360 only is not enough for us.
> > 
> > The reason why the powerpc patches are DENX-based is simply that this
> > tree worked for me over time, for various platforms (52xx, 4xx/44x, pa6t
> > come to mind), way before mainline did. Xenomai supports recent
> > platforms like the 512x series precisely because of that as well.
> > 
> > Does this mean that the pipeline patches will be based on the DENX tree
> > until hell freezes? No, this does not, because the DENX folks are doing
> > their job as well, and make their best to close the gap between their
> > tree and mainline, taking all needed provisions to get their bits merged
> > upstream sooner.
> 
> Well I hope it happens soon.  Things always become much easier when you
> can work with the official kernel releases.  The powerpc support in the
> main kernel tree seem rather good.
> 

Generally yes, it is. We just have to deal with exceptions, and those
exceptions used to be many. I agree that things evolve and the situation
has to be reassessed from time to time, though. It's probably a good
time to do this.

> > A sidenote though: you can run Xenomai over mpc8360 because DENX
> > published this support which was initially based on their tree, on
> > behalf of a customer, like a bunch of other developments:
> > http://www.denx.de/en/Software/SoftwareXenomaiProjects
> > This makes your argument, about not depending on anything being
> > DENX-originated, sound a bit weird. Make no mistake, you owe them quite
> > a few kudos. Actually, anyone running Xenomai over powerpc owe them a
> > lot.
> 
> Oh I know that.  We paid for it.  It was well worth it.  That doesn't
> mean I want to use the DENX kernel tree.

But at least, you know for sure why having a working kernel is
important, specially to those who cannot rely on mainline yet.

> 
> > You did port the pipeline to 2.6.32/ppc32 for running on mpc8360, which
> > fits your needs. But the pipeline patch has to be upgraded for ppc64 as
> > well. Even for ppc32, a patch is normally validated for a set of 4xx,
> > 512x, 52xx, 82xx, 85xx, and 86xx platforms, by the Xenomai standards:
> > http://www.xenomai.org/index.php/Embedded_Device_Support#Supported_Evaluation_Boards_3
> 
> Well I managed to get every piece except a few ppc64 bits (which as
> usual seemed to only apply to parts of the DENX tree.  When will those
> bits go mainline I wonder.  They seem to have been there for a while now).
> 
> I can only test on the 83xx boards we have here, but the person I gave
> a copy to said it worked for him, which was a different board, so it
> can't have been too bad.

It was likely fine, this was not my point. My point was rather that
testing this on all of the hw platforms we are supposed to test it is
much easier from a single code base.

> 
> > Btw, your patch never made it to the list, since this is a
> > subscriber-only list, and last time I checked, you were not subscribed.
> > Or maybe you posted from a different mail address, but I did not see
> > your mail though. I usually acknowledge public contributions.
> 
> I gave a copy to someone else that saked for it who said they would post
> a copy.

For some reason, the patch entered the twilight zone before I could pick
it. Maybe one of my spam filters, I don't know yet, I'll check.

> 
> > That is good to hear. This said, the DENX tree is based on mainline like
> > zillions of other trees, and as you certainly know, many of those trees
> > are feeding mainline with arch-specific improvements and new platform or
> > driver support. So the concepts of "real Linux tree" or "real kernel",
> > "or pure tree" bear absolutely no value. The latest "pure" Linux tree
> > probably dates back to 1994 or so.
> 
> OK, I will call it "Linus's tree from which released kernels are made".
> Specifically patches that apply to those released kernels are nice.
> Of course point release fixes to those release kernels can still break
> the patch.  That's life when working out of tree.

Nope, actually, AFAIC, working out of tree is no life. But someone has
to do it, sometimes.

> 
> > Publishing the DENX-based support on a separate branch for ppc platforms
> > which have incomplete support upstream, along with a mainline-based
> > branch for the rest, is something I could handle.
> 
> Makes sense to me.  Certainly not having support for platforms just
> because the released kernels doesn't support it yet would be silly.
> Just as not having support for people who are running release kernels
> also seems silly.  Both seem very useful.
> 
> > The way for you to help is certainly about testing the mainline-based
> > branch which will probably appear for 2.6.33, and send feedback/fixes
> > as/if needed.
> 
> I will certainly be testing it.
> 

Ok, thanks. I will keep you posted.

-- 
Philippe.



