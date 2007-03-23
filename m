Message-ID: <4603DA8F.8050900@domain.hid>
Date: Fri, 23 Mar 2007 14:47:59 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig04937452A690100248D211F1"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] [Fwd: [rfc][patch] queued spinlocks (i386)]
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

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig04937452A690100248D211F1
Content-Type: multipart/mixed; boundary="------------040606050208030305010505"

This is a multi-part message in MIME format.
--------------040606050208030305010505
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

That idea sounds worthwhile for xnlocks as well, doesn't it?

There is a follow-up discussion [1] on whether MS is holding a patent on
this, but so far the survey is that no conflict exists.

Jan

[1] http://lkml.org/lkml/2007/3/23/82



--------------040606050208030305010505
Content-Type: message/rfc822;
	name="[rfc][patch] queued spinlocks (i386).eml.eml.eml"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="[rfc][patch] queued spinlocks (i386).eml.eml.eml"

Path: news.gmane.org!not-for-mail
From: Nick Piggin <npiggin@domain.hid>
Newsgroups: gmane.linux.kernel
Subject: [rfc][patch] queued spinlocks (i386)
Date: Fri, 23 Mar 2007 09:59:11 +0100
Approved: news@domain.hid
Message-ID: <20070323085910.GA11577@domain.hid>
NNTP-Posting-Host: lo.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Trace: sea.gmane.org 1174640399 27683 80.91.229.12 (23 Mar 2007 08:59:59 GMT)
X-Complaints-To: usenet@domain.hid
NNTP-Posting-Date: Fri, 23 Mar 2007 08:59:59 +0000 (UTC)
Cc: Ravikiran G Thirumalai <kiran@domain.hid>,
	Ingo Molnar <mingo@domain.hid>
To: Linux Kernel Mailing List <linux-kernel@domain.hid>
Original-X-From: linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1422734AbXCWI7R@vger.kernel.org
	Fri Mar 23 09:59:52 2007
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1422734AbXCWI7R@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@domain.hid
Original-Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50) id 1HUfck-0002Ee-7b
	for glk-linux-kernel-3@domain.hid; Fri, 23 Mar 2007 09:59:50 +0100
Original-Received: (majordomo@domain.hid) by vger.kernel.org via
	listexpand
	id S1422734AbXCWI7R (ORCPT <rfc822;glk-linux-kernel-3@domain.hid>);
	Fri, 23 Mar 2007 04:59:17 -0400
