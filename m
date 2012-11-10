Message-ID: <509E1A13.8050204@xenomai.org>
Date: Sat, 10 Nov 2012 10:10:43 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <509DC6BC.9010508@gmail.com>
In-Reply-To: <509DC6BC.9010508@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] at91 tsc error on AT91SAM9G20 platform
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: at91_enthus <nwromania@gmail.com>
Cc: xenomai@xenomai.org

On 11/10/2012 04:15 AM, at91_enthus wrote:

> Hi.
> 
> I'm having problems building the user space for Xenomai 2.6.1 (for
> AT91SAM9G20).
> Long story short, I issue the following commands:
> 
> $ ./configure CFLAGS="-march=armv4t" LDFLAGS="-march=armv4t"
> --host=arm-linux-gnueabi  --enable-arm-tsc=at91


According to this link:
http://www.atmel.com/devices/SAM9G20.aspx

The AT91SAM9G20 is based on an arm926 core, so, it is an armv5, not an 
armv4.

And if you are compiling xenomai for a recent version of the I-pipe 
patch, you do not need to pass the --enable-arm-tsc option. This option 
is made for compiling xenomai for an old kernel.

Anyway, you can try the following patch:
diff --git a/include/asm-arm/syscall.h b/include/asm-arm/syscall.h
index 5ca1bf0..8161d39 100644
--- a/include/asm-arm/syscall.h
+++ b/include/asm-arm/syscall.h
@@ -257,9 +257,9 @@ static inline unsigned long long __xn_rdtsc(void)
 	return __xn_tscinfo.kuser_tsc_get(__xn_tscinfo.kinfo.counter);
 
 #elif CONFIG_XENO_ARM_TSC_TYPE == __XN_TSC_TYPE_FREERUNNING
-	volatile unsigned long long *const tscp = __xn_tscinfo.tsc;
-	volatile unsigned *const counterp = __xn_tscinfo.counter;
-	const unsigned mask = __xn_tscinfo.mask;
+	volatile unsigned long long *const tscp = __xn_tscinfo.kinfo.tsc;
+	volatile unsigned *const counterp = __xn_tscinfo.kinfo.counter;
+	const unsigned mask = __xn_tscinfo.kinfo.mask;
 	register unsigned long long result;
 	unsigned counter;
 
@@ -272,9 +272,9 @@ static inline unsigned long long __xn_rdtsc(void)
 	return (result & ~((unsigned long long) mask)) | (counter & mask);
 
 #elif CONFIG_XENO_ARM_TSC_TYPE == __XN_TSC_TYPE_FREERUNNING_COUNTDOWN
-	volatile unsigned long long *const tscp = __xn_tscinfo.tsc;
-	volatile unsigned *const counterp = __xn_tscinfo.counter;
-	const unsigned mask = __xn_tscinfo.mask;
+	volatile unsigned long long *const tscp = __xn_tscinfo.kinfo.tsc;
+	volatile unsigned *const counterp = __xn_tscinfo.kinfo.counter;
+	const unsigned mask = __xn_tscinfo.kinfo.mask;
 	register unsigned long long result;
 	unsigned counter;
 
@@ -287,9 +287,9 @@ static inline unsigned long long __xn_rdtsc(void)
 	return (result & ~((unsigned long long) mask)) | (counter & mask);
 
 #elif CONFIG_XENO_ARM_TSC_TYPE == __XN_TSC_TYPE_FREERUNNING_FAST_WRAP
-	volatile unsigned long long *const tscp = __xn_tscinfo.tsc;
-	volatile unsigned *const counterp = __xn_tscinfo.counter;
-	const unsigned mask = __xn_tscinfo.mask;
+	volatile unsigned long long *const tscp = __xn_tscinfo.kinfo.tsc;
+	volatile unsigned *const counterp = __xn_tscinfo.kinfo.counter;
+	const unsigned mask = __xn_tscinfo.kinfo.mask;
 	register unsigned long long after, before;
 	unsigned counter;
 
@@ -305,10 +305,10 @@ static inline unsigned long long __xn_rdtsc(void)
 	return (before & ~((unsigned long long) mask)) | (counter & mask);
 
 #elif CONFIG_XENO_ARM_TSC_TYPE == __XN_TSC_TYPE_DECREMENTER
-	volatile unsigned long long *const tscp = __xn_tscinfo.tsc;
-	volatile unsigned *const counterp = __xn_tscinfo.counter;
-	volatile unsigned *const last_cntp = __xn_tscinfo.last_cnt;
-	const unsigned mask = __xn_tscinfo.mask;
+	volatile unsigned long long *const tscp = __xn_tscinfo.kinfo.tsc;
+	volatile unsigned *const counterp = __xn_tscinfo.kinfo.counter;
+	volatile unsigned *const last_cntp = __xn_tscinfo.kinfo.last_cnt;
+	const unsigned mask = __xn_tscinfo.kinfo.mask;
 	register unsigned long long after, before;
 	unsigned counter, last_cnt;
 


> If I don't choose TSC emulation for ARM, everything compiles fine.


...and if you are using a recent I-pipe patch, it is what you should do 
anyway.

-- 
                                                                Gilles.

