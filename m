Message-ID: <47F2A7CC.4050301@domain.hid>
Date: Tue, 01 Apr 2008 17:23:24 -0400
From: Tomas Kalibera <kalibera@domain.hid>
MIME-Version: 1.0
References: <47ED5DE3.60202@domain.hid>	
	<18415.63399.305120.344817@domain.hid>	
	<47F062DE.5000709@domain.hid>	
	<18417.18371.183857.809430@domain.hid>	
	<18417.18921.588809.645062@domain.hid>	
	<47F17B32.7070505@domain.hid>	
	<18417.52630.8850.939898@domain.hid>	
	<47F23E9E.7060801@domain.hid>	
	<2ff1a98a0804010703v7090d7dbhbbff114a51badd6d@domain.hid>	
	<47F258AD.3000103@domain.hid>
	<2ff1a98a0804010858kb009b37y764667cf1fa56c6@domain.hid>
In-Reply-To: <2ff1a98a0804010858kb009b37y764667cf1fa56c6@domain.hid>
Content-Type: multipart/mixed; boundary="------------030201070008080606000209"
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
--------------030201070008080606000209
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by mailhub246.itcs.purdue.edu id m31LNOEt008180

OK, I got rid of old patches and applied only this check (attached).=20
Now, the kernel boots. When I run my Xenomai app, the kernel locks up,=20
without writing anything to console.

I tried to get some info via SysRq keys, though the only working options=20
were reboot and kill. If I did "kill", the kernel started repeating all=20
the time the message below.

T

[  356.939852] Wrong address passed to kunmap_atomic!=E2=94=94=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=98
[  356.944621]        df5b1e74 00000000 00000000 00000007 08102077 c0105f=
bd c0394b3a 0004c000=20
[  356.952854]        00000007 c011a9e1 c039a7ec fffb2000 00000000 c2b94e=
8c c01a99a0 fffb7000=20
[  356.961267]        fffb6000 df57cf44 df99be40 df99b040 f7cbe430 df9a34=
30 43400000 43000000=20
[  356.969681] Call Trace:
[  356.972298]  [<c0105fbd>] show_stack+0x2d/0x40
[  356.976736]  [<c011a9e1>] kunmap_atomic+0x91/0xd0
[  356.981434]  [<c01a99a0>] copy_page_range+0x3f0/0x560
[  356.986481]  [<c012252f>] copy_process+0x8df/0x1250
[  356.991353]  [<c01230dc>] do_fork+0x4c/0x200
[  356.995619]  [<c01022d2>] sys_clone+0x32/0x40
[  356.999970]  [<c01043a1>] sysenter_past_esp+0x6e/0x72



Gilles Chanteperdrix wrote:
> On Tue, Apr 1, 2008 at 5:45 PM, Tomas Kalibera <kalibera@domain.hid>=
 wrote:
>  =20
>>  The stack trace starts getting printed even before the kernel boots -=
 the
>> first occurrence is below. It then repeats printing so frequently that=
 the
>> system is unusable (and I could not run the Xenomai task).
>>
>>  I've attached the highmem_32.c I used.
>>    =20
>
> Ok. You can get rid of old patches. What happens if you make the
> printk, stack trace and fix up, conditional to type =3D=3D KM_PTE0 || t=
ype
> =3D=3D KM_PTE1 ? As in:
>
> if (type =3D=3D KM_PTE0 || type =3D=3D KM_PTE1) {
> 			printk("Wrong address passed to kunmap_atomic!\n");
> 			show_stack(NULL, NULL);
> 			kpte_clear_flush(kmap_pte-idx, __fix_to_virt(FIX_KMAP_BEGIN+idx));
> 		}
>
>  =20


--------------030201070008080606000209
Content-Type: text/x-csrc;
 name="highmem_32.c"
Content-Disposition: inline;
 filename="highmem_32.c"
Content-Transfer-Encoding: 7bit

#include <linux/highmem.h>
#include <linux/module.h>

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
void *kmap_atomic_prot(struct page *page, enum km_type type, pgprot_t prot)
{
	enum fixed_addresses idx;
	unsigned long vaddr;

	/* even !CONFIG_PREEMPT needs this, for in_atomic in do_page_fault */
	pagefault_disable();

	if (!PageHighMem(page))
		return page_address(page);

	idx = type + KM_TYPE_NR*smp_processor_id();
	vaddr = __fix_to_virt(FIX_KMAP_BEGIN + idx);
	BUG_ON(!pte_none(*(kmap_pte-idx)));
	set_pte(kmap_pte-idx, mk_pte(page, prot));
	arch_flush_lazy_mmu_mode();

	return (void *)vaddr;
}

void *kmap_atomic(struct page *page, enum km_type type)
{
	return kmap_atomic_prot(page, type, kmap_prot);
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
		if (type == KM_PTE0 || type == KM_PTE1) {
			printk("Wrong address passed to kunmap_atomic!\n");
			show_stack(NULL, NULL);
			kpte_clear_flush(kmap_pte-idx, __fix_to_virt(FIX_KMAP_BEGIN+idx));
		}
	}

	arch_flush_lazy_mmu_mode();
	pagefault_enable();
}

/* This is the same as kmap_atomic() but can map memory that doesn't
 * have a struct page associated with it.
 */
void *kmap_atomic_pfn(unsigned long pfn, enum km_type type)
{
	enum fixed_addresses idx;
	unsigned long vaddr;

	pagefault_disable();

	idx = type + KM_TYPE_NR*smp_processor_id();
	vaddr = __fix_to_virt(FIX_KMAP_BEGIN + idx);
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
EXPORT_SYMBOL(kmap_atomic);
EXPORT_SYMBOL(kunmap_atomic);
EXPORT_SYMBOL(kmap_atomic_to_page);

--------------030201070008080606000209--

