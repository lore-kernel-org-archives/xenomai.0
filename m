From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <20100114075343.GA5179@domain.hid>
References: <4B209B9C.7010309@domain.hid>
	<20100108105925.GA14163@domain.hid>
	<1262949018.2455.5.camel@domain.hid>
	<1263312199.2455.169.camel@domain.hid>
	<20100112172443.GP8605@domain.hid>
	<1263318551.2455.188.camel@domain.hid>
	<20100112185012.GQ8605@domain.hid>
	<1263324215.2455.293.camel@domain.hid>
	<20100112221802.GR8605@domain.hid>
	<20100114075343.GA5179@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Sun, 17 Jan 2010 23:00:06 +0100
Message-ID: <1263765606.2428.908.camel@domain.hid>
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
To: Richard Cochran <richardcochran@domain.hid>
Cc: adeos-main@gna.org, xenomai@xenomai.org, Lennart Sorensen <lsorense@domain.hid>

On Thu, 2010-01-14 at 08:53 +0100, Richard Cochran wrote: 
> On Tue, Jan 12, 2010 at 05:18:02PM -0500, Lennart Sorensen wrote:
> > Well I have not been able to find the magic invocation that lets me take
> > the DENX tree (which I have had around for a long time just to look at
> > occationally, whenever I was trying to get an ipipe patch to apply),
> > apply the ipipe patch, revert the DENX changes to get back to a release
> > kernel, and generate a diff of the ipipe changes.  It has never worked
> > when I tried.
> 
> Lennart,
> 
> It is not so hard (using git) to remove the Denx patches from the
> ipipe tree. I did this myself for 2.6.30 in about a half an hour. If
> you don't know how to use git, then you would have to consider the
> additional time you need to get to understand it. (For me, it was only
> a year or so ;)
> 
> In the ipipe tree, the Denx commits have been "squashed" together into
> one or two really large commits. So, you can just cherry pick the
> adeos commits into a new branch, with a few minor fixups.
> 
> Philippe,
> 
> I actually agree with Lennart that the Denx stuff is an
> annoyance. When considering my "no-denx" branch that I made, I could
> not see any significant Denx change that adeos builds upon. There were
> a few Denx fixes for one specific board that were close to the adeos
> changes, but these were only a few, and easy to fix. So, I could not
> understand why Denx is a prerequisite for adeos.
> 

As I explained earlier in my reply to Lennart, the DENX tree is not a
pre-requisite for having the pipeline run on each and every hw platform,
but this is still the case for some, because they are not
stable/complete/good enough in mainline yet. The reason to stick with it
stems from this fact.

What has to be reassessed, is the number of platforms Xenomai supports
that still need DENX bits today; if only a few of them remain in this
category, then it's probably sound to start maintaining the pipeline
support for them in a separate tree, rebasing I-pipe mainline over Linux
mainline for ppc as well. I have no issue with that.

> I understand that Denx sponsored the original PowerPC Xenomai port. Is
> the reason that ipipe is based on Denx simply to honor that fact? If
> so, I would not think it a bad reason at all.
> 

No, it's not, because if I had chosen to base the pipeline code for ppc
over mainline at that time, I would have maintained a DENX-based version
for the very reason you mentioned, until it proves useless.

> However, I would still prefer the following ordering for the changes:
> 
> 1. stable linux (2.6.xx.y)
> 2. adeos arch indepedendent
> 3. adeos powerpc
> 4. denx
> 5. adeos for denx (minimal changes, I expect)
> 

What we may be aiming at, if workable, is something like:

ipipe-*-mainline
ipipe-*-amcc
ipipe-*-512x

Maybe one for the PA6T as well, if we want to keep supporting the old A2
board rev. I'm unsure right now, since B0 is fine in mainline already.

A mainline pipeline branch for everything that directly works over
mainline, and platform-specific branches for those that do not. Those
special branches would then disappear as soon as mainline is fine for
the platforms they host as well.

> Richard
> 
> _______________________________________________
> Adeos-main mailing list
> Adeos-main@domain.hid
> https://mail.gna.org/listinfo/adeos-main


-- 
Philippe.






