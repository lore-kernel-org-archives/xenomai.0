Message-ID: <48D90E12.909@domain.hid>
Date: Tue, 23 Sep 2008 17:41:06 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <48D8FEE6.3090109@domain.hid> <48D90034.1070602@domain.hid>
	<48D903AA.5090404@domain.hid> <48D90ADC.2020406@domain.hid>
	<48D90C78.7090100@domain.hid> <48D90D2E.9010608@domain.hid>
In-Reply-To: <48D90D2E.9010608@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Subject: Re: [Adeos-main] [BUG] vmalloc_sync_one complains about
	__ipipe_pin_range_globally
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: adeos-main <adeos-main@gna.org>, Philippe Gerum <rpm@xenomai.org>

Gilles Chanteperdrix wrote:
> Jan Kiszka wrote:
>> Gilles Chanteperdrix wrote:
>>> Jan Kiszka wrote:
>>>> Gilles Chanteperdrix wrote:
>>>>> Jan Kiszka wrote:
>>>>>>                 BUG_ON(pgd_page_vaddr(*pgd) != pgd_page_vaddr(*pgd_ref));
>>> Ok. Maybe printing pgd_page_vaddr(*pgd) and pgd_page_vaddr(*pgd_ref)
>>> would help ?
>> I don't see yet where you want to go. As I said, the issue is rare. I
>> rather think we need to approach it theoretically.
> 
> Well the bug happens when the two virtual addresses are different (so, I
> do not think my original remark applies). So, I want to see what the two
> addresses look like, for instance if they are not 0 or ~0.

OK, will forward the request.

Not sure if this gives more context, but here is also the ipipe trace
that came with the oops:

