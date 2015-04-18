Date: Sat, 18 Apr 2015 08:56:47 +0200
From: Maxime Ripard <maxime.ripard@free-electrons.com>
Message-ID: <20150418065647.GU15807@lukather>
References: <1429171505-5598-1-git-send-email-kinsamanka@gmail.com>
 <20150416131956.GC1589@hermes.click-hack.org>
 <CACreCVJd-1c8iYGuEJE4W_6Q4dpo4sPOtJvDLbQaTUN2m8Bwpw@mail.gmail.com>
 <20150416161629.GF1589@hermes.click-hack.org>
 <552FE54F.6090606@siemens.com>
 <20150416164310.GH1589@hermes.click-hack.org>
 <552FE904.50804@siemens.com>
 <20150416165600.GI1589@hermes.click-hack.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20150416165600.GI1589@hermes.click-hack.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [PATCH] Add support for SUNXI boards
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, GP Orcullo <kinsamanka@gmail.com>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On Thu, Apr 16, 2015 at 06:56:00PM +0200, Gilles Chanteperdrix wrote:
> On Thu, Apr 16, 2015 at 06:53:24PM +0200, Jan Kiszka wrote:
> > On 2015-04-16 18:43, Gilles Chanteperdrix wrote:
> > > On Thu, Apr 16, 2015 at 06:37:35PM +0200, Jan Kiszka wrote:
> > >> On 2015-04-16 18:16, Gilles Chanteperdrix wrote:
> > >>> On Fri, Apr 17, 2015 at 12:04:22AM +0800, GP Orcullo wrote:
> > >>>> On Thu, Apr 16, 2015 at 9:19 PM, Gilles Chanteperdrix
> > >>>> <gilles.chanteperdrix@xenomai.org> wrote:
> > >>>>> On Thu, Apr 16, 2015 at 04:05:05PM +0800, GP Orcullo wrote:
> > >>>>>> Tested on a Cubieboard2 with v3.16.7-ckt9 kernel.
> > >>>>>
> > >>>>> Does not sunxi have GPIO ?
> > >>>>>
> > >>>>> --
> > >>>>>                                             Gilles.
> > >>>>
> > >>>> There's no GPIO driver in the mainline kernel. The original sunxi
> > >>>> kernel has incomplete support for GPIOs.
> > >>>
> > >>> Ok, what about timer and tsc? Basically, you should run through the
> > >>> ARM porting guide and check every modification to be made. And if
> > >>> you have done so, the commit message should mention it.
> > >>
> > >> sunxi is pretty generic ARMv7-class in that regard, but double-checking
> > >> is surely better.
> > > 
> > > armv7 does not mean a particular timer. Cortex A9 or cortex A15 do,
> > > but different ones, and Cortex A8 does not for instance. The
> > > processor we are talking about is probably not a cortex A9 since on
> > > I-pipe, there is no timer or tsc defined on A9 when booting in UP
> > > mode (and GP Orcullo is booting in UP mode). So my question is not
> > > about "double-checking", it is rather the first check.
> > 
> > The A20 is a dual-core Cortex A7.
> 
> Strange that GP Orcullo is not running the kernel in SMP mode then.

The A20 uses PSCI to implement its SMP ops, which requires some
cooperation from the bootloader. Maybe he just has a too ancient
bootloader.

> The question still stands, what does this processor/core use as
> timer/tsc?

ARM's architected timers, mostly.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://www.xenomai.org/pipermail/xenomai/attachments/20150418/54cedb2d/attachment.sig>
