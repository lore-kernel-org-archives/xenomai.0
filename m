Date: Tue, 1 Apr 2008 12:43:11 +0200
From: Robert Schwebel <r.schwebel@domain.hid>
Message-ID: <20080401104311.GT13814@domain.hid>
References: <20080401103647.GR13814@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20080401103647.GR13814@domain.hid>
Subject: [Xenomai-core] [PATCH][SOLO] sparse fix: use NULL instead of 0
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

Sparse has found this, fixed by the patch below:

tlsf/tlsf.c:383:51: warning: Using plain integer as NULL pointer
tlsf/tlsf.c:388:16: warning: Using plain integer as NULL pointer
tlsf/tlsf.c:467:16: warning: Using plain integer as NULL pointer
tlsf/tlsf.c:383:51: warning: Using plain integer as NULL pointer
tlsf/tlsf.c:388:16: warning: Using plain integer as NULL pointer

Signed-off-by: Robert Schwebel <r.schwebel@domain.hid>

---
 base/tlsf/tlsf.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

Index: xenomai-solo/base/tlsf/tlsf.c
===================================================================
--- xenomai-solo.orig/base/tlsf/tlsf.c	2008-03-29 22:54:41.000000000 +0100
+++ xenomai-solo/base/tlsf/tlsf.c	2008-03-30 19:49:59.000000000 +0200
@@ -380,12 +380,12 @@
          MIN_BLOCK_SIZE) ? MIN_BLOCK_SIZE : ROUNDUP_SIZE(sizeof(area_info_t)) | USED_BLOCK | PREV_USED;
     b = (bhdr_t *) GET_NEXT_BLOCK(ib->ptr.buffer, ib->size & BLOCK_SIZE);
     b->size = ROUNDDOWN_SIZE(size - 3 * BHDR_OVERHEAD - (ib->size & BLOCK_SIZE)) | USED_BLOCK | PREV_USED;
-    b->ptr.free_ptr.prev = b->ptr.free_ptr.next = 0;
+    b->ptr.free_ptr.prev = b->ptr.free_ptr.next = NULL;
     lb = GET_NEXT_BLOCK(b->ptr.buffer, b->size & BLOCK_SIZE);
     lb->prev_hdr = b;
     lb->size = 0 | USED_BLOCK | PREV_FREE;
     ai = (area_info_t *) ib->ptr.buffer;
-    ai->next = 0;
+    ai->next = NULL;
     ai->end = lb;
     return ib;
 }
@@ -464,7 +464,7 @@
 
     memset(area, 0, area_size);
     ptr = tlsf->area_head;
-    ptr_prev = 0;
+    ptr_prev = NULL;
 
     ib0 = process_area(area, area_size);
     b0 = GET_NEXT_BLOCK(ib0->ptr.buffer, ib0->size & BLOCK_SIZE);
-- 
 Dipl.-Ing. Robert Schwebel | http://www.pengutronix.de
 Pengutronix - Linux Solutions for Science and Industry
   Handelsregister:  Amtsgericht Hildesheim, HRA 2686
     Hannoversche Str. 2, 31134 Hildesheim, Germany
   Phone: +49-5121-206917-0 |  Fax: +49-5121-206917-9


