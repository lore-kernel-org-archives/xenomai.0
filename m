Message-ID: <47F258AD.3000103@domain.hid>
Date: Tue, 01 Apr 2008 11:45:49 -0400
From: Tomas Kalibera <kalibera@domain.hid>
MIME-Version: 1.0
References: <47ED5DE3.60202@domain.hid>	
	<18413.34914.638951.575098@domain.hid>	
	<47ED9D05.7060707@domain.hid>	
	<18415.63399.305120.344817@domain.hid>	
	<47F062DE.5000709@domain.hid>	
	<18417.18371.183857.809430@domain.hid>	
	<18417.18921.588809.645062@domain.hid>	
	<47F17B32.7070505@domain.hid>	
	<18417.52630.8850.939898@domain.hid>	
	<47F23E9E.7060801@domain.hid>
	<2ff1a98a0804010703v7090d7dbhbbff114a51badd6d@domain.hid>
In-Reply-To: <2ff1a98a0804010703v7090d7dbhbbff114a51badd6d@domain.hid>
Content-Type: multipart/mixed; boundary="------------000406000303090702080505"
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
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai-core <xenomai@xenomai.org>

This is a multi-part message in MIME format.
--------------000406000303090702080505
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


The stack trace starts getting printed even before the kernel boots - 
the first occurrence is below. It then repeats printing so frequently 
that the system is unusable (and I could not run the Xenomai task).

I've attached the highmem_32.c I used.

Tomas

...

[   14.232387] I-pipe 2.0-03: pipeline enabled.
[   14.233719] Console: colour VGA+ 80x25
[   14.233723] console [tty0] enabled
[   14.235351] console [ttyS0] enabled
[   14.477149] Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
[   14.484474] Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
[   14.725139] Memory: 3588720k/4194304k available (2152k kernel code, 78516k reserved, 904k data, 296k init, 2751016k highme
m)
[   14.736370] virtual kernel memory layout:
[   14.736371]     fixmap  : 0xfff52000 - 0xfffff000   ( 692 kB)
[   14.736371]     pkmap   : 0xff800000 - 0xffc00000   (4096 kB)
[   14.736372]     vmalloc : 0xf8800000 - 0xff7fe000   ( 111 MB)
[   14.736373]     lowmem  : 0xc0000000 - 0xf8000000   ( 896 MB)
[   14.736374]       .init : 0xc0404000 - 0xc044e000   ( 296 kB)
[   14.736375]       .data : 0xc031a3a6 - 0xc03fc664   ( 904 kB)
[   14.736375]       .text : 0xc0100000 - 0xc031a3a6   (2152 kB)
[   14.780692] Checking if this processor honours the WP bit even in supervisor mode... Ok.
[   14.848936] Calibrating delay using timer specific routine.. 7583.33 BogoMIPS (lpj=3791666)
[   14.857374] Security Framework initialized
[   14.861493] SELinux:  Disabled at boot.
[   14.865360] Mount-cache hash table entries: 512
[   14.869987] Wrong address passed to kunmap_atomic!
[   14.874796]        c03ffebc 00000000 00000000 00000003 00000000 c0105fbd c0394b4a 00048000 
[   14.883277]        00000003 c011aa9e c039a858 c16f8240 c16f8220 f7c12000 c019e9bd 0000007a 
[   14.891970]        00000044 00000000 c01b7210 f7c11000 00000001 00000001 00000000 c03dbc80 
[   14.900661] Call Trace:
[   14.903348]  [<c0105fbd>] show_stack+0x2d/0x40
[   14.907856]  [<c011aa9e>] kunmap_atomic+0x4e/0xf0
[   14.912617]  [<c019e9bd>] get_page_from_freelist+0x2ed/0x4d0
[   14.918333]  [<c01b7210>] do_ccupdate_local+0x0/0x40
[   14.923358]  [<c019ec47>] __alloc_pages+0x57/0x360
[   14.928208]  [<c01b7e89>] enable_cpucache+0x29/0xb0
[   14.933141]  [<c01d15c5>] alloc_vfsmnt+0x95/0xd0
[   14.937816]  [<c019efec>] get_zeroed_page+0x3c/0x50
[   14.942750]  [<c01bc8f6>] vfs_kern_mount+0x56/0x120
[   14.947682]  [<c01bc9d2>] kern_mount_data+0x12/0x20
[   14.952616]  [<c041842d>] proc_root_init+0x2d/0xb0
[   14.957464]  [<c0404a6d>] start_kernel+0x2fd/0x3a0
[   14.962311]  [<c0404140>] unknown_bootoption+0x0/0x1f0
[   14.967506]  =======================
[   14.971152] monitor/mwait feature present.
[   14.975271] CPU: Trace cache: 12K uops, L1 D cache: 16K
[   14.980553] CPU: L2 cache: 2048K
[   14.983804] CPU: Physical Processor ID: 0
...


Gilles Chanteperdrix wrote:
> Ok. In the mean time, I think I may have found the reason for the
> crash. Try this patch, you should get a printk and a stack trace
> instead of the bug.
>
>   


--------------000406000303090702080505
Content-Type: text/x-csrc;
 name="highmem_32.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="highmem_32.c"

