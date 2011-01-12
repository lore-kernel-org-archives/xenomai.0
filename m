Message-ID: <4D2E0D0A.4050700@domain.hid>
Date: Wed, 12 Jan 2011 21:20:26 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <6FCCA913376DD7488F4139A4D11B8F48016311A5@domain.hid>	<4D1FAE66.8080005@domain.hid>	<6FCCA913376DD7488F4139A4D11B8F4801673CAB@troe2k1.cs.myharris.net>	<4D24E3AC.2000904@domain.hid>
	<4D24EB92.3050104@domain.hid>	<4D24F0B7.7010604@domain.hid>	<6FCCA913376DD7488F4139A4D11B8F4801673CD4@domain.hid>
	<4D25C9D6.4030707@domain.hid> <4D2CE77C.7000109@domain.hid>
	<6FCCA913376DD7488F4139A4D11B8F4801674163@domain.hid>
	<4D2DAE16.2060805@domain.hid>
	<6FCCA913376DD7488F4139A4D11B8F48016741A9@domain.hid>
	<4D2DD61E.7000006@domain.hid>
	<6FCCA913376DD7488F4139A4D11B8F48016741F6@domain.hid>
In-Reply-To: <6FCCA913376DD7488F4139A4D11B8F48016741F6@domain.hid>
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
>> Simply call rtdm_mmap_noncached_to_user instead of rtdm_mmap_to_user.
>>
> 
> Get same kernel panic error as before with this patch. I need to look closer
> at what are the memory allocation functions used by pci_ and dma_.

You need to look closely into rtdm_mmap_to_buffer what physical address
gets passed to the mapping function (should be xnarch_remap_vm_page, as
the virtual address being mapped non cacheable, it probably belongs to
the vmalloc area). In particular, it should be the same as the
dma_addr_t returned by pci_alloc_consistent.

-- 
                                                                Gilles.

