Message-ID: <4CBD7880.1020701@domain.hid>
Date: Tue, 19 Oct 2010 12:52:48 +0200
From: Anders Blomdell <anders.blomdell@domain.hid>
MIME-Version: 1.0
References: <DF9F3A3C150B0646A17FF1487C1B6D5E0380C00C@rennsmail06.eu.thmulti.com>	<DF9F3A3C150B0646A17FF1487C1B6D5E0380C00E@rennsmail06.eu.thmulti.com>	<4CB57DB2.3010709@domain.hid>	<DF9F3A3C150B0646A17FF1487C1B6D5E0380C010@domain.hid>	<4CB5A7DD.9090203@domain.hid>	<DF9F3A3C150B0646A17FF1487C1B6D5E0380C011@domain.hid>	<4CB78450.70204@domain.hid>	<DF9F3A3C150B0646A17FF1487C1B6D5E0380C01F@rennsmail06.eu.thmulti.com>
	<4CBD7182.2050500@domain.hid>
In-Reply-To: <4CBD7182.2050500@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] rt_heap and DMA32 zone
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org, "Daniel Jacques (Alten)" <jacques.daniel@domain.hid>

On 2010-10-19 12.22, Gilles Chanteperdrix wrote:
> Daniel Jacques (Alten) wrote:
>> Hi,
>>
>> I noticed some allocation failure using kmalloc in case of GFP_DMA32 with big size, even if I modified the CONFIG_FORCE_MAX_ZONEORDER to be coherent with my max size (32MB).
>> I don't know the reason of this failure. I am interesting by any idea about this point ...
>> Meanwhile, to avoid this trouble I performed the following additional patch in ksrc/nucleus/heap.c to force using of __get_free_pages instead of kmalloc in case of GFP_DMA32 flag.
>> Jacques
> 
> At this point, the problem seems to be in linux code. So, there should
> be no need to modify xenomai code. Are you sure that kmalloc does not
> fail due to fragmentation?
I have some vague recollection that dmaable allocations larger than 2MB should
be done by pci_alloc_consistent and similar (see Documentation/DMA-mapping.txt
or Documentation/DMA-API-HOWTO.txt in newer kernels)

/Anders

-- 
Anders Blomdell                  Email: anders.blomdell@domain.hid
Department of Automatic Control
Lund University                  Phone:    +46 46 222 4625
P.O. Box 118                     Fax:      +46 46 138118
SE-221 00 Lund, Sweden