#include <linux/highmem.h>
#include <linux/module.h>

static struct {
	const char *file;
	unsigned line;
} last_km_user0 [NR_CPUS];

void *kmap(struct page *page)
{
	might_sleep();
	if (!PageHighMem(page))
		return page_address(page);
	return kmap_high(page);
}

void kunmap(struct page *page)
{
	if (in_interrupt())
		BUG();
	if (!PageHighMem(page))
		return;
	kunmap_high(page);
}

/*
 * kmap_atomic/kunmap_atomic is significantly faster than kmap/kunmap because
 * no global lock is needed and because the kmap code must perform a global TLB
 * invalidation when the kmap pool wraps.
 *
 * However when holding an atomic kmap is is not legal to sleep, so atomic
 * kmaps are appropriate for short, tight code paths only.
 */
void *_kmap_atomic_prot(struct page *page, enum km_type type,
			pgprot_t prot, const char *file, unsigned line)
{
	enum fixed_addresses idx;
	unsigned long vaddr;

	/* even !CONFIG_PREEMPT needs this, for in_atomic in do_page_fault */
	pagefault_disable();

	if (!PageHighMem(page))
		return page_address(page);

	idx = type + KM_TYPE_NR*smp_processor_id();
	vaddr = __fix_to_virt(FIX_KMAP_BEGIN + idx);
	if (!pte_none(*(kmap_pte-idx))) {
		if (type == KM_USER0)
			printk("KM_USER0 already mapped at %s:%d\n",
			       last_km_user0[smp_processor_id()].file,
			       last_km_user0[smp_processor_id()].line);
		BUG();
	} else if (type == KM_USER0) {
		last_km_user0[smp_processor_id()].file = file;
		last_km_user0[smp_processor_id()].line = line;
	}

	set_pte(kmap_pte-idx, mk_pte(page, prot));
	arch_flush_lazy_mmu_mode();

	return (void *)vaddr;
}

void *_kmap_atomic(struct page *page, enum km_type type,
		   const char *file, unsigned line)
{
	return _kmap_atomic_prot(page, type, kmap_prot, file, line);
}

void kunmap_atomic(void *kvaddr, enum km_type type)
{
	unsigned long vaddr = (unsigned long) kvaddr & PAGE_MASK;
	enum fixed_addresses idx = type + KM_TYPE_NR*smp_processor_id();

	/*
	 * Force other mappings to Oops if they'll try to access this pte
	 * without first remap it.  Keeping stale mappings around is a bad idea
	 * also, in case the page changes cacheability attributes or becomes
	 * a protected page in a hypervisor.
	 */
	if (vaddr == __fix_to_virt(FIX_KMAP_BEGIN+idx))
		kpte_clear_flush(kmap_pte-idx, vaddr);
	else {
#ifdef CONFIG_DEBUG_HIGHMEM
		BUG_ON(vaddr < PAGE_OFFSET);
		BUG_ON(vaddr >= (unsigned long)high_memory);
#endif
		printk("Wrong address passed to kunmap_atomic!\n");
		show_stack(NULL, NULL);
		kpte_clear_flush(kmap_pte-idx, __fix_to_virt(FIX_KMAP_BEGIN+idx));
	}
	if (type == KM_USER0) {
		last_km_user0[smp_processor_id()].file = NULL;
		last_km_user0[smp_processor_id()].line = 0;
	}

	arch_flush_lazy_mmu_mode();
	pagefault_enable();
}

/* This is the same as kmap_atomic() but can map memory that doesn't
 * have a struct page associated with it.
 */
void *_kmap_atomic_pfn(unsigned long pfn, enum km_type type,
		       const char *file, unsigned line)
{
	enum fixed_addresses idx;
	unsigned long vaddr;

	pagefault_disable();

	idx = type + KM_TYPE_NR*smp_processor_id();
	vaddr = __fix_to_virt(FIX_KMAP_BEGIN + idx);
	if (!pte_none(*(kmap_pte-idx))) {
		if (type == KM_USER0)
			printk("KM_USER0 already mapped at %s:%d\n",
			       last_km_user0[smp_processor_id()].file,
			       last_km_user0[smp_processor_id()].line);
		BUG();
	} else if (type == KM_USER0) {
		last_km_user0[smp_processor_id()].file = file;
		last_km_user0[smp_processor_id()].line = line;
	}
	set_pte(kmap_pte-idx, pfn_pte(pfn, kmap_prot));
	arch_flush_lazy_mmu_mode();

	return (void*) vaddr;
}

struct page *kmap_atomic_to_page(void *ptr)
{
	unsigned long idx, vaddr = (unsigned long)ptr;
	pte_t *pte;

	if (vaddr < FIXADDR_START)
		return virt_to_page(ptr);

	idx = virt_to_fix(vaddr);
	pte = kmap_pte - (idx - FIX_KMAP_BEGIN);
	return pte_page(*pte);
}

EXPORT_SYMBOL(kmap);
EXPORT_SYMBOL(kunmap);
EXPORT_SYMBOL(_kmap_atomic);
EXPORT_SYMBOL(kunmap_atomic);
EXPORT_SYMBOL(kmap_atomic_to_page);

--------------000406000303090702080505--

