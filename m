Message-ID: <543F70C5.1090005@xenomai.org>
Date: Thu, 16 Oct 2014 09:16:21 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <543E4B9F.60602@cgglobal.com> <543E5380.3080700@cgglobal.com>
In-Reply-To: <543E5380.3080700@cgglobal.com>
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

On 10/15/2014 12:59 PM, ZIV-Alberto Ozalla Cantabrana wrote:
> 'CFLAGS=-Os -pipe -D_REENTRANT -fomit-frame-pointer -march=armv7-a
> -mtune=cortex-a8  -mfpu=vfpv3-d16 -finline-functions
> -finline-limit=50 -ffast-math -include
> /home/aozalla/pro/npcp/toolchain/include/builtin_redefines.h
> -DMAX_PCI_SLOTS=8 -fPIC -DPIC -DNO_LARGEFILE_SOURCE
> -U_LARGEFILE_SOURCE -U_LARGE_FILES -U_FILE_OFFSET_BITS'

As a side note, if you have a modern toolchain which compiles by default
for thumb2, by passing -march=armv7-a you disable compilation for thumb,
and from my experience thumb2 code results in better latencies than ARM
code. Also -Os -finline-functions is a bit strange: the advantage of
using -Os is that it inline less functions, so it looks like a strange
way to ask for -O2. Also note that according to my tests, you get better
latencies on ARM with -Os than with -O2. Finally, I do not know what
builtin_redefines.h does but beware: xenomai uses gcc builtin functions
for atomic instructions by default now.

-- 
                                                                Gilles.

