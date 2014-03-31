From: "Lennart Sorensen" <lsorense@csclub.uwaterloo.ca>
Date: Mon, 31 Mar 2014 15:37:42 -0400
Message-ID: <20140331193742.GS17765@csclub.uwaterloo.ca>
References: <20140331174555.GO17765@csclub.uwaterloo.ca>
 <5339B015.3080008@xenomai.org>
 <20140331182404.GP17765@csclub.uwaterloo.ca>
 <20140331191502.GQ17765@csclub.uwaterloo.ca>
 <5339BF3C.8090906@xenomai.org>
 <20140331191849.GR17765@csclub.uwaterloo.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20140331191849.GR17765@csclub.uwaterloo.ca>
Subject: Re: [Xenomai] Porting xenomai 2.6.3 and ipipe to 3.12 kernel
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

On Mon, Mar 31, 2014 at 03:18:49PM -0400, Lennart Sorensen wrote:
> On Mon, Mar 31, 2014 at 09:17:16PM +0200, Gilles Chanteperdrix wrote:
> > Are you sure you are loking at the right tree? I am talking about the
> > raw/for-ipipe-3.12.0 tree in ipipe-gch.git, not the raw/ipipe-3.12.0
> > tree in ipipe.git
> 
> Oh, then no, wrong tree.
> 
> Let me check the other one.

Ok that looks better.

Couple of things:

I think this is wrong:

  @@ -268,13 +298,22 @@ extern void flush_cache_page(struct vm_area_struct *vma, unsigned long user_addr                               
    * Harvard caches are synchronised for the user space address range.                                                                
    * This is used for the ARM private sys_cacheflush system call.
    */
  -#define flush_cache_user_range(s,e)    __cpuc_coherent_user_range(s,e)
  +#define flush_cache_user_range(s, e)                                   \                                                            
  +       ({                                                              \                                                            
  +               struct mm_struct *_mm = current->mm;                    \
  +               unsigned long _s, _e;                                   \
  +               _s = fcse_va_to_mva(_mm, s) & PAGE_MASK;                \
  +               _e = PAGE_ALIGN(fcse_va_to_mva(_mm, e));                \
  +               __cpuc_coherent_user_range(_s, _e);                     \                                                            
  +       })                                                                                                                           
   
   /* 
    * Perform necessary cache operations to ensure that data previously                                                                

The kernel specificly did NOT want the PAGE_MASK and PAGE_ALIGN and got
rid of it.  At last that's what the commit that changed it said.  So I
think the ipipe patch should follow that change too.  ie:

  @@ -268,13 +298,22 @@ extern void flush_cache_page(struct vm_area_struct *vma, unsigned long user_addr                               
    * Harvard caches are synchronised for the user space address range.                                                                
    * This is used for the ARM private sys_cacheflush system call.
    */
  -#define flush_cache_user_range(s,e)    __cpuc_coherent_user_range(s,e)
  +#define flush_cache_user_range(s, e)                                   \                                                            
  +       ({                                                              \                                                            
  +               struct mm_struct *_mm = current->mm;                    \
  +               unsigned long _s, _e;                                   \
  +               _s = fcse_va_to_mva(_mm, s);                            \
  +               _e = fcse_va_to_mva(_mm, e);                            \
  +               __cpuc_coherent_user_range(_s, _e);                     \                                                            
  +       })                                                                                                                           
   
   /* 
    * Perform necessary cache operations to ensure that data previously                                                                

Also my version of arch/arm/include/asm/barrier.h turned out a bit
different (I was trying to avoid changing the kernel code as much as
possible).  Diff versus yours is:

--- /tmp/barrier.h      2014-03-31 19:26:10.000000000 +0000
+++ linux-3.12.14.rr1/arch/arm/include/asm/barrier.h    2014-03-27 20:06:33.000000000 +0000
@@ -16,17 +16,15 @@
 #if __LINUX_ARM_ARCH__ >= 7
 #define isb(option) __asm__ __volatile__ ("isb " #option : : : "memory")
 #define dsb(option) __asm__ __volatile__ ("dsb " #option : : : "memory")
-#define DMB(option) "dmb " #option
+#define DMB "dmb"
 #define DMB_IN
-
 #elif defined(CONFIG_CPU_XSC3) || __LINUX_ARM_ARCH__ == 6
 #define isb(x) __asm__ __volatile__ ("mcr p15, 0, %0, c7, c5, 4" \
                                    : : "r" (0) : "memory")
 #define dsb(x) __asm__ __volatile__ ("mcr p15, 0, %0, c7, c10, 4" \
                                    : : "r" (0) : "memory")
-#define DMB(option) "mcr p15, 0, %0, c7, c10, 5"
+#define DMB "mcr p15, 0, %0, c7, c10, 5"
 #define DMB_IN "r" (0)
-
 #elif defined(CONFIG_CPU_FA526)
 #define isb(x) __asm__ __volatile__ ("mcr p15, 0, %0, c7, c5, 4" \
                                    : : "r" (0) : "memory")
@@ -39,9 +37,9 @@
 #endif
 
 #ifdef DMB
-#define dmb(option) __asm__ __volatile__(DMB(option) : : DMB_IN : "memory")
+#define dmb(option) __asm__ __volatile__(DMB #option : : DMB_IN : "memory")
 #else
-#define dmb(option) __asm__ __volatile__("" : : : "memory")
+#define dmb(option) __asm__ __volatile__("" #option : : : "memory")
 #endif
 
 
@@ -62,7 +60,6 @@
 #define smp_rmb()      barrier()
 #define smp_wmb()      barrier()
 #else
-
 #ifdef CONFIG_THUMB2_KERNEL
 #define SMP_ONLY(smp) \
        "9998:  " smp "\n"                                      \
@@ -80,16 +77,13 @@
 #endif
 
 #ifdef DMB
-#define smp_mb() \
-       __asm__ __volatile__ (SMP_ONLY(DMB(ish)) : : DMB_IN : "memory")
-#define smp_rmb() \
-       __asm__ __volatile__ (SMP_ONLY(DMB(ish)) : : DMB_IN : "memory")
-#define smp_wmb() \
-       __asm__ __volatile__ (SMP_ONLY(DMB(ishst)) : : DMB_IN : "memory")
-#else
-#define smp_mb() barrier()
-#define smp_rmb() barrier()
-#define smp_wmb() barrier()
+#define smp_mb() __asm__ __volatile__ (SMP_ONLY(DMB " ish") : : DMB_IN : "memory")
+#define smp_rmb()      smp_mb()
+#define smp_wmb() __asm__ __volatile__ (SMP_ONLY(DMB " ishst") : : DMB_IN : "memory")
+#else
+#define smp_mb()       dmb(ish)
+#define smp_rmb()      smp_mb()
+#define smp_wmb()      dmb(ishst)
 #endif
 #endif

I haven't fully checked if there is any functional difference yet.

-- 
Len Sorensen

