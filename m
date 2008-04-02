From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="ZM6r2xlZK3"
Content-Transfer-Encoding: 7bit
Message-ID: <18420.3711.295442.250105@domain.hid>
Date: Thu, 3 Apr 2008 00:53:51 +0200
In-Reply-To: <18420.2520.32895.319766@domain.hid>
References: <47ED5DE3.60202@domain.hid> <47F17B32.7070505@domain.hid>
	<18417.52630.8850.939898@domain.hid>
	<47F23E9E.7060801@domain.hid>
	<2ff1a98a0804010703v7090d7dbhbbff114a51badd6d@domain.hid>
	<47F258AD.3000103@domain.hid>
	<2ff1a98a0804010858kb009b37y764667cf1fa56c6@domain.hid>
	<47F2A7CC.4050301@domain.hid>
	<2ff1a98a0804020142r55bab884x8896c8191f8580d5@domain.hid>
	<47F3A00E.1020700@domain.hid>
	<2ff1a98a0804020807t4d2cc718x493ae3c48e9a042f@domain.hid>
	<47F3E0B3.2030805@domain.hid>
	<18419.57862.758026.458669@domain.hid>
	<47F3FE7E.6020302@domain.hid>
	<18420.2520.32895.319766@domain.hid>
Subject: Re: [Xenomai-core] Kernel crash with Xenomai (caused by fork?)
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Tomas Kalibera <kalibera@domain.hid>, xenomai-core <xenomai@xenomai.org>


--ZM6r2xlZK3
Content-Type: text/plain; charset=us-ascii
Content-Description: message body and .signature
Content-Transfer-Encoding: 7bit

Gilles Chanteperdrix wrote:
 > Tomas Kalibera wrote:
 >  > Gilles Chanteperdrix wrote:
 >  > > Tomas Kalibera wrote:
 >  > >  > 
 >  > >  > Hi Gilles,
 >  > >  > 
 >  > >  > I've recompiled the kernel again from scratch and got the same lock up. 
 >  > >  > Fix 5 does not help... If you want to inspect the exact kernel I used, 
 >  > >  > it's again at http://www.cs.purdue.edu/~tkaliber/crash, the one with 
 >  > >  > "p5" in its name.
 >  > >  > 
 >  > >  > Tomas
 >  > >
 >  > > But... do you get the lock-up without the patch ?
 >  > >
 >  > >   
 >  > No. Or, more precisely, not the same one. With this patch (5), the 
 >  > system locks up as soon as the application starts. It  does not print 
 >  > any stack trace.
 >  > Without the patch, the system gets to unusable state when the 
 >  > application calls clone/fork, and it does produce a stack trace (those I 
 >  > was sending you before). It seems to be more alive (processes start, but 
 >  > crash, because of garbled preempt_count).
 >  > 
 >  > The crashes are perfectly repeatable on the system I have. So, the 
 >  > crashes make no sense to you, right ?  I can indeed try to go the 
 >  > defensive path and try an older kernel or something, but if there is a 
 >  > Xenomai bug, it would be nice to find it...  The same for kernel bug, 
 >  > indeed.
 > 
 > Of course, we are looking for all bugs. But please tell me: do you get
 > the lock-up even before fork is called ? If not, could you verify that
 > at least some Xenomai programs run correctly, for instance latency ?
 > Looking at the code, I think I found a bug, but I doubt it could cause a
 > lockup. The definition of VM_PINNED in include/linux/mm.h collides with
 > another bit used by Linux, so this defintion should be changed from:
 > #define VM_PINNED 0x08000000
 > to:
 > #define VM_PINNED 0x10000000

Here comes a 6th patch for this bug, (patch 6 includes patch 5).

-- 


					    Gilles.

--ZM6r2xlZK3
Content-Type: text/plain
Content-Disposition: inline;
	filename="ipipe-kmap_atomic-bug.6.diff"
Content-Transfer-Encoding: 7bit

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 7f27db6..a0c80c7 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -104,10 +104,11 @@ extern unsigned int kobjsize(const void *objp);
 #define VM_MAPPED_COPY	0x01000000	/* T if mapped copy of data (nommu mmap) */
 #define VM_INSERTPAGE	0x02000000	/* The vma has had "vm_insert_page()" done on it */
 #define VM_ALWAYSDUMP	0x04000000	/* Always include in core dumps */
-#define VM_PINNED	0x08000000	/* Disable faults for the vma */
 
 #define VM_CAN_NONLINEAR 0x08000000	/* Has ->fault & does nonlinear pages */
 
+#define VM_PINNED	0x10000000	/* Disable faults for the vma */
+
 #ifndef VM_STACK_DEFAULT_FLAGS		/* arch can override this */
 #define VM_STACK_DEFAULT_FLAGS VM_DATA_DEFAULT_FLAGS
 #endif
diff --git a/mm/memory.c b/mm/memory.c
index e0e7a3d..32d6cb6 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -584,8 +584,14 @@ again:
 			if (is_cow_mapping(vma->vm_flags)) {
 				if (((vma->vm_flags|src_mm->def_flags) & (VM_LOCKED|VM_PINNED))
 				    == (VM_LOCKED|VM_PINNED)) {
+				    	arch_leave_lazy_mmu_mode();
+				    	spin_unlock(src_ptl);
+				    	pte_unmap_nested(src_pte);
+				    	add_mm_rss(dst_mm, rss[0], rss[1]);
+				    	pte_unmap_unlock(dst_pte, dst_ptl);
+				    	cond_resched();
 					do_cow_break = 1;
-					break;
+					goto again;
 				}
 			}
 		}

--ZM6r2xlZK3--

