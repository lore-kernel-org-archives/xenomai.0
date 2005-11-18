Message-ID: <437E0529.8030102@domain.hid>
Date: Fri, 18 Nov 2005 18:45:29 +0200
From: Heikki Lindholm <holindho@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------070702080006090706090008"
Subject: [Xenomai-core] [PATCH] xenomai 2.1 ppc64 build fix
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

This is a multi-part message in MIME format.
--------------070702080006090706090008
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Xenomai 2.1:

- powerpc/atomic.h lost one 64-bit #ifdef during the merge - ppc64 
defines its own atomic mask functions.

-- Heikki Lindholm

--------------070702080006090706090008
Content-Type: text/plain; x-mac-type="0"; x-mac-creator="0";
	name="xenomai2.1-051118-atomic.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="xenomai2.1-051118-atomic.patch"

diff -Nru xenomai/include/asm-powerpc/atomic.h xenomai-devel/include/asm-powerpc/atomic.h
--- xenomai/include/asm-powerpc/atomic.h	2005-11-08 09:43:39.000000000 +0200
+++ xenomai-devel/include/asm-powerpc/atomic.h	2005-11-18 15:37:34.000000000 +0200
@@ -210,6 +210,7 @@
     return t;
 }
 
+#ifndef __powerpc64__
 static __inline__ void atomic_set_mask(unsigned long mask,
 				       unsigned long *ptr)
 {
@@ -237,6 +238,7 @@
 	: "r" (ptr), "r" (mask)
 	: "r5", "cc", "memory");
 }
+#endif /* __powerpc64__ */
 
 #define xnarch_atomic_xchg(ptr,v)   atomic_xchg(ptr,v)
 #define xnarch_memory_barrier()     __asm__ __volatile__("": : :"memory")

--------------070702080006090706090008--

