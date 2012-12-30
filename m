Message-ID: <50E0BD01.1020404@xenomai.org>
Date: Sun, 30 Dec 2012 23:15:29 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <50E062E8.6030903@openwide.fr>
In-Reply-To: <50E062E8.6030903@openwide.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Xenomai 2.6.2 user-space compilation error on ARM <
 armv6
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Romain Naour <romain.naour@openwide.fr>
Cc: xenomai@xenomai.org

On 12/30/2012 04:51 PM, Romain Naour wrote:

> Hi Gilles,
> 
> First of all, thank you for the new release of Xenomai :)
> 
> I'm compiling Xenomai 2.6.2 and Linux kernel 3.5.3 for mini2440 with
> buildroot 2012.11.
> 
> During compilation I get the following error: error: #error "SMP not
> supported below armv6, compile with -march=armv6 or above"
> 
> This error is caused by the SMP mode which is now enabled by default
> on ARM. So I added the option --disable-smp on the buildroot's
> command line for ./configure (buildroot assumes that the SMP mode is
> not enabled when it compile Xenomai for arm)
> 
> This option became mandatory for ARM < armv6 to pass this test:
> (xenomai-2.6/include/asm-arm/feature.h)
> 
> #if __LINUX_ARM_ARCH__ < 6 && defined(CONFIG_SMP) #error "SMP not
> supported below armv6, compile with -march=armv6 or above" #endif
> 
> The error message may be advisable to add the option --disable-smp ? 
> However, since your objective is to allow to run the same binary on
> UP and SMP system, it is safe to remove this test for ARM < armv6 now
> ?


Could you try the following patch?

diff --git a/include/asm-arm/atomic_asm.h b/include/asm-arm/atomic_asm.h
index 47f17c9..ef62690 100644
--- a/include/asm-arm/atomic_asm.h
+++ b/include/asm-arm/atomic_asm.h
@@ -27,6 +27,10 @@
 #error "please don't include asm/atomic_asm.h directly"
 #endif
 
+#if __LINUX_ARM_ARCH__ < 6 && defined(CONFIG_SMP)
+#error "SMP not supported below armv6 with ad-hoc atomic operations, compile without SMP or with -march=armv6 or above"
+#endif
+
 extern void __xnarch_xchg_called_with_bad_pointer(void);
 
 #define xnarch_read_memory_barrier()		xnarch_memory_barrier()
diff --git a/include/asm-arm/features.h b/include/asm-arm/features.h
index 279f752..bddaa5e 100644
--- a/include/asm-arm/features.h
+++ b/include/asm-arm/features.h
@@ -73,10 +73,6 @@
 #error "Could not find current ARM architecture"
 #endif
 
-#if __LINUX_ARM_ARCH__ < 6 && defined(CONFIG_SMP)
-#error "SMP not supported below armv6, compile with -march=armv6 or above"
-#endif
-
 #define CONFIG_XENO_FASTSYNCH 1
 
 #if CONFIG_XENO_ARM_TSC_TYPE == __XN_TSC_TYPE_KUSER

-- 
                                                                Gilles.

