From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <4B263E6A.7040104@domain.hid>
References: <4B263E6A.7040104@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 15 Dec 2009 11:09:25 +0100
Message-ID: <1260871765.2216.102.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] Build tests.
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Alexis Berlemont <alexis.berlemont@domain.hid>, xenomai-core <xenomai@xenomai.org>

On Mon, 2009-12-14 at 14:32 +0100, Gilles Chanteperdrix wrote:
> Hi,
> 
> I am working on automated build tests of several configurations of
> Xenomai head. While running them, I found a few issues, and would need
> acks, since it is in parts others maintain.
> 
> Alex: https://mail.gna.org/public/xenomai-git/2009-12/msg00112.html
> 
> Wolfgang: https://mail.gna.org/public/xenomai-git/2009-12/msg00113.html
> 
> Anyone: https://mail.gna.org/public/xenomai-git/2009-12/msg00114.html
> 
> Philippe (check powerpc 2.4):
> https://mail.gna.org/public/xenomai-git/2009-12/msg00115.html
> 

We have to include asm/mmu.h to get phys_addr_t defined.
The default declaration of this type for pre-2.6.28 kernels breaks
2.6.20. Better rely on phys_addr_t being defined in linux/types.h, or
specifically in our wrappers for older kernels. What a mess.

Tested here on blackfin 2.6.3x, x86* 2.6.27-2.6.30, nios2 2.6.3x, ppc
2.4.x, 2.6.20, 2.6.3x. You may want to check this against ARM as well.

diff --git a/include/asm-generic/wrappers.h b/include/asm-generic/wrappers.h
index 198d882..ae36932 100644
--- a/include/asm-generic/wrappers.h
+++ b/include/asm-generic/wrappers.h
@@ -319,16 +319,10 @@ static inline unsigned long hweight_long(unsigned long w)
 unsigned long find_next_bit(const unsigned long *addr,
                             unsigned long size, unsigned long offset);
 
-typedef phys_addr_t resource_size_t;
-
 #define mmiowb()	barrier()
 
 #else /* LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,0) */
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,28)
-typedef unsigned long phys_addr_t;
-#endif
-
 #define compat_module_param_array(name, type, count, perm) \
 	module_param_array(name, type, NULL, perm)
 
diff --git a/include/asm-powerpc/wrappers.h b/include/asm-powerpc/wrappers.h
index 7d98539..edab86c 100644
--- a/include/asm-powerpc/wrappers.h
+++ b/include/asm-powerpc/wrappers.h
@@ -30,6 +30,8 @@
 
 #if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0)
 
+#include <asm/mmu.h>
+
 #define CONFIG_MMU 1
 
 #define wrap_phys_mem_prot(filp,pfn,size,prot)  \
@@ -53,6 +55,8 @@ static __inline__ int fls(unsigned int x)
 	return 32 - lz;
 }
 
+typedef phys_addr_t resource_size_t;
+
 #else /*  LINUX_VERSION_CODE >= KERNEL_VERSION(2,5,0)  */
 
 #define wrap_phys_mem_prot(filp,pfn,size,prot) \
diff --git a/include/asm-x86/wrappers_32.h b/include/asm-x86/wrappers_32.h
index d16cf6d..90ccdc1 100644
--- a/include/asm-x86/wrappers_32.h
+++ b/include/asm-x86/wrappers_32.h
@@ -78,6 +78,10 @@ static inline int fls(int x)
 	return r+1;
 }
 
+typedef unsigned long phys_addr_t;
+
+typedef phys_addr_t resource_size_t;
+
 #else /*  LINUX_VERSION_CODE >= KERNEL_VERSION(2,5,0)  */
 
 #define wrap_phys_mem_prot(filp,pfn,size,prot)  (prot)

> The current status of the tests may be found here:
> http://sisyphus.hd.free.fr/~gilles/bx/
> 
> TIA,
> Regards.
> 


-- 
Philippe.



