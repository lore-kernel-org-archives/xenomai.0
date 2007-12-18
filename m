Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 18 Dec 2007 18:40:30 +0100
Message-ID: <0B45E93C5FF65740AEAE690BF3848B7A4AB2F0@domain.hid>
From: "Fillod Stephane" <stephane.fillod@domain.hid>
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
To: xenomai-help <xenomai@xenomai.org>

Gilles Chanteperdrix wrote:
>On Dec 18, 2007 1:47 PM, Jan Kiszka <jan.kiszka@domain.hid> wrote:
>> Perrine Martignoni wrote:
>> > Thanks for the explanation.
>> > But how can I do to allocate the DMA area ? with the Dma-api of
Linux or
>> > Xenomai offers the possibility to do this ? and what about memory
heap with
>> > H_DMA ?
>> > I'm a bit confused with all of this.
>>
>> Yes, allocation and registration (pci_map*/pci_unmap*) is intended to
>> run via normal Linux. H_DMA (if you were using heaps here), which
leads
>> to GFP_DMA, is only involved for old ISA hardware.
>
>GFP_DMA may also make a big difference on some ARMs. See
>arch/arm/common/dmabounce.c for details.

Not only ARMs. The H_DMA flag appears to work fine with PowerPCs (PQ).
This is quite=20
handy in order to obtain physically contiguous memory, from a user task
context.=20
The question though is whether there's the below 16 MB address mask in
action,
which is kind of stupid most of the time on embedded PowerPCs.
The patch I sent previously about rt_heap_inquire is also useful to get=20
the physical address of the buffer (hint hint: care to commit it?),
which
is needed by most embedded DMAs.

--=20
Stephane

