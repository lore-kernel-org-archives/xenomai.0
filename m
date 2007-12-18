Message-ID: <2ff1a98a0712180955n43827699m2f311f6a6bcead22@domain.hid>
Date: Tue, 18 Dec 2007 18:55:13 +0100
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <0B45E93C5FF65740AEAE690BF3848B7A4AB2F0@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <0B45E93C5FF65740AEAE690BF3848B7A4AB2F0@domain.hid>
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
To: Fillod Stephane <stephane.fillod@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>

On Dec 18, 2007 6:40 PM, Fillod Stephane <stephane.fillod@domain.hid> wrote:
> Gilles Chanteperdrix wrote:
> >On Dec 18, 2007 1:47 PM, Jan Kiszka <jan.kiszka@domain.hid> wrote:
> >> Perrine Martignoni wrote:
> >> > Thanks for the explanation.
> >> > But how can I do to allocate the DMA area ? with the Dma-api of
> Linux or
> >> > Xenomai offers the possibility to do this ? and what about memory
> heap with
> >> > H_DMA ?
> >> > I'm a bit confused with all of this.
> >>
> >> Yes, allocation and registration (pci_map*/pci_unmap*) is intended to
> >> run via normal Linux. H_DMA (if you were using heaps here), which
> leads
> >> to GFP_DMA, is only involved for old ISA hardware.
> >
> >GFP_DMA may also make a big difference on some ARMs. See
> >arch/arm/common/dmabounce.c for details.
>
> Not only ARMs. The H_DMA flag appears to work fine with PowerPCs (PQ).
> This is quite
> handy in order to obtain physically contiguous memory, from a user task
> context.

> The question though is whether there's the below 16 MB address mask in
> action,
> which is kind of stupid most of the time on embedded PowerPCs.

The way I understand the GFP_DMA flags, its aim is not to obtain
physically contiguous memory, memory obtained with get_free_pages is
always contiguous anyway. The aim seems rather to allocate in a
machine dependent memory zone that will allow memory to be used for
DMA (for example, allocating it below a 16 MB limit).

> The patch I sent previously about rt_heap_inquire is also useful to get
> the physical address of the buffer (hint hint: care to commit it?),
> which
> is needed by most embedded DMAs.

I have not looked at the patch, but I think that it is indeed a good
idea to have a way to obtain the physical address of a heap.

-- 
                                               Gilles Chanteperdrix

