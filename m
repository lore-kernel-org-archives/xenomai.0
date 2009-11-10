Message-ID: <4AF9AD44.10000@domain.hid>
Date: Tue, 10 Nov 2009 19:13:24 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <6FCCA913376DD7488F4139A4D11B8F48FD1044@domain.hid>	<4AF99CAD.9070105@domain.hid>
	<6FCCA913376DD7488F4139A4D11B8F48FD107D@troe2k1.cs.myharris.net>
In-Reply-To: <6FCCA913376DD7488F4139A4D11B8F48FD107D@troe2k1.cs.myharris.net>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] rtdm_iomap_to_user with phys addr > 4GB
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: "Herrera-Bendezu, Luis" <lherrera@domain.hid>
Cc: xenomai@xenomai.org

Herrera-Bendezu, Luis wrote:
>  
> 
>> -----Original Message-----
>> From: Jan Kiszka [mailto:jan.kiszka@domain.hid] 
>> Sent: Tuesday, November 10, 2009 12:03 PM
>> To: Herrera-Bendezu, Luis
>> Cc: xenomai@xenomai.org
>> Subject: Re: rtdm_iomap_to_user with phys addr > 4GB
>>
>>
>> Herrera-Bendezu, Luis wrote:
>>> Hello,
>>>
>>> I am writing an RTDM driver to replace one that uses UIO. The device
>>> resides in a physical address > 4 GB on a PPC440EPx. The UIO could
>>> not handle this address so I made a proposal to address it, 
>> details at:
>>> http://lists.ozlabs.org/pipermail/linuxppc-dev/2009-April/070097.html
>>>
>>> Function rtdm_iomap_to_user() has same issue with the physical I/O
>>> address
>>>    unsigned long src_addr
>>>
>>> I am new to Xenomai and would like to get some ideas on how to solve
>>> this
>>> issue.
>> I think UIO as well as RTDM suffers from the same problem here: The
>> kernel service used to remap the physical memory (remap_pfn_range)
>> accepts unsigned long, not phys_addr_t. How is this supposed to work?
>>
>> Jan
>>
>> -- 
>> Siemens AG, Corporate Technology, CT SE 2
>> Corporate Competence Center Embedded Linux
>>
> 
> Actually, remap_pfn_range() gets passed the physical address left
> shifted by PAGE_SIZE in both UIO and RTDM (xnarch_remap_io_page_range,
> wrap_remap_io_page_range).

No, the target address is expressed in pages, the source in bytes.

Jan

-- 
Siemens AG, Corporate Technology, CT SE 2
Corporate Competence Center Embedded Linux

