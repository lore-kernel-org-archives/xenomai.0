Subject: Re: [PATCH 5.4] x86: ipipe: Harden path between use_temporary_mm and
 unuse_temporary_mm
References: <3511af9f-f393-a226-0e41-a23d8c1577c8@siemens.com>
 <87ft0xfyj4.fsf@xenomai.org>
 <4f5118a4-d362-7f18-fdcf-da22aabb7344@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <f1c8a7a3-6763-447b-d6ca-b60ee08054ea@siemens.com>
Date: Mon, 15 Mar 2021 09:08:24 +0100
MIME-Version: 1.0
In-Reply-To: <4f5118a4-d362-7f18-fdcf-da22aabb7344@siemens.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

On 15.03.21 07:19, Jan Kiszka via Xenomai wrote:
> On 14.03.21 18:14, Philippe Gerum wrote:
>>
>> Jan Kiszka via Xenomai <xenomai@xenomai.org> writes:
>>
>>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>>
>>> This is only called during early init, e.g. for switching alternatives.
>>> Still, switch_mm_irqs_off would complain without this, and we are better
>>> safe than sorry.
>>>
>>
>> The way this is done in Dovetail is fragile too, since the protection we
>> have there still expects the pipeline entry code not to mess up on
>> handling an interrupt, which defeats the purpose of such
>> precaution. Besides, the temp_state should be snapshot under protection
>> too. IOW, IRQs should be hard disabled fully while using the temporary
>> mm.
>>
>> Upstreaming a similar patch for Dovetail.
> 
> Just saw it: It's wrong as it left the hard_irq_save_full at the caller
> site. Would raise a warning when debugging is enabled. Please fix.
> 

IOW, this should be merged into the original patch changing it:

diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index cbaa584a9f23..d6c9fb7bd790 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -908,7 +908,7 @@ static void *__text_poke(void *addr, const void *opcode, size_t len)
 	 */
 	VM_BUG_ON(!ptep);
 
-	local_irq_save_full(flags);
+	local_irq_save(flags);
 
 	pte = mk_pte(pages[0], pgprot);
 	set_pte_at(poking_mm, poking_addr, ptep, pte);
@@ -959,7 +959,7 @@ static void *__text_poke(void *addr, const void *opcode, size_t len)
 	 */
 	BUG_ON(memcmp(addr, opcode, len));
 
-	local_irq_restore_full(flags);
+	local_irq_restore(flags);
 	pte_unmap_unlock(ptep, ptl);
 	return addr;
 }

Without it, you get

[    0.352686] WARNING: CPU: 0 PID: 1 at ../arch/x86/kernel/alternative.c:824 __text_poke+0x265/0x4a0

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

