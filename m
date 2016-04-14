From: "Lennart Sorensen" <lsorense@csclub.uwaterloo.ca>
Date: Thu, 14 Apr 2016 16:23:18 -0400
Message-ID: <20160414202318.GV11630@csclub.uwaterloo.ca>
References: <CAHoW4hE=sh9dL_+LpCmO8qKhzfnMYQbu9Yx-2jf+6Cu4gDFUrg@mail.gmail.com>
 <20160413185757.GT11630@csclub.uwaterloo.ca>
 <CAHoW4hHtHAuqpqeCZkb3iebgqjzLR09qQHGE-zQi-3p5qN1yzg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHoW4hHtHAuqpqeCZkb3iebgqjzLR09qQHGE-zQi-3p5qN1yzg@mail.gmail.com>
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
To: Charles Kiorpes <ckiorpes@gmail.com>
Cc: xenomai@xenomai.org

On Thu, Apr 14, 2016 at 04:09:28PM -0400, Charles Kiorpes wrote:
> I am using am57xx-beagle-x15.dts/dtb, as included in the mainline 4.1.18
> source (not the ti-linux-kernel, just linux-stable).

Oh.  I hadn't noticed that they had it sufficiently mainlined by now.
That's good.

> The board I am using reports itself to u-boot as the TI AM572x GP EVM,
> which I understood to simply be a change in the eeprom, and should be
> compatible with the beagle-x15 device tree (EVM device tree merely adds the
> expansion board functionality, which I don't need).

That sounds reasonable.

> I noticed the discrepancy with the naming as well.  I did see the correct
> printout for "Machine model: TI AM5728 BeagleBoard-X15", but all of the
> failure printouts show "Hardware name: Generic DRA74X (Flattened Device
> Tree)".

Oh that's odd.  I wonder why that happens.

Hmm, seems that any AM572x will match:
DT_MACHINE_START(DRA74X_DT, "Generic DRA74X (Flattened Device Tree)")
while AM571x will match:
DT_MACHINE_START(DRA72X_DT, "Generic DRA72X (Flattened Device Tree)")

That's in arch/arm/mach-omap2/board-generic.c

So doesn't mean anything much and simply means the dtb used contained
the right compat string to startup as the right CPU type.

> I hope that the case is not that an entire interrupt controller's code
> needs to be made ipipe-ready, because that is pretty far out of my league.
> However, I will look further into the tps659038.
> 
> I removed the palmas driver in stages (piece by piece across several kernel
> builds and test boots), and still wound up with a null dereference, even
> when the driver was completely removed from the kernel config.
> 
> For your successful Xenomai 2.6.4 run on the 3.14 kernel, were you using
> the ti-linux-kernel, or mainline?  I would be perfectly content to test on
> Xenomai 2.6.4 for the short term, so it would be great to just get a kernel
> running, even with limited peripheral support.

Using ti-linux-kernel ti-linux-3.14.y branch.

-- 
Len Sorensen

