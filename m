Message-ID: <509DC6BC.9010508@gmail.com>
Date: Fri, 09 Nov 2012 21:15:08 -0600
From: at91_enthus <nwromania@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] at91 tsc error on AT91SAM9G20 platform
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hi.

I'm having problems building the user space for Xenomai 2.6.1 (for
AT91SAM9G20).
Long story short, I issue the following commands:

$ ./configure CFLAGS="-march=armv4t" LDFLAGS="-march=armv4t"
--host=arm-linux-gnueabi  --enable-arm-tsc=at91

$ make DESTDIR=../xenomai_dest  install

Here's a snippet of the error messages:
******************************************
In file included from ../../../src/include/asm/xenomai/atomic.h:276,
                 from ../../../include/nucleus/system.h:26,
                 from ../../../src/include/asm/xenomai/system.h:247,
                 from ../../../include/nucleus/types.h:36,
                 from ../../../include/nucleus/thread.h:25,
                 from assert_context.c:24:
../../../src/include/asm/xenomai/syscall.h: In function '__xn_rdtsc':
../../../src/include/asm/xenomai/syscall.h:290: error: 'struct
__xn_full_tscinfo' has no member named 'tsc'
../../../src/include/asm/xenomai/syscall.h:291: error: 'struct
__xn_full_tscinfo' has no member named 'counter'
../../../src/include/asm/xenomai/syscall.h:292: error: 'struct
__xn_full_tscinfo' has no member named 'mask'
******************************************

If I don't choose TSC emulation for ARM, everything compiles fine.


Thank you.


