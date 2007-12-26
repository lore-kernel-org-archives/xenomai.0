MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="+EdJAhPSWG"
Content-Transfer-Encoding: 7bit
Message-ID: <18290.58833.261791.68352@domain.hid>
Date: Thu, 27 Dec 2007 00:37:53 +0100
In-Reply-To: <0B45E93C5FF65740AEAE690BF3848B7A4AB2DF@rennsmail04.eu.thmulti.com>
References: <0B45E93C5FF65740AEAE690BF3848B7A4AB2DF@rennsmail04.eu.thmulti.com>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Subject: Re: [Xenomai-help] RTDM mmap and DMA
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Fillod Stephane <stephane.fillod@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>


--+EdJAhPSWG
Content-Type: text/plain; charset=us-ascii
Content-Description: message body and .signature
Content-Transfer-Encoding: 7bit

Fillod Stephane wrote:
 > Perrine Martignoni wrote:
 > >Currently, I write an RTDM module and I would like to do DMA and mmap
 > to perform transfers who have hard constraints.
 > >I would like to know if there is an example in a driver who would help
 > me to do this.
 > 
 > I'm looking for the same need, except I'm not using RTDM, and everything
 > is in userland. Using the attached patch against Xenomai 2.4.0, I hope
 > to make it to work with something like this:

I propose the attached modifications. Is it Ok for you ?

-- 


					    Gilles Chanteperdrix.

--+EdJAhPSWG
Content-Type: text/plain
Content-Disposition: inline;
	filename="heap_dma.2.patch"
Content-Transfer-Encoding: 7bit

Index: ksrc/nucleus/heap.c
===================================================================
--- ksrc/nucleus/heap.c	(revision 3301)
+++ ksrc/nucleus/heap.c	(working copy)
@@ -1180,7 +1180,11 @@
 		 * space. Assume that we can wait to get the required memory.
 		 */
 
-		ptr = kmalloc(size, kmflags | GFP_KERNEL);
+		if (size <= KMALLOC_MAX_SIZE)
+			ptr = kmalloc(size, kmflags | GFP_KERNEL);
+		else
+			ptr = (void*) __get_free_pages(kmflags | GFP_KERNEL,
+						       get_order(size));
 
 		if (!ptr)
 			return NULL;
@@ -1212,7 +1216,10 @@
 		for (vaddr = vabase; vaddr < vabase + size; vaddr += PAGE_SIZE)
 			ClearPageReserved(virt_to_page(vaddr));
 
-		kfree(ptr);
+		if (size <= KMALLOC_MAX_SIZE)
+			kfree(ptr);
+		else
+			free_pages((unsigned long)ptr, get_order(size));
 	}
 }
 
Index: ksrc/skins/native/heap.c
===================================================================
--- ksrc/skins/native/heap.c	(revision 3301)
+++ ksrc/skins/native/heap.c	(working copy)
@@ -730,6 +730,7 @@
 	info->usablemem = xnheap_usable_mem(&heap->heap_base);
 	info->usedmem = xnheap_used_mem(&heap->heap_base);
 	info->mode = heap->mode;
+	info->phys_addr = (heap->mode & H_SINGLE) ? virt_to_phys(heap->sba):0;
 
       unlock_and_exit:
 
Index: include/native/heap.h
===================================================================
--- include/native/heap.h	(revision 3301)
+++ include/native/heap.h	(working copy)
@@ -48,6 +48,8 @@
 
     char name[XNOBJECT_NAME_LEN]; /* !< Symbolic name. */
 
+    unsigned long phys_addr;	/* !< Physical address. */
+
 } RT_HEAP_INFO;
 
 typedef struct rt_heap_placeholder {
Index: include/asm-generic/wrappers.h
===================================================================
--- include/asm-generic/wrappers.h	(revision 3301)
+++ include/asm-generic/wrappers.h	(working copy)
@@ -27,6 +27,7 @@
 
 #include <linux/version.h>
 #include <linux/module.h>
+#include <linux/slab.h>
 #include <asm/io.h>
 
 #if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0)
@@ -281,4 +282,8 @@
 #define trace_mark(ev, fmt, args...)	do { } while (0)
 #endif /* CONFIG_MARKERS */
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,22)
+#define KMALLOC_MAX_SIZE 131072
+#endif /* !KMALLOC_MAX_SIZE */
+
 #endif /* _XENO_ASM_GENERIC_WRAPPERS_H */

--+EdJAhPSWG--

