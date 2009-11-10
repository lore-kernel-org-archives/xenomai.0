Message-ID: <4AF99CAD.9070105@domain.hid>
Date: Tue, 10 Nov 2009 18:02:37 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <6FCCA913376DD7488F4139A4D11B8F48FD1044@domain.hid>
In-Reply-To: <6FCCA913376DD7488F4139A4D11B8F48FD1044@domain.hid>
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
> Hello,
> 
> I am writing an RTDM driver to replace one that uses UIO. The device
> resides in a physical address > 4 GB on a PPC440EPx. The UIO could
> not handle this address so I made a proposal to address it, details at:
> http://lists.ozlabs.org/pipermail/linuxppc-dev/2009-April/070097.html
> 
> Function rtdm_iomap_to_user() has same issue with the physical I/O
> address
>    unsigned long src_addr
> 
> I am new to Xenomai and would like to get some ideas on how to solve
> this
> issue.

I think UIO as well as RTDM suffers from the same problem here: The
kernel service used to remap the physical memory (remap_pfn_range)
accepts unsigned long, not phys_addr_t. How is this supposed to work?

Jan

-- 
Siemens AG, Corporate Technology, CT SE 2
Corporate Competence Center Embedded Linux

