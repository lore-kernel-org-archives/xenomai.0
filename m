Message-ID: <543F7ED2.2080201@xenomai.org>
Date: Thu, 16 Oct 2014 10:16:18 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <543E4B9F.60602@cgglobal.com> <543E5380.3080700@cgglobal.com>
 <543F70C5.1090005@xenomai.org>
In-Reply-To: <543F70C5.1090005@xenomai.org>
Content-Type: text/plain; charset=UTF-8
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
To: alberto.ozalla@cgglobal.com, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 10/16/2014 09:16 AM, Gilles Chanteperdrix wrote:
> On 10/15/2014 12:59 PM, ZIV-Alberto Ozalla Cantabrana wrote:
>> 'CFLAGS=-Os -pipe -D_REENTRANT -fomit-frame-pointer -march=armv7-a
>> -mtune=cortex-a8  -mfpu=vfpv3-d16 -finline-functions
>> -finline-limit=50 -ffast-math -include
>> /home/aozalla/pro/npcp/toolchain/include/builtin_redefines.h
>> -DMAX_PCI_SLOTS=8 -fPIC -DPIC -DNO_LARGEFILE_SOURCE
>> -U_LARGEFILE_SOURCE -U_LARGE_FILES -U_FILE_OFFSET_BITS'
> 
> As a side note, if you have a modern toolchain which compiles by default
> for thumb2, by passing -march=armv7-a you disable compilation for thumb,
> and from my experience thumb2 code results in better latencies than ARM
> code. Also -Os -finline-functions is a bit strange: the advantage of
> using -Os is that it inline less functions, so it looks like a strange
> way to ask for -O2. Also note that according to my tests, you get better
> latencies on ARM with -Os than with -O2. Finally, I do not know what
> builtin_redefines.h does but beware: xenomai uses gcc builtin functions
> for atomic instructions by default now.
> 

Also, vfpv3-d16 looks suspicious to me: you may be uselessly limiting
the number of vfp registers available to the compiler. If cat
/proc/cpuinfo tells you vfpv3 and not vfpv3-d16, you can use
-mfpu=vfpv3, if it tells you neon, you can use -mfpu=neon. I am almost
sure the beaglebone processor has 32 double vfp registers, not 16.

This page:
http://www.ti.com/product/AM3358/datasheet

Seems to imply that the beaglebone processor has NEON.

And this page:
http://en.wikipedia.org/wiki/ARM_architecture#Floating-point_.28VFP.29

Seems to imply that since it is a cortex a8, it has 32 double vfp
registers and not 16.

It would seem among arm processors of the "A" family and the armv7
architecture, only cortex A5 and cortex A7 may have 16 double vfp
registers (the atmel sama5d3 for instance is in this case).

-- 
                                                                Gilles.