...
 |   #func                  -14 notify_die+0xd (do_invalid_op+0x7a)
 |   #func                  -15 do_invalid_op+0x10 (__ipipe_handle_exception+0x18e)
 |   +func                  -15 __ipipe_handle_exception+0x16 (error_sti+0x1e)
     +func                  -16 vmalloc_sync_one+0x16 (__ipipe_pin_range_globally+0x9a)
     +func                  -16 page_to_pfn+0x9 (__ipipe_pin_range_globally+0x7d)
     +func                  -17 _spin_lock+0x9 (__ipipe_pin_range_globally+0x68)
     +func                  -17 __ipipe_pin_range_globally+0x16 (map_vm_area+0x29f)
     +func                  -17 page_to_pfn+0x9 (map_vm_area+0x226)
     +func                  -18 page_to_pfn+0x9 (map_vm_area+0x226)
     +func                  -18 page_to_pfn+0x9 (map_vm_area+0x226)
     +func                  -18 page_to_pfn+0x9 (map_vm_area+0x226)
     +func                  -19 map_vm_area+0x16 (__vmalloc_area_node+0x173)
     +func                  -19 page_to_pfn+0x9 (__alloc_pages+0x357)
 |   +end     0x80000000    -19 __ipipe_unstall_root+0x5e (__ipipe_restore_root+0x2c)
 |   #begin   0x80000000    -19 __ipipe_unstall_root+0x1b (__ipipe_restore_root+0x2c)
     #func                  -20 __ipipe_unstall_root+0x9 (__ipipe_restore_root+0x2c)
     #func                  -20 __ipipe_restore_root+0x9 (get_page_from_freelist+0x3c8)
     #func                  -20 __inc_zone_state+0x9 (zone_statistics+0x69)
     #func                  -20 __inc_zone_state+0x9 (zone_statistics+0x4a)
     #func                  -20 zone_statistics+0xc (get_page_from_freelist+0x3b3)
     +func                  -20 ipipe_check_context+0xe (get_page_from_freelist+0x26a)
     +func                  -20 ipipe_check_context+0xe (get_page_from_freelist+0x239)
     +func                  -20 zone_watermark_ok+0xa (get_page_from_freelist+0x169)
     +func                  -20 get_page_from_freelist+0x16 (__alloc_pages+0x6f)
     +func                  -21 cond_resched+0x9 (__alloc_pages+0x47)
     +func                  -21 ipipe_check_context+0xe (__alloc_pages+0x42)
     +func                  -21 __alloc_pages+0x16 (alloc_pages_current+0x7d)
     +func                  -21 zonelist_policy+0x9 (alloc_pages_current+0x70)
     +func                  -21 alloc_pages_current+0xc (__vmalloc_area_node+0xc9)
     +func                  -21 page_to_pfn+0x9 (__alloc_pages+0x357)
 |   +end     0x80000000    -21 __ipipe_unstall_root+0x5e (__ipipe_restore_root+0x2c)
 |   #begin   0x80000000    -21 __ipipe_unstall_root+0x1b (__ipipe_restore_root+0x2c)
     #func                  -21 __ipipe_unstall_root+0x9 (__ipipe_restore_root+0x2c)
     #func                  -21 __ipipe_restore_root+0x9 (get_page_from_freelist+0x3c8)
     #func                  -22 __inc_zone_state+0x9 (zone_statistics+0x69)
     #func                  -22 __inc_zone_state+0x9 (zone_statistics+0x4a)
     #func                  -22 zone_statistics+0xc (get_page_from_freelist+0x3b3)
     +func                  -22 ipipe_check_context+0xe (get_page_from_freelist+0x26a)
     +func                  -22 ipipe_check_context+0xe (get_page_from_freelist+0x239)
     +func                  -22 zone_watermark_ok+0xa (get_page_from_freelist+0x169)
     +func                  -22 get_page_from_freelist+0x16 (__alloc_pages+0x6f)
     +func                  -22 cond_resched+0x9 (__alloc_pages+0x47)
     +func                  -22 ipipe_check_context+0xe (__alloc_pages+0x42)
     +func                  -23 __alloc_pages+0x16 (alloc_pages_current+0x7d)
     +func                  -23 zonelist_policy+0x9 (alloc_pages_current+0x70)
     +func                  -23 alloc_pages_current+0xc (__vmalloc_area_node+0xc9)
     +func                  -23 page_to_pfn+0x9 (__alloc_pages+0x357)
 |   +end     0x80000000    -23 __ipipe_unstall_root+0x5e (__ipipe_restore_root+0x2c)
 |   #begin   0x80000000    -23 __ipipe_unstall_root+0x1b (__ipipe_restore_root+0x2c)
     #func                  -23 __ipipe_unstall_root+0x9 (__ipipe_restore_root+0x2c)
     #func                  -23 __ipipe_restore_root+0x9 (get_page_from_freelist+0x3c8)
     #func                  -23 __inc_zone_state+0x9 (zone_statistics+0x69)
     #func                  -24 __inc_zone_state+0x9 (zone_statistics+0x4a)
     #func                  -24 zone_statistics+0xc (get_page_from_freelist+0x3b3)
     +func                  -24 ipipe_check_context+0xe (get_page_from_freelist+0x26a)
     +func                  -24 ipipe_check_context+0xe (get_page_from_freelist+0x239)
     +func                  -24 zone_watermark_ok+0xa (get_page_from_freelist+0x169)
     +func                  -24 get_page_from_freelist+0x16 (__alloc_pages+0x6f)
     +func                  -24 cond_resched+0x9 (__alloc_pages+0x47)
     +func                  -24 ipipe_check_context+0xe (__alloc_pages+0x42)
     +func                  -25 __alloc_pages+0x16 (alloc_pages_current+0x7d)
     +func                  -25 zonelist_policy+0x9 (alloc_pages_current+0x70)
     +func                  -25 alloc_pages_current+0xc (__vmalloc_area_node+0xc9)
     +func                  -25 page_to_pfn+0x9 (__alloc_pages+0x357)
 |   +end     0x80000000    -25 __ipipe_unstall_root+0x5e (__ipipe_restore_root+0x2c)
 |   #begin   0x80000000    -25 __ipipe_unstall_root+0x1b (__ipipe_restore_root+0x2c)
     #func                  -25 __ipipe_unstall_root+0x9 (__ipipe_restore_root+0x2c)
     #func                  -25 __ipipe_restore_root+0x9 (get_page_from_freelist+0x3c8)
     #func                  -26 __inc_zone_state+0x9 (zone_statistics+0x69)
     #func                  -26 __inc_zone_state+0x9 (zone_statistics+0x4a)
     #func                  -26 zone_statistics+0xc (get_page_from_freelist+0x3b3)
     +func                  -27 ipipe_check_context+0xe (get_page_from_freelist+0x26a)
     +func                  -27 ipipe_check_context+0xe (get_page_from_freelist+0x239)
     +func                  -27 zone_watermark_ok+0xa (get_page_from_freelist+0x169)
     +func                  -27 get_page_from_freelist+0x16 (__alloc_pages+0x6f)
     +func                  -27 cond_resched+0x9 (__alloc_pages+0x47)
     +func                  -27 ipipe_check_context+0xe (__alloc_pages+0x42)
     +func                  -27 __alloc_pages+0x16 (alloc_pages_current+0x7d)


-- 
Siemens AG, Corporate Technology, CT SE 2
Corporate Competence Center Embedded Linux

