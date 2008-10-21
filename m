Message-ID: <48FDFC38.4060807@domain.hid>
Date: Tue, 21 Oct 2008 17:58:48 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <48F1D15F.3010902@domain.hid>
	<200810210045.16020.berlemont.hauw@domain.hid>
In-Reply-To: <200810210045.16020.berlemont.hauw@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] Comedi buffer management.
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Alexis Berlemont <berlemont.hauw@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

Alexis Berlemont wrote:
> Hi Gilles,
> 
> Sorry for answering so late. I was unable to regularly check my private mails 
> the last week; I missed yours.
> 
>> I commited in trunk a fix of Xenomai heap management for the highmem
>> case. What the patch does is essentially replacing __va_to_kva (which
>> does not work correctly with highmem) with vmalloc_to_page, which is
>> available on all linux versions Xenomai supports.
>>
>> However, I found that comedi buffer management also uses __va_to_kva. We
>> can fix SetPageReserved and ClearPageReserved easily to use
>> vmalloc_to_page, however, I do not see what pg_list is used for, so do
>> not really know how to fix it. Here is a proposed patch:
> 
> If I remember well, pg_list may be used by some PCI/PCIe DMA components which 
> can dump acquired data to physically non-contiguous buffers. In such cases, 
> the driver has to provide a list of the pages addresses into which the DMA 
> controller can trigger shots.
> 
> Many thanks for your fix. 

No problem, really, I actually did not fix pg_list. It will not work
with highmem. What do the DMA needs? physical adresses? Then you need to
replace page_address(vmalloc_to_page(vaddr)) with
page_to_phys(vmalloc_to_page(vaddr))

Or you may store the struct page, and let the drivers do what they want
with it.

-- 
                                                 Gilles.

