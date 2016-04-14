MIME-Version: 1.0
In-Reply-To: <20160413185757.GT11630@csclub.uwaterloo.ca>
References: <CAHoW4hE=sh9dL_+LpCmO8qKhzfnMYQbu9Yx-2jf+6Cu4gDFUrg@mail.gmail.com>
 <20160413185757.GT11630@csclub.uwaterloo.ca>
Date: Thu, 14 Apr 2016 16:09:28 -0400
Message-ID: <CAHoW4hHtHAuqpqeCZkb3iebgqjzLR09qQHGE-zQi-3p5qN1yzg@mail.gmail.com>
From: Charles Kiorpes <ckiorpes@gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Xenomai] i-pipe patched 4.1.18 fails to boot on
 BeagleBoard-x15 (AM5728 processor)
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
Cc: xenomai@xenomai.org

I am using am57xx-beagle-x15.dts/dtb, as included in the mainline 4.1.18
source (not the ti-linux-kernel, just linux-stable).

The board I am using reports itself to u-boot as the TI AM572x GP EVM,
which I understood to simply be a change in the eeprom, and should be
compatible with the beagle-x15 device tree (EVM device tree merely adds the
expansion board functionality, which I don't need).

I noticed the discrepancy with the naming as well.  I did see the correct
printout for "Machine model: TI AM5728 BeagleBoard-X15", but all of the
failure printouts show "Hardware name: Generic DRA74X (Flattened Device
Tree)".

I hope that the case is not that an entire interrupt controller's code
needs to be made ipipe-ready, because that is pretty far out of my league.
However, I will look further into the tps659038.

I removed the palmas driver in stages (piece by piece across several kernel
builds and test boots), and still wound up with a null dereference, even
when the driver was completely removed from the kernel config.

For your successful Xenomai 2.6.4 run on the 3.14 kernel, were you using
the ti-linux-kernel, or mainline?  I would be perfectly content to test on
Xenomai 2.6.4 for the short term, so it would be great to just get a kernel
running, even with limited peripheral support.

Thanks for your help,
Charles



On Wed, Apr 13, 2016 at 2:57 PM, Lennart Sorensen <
lsorense@csclub.uwaterloo.ca> wrote:

> On Wed, Apr 13, 2016 at 02:04:16PM -0400, Charles Kiorpes wrote:
> > Hello,
> >
> > I have been trying to bring up a Rev A2 BeagleBoard-x15 with i-pipe, in
> > order to test Xenomai co-kernel functionality on this board.
> >
> > I have verified that the kernel configuration settings that I'm using
> > create a bootable mainline 4.1.18 kernel.
> >
> > Once I patch the 4.1.18 kernel with ipipe-core-4.1.18-arm-4.patch, and
> make
> > the same configuration changes, I am unable to boot the resulting kernel.
> >
> > I have attached my kernel config and the kernel output from a failed
> boot.
> >
> > The first major error (aside from some lock debug printouts) occurs at
> > 2.141340, when the kernel attempts to dereference a NULL pointer.
> > It appears that the problem is related to the PALMAS driver, but I am not
> > well-versed in kernel development and don't know how to proceed.
> >
> > What steps can I take to better debug and eventually correct the problem?
>
> I have a suspicion that you have the wrong dtb file.
>
> Yours says:
>
> Hardware name: Generic DRA74X (Flattened Device Tree)
>
> I would have expected something like:
>
> Hardware name: TI AM5728 BeagleBoard-X15
>
> Which kernel tree are you basing this on?
>
> Certainly the AM5728 is known to work with ipipe, but so far with 3.14.x
> kernel with xenomai 2.6.4.  I have not tried with xenomai 3.x yet or
> the 4.1 kernel.  The palmas driver has no IRQ on our board though since
> we have no power button or the other stuff that it has on the X15.
>
> The X15 uses a tps659038 as an interrupt controller.  Maybe that code
> isn't updated for ipipe use.  Our board has no such thing.  It may be
> that your problem is that palmas requests and IRQ from the tps659038 and
> if it's code isn't ipipe ready it could blow up when the irq is requested.
>
> --
> Len Sorensen
>
