From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <20100112185012.GQ8605@domain.hid>
References: <4B209B9C.7010309@domain.hid>
	<20100108105925.GA14163@domain.hid>
	<1262949018.2455.5.camel@domain.hid>
	<1263312199.2455.169.camel@domain.hid>
	<20100112172443.GP8605@domain.hid>
	<1263318551.2455.188.camel@domain.hid>
	<20100112185012.GQ8605@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 12 Jan 2010 20:23:35 +0100
Message-ID: <1263324215.2455.293.camel@domain.hid>
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

On Tue, 2010-01-12 at 13:50 -0500, Lennart Sorensen wrote:
> On Tue, Jan 12, 2010 at 06:49:11PM +0100, Philippe Gerum wrote:
> > > > As expected, upgrading from 2.6.30 to 2.6.32 for ppc64 was a real pain.
> > > > Anyway, here is a patch which applies against 2.6.32.2 mainline; it is
> > > > pretty large because it also includes DENX-originated bits, from v2.6.32
> > > > to DENX-v2.6.32.
> > > > 
> > > > http://download.gna.org/adeos/patches/tmp/adeos-ipipe-2.6.32.2-powerpc-2.8-00.patch
> > > > 
> > > > This is expected to work over Xenomai 2.5.0. Tested over 52xx, 85xx, 4xx
> > > > for the 32bit support, pasemi for the 64bit part. I did not manage to
> > > > put my hands on a working ppc32/SMP board to give it a shot yet, so,
> > > > well, I wish you luck. This said, ppc64/SMP has been validated, so there
> > > > is hope.
> > > > 
> > > > Sidenote: ftrace may induce a massive stack consumption on ppc64 under
> > > > certain circumstances, causing kernel stack overflows. A way to work
> > > > around this should be to enable CONFIG_IRQSTACKS, but this won't work
> > > > with Xenomai over ppc64 yet, albeit this does work over ppc32. 
> > > > 
> > > > This patch is in a staging directory for now; waiting for some feedback
> > > > to go further.
> > > 
> > > Any chance of getting it without the DENX bits since some of us really
> > > really don't care for those and want to apply against Linus's releases
> > > only.  Having the patch always fail to apply is rather annoying.
> > > 
> > 
> > It turns out that it really, really annoys me not to have the DENX bits
> > in when working on embedded powerpc targets, but you do have the option
> > of cloning git://git.denx.de/ipipe-2.6.git, and diff whatever you see
> > fit with commit 9d81556f or later.
> 
> It seems to me that releasing xenomai and ipipe releases that don't
> apply cleanly to official linux release versions is just rediculous.
> The x86 parts seem to work fine with Linus's releases, why should any
> other architecture be different?  It is rather inconvinient for a lot
> of people.
> 
> I don't believe there is any clean way to generate an ipipe patch for
> Linus's official releases when they contain bits intended to go with
> the DENX tree.  There are just too many changes all over the place.
> 
> 

This is likely because your knowledge overwhelms mine. I'm only a moron,
so git diff with a proper commit number, or even patch -R does work for
me. Simple things always work for simple idiots, it's a fact of life.

> Users of the DENX tree are a tiny minority compared to the users of the
> official kernel releases.  That majority should be the target of releases.
> 

If you do think that the situation for x86 must be applicable to any
other architecture, then I really can't do anything for you, except
perhaps suggest to get your feet a bit more wet with those, and probably
do some reality check against your knowledge of the embedded world.

Aside of this, I don't intend to get dragged into such a discussion,
it's a pure loss of time. So please, take what I can offer, or just
blame me for being an idiot to have a different perspective from yours,
but don't waste my bandwidth. I need it direly to be able to issue
patches you can use, even at the expense of cloning a git tree.

However, if you do think that some good reason might exist to work with
DENX material when it comes to powerpc over embedded platforms, but want
to help in issuing a mainline-based version of the pipeline patches
regularly, then I would agree to ease your task.

So, instead of complaining about how things are not done the way you
want, do you agree to help in changing this situation, or what? 

-- 
Philippe.



