Message-ID: <544122F9.9060203@optusnet.com.au>
Date: Sat, 18 Oct 2014 01:08:57 +1100
From: Tom Evans <tom_usenet@optusnet.com.au>
MIME-Version: 1.0
References: <543E4B9F.60602@cgglobal.com> <543E5380.3080700@cgglobal.com>
 <543F70C5.1090005@xenomai.org> <543F7ED2.2080201@xenomai.org>
 <20141016181711.GB24110@csclub.uwaterloo.ca>
 <20141016185819.GF30661@sisyphus.hd.free.fr>
 <20141016205621.GC24110@csclub.uwaterloo.ca>
 <54405164.3090205@optusnet.com.au>
 <20141017053423.GG30661@sisyphus.hd.free.fr>
 <5440BB6B.9030807@optusnet.com.au>
 <20141017070201.GI30661@sisyphus.hd.free.fr>
In-Reply-To: <20141017070201.GI30661@sisyphus.hd.free.fr>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
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
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

On 17/10/2014 6:02 PM, Gilles Chanteperdrix wrote:
> On Fri, Oct 17, 2014 at 05:47:07PM +1100, Tom Evans wrote:
>> On 17/10/14 16:34, Gilles Chanteperdrix wrote:
>>>> Work out how many pixels per second you're processing and then
>>>> compare it to the memory bandwidth.

That would still be an interesting number to measure and quote.

>> It might be better to FLUSH the entire cache, perform a L2-sized
>> transfer and then flush it again. The flushes *might* be to linear
>> addresses in open pages.

Thinking more about this it would be better to flush the entire cache 
and then perform a preload-and-read pass (to load the cache from 
complete open rows in on-page RAM) then loop reading and writing (from 
cache to cache) and then loop flushing the destination cache lines into 
open rows of the RAM.

This would be easy on the PPC. It has six "User level cache 
instructions". Even the Coldfire has a "CPUSHL" user-mode instruction.

This seems to be impossible from user-space on the ARM, for as far as I 
can tell all of the 13 "Cache and branch predictor maintenance 
operations, VMSA" instructions "can be executed only by software 
executing at PL1 or higher". The only user-space ones are PLD, PLDW and 
PLI. So I'd have to write a kernel driver to copy user memory and worry 
about the page translation.

>> I got my fastest memcpy() speed on an MCF5329 by reading 2k to the
>> stack (in static ram in the CPU) and then writing that back out.
>> Copying twice was a LOT faster than any other method.

240MHz Coldfire with 80MHz 32-bit SDR memory. It started out at 33MB/s, 
got to 39MB/s by using the multiple register move instruction, and 
peaked at 55 MB/s copying via the stack in internal SRAM. Memcpy() from 
internal RAM to internal RAM managed 304MB/s!

RAM could be read at 87MB/s (due to the lack of pipelining in this CPU) 
but could be written at 207MB/s.

Function             kB/s   Memclk/cache line
=============================================
memcpy_gcc_4_4       30883  41.45
memcpy_gcc_4_3_O1    33382  38.34
memcpy_gcc_4_3_O2    33385  38.34
memcpy_gcc_2         33390  38.33

memcpy(132096)       33379  38.35
memcpy_moveml        39752  32.20
memcpy_dma           43709  29.28
memcpy_moveml_32     49618  25.80
memcpy_stack         52912  24.19
memcpy_moveml_192    54052  23.68
memcpy_moveml_48     54093  23.66
memcpy_stack_48      54997  23.27
memcpy_stack_32_mis  55079  23.24
memcpy_stack_32      55125  23.22
memcpy_stack_192     55736  22.97
memcpy_moveml_96_ps  56739  22.56
memRead_stack_32     85017  15.06
memRead_moveml_32    87141  14.69
memWrite_stack_32   196864   6.50
memWrite_moveml_32  207535   6.17
memcpy_stack_stack  304368   4.21 (12.62 CPU clocks)

> Actually, I am wrong, I was only reading the image,
 > not writing to it, simply computing a very reduced
 > averaged image, so there were some writes from time
 > to time, but very rarely.

That should get the best performance. That's not a common operation in 
what I'm doing which is alpha-blending graphics over each other.

 > > Miss L1 and wait 10 clocks. Miss L2 and wait 153 clocks! Step
 > > through memory 4k at a time and wait 46 clocks for the TLB to
 > > reload.
 >
 > That does not prove that the memory system is slow, that
 > proves that the processor access to memory is slow. But
 > why is that?

The memory controller may not be capable of keeping multiple banks open, 
or even rows open. It takes a long time to close an open row with the 
precharge and to then open the next one.

Don't even think about reading or writing peripheral pins. I worked on 
an ARM chip (PXA) that took 200 CPU Clocks to read or write a port 
register. It was actually recommended to program the DMA controller to 
read and write the ports and to interrupt the CPU when done!

That previously-quoted ARM FAQ on memory copying suggests the same thing 
(DMA or Preload Engine) for copying memory while the CPU goes and does 
something else.

> But I see your point, the problem is not NEON, but the
 > way the processor handles memory and cache.

The frustrating thing is the missing user-mode cache control instructions.

Tom



