Date: Fri, 17 Oct 2014 21:36:08 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20141017193608.GQ30661@sisyphus.hd.free.fr>
References: <543F70C5.1090005@xenomai.org> <543F7ED2.2080201@xenomai.org>
 <20141016181711.GB24110@csclub.uwaterloo.ca>
 <20141016185819.GF30661@sisyphus.hd.free.fr>
 <20141016205621.GC24110@csclub.uwaterloo.ca>
 <54405164.3090205@optusnet.com.au>
 <20141017053423.GG30661@sisyphus.hd.free.fr>
 <5440BB6B.9030807@optusnet.com.au>
 <20141017070201.GI30661@sisyphus.hd.free.fr>
 <544122F9.9060203@optusnet.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <544122F9.9060203@optusnet.com.au>
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

On Sat, Oct 18, 2014 at 01:08:57AM +1100, Tom Evans wrote:
> On 17/10/2014 6:02 PM, Gilles Chanteperdrix wrote:
> >On Fri, Oct 17, 2014 at 05:47:07PM +1100, Tom Evans wrote:
> >>On 17/10/14 16:34, Gilles Chanteperdrix wrote:
> >>>>Work out how many pixels per second you're processing and then
> >>>>compare it to the memory bandwidth.
> 
> That would still be an interesting number to measure and quote.

I no longer have access to either the hardware (a TI DM8148) or the
software, so that is going to be a bit hard.

> 
> >>It might be better to FLUSH the entire cache, perform a L2-sized
> >>transfer and then flush it again. The flushes *might* be to linear
> >>addresses in open pages.
> 
> Thinking more about this it would be better to flush the entire
> cache and then perform a preload-and-read pass (to load the cache
> from complete open rows in on-page RAM) then loop reading and
> writing (from cache to cache) and then loop flushing the destination
> cache lines into open rows of the RAM.
> 
> This would be easy on the PPC. It has six "User level cache
> instructions". Even the Coldfire has a "CPUSHL" user-mode
> instruction.
> 
> This seems to be impossible from user-space on the ARM, for as far
> as I can tell all of the 13 "Cache and branch predictor maintenance
> operations, VMSA" instructions "can be executed only by software
> executing at PL1 or higher". The only user-space ones are PLD, PLDW
> and PLI. So I'd have to write a kernel driver to copy user memory
> and worry about the page translation.
> 
> >>I got my fastest memcpy() speed on an MCF5329 by reading 2k to the
> >>stack (in static ram in the CPU) and then writing that back out.
> >>Copying twice was a LOT faster than any other method.
> 
> 240MHz Coldfire with 80MHz 32-bit SDR memory. It started out at
> 33MB/s, got to 39MB/s by using the multiple register move
> instruction, and peaked at 55 MB/s copying via the stack in internal
> SRAM. Memcpy() from internal RAM to internal RAM managed 304MB/s!
> 
> RAM could be read at 87MB/s (due to the lack of pipelining in this
> CPU) but could be written at 207MB/s.
> 
> Function             kB/s   Memclk/cache line
> =============================================
> memcpy_gcc_4_4       30883  41.45
> memcpy_gcc_4_3_O1    33382  38.34
> memcpy_gcc_4_3_O2    33385  38.34
> memcpy_gcc_2         33390  38.33
> 
> memcpy(132096)       33379  38.35
> memcpy_moveml        39752  32.20
> memcpy_dma           43709  29.28
> memcpy_moveml_32     49618  25.80
> memcpy_stack         52912  24.19
> memcpy_moveml_192    54052  23.68
> memcpy_moveml_48     54093  23.66
> memcpy_stack_48      54997  23.27
> memcpy_stack_32_mis  55079  23.24
> memcpy_stack_32      55125  23.22
> memcpy_stack_192     55736  22.97
> memcpy_moveml_96_ps  56739  22.56
> memRead_stack_32     85017  15.06
> memRead_moveml_32    87141  14.69
> memWrite_stack_32   196864   6.50
> memWrite_moveml_32  207535   6.17
> memcpy_stack_stack  304368   4.21 (12.62 CPU clocks)
> 
> >Actually, I am wrong, I was only reading the image,
> > not writing to it, simply computing a very reduced
> > averaged image, so there were some writes from time
> > to time, but very rarely.
> 
> That should get the best performance. That's not a common operation
> in what I'm doing which is alpha-blending graphics over each other.

The procedure was used during a calibration phase of an optical
system, to compute tables that were later used for real-time images
corrections by an FPGA, so, optimizing this procedure only made the
calibration shorter, it was not used in real-time, so, I spent some
time optimizing it, but could not spend a lot.

-- 
					    Gilles.

