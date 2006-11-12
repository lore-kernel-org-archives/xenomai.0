Subject: Re: [Xenomai-core] r1827 seems to have broken PPC with vxworks skin
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <200611122203.31192.niklaus.giger@domain.hid>
References: <200611122203.31192.niklaus.giger@domain.hid>
Content-Type: text/plain
Date: Sun, 12 Nov 2006 23:08:09 +0100
Message-Id: <1163369289.12206.37.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Reply-To: rpm@xenomai.org
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: niklaus.giger@domain.hid
Cc: xenomai-core <xenomai@xenomai.org>

On Sun, 2006-11-12 at 22:03 +0100, Niklaus Giger wrote:
> Hi Philippe
> 
> Your commit 1827 "Make rthal_thread_switch() return the last current task 
> pointer as expected by the vanilla switch code" seems to trigger a failure in 
> my PPC405 vxworks setup.
> 
> See http://ngiger.dyndns.org/buildbot/hcu3_vx_q/builds/2/step-xenotest/0
> where I got the following error on startup:
> 
> I-pipe: Domain Xenomai registered.
> Xenomai: hal/powerpc started.
> Xenomai: real-time nucleus v2.3-rc1 (Baroque) loaded.
> Xenomai: starting native API services.
> Xenomai: starting RTDM services.
> Oops: kernel access of bad area, sig: 11 [#1]
> NIP: C0063384 LR: C0062168 SP: C02CBF50 REGS: c02cbea0 TRAP: 0300    Not 
> tainted

The bug is not related to #1827, which is ok. Fact is that this must be
the first time that someone even tries to load the VRTX skin since I've
added the direct syscall interface, because I have introduced a silly
and deadly showstopper to its init code while doing so. This patch
should fix the problem you encountered:

--- ksrc/skins/vrtx/heap.c	(revision 1829)
+++ ksrc/skins/vrtx/heap.c	(working copy)
@@ -104,27 +104,29 @@
 	if (heap0size < 2048)
 		heap0size = 2048;
 
+	vrtx_heap_idmap = vrtx_alloc_idmap(VRTX_MAX_HEAPS, 0);
+
+	if (!vrtx_heap_idmap)
+		return -ENOMEM;
+
 	heap0addr = (char *)xnmalloc(heap0size);
 
-	if (!heap0addr)
+	if (!heap0addr) {
+		vrtx_free_idmap(vrtx_heap_idmap);
 		return -ENOMEM;
+	}
 
-	hid = sc_hcreate(heap0addr, heap0size, 7, &err);	/* Must be #0 */
+	hid = sc_hcreate(heap0addr, heap0size, 7, &err); /* Must be #0 */
 
 	if (err) {
+		vrtx_free_idmap(vrtx_heap_idmap);
+
 		if (err == ER_IIP)
 			return -EINVAL;
 		else
 			return -ENOMEM;
 	}
 
-	vrtx_heap_idmap = vrtx_alloc_idmap(VRTX_MAX_HEAPS, 0);
-
-	if (!vrtx_heap_idmap) {
-		sc_hdelete(hid, 1, &err);
-		return -ENOMEM;
-	}
-
 	return 0;
 }
 
Index: ksrc/skins/vrtx/module.c
===================================================================
--- ksrc/skins/vrtx/module.c	(revision 1829)
+++ ksrc/skins/vrtx/module.c	(working copy)
@@ -101,10 +101,6 @@
 		   the bitmap space which cannot be used to draw ids. */
 
 		hi = ffnz(map->himap & ~map->himask);
-
-		if (!hi)
-			goto unlock_and_exit;
-
 		lo = ffnz(map->lomap[hi]);
 		id = hi * BITS_PER_LONG + lo;
 		++map->usedids;


-- 
Philippe.



