MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="bPAUd2c2dj"
Content-Transfer-Encoding: 7bit
Message-ID: <18415.63399.305120.344817@domain.hid>
Date: Sun, 30 Mar 2008 22:27:19 +0200
In-Reply-To: <47ED9D05.7060707@domain.hid>
References: <47ED5DE3.60202@domain.hid>
	<18413.32341.751841.753799@domain.hid>
	<18413.34914.638951.575098@domain.hid>
	<47ED9D05.7060707@domain.hid>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
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
To: Tomas Kalibera <kalibera@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>


--bPAUd2c2dj
Content-Type: text/plain; charset=us-ascii
Content-Description: message body and .signature
Content-Transfer-Encoding: 7bit

Tomas Kalibera wrote:
 > Hi Gilles,
 > 
 > thanks for looking at it. Your analysis is correct, I don't indeed have 
 > CONFIG_PREEMPT_RT kernel, but only CONFIG_PREEMPT, sorry for the confusion.
 > 
 > I've put the kernel config, sources, and binary on the web, so that you 
 > can be sure you're really looking on the kernel that is crashing, 
 > http://www.cs.purdue.edu/homes/tkaliber/crash

After looking at the sources, it appears that kmap_atomic disables
preemption and kunmap_atomic reenables it. In short, the bug should
never happen. What could happen is that the preemption count is garbled,
or that a call to kmap_atomic is not paired with a kunmap_atomic.

To check if the problem comes from the preemption count, could you apply
the following patch ?

-- 


					    Gilles.

--bPAUd2c2dj
Content-Type: text/plain
Content-Disposition: inline;
	filename="ipipe-kmap_atomic-bug.diff"
Content-Transfer-Encoding: 7bit

diff --git a/arch/x86/mm/highmem_32.c b/arch/x86/mm/highmem_32.c
index 1c3bf95..4bb9fc6 100644
--- a/arch/x86/mm/highmem_32.c
+++ b/arch/x86/mm/highmem_32.c
@@ -34,6 +34,7 @@ void *kmap_atomic_prot(struct page *page, enum km_type type, pgprot_t prot)
 	/* even !CONFIG_PREEMPT needs this, for in_atomic in do_page_fault */
 	pagefault_disable();
 
+	BUG_ON(type == KM_USER0 && !in_atomic());
 	if (!PageHighMem(page))
 		return page_address(page);
 
@@ -85,6 +86,7 @@ void *kmap_atomic_pfn(unsigned long pfn, enum km_type type)
 
 	pagefault_disable();
 
+	BUG_ON(type == KM_USER0 && !in_atomic());
 	idx = type + KM_TYPE_NR*smp_processor_id();
 	vaddr = __fix_to_virt(FIX_KMAP_BEGIN + idx);
 	set_pte(kmap_pte-idx, pfn_pte(pfn, kmap_prot));

--bPAUd2c2dj--

