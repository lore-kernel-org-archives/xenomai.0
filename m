Message-ID: <48D9103C.1070304@domain.hid>
Date: Tue, 23 Sep 2008 17:50:20 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <48D8FEE6.3090109@domain.hid> <48D90034.1070602@domain.hid>
	<48D903AA.5090404@domain.hid> <48D90ADC.2020406@domain.hid>
	<48D90C78.7090100@domain.hid> <48D90D2E.9010608@domain.hid>
	<48D90E12.909@domain.hid>
In-Reply-To: <48D90E12.909@domain.hid>
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
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: adeos-main <adeos-main@gna.org>, Philippe Gerum <rpm@xenomai.org>

Jan Kiszka wrote:
> Gilles Chanteperdrix wrote:
>> Jan Kiszka wrote:
>>> Gilles Chanteperdrix wrote:
>>>> Jan Kiszka wrote:
>>>>> Gilles Chanteperdrix wrote:
>>>>>> Jan Kiszka wrote:
>>>>>>>                 BUG_ON(pgd_page_vaddr(*pgd) != pgd_page_vaddr(*pgd_ref));
>>>> Ok. Maybe printing pgd_page_vaddr(*pgd) and pgd_page_vaddr(*pgd_ref)
>>>> would help ?
>>> I don't see yet where you want to go. As I said, the issue is rare. I
>>> rather think we need to approach it theoretically.
>> Well the bug happens when the two virtual addresses are different (so, I
>> do not think my original remark applies). So, I want to see what the two
>> addresses look like, for instance if they are not 0 or ~0.
> 
> OK, will forward the request.

Ok. Something else: x86_32 and vmalloc_sync_all use spinlock_irqsave,
so, maybe __ipipe_pin_range_globally should use irqsave as well ?

-- 
                                                 Gilles.

