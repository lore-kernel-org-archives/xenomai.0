From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <1247663762.4228.10.camel@domain.hid>
References: <5D63919D95F87E4D9D34FF7748CE2C2A01B1A843@domain.hid>
	<1247663762.4228.10.camel@domain.hid>
Content-Type: text/plain
Date: Thu, 16 Jul 2009 18:22:44 +0200
Message-Id: <1247761364.4228.75.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] rtdm_lock_init does not compile with
 ppc-ipipe-patch 2.0.1
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: roderik.wildenburg@domain.hid
Cc: xenomai@xenomai.org

On Wed, 2009-07-15 at 15:16 +0200, Philippe Gerum wrote:
> On Wed, 2009-07-15 at 15:00 +0200, roderik.wildenburg@domain.hid
> wrote:
> > When I try to compile RTnet (for PPC, Xenomai 2.4.8, Ipipe 2.0.1, Kernel
> > 2.4.25) I get the following error message :
> > 
> > In file included from rtdev.c:33:
> > ../stack/include/rtskb.h: In function `rtskb_queue_init':
> > ../stack/include/rtskb.h:289: error: parse error before '{' token
> > ../stack/include/rtskb.h: At top level:
> > ../stack/include/rtskb.h:290: error: parse error before '->' token
> > ../stack/include/rtskb.h: In function `rtskb_prio_queue_init':
> > ../stack/include/rtskb.h:301: error: parse error before '{' token
> > rtdev.c: In function `rtdev_alloc':
> > rtdev.c:243: error: parse error before '{' token
> > 

> In UP mode, you should not even have any expansion for a spinlock init.
> I will have a look at this.
> 

You need this on top of 2.0-01:

diff --git a/include/asm-ppc/spinlock.h b/include/asm-ppc/spinlock.h
index 855b815..f50df97 100644
--- a/include/asm-ppc/spinlock.h
+++ b/include/asm-ppc/spinlock.h
@@ -30,6 +30,7 @@ typedef struct {
 #endif
 
 #define SPIN_LOCK_UNLOCKED	(spinlock_t) { 0 SPINLOCK_DEBUG_INIT }
+#define __SPIN_LOCK_UNLOCKED	{ 0 SPINLOCK_DEBUG_INIT }
 
 #define spin_lock_init(x) 	do { *(x) = SPIN_LOCK_UNLOCKED; } while(0)
 #define spin_is_locked(x)	((x)->lock != 0)
diff --git a/include/linux/spinlock.h b/include/linux/spinlock.h
index 1462732..fe56f59 100644
--- a/include/linux/spinlock.h
+++ b/include/linux/spinlock.h
@@ -120,9 +120,11 @@ do {									\
 #if (__GNUC__ > 2 || __GNUC_MINOR__ > 95)
   typedef struct { } spinlock_t;
   #define SPIN_LOCK_UNLOCKED (spinlock_t) { }
+  #define __SPIN_LOCK_UNLOCKED { }
 #else
   typedef struct { int gcc_is_buggy; } spinlock_t;
   #define SPIN_LOCK_UNLOCKED (spinlock_t) { 0 }
+  #define __SPIN_LOCK_UNLOCKED { 0 }
 #endif
 
 #define spin_lock_init(lock)	do { } while(0)
@@ -138,6 +140,7 @@ typedef struct {
 	volatile unsigned long lock;
 } spinlock_t;
 #define SPIN_LOCK_UNLOCKED (spinlock_t) { 0 }
+#define __SPIN_LOCK_UNLOCKED { 0 }
 
 #define spin_lock_init(x)	do { (x)->lock = 0; } while (0)
 #define spin_is_locked(lock)	(test_bit(0,(lock)))
@@ -155,6 +158,7 @@ typedef struct {
 	const char *module;
 } spinlock_t;
 #define SPIN_LOCK_UNLOCKED (spinlock_t) { 0, 25, __BASE_FILE__ }
+#define __SPIN_LOCK_UNLOCKED { 0, 25, __BASE_FILE__ }
 
 #include <linux/kernel.h>
 
@@ -202,7 +206,7 @@ typedef struct {
 } __ipipe_spinlock_t;
 
 #ifdef CONFIG_IPIPE
-#define IPIPE_SPIN_LOCK_UNLOCKED	{ .__lock = SPIN_LOCK_UNLOCKED }
+#define IPIPE_SPIN_LOCK_UNLOCKED	(__ipipe_spinlock_t) { .__lock = __SPIN_LOCK_UNLOCKED }
 #define ipipe_spinlock_t		__ipipe_spinlock_t
 #define IPIPE_DEFINE_SPINLOCK(x)	ipipe_spinlock_t x = IPIPE_SPIN_LOCK_UNLOCKED
 #define IPIPE_DECLARE_SPINLOCK(x)	extern ipipe_spinlock_t x
@@ -219,7 +223,7 @@ void __ipipe_spin_unlock_irqcomplete(unsigned long x);
 	spin_unlock_irqrestore(lock, flags)
 #else /* !CONFIG_IPIPE */
 #define ipipe_spinlock_t		spinlock_t
-#define IPIPE_SPIN_LOCK_UNLOCKED	SPIN_LOCK_UNLOCKED
+#define IPIPE_SPIN_LOCK_UNLOCKED	__SPIN_LOCK_UNLOCKED
 #define IPIPE_DEFINE_SPINLOCK(x)	spinlock_t x
 #define IPIPE_DECLARE_SPINLOCK(x)	extern spinlock_t x
 
-- 
Philippe.