Original-Received: (majordomo@domain.hid) by vger.kernel.org id
	S1422743AbXCWI7R (ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Mar 2007 04:59:17 -0400
Original-Received: from cantor.suse.de ([195.135.220.2]:36718 "EHLO
	mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422734AbXCWI7Q (ORCPT <rfc822;linux-kernel@domain.hid>);
	Fri, 23 Mar 2007 04:59:16 -0400
Original-Received: from Relay1.suse.de (mail2.suse.de [195.135.221.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.suse.de (Postfix) with ESMTP id D0AEB12220;
	Fri, 23 Mar 2007 09:59:15 +0100 (CET)
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Original-Sender: linux-kernel-owner@domain.hid
Precedence: bulk
X-Mailing-List: linux-kernel@domain.hid
Xref: news.gmane.org gmane.linux.kernel:508210
Archived-At: <http://permalink.gmane.org/gmane.linux.kernel/508210>


Implement queued spinlocks for i386. This shouldn't increase the size of
the spinlock structure, while still able to handle 2^16 CPUs.

Not completely implemented with assembly yet, to make the algorithm a bit
clearer.

The queued spinlock has 2 fields, a head and a tail, which are indexes
into a FIFO of waiting CPUs. To take a spinlock, a CPU performs an
"atomic_inc_return" on the head index, and keeps the returned value as
a ticket. The CPU then spins until the tail index is equal to that
ticket.

To unlock a spinlock, the tail index is incremented (this can be non
atomic, because only the lock owner will modify tail).

Implementation inefficiencies aside, this change should have little
effect on performance for uncontended locks, but will have quite a
large cost for highly contended locks [O(N) cacheline transfers vs
O(1) per lock aquisition, where N is the number of CPUs contending].
The benefit is is that contended locks will not cause any starvation.

Just an idea. Big NUMA hardware seems to have fairness logic that
prevents starvation for the regular spinlock logic. But it might be
interesting for -rt kernel or systems with starvation issues. 


Index: linux-2.6/include/asm-i386/spinlock.h
===================================================================
--- linux-2.6.orig/include/asm-i386/spinlock.h
+++ linux-2.6/include/asm-i386/spinlock.h
@@ -29,69 +29,23 @@
 
 static inline int __raw_spin_is_locked(raw_spinlock_t *x)
 {
-	return *(volatile signed char *)(&(x)->slock) <= 0;
+	return unlikely(x->qhead != x->qtail);
 }
 
 static inline void __raw_spin_lock(raw_spinlock_t *lock)
 {
-	asm volatile("\n1:\t"
-		     LOCK_PREFIX " ; decb %0\n\t"
-		     "jns 3f\n"
-		     "2:\t"
-		     "rep;nop\n\t"
-		     "cmpb $0,%0\n\t"
-		     "jle 2b\n\t"
-		     "jmp 1b\n"
-		     "3:\n\t"
-		     : "+m" (lock->slock) : : "memory");
-}
+	unsigned short pos = 1;
 
-/*
- * It is easier for the lock validator if interrupts are not re-enabled
- * in the middle of a lock-acquire. This is a performance feature anyway
- * so we turn it off:
- *
- * NOTE: there's an irqs-on section here, which normally would have to be
- * irq-traced, but on CONFIG_TRACE_IRQFLAGS we never use this variant.
- */
-#ifndef CONFIG_PROVE_LOCKING
-static inline void __raw_spin_lock_flags(raw_spinlock_t *lock, unsigned long flags)
-{
-	asm volatile(
-		"\n1:\t"
-		LOCK_PREFIX " ; decb %[slock]\n\t"
-		"jns 5f\n"
-		"2:\t"
-		"testl $0x200, %[flags]\n\t"
-		"jz 4f\n\t"
-		STI_STRING "\n"
-		"3:\t"
-		"rep;nop\n\t"
-		"cmpb $0, %[slock]\n\t"
-		"jle 3b\n\t"
-		CLI_STRING "\n\t"
-		"jmp 1b\n"
-		"4:\t"
-		"rep;nop\n\t"
-		"cmpb $0, %[slock]\n\t"
-		"jg 1b\n\t"
-		"jmp 4b\n"
-		"5:\n\t"
-		: [slock] "+m" (lock->slock)
-		: [flags] "r" (flags)
-	 	  CLI_STI_INPUT_ARGS
-		: "memory" CLI_STI_CLOBBERS);
+	asm volatile(LOCK_PREFIX "xaddw %0, %1\n\t"
+		     : "+r" (pos), "+m" (lock->qhead) : : "memory");
+	while (unlikely(pos != lock->qtail))
+		cpu_relax();
 }
-#endif
 
 static inline int __raw_spin_trylock(raw_spinlock_t *lock)
 {
-	char oldval;
-	asm volatile(
-		"xchgb %b0,%1"
-		:"=q" (oldval), "+m" (lock->slock)
-		:"0" (0) : "memory");
-	return oldval > 0;
+	unsigned short qtail = lock->qtail;
+	return likely(cmpxchg(&lock->qhead, qtail, qtail+1) == qtail);
 }
 
 /*
@@ -105,18 +59,14 @@ static inline int __raw_spin_trylock(raw
 
 static inline void __raw_spin_unlock(raw_spinlock_t *lock)
 {
-	asm volatile("movb $1,%0" : "+m" (lock->slock) :: "memory");
+	asm volatile("addw $1,%0" : "+m" (lock->qtail) :: "memory");
 }
 
 #else
 
 static inline void __raw_spin_unlock(raw_spinlock_t *lock)
 {
-	char oldval = 1;
-
-	asm volatile("xchgb %b0, %1"
-		     : "=q" (oldval), "+m" (lock->slock)
-		     : "0" (oldval) : "memory");
+	asm volatile(LOCK_PREFIX "addw $1,%0" : "+m" (lock->qtail) :: "memory");
 }
 
 #endif
Index: linux-2.6/include/asm-i386/spinlock_types.h
===================================================================
--- linux-2.6.orig/include/asm-i386/spinlock_types.h
+++ linux-2.6/include/asm-i386/spinlock_types.h
@@ -6,10 +6,11 @@
 #endif
 
 typedef struct {
-	unsigned int slock;
+	unsigned short qhead;
+	unsigned short qtail;
 } raw_spinlock_t;
 
-#define __RAW_SPIN_LOCK_UNLOCKED	{ 1 }
+#define __RAW_SPIN_LOCK_UNLOCKED	{ 0, 0 }
 
 typedef struct {
 	unsigned int lock;




--------------040606050208030305010505--

--------------enig04937452A690100248D211F1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGA9qPniDOoMHTA+kRAkHaAJ9sTgfc59o/LKus3MmfSV2XESVNUwCfZxV1
VXD2Vv3S8sWSCjSGbN7scLY=
=qnoj
-----END PGP SIGNATURE-----

--------------enig04937452A690100248D211F1--

