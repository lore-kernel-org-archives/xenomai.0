Date: Wed, 27 Sep 2017 10:39:48 -0400
Message-ID: <20170927143948.b5idby3cd7ncevck@csclub.uwaterloo.ca>
References: <CAKJ14NdyH7FF+pwj9J-FLSnCWHOqAteKVrrbagA4eqhvETgFoA@mail.gmail.com>
 <CAKJ14NfuNCtfK9bT5Oh+dRYAKhW+4KgaFO5w=xt=exJOw6forQ@mail.gmail.com>
 <e847e788-f0c4-9d27-9dd7-4cb9c22de649@xenomai.org>
 <CAKJ14NcCac2Q32b8tGsNKXYZX9toGsxBEvXGt+2Pa8FYrihdKQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKJ14NcCac2Q32b8tGsNKXYZX9toGsxBEvXGt+2Pa8FYrihdKQ@mail.gmail.com>
From: lsorense@csclub.uwaterloo.ca (Lennart Sorensen)
Subject: Re: [Xenomai] Unexpected mode switches when reordering C++ lines
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Andreas Glatz <andi.glatz@gmail.com>
Cc: xenomai@xenomai.org

On Wed, Sep 27, 2017 at 02:37:39PM +0100, Andreas Glatz wrote:
> It's true according to the ARM doc [1]. But the pDat alignment is
> prescribed by the sender and we're at the receiver. So I guess the
> question is how to tell the assembler not to use ldm in the first
> place?

It certainly looks like the code somehow is optimizing two consequitive
32 bit reads into a single 64 bit read, but then the input is not 64 bit
aligned (but is 32 bit aligned) which causes an alignment exception on
the 64 bit read while the 32 bit reads were fine.

One would think the compiler should NOT be doing that.

Now as far as I remember, armv7 (which is what you appear to have)
allows unaligned accesses to normal memory, but not to IO ports or other
special memory.  I recall hitting a case where someone had flagged
some memory as DMA which caused the alignement exception to be hit.
Since the memory really had no reason to be flagged for DMA or anything
else special it was easy to fix.

Is the memory at your pointer allocated with any special flags or is
it device memory?  Because if it isn't, then you shouldn't as far as I
recall be hitting that exception.

Part of the problem seems to be that gcc optimizes with the assumption
that it is always talking to normal memory on arm and hence no alignment
rules apply anymore, but in driver code talking to IO and in cases where
you are flagging memory for DMA and such, gcc's optimizations get you
in trouble if you don't hit it with a stick in the right places.

-- 
Len Sorensen

