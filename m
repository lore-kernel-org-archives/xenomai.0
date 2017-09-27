References: <CAKJ14NdyH7FF+pwj9J-FLSnCWHOqAteKVrrbagA4eqhvETgFoA@mail.gmail.com>
 <CAKJ14NfuNCtfK9bT5Oh+dRYAKhW+4KgaFO5w=xt=exJOw6forQ@mail.gmail.com>
 <e847e788-f0c4-9d27-9dd7-4cb9c22de649@xenomai.org>
 <CAKJ14NcCac2Q32b8tGsNKXYZX9toGsxBEvXGt+2Pa8FYrihdKQ@mail.gmail.com>
 <20170927143948.b5idby3cd7ncevck@csclub.uwaterloo.ca>
 <CAKJ14Nfge9hmwULBbeOBKD6okdJA1-r2qmfRdmBompJ0LLFHdg@mail.gmail.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <b20d29f8-d8cf-0ef4-4949-1f14aa0a204a@xenomai.org>
Date: Wed, 27 Sep 2017 20:49:39 +0200
MIME-Version: 1.0
In-Reply-To: <CAKJ14Nfge9hmwULBbeOBKD6okdJA1-r2qmfRdmBompJ0LLFHdg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] Unexpected mode switches when reordering C++ lines
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Andreas Glatz <andi.glatz@gmail.com>, Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
Cc: xenomai@xenomai.org

On 09/27/2017 07:33 PM, Andreas Glatz wrote:
> Hi Lennart
> 
> On Wed, Sep 27, 2017 at 3:39 PM, Lennart Sorensen
> <lsorense@csclub.uwaterloo.ca> wrote:
>> On Wed, Sep 27, 2017 at 02:37:39PM +0100, Andreas Glatz wrote:
>>> It's true according to the ARM doc [1]. But the pDat alignment is
>>> prescribed by the sender and we're at the receiver. So I guess the
>>> question is how to tell the assembler not to use ldm in the first
>>> place?
>>
>> It certainly looks like the code somehow is optimizing two consequitive
>> 32 bit reads into a single 64 bit read, but then the input is not 64 bit
>> aligned (but is 32 bit aligned) which causes an alignment exception on
>> the 64 bit read while the 32 bit reads were fine.
>>
>> One would think the compiler should NOT be doing that.
> 
> Yes, one would think so...
> 
>>
>> Now as far as I remember, armv7 (which is what you appear to have)
>> allows unaligned accesses to normal memory, but not to IO ports or other
>> special memory.  I recall hitting a case where someone had flagged
>> some memory as DMA which caused the alignement exception to be hit.
>> Since the memory really had no reason to be flagged for DMA or anything
>> else special it was easy to fix.
> 
> I shall try to play with these options then. As explained to Philippe
> and hinted by you one would ideally want a flag to mark a memory
> regions as 'unaligned' so that the compiler/assembler know that they
> should only use instructions that support unaligned access, albeit
> being slower.
> 
>>
>> Is the memory at your pointer allocated with any special flags or is
>> it device memory?  Because if it isn't, then you shouldn't as far as I
>> recall be hitting that exception.
> 
> The memory is malloc'd before the Xenomai thread starts, but after
> locking all the pages into memory (the usual Xenomai startup stuff).
> 
>>
>> Part of the problem seems to be that gcc optimizes with the assumption
>> that it is always talking to normal memory on arm and hence no alignment
>> rules apply anymore, but in driver code talking to IO and in cases where
>> you are flagging memory for DMA and such, gcc's optimizations get you
>> in trouble if you don't hit it with a stick in the right places.
> 
> Apparently :) Other option would be to write my own access function
> for this piece of memory in assembly... then there'd be no room for
> wiggling around anymore.

There is also the option to go through a packed attribute window for reading the data, e.g.:

#include <linux/types.h>
#include <netinet/in.h>

struct maybe_unaligned {
	__u32 val;
} __attribute__((__packed__));

extern "C" __u32 read32_unaligned(const void *p)
{
	return ntohl(static_cast<const struct maybe_unaligned *>(p)->val);
}

The disassembly looks promising, since ldr can deal with unaligned accesses (which is confirmed by the assembler's annotation):

{rpm@cobalt} arm-linux-gnueabihf-g++ -O2 c.cc -S -o -
...
read32_unaligned:
	.fnstart
.LFB6:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	ldr	r0, [r0]	@ unaligned
	rev	r0, r0
	bx	lr
...

-- 
Philippe.

