Date: Wed, 27 Sep 2017 13:57:41 -0400
Message-ID: <20170927175741.e2gia5r2iaz3jsiq@csclub.uwaterloo.ca>
References: <CAKJ14NdyH7FF+pwj9J-FLSnCWHOqAteKVrrbagA4eqhvETgFoA@mail.gmail.com>
 <CAKJ14NfuNCtfK9bT5Oh+dRYAKhW+4KgaFO5w=xt=exJOw6forQ@mail.gmail.com>
 <e847e788-f0c4-9d27-9dd7-4cb9c22de649@xenomai.org>
 <CAKJ14NcCac2Q32b8tGsNKXYZX9toGsxBEvXGt+2Pa8FYrihdKQ@mail.gmail.com>
 <20170927143948.b5idby3cd7ncevck@csclub.uwaterloo.ca>
 <CAKJ14Nfge9hmwULBbeOBKD6okdJA1-r2qmfRdmBompJ0LLFHdg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKJ14Nfge9hmwULBbeOBKD6okdJA1-r2qmfRdmBompJ0LLFHdg@mail.gmail.com>
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

On Wed, Sep 27, 2017 at 06:33:50PM +0100, Andreas Glatz wrote:
> Yes, one would think so...

Well reading a bit, it seems by default gcc assumes all pointers are
sensibly aligned.  Still not sure how that excuses doing a combination
of two reads into one in this case.

Which gcc version are you using?

> I shall try to play with these options then. As explained to Philippe
> and hinted by you one would ideally want a flag to mark a memory
> regions as 'unaligned' so that the compiler/assembler know that they
> should only use instructions that support unaligned access, albeit
> being slower.
> 
> The memory is malloc'd before the Xenomai thread starts, but after
> locking all the pages into memory (the usual Xenomai startup stuff).

So according to
http://infocenter.arm.com/help/index.jsp?topic=/com.arm.doc.faqs/ka15414.html
only memory marked as normal allows unaligned accesses.  It also says
that the LDM instruction is NOT allowed on unaligned accesses.  So then
the question is why does gcc assume that pointer is always going to
be aligned?  Is this a bug in gcc?

> Apparently :) Other option would be to write my own access function
> for this piece of memory in assembly... then there'd be no room for
> wiggling around anymore.

Any change adding -fno-strict-aliasing to the gcc arguments helps?

-- 
Len Sorensen

