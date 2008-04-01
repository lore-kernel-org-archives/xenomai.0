Message-ID: <47F17B32.7070505@domain.hid>
Date: Mon, 31 Mar 2008 20:00:50 -0400
From: Tomas Kalibera <kalibera@domain.hid>
MIME-Version: 1.0
References: <47ED5DE3.60202@domain.hid>	<18413.32341.751841.753799@domain.hid>	<18413.34914.638951.575098@domain.hid>	<47ED9D05.7060707@domain.hid>	<18415.63399.305120.344817@domain.hid>	<47F062DE.5000709@domain.hid>	<18417.18371.183857.809430@domain.hid>
	<18417.18921.588809.645062@domain.hid>
In-Reply-To: <18417.18921.588809.645062@domain.hid>
Content-Type: multipart/mixed; boundary="------------040203000802060106070706"
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
--------------040203000802060106070706
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


I added a missing underscore and re-tried, and none of the debug 
messages was printed. I added another one to make sure that there is not 
a problem with getting printk messages to the serial console. The 
resulting highmem_32.c and the output is attached.

T


Gilles Chanteperdrix wrote:
> Gilles Chanteperdrix wrote:
>  > Tomas Kalibera wrote:
>  >  > 
>  >  > Crashed on the very same line as before
>  >  > Tomas
>  > 
>  > Ok. Let us look for unbalanced kmap_atomics then. Try this patch instead.
>
> Just when I hit the reply button, I realize that I forgot something. So,
> try this one instead.
>
>   


--------------040203000802060106070706
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
		if (type == KM_USER0) {
			printk("KM_USER0 already mapped at %s:%d\n",
			       last_km_user0[smp_processor_id()].file,
			       last_km_user0[smp_processor_id()].line);
		} else {
			printk("type is NOT KM_USER0\n");
		}
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

--------------040203000802060106070706
Content-Type: text/plain;
 name="all"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="all"

