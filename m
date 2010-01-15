From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <20100112221802.GR8605@domain.hid>
References: <4B209B9C.7010309@domain.hid>
	<20100108105925.GA14163@domain.hid>
	<1262949018.2455.5.camel@domain.hid>
	<1263312199.2455.169.camel@domain.hid>
	<20100112172443.GP8605@domain.hid>
	<1263318551.2455.188.camel@domain.hid>
	<20100112185012.GQ8605@domain.hid>
	<1263324215.2455.293.camel@domain.hid>
	<20100112221802.GR8605@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 15 Jan 2010 16:03:31 +0100
Message-ID: <1263567811.2428.487.camel@domain.hid>
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

On Tue, 2010-01-12 at 17:18 -0500, Lennart Sorensen wrote: 
> On Tue, Jan 12, 2010 at 08:23:35PM +0100, Philippe Gerum wrote:
> > This is likely because your knowledge overwhelms mine. I'm only a moron,
> > so git diff with a proper commit number, or even patch -R does work for
> > me. Simple things always work for simple idiots, it's a fact of life.
> 
> Well I have not been able to find the magic invocation that lets me take
> the DENX tree (which I have had around for a long time just to look at
> occationally, whenever I was trying to get an ipipe patch to apply),
> apply the ipipe patch, revert the DENX changes to get back to a release
> kernel, and generate a diff of the ipipe changes.  It has never worked
> when I tried.

To get a complete pipeline, you need the -noarch side, and the -powerpc
side. ipipe-2.6.32-powerpc is based on ipipe-2.6.32-noarch, which is
based on v2.6.32 mainline. From the official I-pipe tree located there:
git://git.denx.de/ipipe-2.6.git

$ git log --abbrev-commit --oneline -4 ipipe-2.6.32-powerpc

gives:

704529e powerpc/ipipe: arch-dependent bits for 2.6.32.2
2cc8efe Merge branch 'DENX-v2.6.32' into ipipe-2.6.32-newppc
01765d4 powerpc: merge DENX-v2.6.32 bits
ea15238 powerpc: merge 2.6.32.2 -stable

So, what you want is a merge between 2.6.32.2 mainline and the powerpc
bits, skipping the DENX bits:

$ git checkout -b ipipe-mainline ipipe-2.6.32-noarch
$ git cherry-pick ea15238
$ git cherry-pick 704529e

This will lead to two trivial rejects, one is in the ppc64 section you
do not care about, the other in process.c, which is a hunk related to
supporting the PA6T 64bit architecture as well, which you don't care
about, either.

# unmerged:   arch/powerpc/kernel/process.c
# unmerged:   arch/powerpc/mm/hash_native_64.c

Basically, it's a 2 minutes work. Granted, it applies to 2.6.32.2 only,
and more conflicts could pop up with different revisions of this work;
but this has never been a massive pain to move from a DENX tree to
mainline, and I did it quite a few times.

> 
> > If you do think that the situation for x86 must be applicable to any
> > other architecture, then I really can't do anything for you, except
> > perhaps suggest to get your feet a bit more wet with those, and probably
> > do some reality check against your knowledge of the embedded world.
> 
> Actually yes I think the x86 situation should be applicable to other
> architectures.  I am currently running embedded x86, powerpc and coldfire,
> all using release kernels.  That to me is a highly desirable goal.
> The coldfire was painful a year ago, but it sure has come a long way in
> that year.
> 

x86 does not qualify for this discussion; with a x86-based system, even
if the kernel at hand does not support the very latest fancy device you
have on board, your kernel will likely still boot and run properly. On
the other hand, you would not even try booting your mpc8360 over a
kernel built for 44x. But given you want to support both, if either of
both happen to be in a poor state in your reference tree, things start
hitting the crapper. The DENX tree saved my day so far, because it
allowed me to work on all powerpc platforms from a single code base.

