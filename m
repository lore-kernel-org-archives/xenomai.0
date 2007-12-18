Message-ID: <4767C175.7060907@domain.hid>
Date: Tue, 18 Dec 2007 13:47:49 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <7289437c0712140324s41dd3255u9534c606bc510ec7@domain.hid>	
	<476792F5.6030108@domain.hid>
	<7289437c0712180212l6d47beb5r5766386d333456c1@domain.hid>
In-Reply-To: <7289437c0712180212l6d47beb5r5766386d333456c1@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] RTDM mmap and DMA
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Perrine Martignoni <perrmart@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>

Perrine Martignoni wrote:
> Thanks for the explanation.
> But how can I do to allocate the DMA area ? with the Dma-api of Linux or
> Xenomai offers the possibility to do this ? and what about memory heap with
> H_DMA ?
> I'm a bit confused with all of this.

Yes, allocation and registration (pci_map*/pci_unmap*) is intended to
run via normal Linux. H_DMA (if you were using heaps here), which leads
to GFP_DMA, is only involved for old ISA hardware.

Jan

-- 
Siemens AG, Corporate Technology, CT SE 2
Corporate Competence Center Embedded Linux