[  255.285392] ------------[ cut here ]------------
[  255.289992] kernel BUG at arch/x86/mm/highmem_32.c:56!
[  255.295107] invalid opcode: 0000 [#1] PREEMPT SMP 
[  255.299901] Modules linked in: rfcomm l2cap bluetooth ppdev sbp2 ipv6 parport_pc lp parport pcspkr iTCO_wdt iTCO_vendor_se
[  255.327057] 
[  255.328538] Pid: 4986, comm: ovmtask Not tainted (2.6.24.3xenomaip3 #2)
[  255.335123] EIP: 0060:[<c011a966>] EFLAGS: 00010286 CPU: 0
[  255.340588] EIP is at _kmap_atomic_prot+0xa6/0x120
[  255.345356] EAX: 00000027 EBX: c2b27520 ECX: 00000000 EDX: 02bcf000
[  255.351594] ESI: fffff000 EDI: 00000007 EBP: 00000007 ESP: decade70
[  255.357832]  DS: 007b ES: 007b FS: 00d8 GS: 0033 SS: 0068
[  255.363205] Process ovmtask (pid: 4986, ti=decac000 task=df820d90 task.ti=decac000)<0>
[  255.370653] I-pipe domain Linux
[  255.374044] Stack: c039a438 00000010 00000000 0000022b c03a1f9e 00000163 0000022b 00000000 
[  255.382435]        c2b2752c 08003875 c011a9fa c03a1f9e 0000022b fffb2000 c01a9976 0000022b 
[  255.390827]        fffb7000 fffb6000 df472ba8 dee09ac0 dee09740 df3b4084 df3b1084 08615000 
[  255.399221] Call Trace:
[  255.401835]  [<c011a9fa>] _kmap_atomic+0x1a/0x20
[  255.406440]  [<c01a9976>] copy_page_range+0x146/0x590
[  255.411484]  [<c01225ff>] copy_process+0x8df/0x1250
[  255.416353]  [<c01231ac>] do_fork+0x4c/0x200
[  255.420613]  [<c01022d2>] sys_clone+0x32/0x40
[  255.424960]  [<c01043a1>] sysenter_past_esp+0x6e/0x72
[  255.429998]  =======================
[  255.433554] Code: 04 82 8b 35 f8 4a 3d c0 8d 2c 38 8d 04 ad 00 00 00 00 29 c1 8b 01 85 c0 74 1b 83 ff 03 74 3f c7 04 24 3 
[  255.452899] EIP: [<c011a966>] _kmap_atomic_prot+0xa6/0x120 SS:ESP 0068:decade70
[  255.460280] ---[ end trace 6f16dfbea90303ec ]---
[  255.464881] note: ovmtask[4986] exited with preempt_count 1
[  255.470435] BUG: scheduling while atomic: ovmtask/4986/0x00000002
[  255.476505] Pid: 4986, comm: ovmtask Tainted: G      D 2.6.24.3xenomaip3 #2
[  255.483440]  [<c0313fed>] schedule+0x53d/0x770
[  255.487882]  [<c0140e04>] clockevents_program_event+0xa4/0x120
[  255.493710]  [<c0315229>] rwsem_down_failed_common+0x69/0x190
[  255.499448]  [<c031539a>] rwsem_down_read_failed+0x1a/0x24
[  255.504926]  [<c0315407>] call_rwsem_down_read_failed+0x7/0xc
[  255.510663]  [<c0314a5a>] down_read+0xa/0x10
[  255.514929]  [<c0143a69>] futex_wake+0x19/0xd0
[  255.519369]  [<c011459e>] smp_apic_timer_interrupt+0x4e/0x80
[  255.525020]  [<c027b0bc>] serial_in+0x2c/0xa0
[  255.529374]  [<c0144d98>] do_futex+0x5d8/0xb30
[  255.533816]  [<c015667c>] __xirq_end+0x0/0x50
[  255.538172]  [<c01569da>] __ipipe_unstall_root+0x4a/0x50
[  255.543475]  [<c012493a>] vprintk+0x2ca/0x3b0
[  255.547830]  [<c0145388>] sys_futex+0x98/0x110
[  255.552270]  [<c0121bc7>] mm_release+0x87/0xa0
[  255.556709]  [<c0126073>] exit_mm+0x13/0xf0
[  255.560889]  [<c0127b3f>] do_exit+0x4ef/0x820
[  255.565243]  [<c0105b67>] die+0x267/0x270
[  255.569252]  [<c0105e81>] do_invalid_op+0x81/0x90
[  255.573952]  [<c011a966>] _kmap_atomic_prot+0xa6/0x120
[  255.579084]  [<c01388db>] autoremove_wake_function+0x1b/0x50
[  255.584749]  [<c011b19b>] __wake_up_common+0x4b/0x80
[  255.589708]  [<c011c3be>] __wake_up+0x3e/0x60
[  255.594062]  [<c0315cc2>] _spin_unlock_irqrestore+0x12/0x40
[  255.599625]  [<c01242bb>] wake_up_klogd+0x3b/0x40
[  255.604323]  [<c012493a>] vprintk+0x2ca/0x3b0
[  255.608676]  [<c011705d>] __ipipe_handle_exception+0xbd/0x220
[  255.614417]  [<c0315ecb>] error_code+0x77/0x84
[  255.618860]  [<c011a966>] _kmap_atomic_prot+0xa6/0x120
[  255.623993]  [<c011a9fa>] _kmap_atomic+0x1a/0x20
[  255.628606]  [<c01a9976>] copy_page_range+0x146/0x590
[  255.633657]  [<c01225ff>] copy_process+0x8df/0x1250
[  255.638532]  [<c01231ac>] do_fork+0x4c/0x200
[  255.642801]  [<c01022d2>] sys_clone+0x32/0x40
[  255.647154]  [<c01043a1>] sysenter_past_esp+0x6e/0x72
[  255.652200]  =======================
[  255.656668] type is NOT KM_USER0
[  255.659886] ------------[ cut here ]------------
[  255.664482] kernel BUG at arch/x86/mm/highmem_32.c:56!
[  255.669596] invalid opcode: 0000 [#2] PREEMPT SMP 
[  255.674389] Modules linked in: rfcomm l2cap bluetooth ppdev sbp2 ipv6 parport_pc lp parport pcspkr iTCO_wdt iTCO_vendor_se
[  255.701549] 
[  255.703029] Pid: 4306, comm: syslogd Tainted: G      D (2.6.24.3xenomaip3 #2)
[  255.710132] EIP: 0060:[<c011a966>] EFLAGS: 00010296 CPU: 0
[  255.715593] EIP is at _kmap_atomic_prot+0xa6/0x120
[  255.720360] EAX: 00000027 EBX: c2b28240 ECX: 02bcf000 EDX: 00000000
[  255.726597] ESI: fffff000 EDI: 00000007 EBP: 00000007 ESP: dedf5ebc
[  255.732835]  DS: 007b ES: 007b FS: 00d8 GS: 0033 SS: 0068
[  255.738208] Process syslogd (pid: 4306, ti=dedf4000 task=decc0c10 task.ti=dedf4000)<0>
[  255.745656] I-pipe domain Linux
[  255.749046] Stack: c039a438 decc0c10 c01388c0 00000a21 c03a1f9e 00000163 00000a21 df806128 
[  255.757438]        c044a720 f7fd73c0 c011a9fa c03a1f9e 00000a21 00000000 c01a8d71 00000a21 
[  255.765829]        00000000 00000002 f7a5c7dc 00000000 b7f48390 df806128 f7fd73c0 df8a8b7c 
[  255.774221] Call Trace:
[  255.776835]  [<c01388c0>] autoremove_wake_function+0x0/0x50
[  255.782391]  [<c011a9fa>] _kmap_atomic+0x1a/0x20
[  255.786995]  [<c01a8d71>] handle_mm_fault+0x91/0x690
[  255.791946]  [<c01bac7a>] do_readv_writev+0x13a/0x1b0
[  255.796983]  [<c0317b36>] do_page_fault+0x336/0x750
[  255.801849]  [<c011705d>] __ipipe_handle_exception+0xbd/0x220
[  255.807578]  [<c01bad2c>] vfs_writev+0x3c/0x50
[  255.812010]  [<c0315ecb>] error_code+0x77/0x84
[  255.816443]  =======================
[  255.819999] Code: 04 82 8b 35 f8 4a 3d c0 8d 2c 38 8d 04 ad 00 00 00 00 29 c1 8b 01 85 c0 74 1b 83 ff 03 74 3f c7 04 24 3 
[  255.839315] EIP: [<c011a966>] _kmap_atomic_prot+0xa6/0x120 SS:ESP 0068:dedf5ebc
[  255.846634] ---[ end trace 6f16dfbea90303ec ]---
[  255.851233] note: syslogd[4306] exited with preempt_count 1
[  255.856790] type is NOT KM_USER0
[  255.860006] ------------[ cut here ]------------
[  255.864602] kernel BUG at arch/x86/mm/highmem_32.c:56!
[  255.869717] invalid opcode: 0000 [#3] PREEMPT SMP 
[  255.874510] Modules linked in: rfcomm l2cap bluetooth ppdev sbp2 ipv6 parport_pc lp parport pcspkr iTCO_wdt iTCO_vendor_se
[  255.901662] 
[  255.903143] Pid: 4306, comm: syslogd Tainted: G      D (2.6.24.3xenomaip3 #2)
[  255.910245] EIP: 0060:[<c011a966>] EFLAGS: 00010282 CPU: 0
[  255.915706] EIP is at _kmap_atomic_prot+0xa6/0x120
[  255.920472] EAX: 00000027 EBX: c2b281a0 ECX: 02bcf000 EDX: 00000000
[  255.926709] ESI: fffff000 EDI: 00000007 EBP: 00000007 ESP: dedf5c80
[  255.932947]  DS: 007b ES: 007b FS: 00d8 GS: 0000 SS: 0068
[  255.938319] Process syslogd (pid: 4306, ti=dedf4000 task=decc0c10 task.ti=dedf4000)<0>
[  255.945768] I-pipe domain Linux
[  255.949158] Stack: c039a438 c044a5e0 c0449280 000002bc c03a1f9e 00000163 000002bc df9c1128 
[  255.957547]        08048000 00000000 c011a9fa c03a1f9e 000002bc 00000000 c01a7611 000002bc 
[  255.965935]        0804efff 00000000 df9c1128 dedf5d28 00000000 00000001 0804f000 df8a8080 
[  255.974323] Call Trace:
[  255.976937]  [<c011a9fa>] _kmap_atomic+0x1a/0x20
[  255.981542]  [<c01a7611>] unmap_vmas+0x181/0x5a0
[  255.986148]  [<c01aae6d>] exit_mmap+0x7d/0x120
[  255.990580]  [<c0121c40>] mmput+0x30/0xe0
[  255.994578]  [<c012779c>] do_exit+0x14c/0x820
[  255.998924]  [<c0105b67>] die+0x267/0x270
[  256.002924]  [<c0105e81>] do_invalid_op+0x81/0x90
[  256.007615]  [<c011a966>] _kmap_atomic_prot+0xa6/0x120
[  256.012738]  [<c015667c>] __xirq_end+0x0/0x50
[  256.017083]  [<c01569da>] __ipipe_unstall_root+0x4a/0x50
[  256.022377]  [<c012493a>] vprintk+0x2ca/0x3b0
[  256.026721]  [<c011705d>] __ipipe_handle_exception+0xbd/0x220
[  256.032451]  [<c0315ecb>] error_code+0x77/0x84
[  256.036882]  [<c011a966>] _kmap_atomic_prot+0xa6/0x120
[  256.042005]  [<c01388c0>] autoremove_wake_function+0x0/0x50
[  256.047562]  [<c011a9fa>] _kmap_atomic+0x1a/0x20
[  256.052165]  [<c01a8d71>] handle_mm_fault+0x91/0x690
[  256.057115]  [<c01bac7a>] do_readv_writev+0x13a/0x1b0
[  256.062153]  [<c0317b36>] do_page_fault+0x336/0x750
[  256.067016]  [<c011705d>] __ipipe_handle_exception+0xbd/0x220
[  256.072744]  [<c01bad2c>] vfs_writev+0x3c/0x50
[  256.077175]  [<c0315ecb>] error_code+0x77/0x84
[  256.081607]  =======================
[  256.085164] Code: 04 82 8b 35 f8 4a 3d c0 8d 2c 38 8d 04 ad 00 00 00 00 29 c1 8b 01 85 c0 74 1b 83 ff 03 74 3f c7 04 24 3 
[  256.104476] EIP: [<c011a966>] _kmap_atomic_prot+0xa6/0x120 SS:ESP 0068:dedf5c80
[  256.111791] ---[ end trace 6f16dfbea90303ec ]---
[  256.116389] Fixing recursive fault but reboot is needed!
[  256.121683] BUG: scheduling while atomic: syslogd/4306/0x00000004
[  256.127753] Pid: 4306, comm: syslogd Tainted: G      D 2.6.24.3xenomaip3 #2
[  256.134688]  [<c0313fed>] schedule+0x53d/0x770
[  256.139130]  [<c0235908>] cfq_free_io_context+0xb8/0xc0
[  256.144351]  [<c0127e39>] do_exit+0x7e9/0x820
[  256.148705]  [<c0124a8b>] printk+0x6b/0xf0
[  256.152800]  [<c0105b67>] die+0x267/0x270
[  256.156807]  [<c0105e81>] do_invalid_op+0x81/0x90
[  256.161506]  [<c011a966>] _kmap_atomic_prot+0xa6/0x120
[  256.166642]  [<c015667c>] __xirq_end+0x0/0x50
[  256.170997]  [<c01569da>] __ipipe_unstall_root+0x4a/0x50
[  256.176301]  [<c012493a>] vprintk+0x2ca/0x3b0
[  256.180654]  [<c011705d>] __ipipe_handle_exception+0xbd/0x220
[  256.186394]  [<c0315ecb>] error_code+0x77/0x84
[  256.190836]  [<c01100d8>] generic_set_all+0x198/0x2e0
[  256.195882]  [<c011a966>] _kmap_atomic_prot+0xa6/0x120
[  256.201016]  [<c011a9fa>] _kmap_atomic+0x1a/0x20
[  256.205628]  [<c01a7611>] unmap_vmas+0x181/0x5a0
[  256.210243]  [<c01aae6d>] exit_mmap+0x7d/0x120
[  256.214684]  [<c0121c40>] mmput+0x30/0xe0
[  256.218691]  [<c012779c>] do_exit+0x14c/0x820
[  256.223046]  [<c0105b67>] die+0x267/0x270
[  256.227053]  [<c0105e81>] do_invalid_op+0x81/0x90
[  256.231754]  [<c011a966>] _kmap_atomic_prot+0xa6/0x120
[  256.236887]  [<c015667c>] __xirq_end+0x0/0x50
[  256.241242]  [<c01569da>] __ipipe_unstall_root+0x4a/0x50
[  256.246548]  [<c012493a>] vprintk+0x2ca/0x3b0
[  256.250902]  [<c011705d>] __ipipe_handle_exception+0xbd/0x220
[  256.256640]  [<c0315ecb>] error_code+0x77/0x84
[  256.261080]  [<c011a966>] _kmap_atomic_prot+0xa6/0x120
[  256.266212]  [<c01388c0>] autoremove_wake_function+0x0/0x50
[  256.271778]  [<c011a9fa>] _kmap_atomic+0x1a/0x20
[  256.276391]  [<c01a8d71>] handle_mm_fault+0x91/0x690
[  256.281351]  [<c01bac7a>] do_readv_writev+0x13a/0x1b0
[  256.286397]  [<c0317b36>] do_page_fault+0x336/0x750
[  256.291273]  [<c011705d>] __ipipe_handle_exception+0xbd/0x220
[  256.297011]  [<c01bad2c>] vfs_writev+0x3c/0x50
[  256.301450]  [<c0315ecb>] error_code+0x77/0x84
[  256.305892]  =======================
[  308.807005] type is NOT KM_USER0
[  308.810230] ------------[ cut here ]------------
[  308.814826] kernel BUG at arch/x86/mm/highmem_32.c:56!
[  308.819938] invalid opcode: 0000 [#4] PREEMPT SMP 
[  308.824733] Modules linked in: rfcomm l2cap bluetooth ppdev sbp2 ipv6 parport_pc lp parport pcspkr iTCO_wdt iTCO_vendor_se
[  308.851890] 
[  308.853371] Pid: 4944, comm: gdmgreeter Tainted: G      D (2.6.24.3xenomaip3 #2)
[  308.860734] EIP: 0060:[<c011a966>] EFLAGS: 00210296 CPU: 0
[  308.866196] EIP is at _kmap_atomic_prot+0xa6/0x120
[  308.870963] EAX: 00000027 EBX: c2b21ca0 ECX: 02bcf000 EDX: 00000000
[  308.877200] ESI: fffff000 EDI: 00000007 EBP: 00000007 ESP: df69debc
[  308.883439]  DS: 007b ES: 007b FS: 00d8 GS: 0033 SS: 0068
[  308.888813] Process gdmgreeter (pid: 4944, ti=df69c000 task=decc06a0 task.ti=df69c000)<0>
[  308.896521] I-pipe domain Linux
[  308.899913] Stack: c039a438 f7c1d000 c01c4888 00000a21 c03a1f9e 00000163 00000a21 dfb9f56c 
[  308.908304]        c044a720 df9b6200 c011a9fa c03a1f9e 00000a21 00000001 c01a8d71 00000a21 
[  308.916694]        0100809b 000081a4 00000001 00000000 08354e98 dfb9f56c df9b6200 df9f7080 
[  308.925085] Call Trace:
[  308.927697]  [<c01c4888>] do_path_lookup+0x78/0x1c0
[  308.932562]  [<c011a9fa>] _kmap_atomic+0x1a/0x20
[  308.937167]  [<c01a8d71>] handle_mm_fault+0x91/0x690
[  308.942118]  [<c0317b36>] do_page_fault+0x336/0x750
[  308.946984]  [<c011705d>] __ipipe_handle_exception+0xbd/0x220
[  308.952714]  [<c0315ecb>] error_code+0x77/0x84
[  308.957147]  =======================
[  308.960703] Code: 04 82 8b 35 f8 4a 3d c0 8d 2c 38 8d 04 ad 00 00 00 00 29 c1 8b 01 85 c0 74 1b 83 ff 03 74 3f c7 04 24 3 
[  308.980015] EIP: [<c011a966>] _kmap_atomic_prot+0xa6/0x120 SS:ESP 0068:df69debc
[  308.987334] ---[ end trace 6f16dfbea90303ec ]---
[  308.991933] note: gdmgreeter[4944] exited with preempt_count 1
[  308.997758] type is NOT KM_USER0
[  309.000975] ------------[ cut here ]------------
[  309.005570] kernel BUG at arch/x86/mm/highmem_32.c:56!
[  309.010683] invalid opcode: 0000 [#5] PREEMPT SMP 
[  309.015476] Modules linked in: rfcomm l2cap bluetooth ppdev sbp2 ipv6 parport_pc lp parport pcspkr iTCO_wdt iTCO_vendor_se
[  309.042627] 
[  309.044107] Pid: 4944, comm: gdmgreeter Tainted: G      D (2.6.24.3xenomaip3 #2)
[  309.051469] EIP: 0060:[<c011a966>] EFLAGS: 00210282 CPU: 0
[  309.056929] EIP is at _kmap_atomic_prot+0xa6/0x120
[  309.061696] EAX: 00000027 EBX: c2b21ca0 ECX: 02bcf000 EDX: 00000000
[  309.067933] ESI: fffff000 EDI: 00000007 EBP: 00000007 ESP: df69dc80
[  309.074171]  DS: 007b ES: 007b FS: 00d8 GS: 0000 SS: 0068
[  309.079544] Process gdmgreeter (pid: 4944, ti=df69c000 task=decc06a0 task.ti=df69c000)<0>
[  309.087252] I-pipe domain Linux
[  309.090644] Stack: c039a438 c044a5e0 c0449280 000002bc c03a1f9e 00000163 000002bc dfb9f668 
[  309.099031]        08048000 00000000 c011a9fa c03a1f9e 000002bc 00000000 c01a7611 000002bc 
[  309.107418]        08075fff 00000000 dfb9f668 df69dd28 00000000 00000001 08076000 df9f7080 
[  309.115807] Call Trace:
[  309.118421]  [<c011a9fa>] _kmap_atomic+0x1a/0x20
[  309.123026]  [<c01a7611>] unmap_vmas+0x181/0x5a0
[  309.127631]  [<c01aae6d>] exit_mmap+0x7d/0x120
[  309.132062]  [<c0121c40>] mmput+0x30/0xe0
[  309.136061]  [<c012779c>] do_exit+0x14c/0x820
[  309.140406]  [<c0105b67>] die+0x267/0x270
[  309.144405]  [<c0105e81>] do_invalid_op+0x81/0x90
[  309.149095]  [<c011a966>] _kmap_atomic_prot+0xa6/0x120
[  309.154217]  [<c013007b>] kill_pgrp+0xb/0x20
[  309.158474]  [<c015667c>] __xirq_end+0x0/0x50
[  309.162817]  [<c0110060>] generic_set_all+0x120/0x2e0
[  309.167856]  [<c01569da>] __ipipe_unstall_root+0x4a/0x50
[  309.173150]  [<c012493a>] vprintk+0x2ca/0x3b0
[  309.177496]  [<c011705d>] __ipipe_handle_exception+0xbd/0x220
[  309.183227]  [<c0315ecb>] error_code+0x77/0x84
[  309.187659]  [<c011a966>] _kmap_atomic_prot+0xa6/0x120
[  309.192782]  [<c01c4888>] do_path_lookup+0x78/0x1c0
[  309.197646]  [<c011a9fa>] _kmap_atomic+0x1a/0x20
[  309.202250]  [<c01a8d71>] handle_mm_fault+0x91/0x690
[  309.207201]  [<c0317b36>] do_page_fault+0x336/0x750
[  309.212067]  [<c011705d>] __ipipe_handle_exception+0xbd/0x220
[  309.217798]  [<c0315ecb>] error_code+0x77/0x84
[  309.222230]  =======================
[  309.225786] Code: 04 82 8b 35 f8 4a 3d c0 8d 2c 38 8d 04 ad 00 00 00 00 29 c1 8b 01 85 c0 74 1b 83 ff 03 74 3f c7 04 24 3 
[  309.245098] EIP: [<c011a966>] _kmap_atomic_prot+0xa6/0x120 SS:ESP 0068:df69dc80
[  309.252414] ---[ end trace 6f16dfbea90303ec ]---
[  309.257013] Fixing recursive fault but reboot is needed!
[  309.262306] BUG: scheduling while atomic: gdmgreeter/4944/0x00000004
[  309.268635] Pid: 4944, comm: gdmgreeter Tainted: G      D 2.6.24.3xenomaip3 #2
[  309.275830]  [<c0313fed>] schedule+0x53d/0x770
[  309.280272]  [<c0235908>] cfq_free_io_context+0xb8/0xc0
[  309.285492]  [<c0127e39>] do_exit+0x7e9/0x820
[  309.289847]  [<c0124a8b>] printk+0x6b/0xf0
[  309.293943]  [<c0105b67>] die+0x267/0x270
[  309.297951]  [<c0105e81>] do_invalid_op+0x81/0x90
[  309.302651]  [<c011a966>] _kmap_atomic_prot+0xa6/0x120
[  309.307784]  [<c015667c>] __xirq_end+0x0/0x50
[  309.312138]  [<c01569da>] __ipipe_unstall_root+0x4a/0x50
[  309.317457]  [<c012493a>] vprintk+0x2ca/0x3b0
[  309.321812]  [<c011705d>] __ipipe_handle_exception+0xbd/0x220
[  309.327550]  [<c0315ecb>] error_code+0x77/0x84
[  309.331992]  [<c01100d8>] generic_set_all+0x198/0x2e0
[  309.337037]  [<c011a966>] _kmap_atomic_prot+0xa6/0x120
[  309.342171]  [<c011a9fa>] _kmap_atomic+0x1a/0x20
[  309.346784]  [<c01a7611>] unmap_vmas+0x181/0x5a0
[  309.351399]  [<c01aae6d>] exit_mmap+0x7d/0x120
[  309.355841]  [<c0121c40>] mmput+0x30/0xe0
[  309.359849]  [<c012779c>] do_exit+0x14c/0x820
[  309.364204]  [<c0105b67>] die+0x267/0x270
[  309.368211]  [<c0105e81>] do_invalid_op+0x81/0x90
[  309.372911]  [<c011a966>] _kmap_atomic_prot+0xa6/0x120
[  309.378044]  [<c013007b>] kill_pgrp+0xb/0x20
[  309.382311]  [<c015667c>] __xirq_end+0x0/0x50
[  309.386664]  [<c0110060>] generic_set_all+0x120/0x2e0
[  309.391712]  [<c01569da>] __ipipe_unstall_root+0x4a/0x50
[  309.397016]  [<c012493a>] vprintk+0x2ca/0x3b0
[  309.401371]  [<c011705d>] __ipipe_handle_exception+0xbd/0x220
[  309.407109]  [<c0315ecb>] error_code+0x77/0x84
[  309.411550]  [<c011a966>] _kmap_atomic_prot+0xa6/0x120
[  309.416682]  [<c01c4888>] do_path_lookup+0x78/0x1c0
[  309.421556]  [<c011a9fa>] _kmap_atomic+0x1a/0x20
[  309.426170]  [<c01a8d71>] handle_mm_fault+0x91/0x690
[  309.431130]  [<c0317b36>] do_page_fault+0x336/0x750
[  309.436003]  [<c011705d>] __ipipe_handle_exception+0xbd/0x220
[  309.441742]  [<c0315ecb>] error_code+0x77/0x84
[  309.446226]  =======================

--------------040203000802060106070706--

