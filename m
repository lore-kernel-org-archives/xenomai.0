From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <1262949018.2455.5.camel@domain.hid>
References: <4B209B9C.7010309@domain.hid>
	<20100108105925.GA14163@domain.hid>
	<1262949018.2455.5.camel@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 12 Jan 2010 17:03:19 +0100
Message-ID: <1263312199.2455.169.camel@domain.hid>
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
Cc: Bernhard Pfund <bernhard@domain.hid>, adeos-main@gna.org, xenomai@xenomai.org, Lennart Sorensen <lsorense@domain.hid>

On Fri, 2010-01-08 at 12:10 +0100, Philippe Gerum wrote:
> On Fri, 2010-01-08 at 11:59 +0100, Richard Cochran wrote:
> > On Thu, Dec 10, 2009 at 07:56:28AM +0100, Bernhard Pfund wrote:
> > > I'm currently working with a fairly new ppc development board (P2020RDB) by 
> > > Freescale. The board's BSP went mainline with 2.6.32 and I'd like to deploy an 
> > > I-pipe enabled DENX kernel for testing. Now, is there an I-pipe patch for said 
> > > kernel on the release schedule anywhere soon?
> > 
> > I got ipipe-2.6.30 running the p2020ds with minimal effort. I can post
> > a diff if that might help you.
> > 
> > I should have my own p2020rdb soon...
> > 
> > I have noticed some unexplained freezes running xenomai programs on
> > the p2020ds in SMP mode, but I have not yet had time to look into
> > it. I hope we can work together to get SMP working reliably.
> 
> I'm working on fixing the pipeline for 2.6.32/ppc64, which includes SMP
> mode. 32bit looks ok in UP mode, but I still need to validate SMP there.
> So it would be great if you could hammer that patch over your P2020 as
> well once it's ready. ETA, early next week. I'll keep you informed about
> this.

As expected, upgrading from 2.6.30 to 2.6.32 for ppc64 was a real pain.
Anyway, here is a patch which applies against 2.6.32.2 mainline; it is
pretty large because it also includes DENX-originated bits, from v2.6.32
to DENX-v2.6.32.

http://download.gna.org/adeos/patches/tmp/adeos-ipipe-2.6.32.2-powerpc-2.8-00.patch

This is expected to work over Xenomai 2.5.0. Tested over 52xx, 85xx, 4xx
for the 32bit support, pasemi for the 64bit part. I did not manage to
put my hands on a working ppc32/SMP board to give it a shot yet, so,
well, I wish you luck. This said, ppc64/SMP has been validated, so there
is hope.

Sidenote: ftrace may induce a massive stack consumption on ppc64 under
certain circumstances, causing kernel stack overflows. A way to work
around this should be to enable CONFIG_IRQSTACKS, but this won't work
with Xenomai over ppc64 yet, albeit this does work over ppc32. 

This patch is in a staging directory for now; waiting for some feedback
to go further.

HTH,

-- 
Philippe.



