Message-ID: <50E062E8.6030903@openwide.fr>
Date: Sun, 30 Dec 2012 16:51:04 +0100
From: Romain Naour <romain.naour@openwide.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] Xenomai 2.6.2 user-space compilation error on ARM < armv6
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hi Gilles,

First of all, thank you for the new release of Xenomai :)

I'm compiling Xenomai 2.6.2 and Linux kernel 3.5.3 for mini2440 with buildroot 2012.11.

During compilation I get the following error:
error: #error "SMP not supported below armv6, compile with -march=armv6 or above"

This error is caused by the SMP mode which is now enabled by default on ARM.
So I added the option --disable-smp on the buildroot's command line for ./configure
(buildroot assumes that the SMP mode is not enabled when it compile Xenomai for arm) 

This option became mandatory for ARM < armv6 to pass this test: (xenomai-2.6/include/asm-arm/feature.h)

#if __LINUX_ARM_ARCH__ < 6 && defined(CONFIG_SMP)
#error "SMP not supported below armv6, compile with -march=armv6 or above"
#endif

The error message may be advisable to add the option --disable-smp ?
However, since your objective is to allow to run the same binary on UP and SMP system, it is safe to remove this test for ARM < armv6 now ?

Regards,
Romain

