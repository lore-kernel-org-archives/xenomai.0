From: Sebastian Smolorz <ssm@domain.hid>
Date: Thu, 16 Nov 2006 10:31:04 +0100
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_Y/CXFVyzrZK2kUt"
Message-Id: <E1GkdaL-0002Rj-8x@domain.hid>
Subject: [Xenomai-core] Typo in latest svn revision
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: rpm@xenomai.org, xenomai@xenomai.org

--Boundary-00=_Y/CXFVyzrZK2kUt
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello Philippe,

there was a typo in your latest check-in.

--
Sebastian

--Boundary-00=_Y/CXFVyzrZK2kUt
Content-Type: text/x-diff;
  charset="us-ascii";
  name="heap_typo.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="heap_typo.patch"

Index: ksrc/nucleus/heap.c
===================================================================
--- ksrc/nucleus/heap.c	(Revision 1840)
+++ ksrc/nucleus/heap.c	(Arbeitskopie)
@@ -1138,7 +1138,7 @@ int xnheap_destroy_mapped(xnheap_t *heap
 	xnlock_put_irqrestore(&nklock, s);
 
 	__unreserve_and_free_heap(heap->archdep.heapbase,
-				  heap->extensize, heap->archdep.kmflags);
+				  heap->extentsize, heap->archdep.kmflags);
 	return 0;
 }
 

--Boundary-00=_Y/CXFVyzrZK2kUt--