> > Aside of this, I don't intend to get dragged into such a discussion,
> > it's a pure loss of time. So please, take what I can offer, or just
> > blame me for being an idiot to have a different perspective from yours,
> > but don't waste my bandwidth. I need it direly to be able to issue
> > patches you can use, even at the expense of cloning a git tree.
> 
> Well debian used to try and package xenomai.  They are still on 2.4.8.
> I suspect they may have given up on it given that they only use release
> kernels, and many of the patches are useless in that case.  What's the
> point of trying then.

The Blackfin uClinux distro was still shipping 2.4.7 in their latest
2009R1 release, albeit they merged the Blackfin-specific bits from the
pipeline into their official kernel tree, many moons ago. Incidentally,
I'm maintaining those bits for their development kernel directly feeding
mainline, so I don't think your reasoning should be generalized.

This said, if you have first hand information from the Debian team
regarding this, maybe you should tell them to drop us a note; we would
be happy to help.

> 
> > However, if you do think that some good reason might exist to work with
> > DENX material when it comes to powerpc over embedded platforms, but want
> > to help in issuing a mainline-based version of the pipeline patches
> > regularly, then I would agree to ease your task.
> 
> Well I do work with embedded powerpc, and so far have had no use for
> the DENX tree.  I have no idea what powerpc systems need stuff from the
> DENX tree to work, but certainly not the mpc8360 I deal with.
> 

I understand your point from your perspective. But maintaining our code
base for mpc8360 only is not enough for us.

The reason why the powerpc patches are DENX-based is simply that this
tree worked for me over time, for various platforms (52xx, 4xx/44x, pa6t
come to mind), way before mainline did. Xenomai supports recent
platforms like the 512x series precisely because of that as well.

Does this mean that the pipeline patches will be based on the DENX tree
until hell freezes? No, this does not, because the DENX folks are doing
their job as well, and make their best to close the gap between their
tree and mainline, taking all needed provisions to get their bits merged
upstream sooner.

A sidenote though: you can run Xenomai over mpc8360 because DENX
published this support which was initially based on their tree, on
behalf of a customer, like a bunch of other developments:
http://www.denx.de/en/Software/SoftwareXenomaiProjects
This makes your argument, about not depending on anything being
DENX-originated, sound a bit weird. Make no mistake, you owe them quite
a few kudos. Actually, anyone running Xenomai over powerpc owe them a
lot.

> > So, instead of complaining about how things are not done the way you
> > want, do you agree to help in changing this situation, or what? 
> 
> I did manage to port the 2.6.30-DENX patch to 2.6.32 pure tree rather
> successfully and sent it to the list.  It did take a few hours.
> 

You did port the pipeline to 2.6.32/ppc32 for running on mpc8360, which
fits your needs. But the pipeline patch has to be upgraded for ppc64 as
well. Even for ppc32, a patch is normally validated for a set of 4xx,
512x, 52xx, 82xx, 85xx, and 86xx platforms, by the Xenomai standards:
http://www.xenomai.org/index.php/Embedded_Device_Support#Supported_Evaluation_Boards_3

Btw, your patch never made it to the list, since this is a
subscriber-only list, and last time I checked, you were not subscribed.
Or maybe you posted from a different mail address, but I did not see
your mail though. I usually acknowledge public contributions.

> Having a patch for the DENX tree is useful to some, but having a patch for
> the real Linux tree seems a lot more useful.
>   How about having both then?
> I am willing to help deal with making the patch work on real kernels if
> that makes it easier.

That is good to hear. This said, the DENX tree is based on mainline like
zillions of other trees, and as you certainly know, many of those trees
are feeding mainline with arch-specific improvements and new platform or
driver support. So the concepts of "real Linux tree" or "real kernel",
"or pure tree" bear absolutely no value. The latest "pure" Linux tree
probably dates back to 1994 or so.

>   At least then there would be something that could
> be used by people using a single kernel tree for multiple architectures.
> 

Publishing the DENX-based support on a separate branch for ppc platforms
which have incomplete support upstream, along with a mainline-based
branch for the rest, is something I could handle.

The way for you to help is certainly about testing the mainline-based
branch which will probably appear for 2.6.33, and send feedback/fixes
as/if needed.

-- 
Philippe.





