Date: Thu, 24 Mar 2016 11:05:49 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20160324100549.GJ22286@hermes.click-hack.org>
References: <56F3B595.5060907@knapp.com>
 <20160324095104.GI22286@hermes.click-hack.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160324095104.GI22286@hermes.click-hack.org>
Subject: Re: [Xenomai] testsuite segfaults on Ubuntu 16.04 with Xenomai 2.6.4
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Christoph Permes <christoph.permes@knapp.com>
Cc: xenomai@xenomai.org

On Thu, Mar 24, 2016 at 10:51:04AM +0100, Gilles Chanteperdrix wrote:
> On Thu, Mar 24, 2016 at 10:38:29AM +0100, Christoph Permes wrote:
> > Hi,
> > 
> > I am experiencing problems getting Xenomai 2.6.4 running on Ubuntu 16.04.
> > 
> > My Xenomai applications and also some applications from the testsuite
> > (e.g. cyclictest, latency) keep crashing instantly with a segfault.
> > 
> > For instance, cyclictest crashes with the following backtrace:
> > 
> > Thread 1 "cyclictest" received signal SIGSEGV, Segmentation fault.
> > 0xb7fb59f3 in xnarch_tsc_to_ns (ticks=16028154345163) at ../../../src/include/asm-generic/xenomai/bits/timeconv.h:37
> > 37              return xnarch_llmulshft(ticks, tsc_scale, tsc_shift);
> > (gdb) bt
> > #0  0xb7fb59f3 in xnarch_tsc_to_ns (ticks=16028154345163) at ../../../src/include/asm-generic/xenomai/bits/timeconv.h:37
> > #1  0xb7fbfa9c in __wrap_clock_gettime (clock_id=1, tp=0x804c1f0 <start>) at clock.c:121
> > #2  0x08049cc3 in main (argc=1, argv=0xbffff6a4) at cyclictest.c:587
> > 
> > The backtrace of all other applications also leads to xnarch_tsc_to_ns.
> > 
> > 
> > I am using
> > - Xenomai 2.6.4
> > - Linux 3.14.44 (see attachment for kernel configuration)
> > - ipipe-core-3.14.44-x86-10.patch
> > 
> > which works without any issues on Ubuntu 14.04, so it seems to me that
> > the problem is related to the compiler or some system libraries.
> > 
> > I have also tried the prebuilt Xenomai packages from the Ubuntu package
> > repository as well as the latest 2.6 git head, different I-Pipe patch
> > (ipipe-core-3.14.44-x86-11.patch), but the problem is still the same.
> > 
> > With Xenomai 3.0.1 the testsuite seems to work, but for now I would
> > prefer staying with 2.6 as porting my applications to Xenomai 3 would
> > take some more effort.
> > 
> > 
> > Can anyone point me into the right direction?
> 
> xnarch_llmulshft is written in assembly, it probably lacks a
> constraint which causes bad code generation under register pressure
> (which is high on x86_32). You need to work at the assembly level to
> understand what is wrong and fix the assembly code. As a quick
> check, you may want to check 3.0 implementation of the same
> function, to see if it has already been fixed.

And the answer is yes, it has. The __lo and __hi output variables
should be declared "early clobbered". In other word, try replacing

"=r"(lo), "=r"(hi)
with:
"=&r"(lo), "=&r"(hi)

-- 
					    Gilles.
https://click-hack.org

