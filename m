Message-ID: <455B8535.6030106@domain.hid>
Date: Wed, 15 Nov 2006 22:23:01 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [BUG] commit #1833 breaks rt_queue_create
References: <455B82F3.702@domain.hid>
In-Reply-To: <455B82F3.702@domain.hid>
Content-Type: multipart/mixed; boundary="------------090506070101090702010706"
Sender: jan.kiszka@domain.hid
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai-core <xenomai@xenomai.org>

This is a multi-part message in MIME format.
--------------090506070101090702010706
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

Jan Kiszka wrote:
> As xnheap_size() changed, a sanity check in xnheap_mmap fails now, at
> least for SVN head, maybe also 2.2.x.
> 
> I would suggest the following patch to fix this,

Wasn't someone recently writing in the wiki, one should post plain-text
patches here...?

Hope this one is less octet-streamed.

--------------090506070101090702010706
Content-Type: text/plain;
 name="fix-mapped-heap-size.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="fix-mapped-heap-size.patch"

Index: ksrc/nucleus/heap.c
===================================================================
--- ksrc/nucleus/heap.c	(Revision 1835)
+++ ksrc/nucleus/heap.c	(Arbeitskopie)
@@ -952,7 +952,7 @@ static int xnheap_mmap(struct file *file
 	size = vma->vm_end - vma->vm_start;
 	heap = (xnheap_t *)file->private_data;
 
-	if (size != heap->extentsize)
+	if (size != xnheap_size(heap))
 		return -ENXIO;	/* Doesn't match the heap size. */
 
 	vma->vm_ops = &xnheap_vmops;
@@ -1135,7 +1135,7 @@ int xnheap_destroy_mapped(xnheap_t *heap
 	xnlock_put_irqrestore(&nklock, s);
 
 	__unreserve_and_free_heap(heap->archdep.heapbase,
-				  heap->extentsize, heap->archdep.kmflags);
+				  xnheap_size(heap), heap->archdep.kmflags);
 	return 0;
 }
 
--------------090506070101090702010706--

