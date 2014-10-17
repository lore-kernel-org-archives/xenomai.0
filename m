Date: Fri, 17 Oct 2014 07:34:23 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20141017053423.GG30661@sisyphus.hd.free.fr>
References: <543E4B9F.60602@cgglobal.com> <543E5380.3080700@cgglobal.com>
 <543F70C5.1090005@xenomai.org> <543F7ED2.2080201@xenomai.org>
 <20141016181711.GB24110@csclub.uwaterloo.ca>
 <20141016185819.GF30661@sisyphus.hd.free.fr>
 <20141016205621.GC24110@csclub.uwaterloo.ca>
 <54405164.3090205@optusnet.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <54405164.3090205@optusnet.com.au>
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

On Fri, Oct 17, 2014 at 10:14:44AM +1100, Tom Evans wrote:
> On 17/10/14 07:56, Lennart Sorensen wrote:
> >On Thu, Oct 16, 2014 at 08:58:19PM +0200, Gilles Chanteperdrix wrote:
> >>... After implementing a routine to average pixels
> >>from a bayer pattern on cortex A8 (where I could use NEON) I got a
> >>factor gain of 2 or 3, far from what could have been expected from
> >>processing 16 pixels at once,
> 
> How big is your data-set? You are probably breaking the L2 cache.

1600x1200, I was definitely breaking the L2 cache (hence the fact
that pld improves things).

> 
> Work out how many pixels per second you're processing and then
> compare it to the memory bandwidth. You may be surprised at how slow
> the memory system is.

The memory was a DDR3 running at 533/1066 MHZ. I would not call that
slow. Given the fact that:
- there were two interleaved banks
- each bank processes 2 bytes at every half tick
that would be 4 Gbytes/sec.

Since the processor was running at 1GHz too, if it had been limited
by memory, it should have been able to process 2 pixels every
processor tick (2 reads, 2 writes), that is process the whole image
in 960us. The process took milliseconds, so, I would say the memory
definitely was not the limit. I do not think latency was an issue
either, because the memory was accessed sequentially.

An FPGA, master on the PCI bus had absolutely no problem to DMA the
1600x1200 pixels at 60 fps.

In my case, the NEON code was written to process two quads per
instruction, that would be 32 pixels at once. After having written
the NEON code, I rewrote the plain C version to work with 32 bits
integer registers, and process 4 pixels at once, and to use
pld. In the end, the NEON version was only performing twice as fast
as the plain C version, whereas it was processing 8 times the number
of pixels at each instruction.

> 
> Download, compile and run this program:
> 
> http://www.cwi.nl/~manegold/Calibrator/
> 
>   root@triton1:/tmp# nice --20 ./calibrator 800 1700k report
> 
>   caches:
>   level  size    linesize   miss-latency        replace-time
>     1     32 KB  128 bytes   12.70 ns =  10 cy   13.40 ns =  11 cy
>     2    256 KB   64 bytes  191.21 ns = 153 cy  194.37 ns = 155 cy
> 
>   TLBs:
>   level #entries  pagesize  miss-latency
>     1       32       4 KB    57.65 ns =  46 cy
> 
> Miss L1 and wait 10 clocks. Miss L2 and wait 153 clocks! Step
> through memory 4k at a time and wait 46 clocks for the TLB to
> reload.

That does not prove that the memory system is slow, that proves that
the processor access to memory is slow. But why is that?

> 
> >> and I got a biggest gain by inserting the non-NEON "pld"
> >> instruction at key points (which I could do in the non NEON
> >> code as well).
> 
> With a 153-clock latency on an L2 miss, PLD will have a large affect
> if you can get them in early enough. You should preload multiple
> cache lines ahead and not just a few words.

Yes, I adjusted the parameters of preload (how many iterations
ahead) and preloaded all the data I needed. In my case, the best
place to put the pld was right before the first vld, I guess because
pld was able to do its job during the vld stall.

> 
> >>I also do not really understand how NEON accelerates memcpy,
> >> why is a NEON multiple registers load/store faster than
> >> ldm/stm, is not it a problem in ldm/stm rather than a
> >>virtue of NEON?
> 
> The following should be a good reference, but doesn't answer this
> question. It says there is no difference, but that's not what we're
> seeing.
> 
> http://infocenter.arm.com/help/index.jsp?topic=/com.arm.doc.faqs/kihAsZfdS5wTMO.html
> 
> The faster Neon copy indicates a problem with the ARM architecture
> itself. Whenever the ARM CPU performs a memcpy(), the sequence is
> (read(src); read(dst); write(dst)). The cache design means that the
> destination cache line is READ before being written, so the memcpy()
> speed is 1/3 of the basic memory speed.

Ah, thanks for the explanation, I had found this page and was rather
puzzled by this result.

> 
> The PPC architecture provides DCBZ and friends. During a memcpy()
> you perform a DCBZ on the destination which is a "promise" to the
> CPU that you're going to write the entire cache line so it doesn't
> have to be read first.
> 
> Neon performs the operations a cache line at a time and gets rid of
> the redundant read operation, so it runs faster by 3/2. The previous
> link implies this might require the correct CPU configuration (Neon
> bypassing L1).
> 
> >>All this to say, is NEON that useful?
> 
> We're performing alpha blending with 32-bit pixels and our Neon code
> is able to do that at the same speed as a CPU-driven memcpy(). It is
> a lot faster than my poor attempts at alpha-blending 4 bytes per
> pixel in C. Our Neon memcpy() (copying 800x480 32-bit pixels at 20Hz
> to /dev/fb0) is 50% faster than the alternative.

I am sorry, I do not want to critic you work, only doubt the power
of NEON: do you really find this impressive? People want to handle
2M pixels images at 60 Hz now, and soon 4K. If you look at x264
performances for instance: 

http://x264dev.multimedia.cx/archives/142

They announce that they can encode CIF resolution with very low
quality (ultrafast setting) at 30 fps with NEON on cortex A8. Once
again, I do not want to critic peoples work, only the hardware,
common x86 hardware can encode several 1080p30 streams concurrently 
with a normal quality.

-- 
					    Gilles.

