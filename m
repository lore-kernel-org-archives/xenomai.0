Message-ID: <4D2DAE16.2060805@domain.hid>
Date: Wed, 12 Jan 2011 14:35:18 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <6FCCA913376DD7488F4139A4D11B8F48016311A5@domain.hid>	<4D1FAE66.8080005@domain.hid>	<6FCCA913376DD7488F4139A4D11B8F4801673CAB@troe2k1.cs.myharris.net>	<4D24E3AC.2000904@domain.hid>
	<4D24EB92.3050104@domain.hid>	<4D24F0B7.7010604@domain.hid>	<6FCCA913376DD7488F4139A4D11B8F4801673CD4@domain.hid>
	<4D25C9D6.4030707@domain.hid> <4D2CE77C.7000109@domain.hid>
	<6FCCA913376DD7488F4139A4D11B8F4801674163@domain.hid>
In-Reply-To: <6FCCA913376DD7488F4139A4D11B8F4801674163@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] [Xenomai -help] User space access to DMA memory
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "Herrera-Bendezu, Luis" <lherrera@domain.hid>
Cc: xenomai@xenomai.org

Herrera-Bendezu, Luis wrote:
>> -----Original Message-----
>> From: Gilles Chanteperdrix [mailto:gilles.chanteperdrix@xenomai.org]
>> Sent: Tuesday, January 11, 2011 6:28 PM
>> To: Herrera-Bendezu, Luis
>> Cc: xenomai@xenomai.org
>> Subject: Re: [Xenomai-help] [Xenomai -help] User space access to DMA memory
>>
>> Gilles Chanteperdrix wrote:
>>> Herrera-Bendezu, Luis wrote:
>>>> On 01/05/2011 5:29 PM Gilles Chanteperdrix wrote:
>>>>> Steven A. Falco wrote:
>>>>>> On 01/05/2011 04:33 PM, Gilles Chanteperdrix wrote:
>>>>> Ok. Could you try to do the same operation with the native API? You just
>>>>> have to pass H_SHARED | H_DMA | H_NONCACHED as flags to rt_heap_create
>>>>> to get the same effect as pci_dma_alloc_coherent.
>>>>>
>>>>> Just to see if the error lies in RTDM implementation or in Xenomai
>>>>> generic code.
>>>>>
>>>>>
>>> (...)
>>> What about the other thing I asked you to test?
>>>
>> Ping? Any news about this test?
> 
> rt_heap_create() with flags H_SHARED | H_DMA | H_NONCACHED report -EINVAL.
> Documentation indicates that H_NONCACHE is not compatible with H_DMA.

Right, supporting H_NONCACHED | H_DMA would mean that we would have to
use kmalloc/get_free_pages then establish a non-cached mapping in
kernel-space with vm_map_ram.

Could you try with H_NONCACHED, but without H_DMA? Of course, the
mapping can not be used for DMA, as it will probably not be physically
contiguous, but at least you can try whether accessing in user-space a
non-cached mapping works.

In any case, we see a defect in the RTDM interface here: we can not ask
the mapping to be mapped non-cacheable, which somewhat defeats the
purpose of pci_alloc_consistent. I do not know enough the powerpc
architecture to know whether this could be the cause of your issue (the
same physical area mapped twice, once cached, once non-cached). However,
on the ARM architecture, for instance, it is bad.


-- 
					    Gilles.

