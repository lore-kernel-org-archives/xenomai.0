Date: Fri, 17 Oct 2014 09:02:01 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20141017070201.GI30661@sisyphus.hd.free.fr>
References: <543E4B9F.60602@cgglobal.com> <543E5380.3080700@cgglobal.com>
 <543F70C5.1090005@xenomai.org> <543F7ED2.2080201@xenomai.org>
 <20141016181711.GB24110@csclub.uwaterloo.ca>
 <20141016185819.GF30661@sisyphus.hd.free.fr>
 <20141016205621.GC24110@csclub.uwaterloo.ca>
 <54405164.3090205@optusnet.com.au>
 <20141017053423.GG30661@sisyphus.hd.free.fr>
 <5440BB6B.9030807@optusnet.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5440BB6B.9030807@optusnet.com.au>
Subject: Re: [Xenomai] First call to rt_timer_tsc() causes an unexpected
 switch to secondary mode.
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Tom Evans <tom_usenet@optusnet.com.au>
Cc: xenomai@xenomai.org

On Fri, Oct 17, 2014 at 05:47:07PM +1100, Tom Evans wrote:
> On 17/10/14 16:34, Gilles Chanteperdrix wrote:
> >On Fri, Oct 17, 2014 at 10:14:44AM +1100, Tom Evans wrote:
> 
> I think we're way off topic here. Should be stop?

the xenomai mailing list is low traffic, I believe we can have such
an interesting digression from time to time.

> 
> >>Work out how many pixels per second you're processing and then
> >>compare it to the memory bandwidth. You may be surprised at how slow
> >>the memory system is.
> >
> >The memory was a DDR3 running at 533/1066 MHZ. I would not call that
> >slow. Given the fact that:
> >- there were two interleaved banks
> >- each bank processes 2 bytes at every half tick
> >that would be 4 Gbytes/sec.
> 
> That has to be slow. Measure your memcpy() speed and see how many
> MBytes/sec you're getting.
> 
> You're working your way through memory, possibly linearly, which
> SHOULD keep the memory pages open (and give you some speed), but
> can't.
> 
> What is happening at "the code level" for a memcpy()is:
> 
> 1 - Read a word or 16 into the CPU from one address,
> 2 - Write them out to another address,
> 3 - Repeat until done.
> 
> What is happening is:
> 
> 1 - Read a word or 16 into the CPU from one address,
> 1a - Pick a RANDOM cache line to evict to make room,
> 1b - Write the data from that cache line to memory,
> 1c - Whoops, wrong DDR3 page, close the previous page and open THAT one,
> 1d - Read the data into that cache line.
> 1e - Whoops, wrong DDR3 page, close the previous page and open THAT one,
> 1f - Read from the cache into the CPU,
> 2 - Write them out to another address,
> 2a - Pick a RANDOM cache line to evict to make room
> 2b - Whoops, wrong DDR3 page, close the page and open THAT one,
> 2c - Write the data from that cache line to memory,
> 2d - Read the data into that cache line.
> 2e - Whoops, wrong DDR3 page, close the previous page and open THAT one,
> 2f - Write from the CPU into that cache line
> 3 - Repeat until done.
> 
> The DDR3 can't keep on the same page and that slows it down. Opening
> the new page takes hugely longer than the double-clocked burst
> transfer.
> 
> Using Neon gets rid of one redundant read, but the writes still have
> to evict cache lines.
> 
> It might be better to FLUSH the entire cache, perform a L2-sized
> transfer and then flush it again. The flushes *might* be to linear
> addresses in open pages.
> 
> Otherwise it might be worth burst-reading to static RAM inside the
> CPU and then burst-writing that, again possibly with full (or
> specific) cache flushes.
> 
> I got my fastest memcpy() speed on an MCF5329 by reading 2k to the
> stack (in static ram in the CPU) and then writing that back out.
> Copying twice was a LOT faster than any other method.


Actually, I am wrong, I was only reading the image, not writing to
it, simply computing a very reduced averaged image, so there were
some writes from time to time, but very rarely. I agree that you can
not assume that you read or write at full speed, and that the DDR
controller has to change page from time to time, but that should be
negligible if you do not alternate reads and writes.

But I see your point, the problem is not NEON, but the way the
processor handles memory and cache.

-- 
					    Gilles.

