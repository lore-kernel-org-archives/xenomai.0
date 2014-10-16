Message-ID: <54405164.3090205@optusnet.com.au>
Date: Fri, 17 Oct 2014 10:14:44 +1100
From: Tom Evans <tom_usenet@optusnet.com.au>
MIME-Version: 1.0
References: <543E4B9F.60602@cgglobal.com> <543E5380.3080700@cgglobal.com>
 <543F70C5.1090005@xenomai.org> <543F7ED2.2080201@xenomai.org>
 <20141016181711.GB24110@csclub.uwaterloo.ca>
 <20141016185819.GF30661@sisyphus.hd.free.fr>
 <20141016205621.GC24110@csclub.uwaterloo.ca>
In-Reply-To: <20141016205621.GC24110@csclub.uwaterloo.ca>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] First call to rt_timer_tsc() causes an unexpected
 switch to secondary mode.
Reply-To: tom_usenet@optusnet.com.au
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

On 17/10/14 07:56, Lennart Sorensen wrote:
> On Thu, Oct 16, 2014 at 08:58:19PM +0200, Gilles Chanteperdrix wrote:
>> ... After implementing a routine to average pixels
>> from a bayer pattern on cortex A8 (where I could use NEON) I got a
>> factor gain of 2 or 3, far from what could have been expected from
>> processing 16 pixels at once,

How big is your data-set? You are probably breaking the L2 cache.

Work out how many pixels per second you're processing and then compare it to 
the memory bandwidth. You may be surprised at how slow the memory system is.

Download, compile and run this program:

http://www.cwi.nl/~manegold/Calibrator/

   root@triton1:/tmp# nice --20 ./calibrator 800 1700k report

   caches:
   level  size    linesize   miss-latency        replace-time
     1     32 KB  128 bytes   12.70 ns =  10 cy   13.40 ns =  11 cy
     2    256 KB   64 bytes  191.21 ns = 153 cy  194.37 ns = 155 cy

   TLBs:
   level #entries  pagesize  miss-latency
     1       32       4 KB    57.65 ns =  46 cy

Miss L1 and wait 10 clocks. Miss L2 and wait 153 clocks! Step through memory 
4k at a time and wait 46 clocks for the TLB to reload.

 >> and I got a biggest gain by inserting the non-NEON "pld"
 >> instruction at key points (which I could do in the non NEON
 >> code as well).

With a 153-clock latency on an L2 miss, PLD will have a large affect if you 
can get them in early enough. You should preload multiple cache lines ahead 
and not just a few words.

>> I also do not really understand how NEON accelerates memcpy,
 >> why is a NEON multiple registers load/store faster than
 >> ldm/stm, is not it a problem in ldm/stm rather than a
>> virtue of NEON?

The following should be a good reference, but doesn't answer this question. It 
says there is no difference, but that's not what we're seeing.

http://infocenter.arm.com/help/index.jsp?topic=/com.arm.doc.faqs/kihAsZfdS5wTMO.html

The faster Neon copy indicates a problem with the ARM architecture itself. 
Whenever the ARM CPU performs a memcpy(), the sequence is (read(src); 
read(dst); write(dst)). The cache design means that the destination cache line 
is READ before being written, so the memcpy() speed is 1/3 of the basic memory 
speed.

The PPC architecture provides DCBZ and friends. During a memcpy() you perform 
a DCBZ on the destination which is a "promise" to the CPU that you're going to 
write the entire cache line so it doesn't have to be read first.

Neon performs the operations a cache line at a time and gets rid of the 
redundant read operation, so it runs faster by 3/2. The previous link implies 
this might require the correct CPU configuration (Neon bypassing L1).

>> All this to say, is NEON that useful?

We're performing alpha blending with 32-bit pixels and our Neon code is able 
to do that at the same speed as a CPU-driven memcpy(). It is a lot faster than 
my poor attempts at alpha-blending 4 bytes per pixel in C. Our Neon memcpy() 
(copying 800x480 32-bit pixels at 20Hz to /dev/fb0) is 50% faster than the 
alternative.

I also had an instance when performing an affine transform (rotation) where 
the speed dropped to 29% at specific rotation angle where a 300-pixel "walk" 
through memory aliased in the caches. That was fixed by performing the 
transform in 48 by 48 pixel "tiles".

> Well the vfp on the Cortex-A8 is rather slow,

10 CPU clocks per instruction instead of 1 clock on the other chips.

Tom


