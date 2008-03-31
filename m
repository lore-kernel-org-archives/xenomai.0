MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="5vqUu/mu+K"
Content-Transfer-Encoding: 7bit
Message-ID: <18417.18371.183857.809430@domain.hid>
Date: Mon, 31 Mar 2008 22:21:23 +0200
In-Reply-To: <47F062DE.5000709@domain.hid>
References: <47ED5DE3.60202@domain.hid>
	<18413.32341.751841.753799@domain.hid>
	<18413.34914.638951.575098@domain.hid>
	<47ED9D05.7060707@domain.hid>
	<18415.63399.305120.344817@domain.hid>
	<47F062DE.5000709@domain.hid>
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


--5vqUu/mu+K
Content-Type: text/plain; charset=us-ascii
Content-Description: message body and .signature
Content-Transfer-Encoding: 7bit

Tomas Kalibera wrote:
 > 
 > Crashed on the very same line as before
 > Tomas

Ok. Let us look for unbalanced kmap_atomics then. Try this patch instead.

-- 


					    Gilles.

--5vqUu/mu+K
Content-Type: text/plain
Content-Disposition: inline;
	filename="ipipe-kmap_atomic-bug.2.diff"
Content-Transfer-Encoding: 7bit

diff --git a/arch/x86/mm/highmem_32.c b/arch/x86/mm/highmem_32.c
index 1c3bf95..a78494e 100644
--- a/arch/x86/mm/highmem_32.c
+++ b/arch/x86/mm/highmem_32.c
@@ -1,6 +1,11 @@
 #include <linux/highmem.h>
 #include <linux/module.h>
 
+static struct {
+	const char *file;
+	unsigned line;
+} last_km_user0 [NR_CPUS];
+
 void *kmap(struct page *page)
 {
 	might_sleep();
@@ -26,7 +31,8 @@ void kunmap(struct page *page)
  * However when holding an atomic kmap is is not legal to sleep, so atomic
  * kmaps are appropriate for short, tight code paths only.
  */
-void *kmap_atomic_prot(struct page *page, enum km_type type, pgprot_t prot)
+void *_kmap_atomic_prot(struct page *page, enum km_type type,
+			pgprot_t prot, const char *file, unsigned line)
 {
 	enum fixed_addresses idx;
 	unsigned long vaddr;
@@ -39,7 +45,17 @@ void *kmap_atomic_prot(struct page *page, enum km_type type, pgprot_t prot)
 
 	idx = type + KM_TYPE_NR*smp_processor_id();
 	vaddr = __fix_to_virt(FIX_KMAP_BEGIN + idx);
-	BUG_ON(!pte_none(*(kmap_pte-idx)));
+	if (!pte_none(*(kmap_pte-idx))) {
+		if (type == KM_USER0)
+			printk("KM_USER0 already mapped at %s:%d\n",
+			       last_km_user0[smp_processor_id()].file,
+			       last_km_user0[smp_processor_id()].line);
+		BUG();
+	} else if (type == KM_USER0) {
+		last_km_user0[smp_processor_id()].file = file;
+		last_km_user0[smp_processor_id()].line = line;
+	}
+
 	set_pte(kmap_pte-idx, mk_pte(page, prot));
 	arch_flush_lazy_mmu_mode();
 
@@ -70,6 +86,10 @@ void kunmap_atomic(void *kvaddr, enum km_type type)
 		BUG_ON(vaddr >= (unsigned long)high_memory);
 #endif
 	}
+	if (type == KM_USER0) {
+		last_km_user0[smp_processor_id()].file = NULL;
+		last_km_user0[smp_processor_id()].line = 0;
+	}
 
 	arch_flush_lazy_mmu_mode();
 	pagefault_enable();
@@ -78,7 +98,8 @@ void kunmap_atomic(void *kvaddr, enum km_type type)
 /* This is the same as kmap_atomic() but can map memory that doesn't
  * have a struct page associated with it.
  */
-void *kmap_atomic_pfn(unsigned long pfn, enum km_type type)
+void *_kmap_atomic_pfn(unsigned long pfn, enum km_type type,
+		       const char *file, unsigned line)
 {
 	enum fixed_addresses idx;
 	unsigned long vaddr;
@@ -87,6 +108,16 @@ void *kmap_atomic_pfn(unsigned long pfn, enum km_type type)
 
 	idx = type + KM_TYPE_NR*smp_processor_id();
 	vaddr = __fix_to_virt(FIX_KMAP_BEGIN + idx);
+	if (!pte_none(*(kmap_pte-idx))) {
+		if (type == KM_USER0)
+			printk("KM_USER0 already mapped at %s:%d\n",
+			       last_km_user0[smp_processor_id()].file,
+			       last_km_user0[smp_processor_id()].line);
+		BUG();
+	} else if (type == KM_USER0) {
+		last_km_user0[smp_processor_id()].file = file;
+		last_km_user0[smp_processor_id()].line = line;
+	}
 	set_pte(kmap_pte-idx, pfn_pte(pfn, kmap_prot));
 	arch_flush_lazy_mmu_mode();
 
diff --git a/include/asm-x86/highmem.h b/include/asm-x86/highmem.h
index 13cdcd6..57b89f7 100644
--- a/include/asm-x86/highmem.h
+++ b/include/asm-x86/highmem.h
@@ -68,10 +68,16 @@ extern void FASTCALL(kunmap_high(struct page *page));
 
 void *kmap(struct page *page);
 void kunmap(struct page *page);
-void *kmap_atomic_prot(struct page *page, enum km_type type, pgprot_t prot);
+void *_kmap_atomic_prot(struct page *page, enum km_type type,
+			pgprot_t prot, const char *file, unsigned line);
+#define kmap_atomic_prot(page, type, prot) \
+	_kmap_atomic_prot(page, type, prot, __FILE__, __LINE__)
 void *kmap_atomic(struct page *page, enum km_type type);
 void kunmap_atomic(void *kvaddr, enum km_type type);
-void *kmap_atomic_pfn(unsigned long pfn, enum km_type type);
+void *_kmap_atomic_pfn(unsigned long pfn, enum km_type type,
+		       const char *file, unsigned line);
+#define kmap_atomic_pfn(pfn, type) \
+	_kmap_atomic_pfn(pfn, type, __FILE__, __LINE__)
 struct page *kmap_atomic_to_page(void *ptr);
 
 #ifndef CONFIG_PARAVIRT

--5vqUu/mu+K--

