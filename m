Message-ID: <4D2E2F26.20000@domain.hid>
Date: Wed, 12 Jan 2011 23:45:58 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <6FCCA913376DD7488F4139A4D11B8F48016311A5@domain.hid>		<4D1FAE66.8080005@domain.hid>		<6FCCA913376DD7488F4139A4D11B8F4801673CAB@troe2k1.cs.myharris.net>		<4D24E3AC.2000904@domain.hid>	<4D24EB92.3050104@domain.hid>		<4D24F0B7.7010604@domain.hid>		<6FCCA913376DD7488F4139A4D11B8F4801673CD4@domain.hid>		<4D25C9D6.4030707@domain.hid>	<4D2CE77C.7000109@domain.hid>		<6FCCA913376DD7488F4139A4D11B8F4801674163@domain.hid>		<4D2DAE16.2060805@domain.hid>		<6FCCA913376DD7488F4139A4D11B8F48016741A9@domain.hid>		<4D2DD61E.7000006@domain.hid>		<6FCCA913376DD7488F4139A4D11B8F48016741F6@domain.hid>		<4D2E10E4.7040608@domain.hid>		<6FCCA913376DD7488F4139A4D11B8F4801674280@domain.hid>	<1294870292.1828.258.camel@domain.hid>	<4D2E27C4.7040106@domain.hid>
	<4D2E28B0.8070202@domain.hid>
In-Reply-To: <4D2E28B0.8070202@domain.hid>
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
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

Gilles Chanteperdrix wrote:
>> if ((vaddr >= VMALLOC_START) && (vaddr < VMALLOC_END))
>>
>> returns false, and the memory is handled as if it were kmalloced memory.
> 
> Replacing this test with if (!virt_addr_valid(vaddr)) should do the
> trick. Remains to see whethe this macro existed in older versions.
> 

No, it will not work. vmalloc_to_page will fail for the same reason. So,
we can not use rtdm_mmap_to_user with virtual address returned by
dma_alloc_coherent, unless we start writing a page walk table like
vmalloc_to_page but which does not test that the give address is in the
vmalloc range.

-- 
                                                                Gilles.

