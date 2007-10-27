Message-ID: <472352F6.4000409@domain.hid>
Date: Sat, 27 Oct 2007 17:02:14 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <0B45E93C5FF65740AEAE690BF3848B7A4AB267@domain.hid>
In-Reply-To: <0B45E93C5FF65740AEAE690BF3848B7A4AB267@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-core] Xenomai v2.4-rc4: freeze with RTAI skin,
 fine with other skins
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
To: Fillod Stephane <stephane.fillod@domain.hid>
Cc: xenomai@xenomai.org

Fillod Stephane wrote:
> Philippe Gerum wrote:
>> Fillod Stephane wrote:
>>> For the legacy RTAI application to load, the attached patch was
>>> necessary.
>>> The patch against ksrc/skins/rtai/shm.c is somewhat defeating the
>>> purpose
>>> of a lower XNCORE_PAGE_SIZE, so a better fix might be expected.
>>>
>> This one should prevent -EINVAL from being returned. Hopefully.
> 
> Nope, it doesn't :-(
> Most probably because still (hdrsize + 2 * pagesize > heapsize).
> 

This rounding was missing too. We need the previous one for kernel local
 heaps, and the one below to meet the stricter PAGE_SIZE constraint for
shareable heaps.

--- ksrc/nucleus/heap.c	(revision 3095)
+++ ksrc/nucleus/heap.c	(working copy)
@@ -1103,7 +1103,7 @@
 	spl_t s;
 	int err;

-	heapsize = PAGE_ALIGN(heapsize);
+	heapsize = xnheap_rounded_size(heapsize, PAGE_SIZE);
 	heapbase = __alloc_and_reserve_heap(heapsize, memflags);

 	if (!heapbase)

-- 
Philippe.

