From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <566451a98761369f757a.1257105488@domain.hid>
References: <566451a98761369f757a.1257105488@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Sun, 01 Nov 2009 22:34:29 +0100
Message-ID: <1257111269.2065.596.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [PATCH] Check frequency in xnarch_init_timeconv()
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Bernhard Walle <bernhard@domain.hid>
Cc: xenomai@xenomai.org

On Sun, 2009-11-01 at 19:58 +0000, Bernhard Walle wrote:
> In some conditions, while testing Xenomai in VirtualBox, I had the error that
> xnarch_init_timeconv() is called from init_32.h with a frequency of 0. That
> leads to a division by zero, followed by a system oops.
> 
> Of course that is a bug in the virtualisation and Linux reports a CPU frequency
> of 0 in /proc/cpuinfo. However, there's no harm if Xenomai checks that instead
> of crashing the whole system.
> 
> 

I agree with the conclusion, not with the fix.

- the userland part reuses the frequency value returned by the nucleus,
so testing the issue up front when the nucleus initializes would be
enough. No need to propagate error detection to userland.

- the kernel side should rather test RTHAL_CPU_FREQ for consistency in
the generic hal init code, and bail out with an error if 0 is detected,
since there is no way for the nucleus to operate properly with such
setting anyway.

It turns out that no change have to be done in xnarch_init_timeconv()
which should remain a void routine, but its argument - RTHAL_CPU_FREQ -
should rather be tested as early as possible for consistency, directly
from kernel space.

> Signed-off-by: Bernhard Walle <bernhard@domain.hid>
> 
> 
>  include/asm-arm/bits/init.h         |   4 +++-
>  include/asm-blackfin/bits/init.h    |   4 +++-
>  include/asm-generic/bits/timeconv.h |  18 +++++++++++++++++-
>  include/asm-nios2/bits/init.h       |   4 +++-
>  include/asm-powerpc/bits/init.h     |   4 +++-
>  include/asm-x86/bits/init_32.h      |   4 +++-
>  include/asm-x86/bits/init_64.h      |   4 +++-
>  src/skins/native/timer.c            |   7 ++++++-
>  src/skins/posix/clock.c             |   8 +++++++-
>  9 files changed, 48 insertions(+), 9 deletions(-)
> 
> 
> _______________________________________________
> Xenomai-core mailing list
> Xenomai-core@domain.hid
> https://mail.gna.org/listinfo/xenomai-core


-- 
Philippe.



