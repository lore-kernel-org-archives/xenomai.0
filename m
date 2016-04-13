From: "Lennart Sorensen" <lsorense@csclub.uwaterloo.ca>
Date: Wed, 13 Apr 2016 14:57:57 -0400
Message-ID: <20160413185757.GT11630@csclub.uwaterloo.ca>
References: <CAHoW4hE=sh9dL_+LpCmO8qKhzfnMYQbu9Yx-2jf+6Cu4gDFUrg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHoW4hE=sh9dL_+LpCmO8qKhzfnMYQbu9Yx-2jf+6Cu4gDFUrg@mail.gmail.com>
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

On Wed, Apr 13, 2016 at 02:04:16PM -0400, Charles Kiorpes wrote:
> Hello,
> 
> I have been trying to bring up a Rev A2 BeagleBoard-x15 with i-pipe, in
> order to test Xenomai co-kernel functionality on this board.
> 
> I have verified that the kernel configuration settings that I'm using
> create a bootable mainline 4.1.18 kernel.
> 
> Once I patch the 4.1.18 kernel with ipipe-core-4.1.18-arm-4.patch, and make
> the same configuration changes, I am unable to boot the resulting kernel.
> 
> I have attached my kernel config and the kernel output from a failed boot.
> 
> The first major error (aside from some lock debug printouts) occurs at
> 2.141340, when the kernel attempts to dereference a NULL pointer.
> It appears that the problem is related to the PALMAS driver, but I am not
> well-versed in kernel development and don't know how to proceed.
> 
> What steps can I take to better debug and eventually correct the problem?

I have a suspicion that you have the wrong dtb file.

Yours says:

Hardware name: Generic DRA74X (Flattened Device Tree)

I would have expected something like:

Hardware name: TI AM5728 BeagleBoard-X15

Which kernel tree are you basing this on?

Certainly the AM5728 is known to work with ipipe, but so far with 3.14.x
kernel with xenomai 2.6.4.  I have not tried with xenomai 3.x yet or
the 4.1 kernel.  The palmas driver has no IRQ on our board though since
we have no power button or the other stuff that it has on the X15.

The X15 uses a tps659038 as an interrupt controller.  Maybe that code
isn't updated for ipipe use.  Our board has no such thing.  It may be
that your problem is that palmas requests and IRQ from the tps659038 and
if it's code isn't ipipe ready it could blow up when the irq is requested.

-- 
Len Sorensen

