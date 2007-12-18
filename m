Message-ID: <7289437c0712180611i45662e10k1f02c66e584ec99b@domain.hid>
Date: Tue, 18 Dec 2007 15:11:52 +0100
From: "Perrine Martignoni" <perrmart@domain.hid>
In-Reply-To: <4767C175.7060907@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_10000_16482018.1197987112756"
References: <7289437c0712140324s41dd3255u9534c606bc510ec7@domain.hid>
	<476792F5.6030108@domain.hid>
	<7289437c0712180212l6d47beb5r5766386d333456c1@domain.hid>
	<4767C175.7060907@domain.hid>
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
To: xenomai-help <xenomai@xenomai.org>, Jan Kiszka <jan.kiszka@domain.hid>

------=_Part_10000_16482018.1197987112756
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

So, if I understand, I have to use the Dma Api of Linux (linux/dma-mapping.h)
to allocate a dma buffer and then call rtdm_mmap_to_user to map it in user
space.
Isn't it disadvantageous to do it in regular Linux ?


On Dec 18, 2007 1:47 PM, Jan Kiszka <jan.kiszka@domain.hid> wrote:

> Perrine Martignoni wrote:
> > Thanks for the explanation.
> > But how can I do to allocate the DMA area ? with the Dma-api of Linux or
> > Xenomai offers the possibility to do this ? and what about memory heap
> with
> > H_DMA ?
> > I'm a bit confused with all of this.
>
> Yes, allocation and registration (pci_map*/pci_unmap*) is intended to
> run via normal Linux. H_DMA (if you were using heaps here), which leads
> to GFP_DMA, is only involved for old ISA hardware.
>
> Jan
>
> --
> Siemens AG, Corporate Technology, CT SE 2
> Corporate Competence Center Embedded Linux
>

------=_Part_10000_16482018.1197987112756
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

So, if I understand, I have to use the Dma Api of Linux (linux/dma-mapping.h) to allocate a dma buffer and then call rtdm_mmap_to_user to map it in user space.<br>Isn&#39;t it disadvantageous to do it in regular Linux ?<br>
<br><br><div class="gmail_quote">On Dec 18, 2007 1:47 PM, Jan Kiszka &lt;<a href="mailto:jan.kiszka@domain.hid">jan.kiszka@domain.hid</a>&gt; wrote:<br><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
<div class="Ih2E3d">Perrine Martignoni wrote:<br>&gt; Thanks for the explanation.<br>&gt; But how can I do to allocate the DMA area ? with the Dma-api of Linux or<br>&gt; Xenomai offers the possibility to do this ? and what about memory heap with
<br>&gt; H_DMA ?<br>&gt; I&#39;m a bit confused with all of this.<br><br></div>Yes, allocation and registration (pci_map*/pci_unmap*) is intended to<br>run via normal Linux. H_DMA (if you were using heaps here), which leads
<br>to GFP_DMA, is only involved for old ISA hardware.<br><br>Jan<br><font color="#888888"><br>--<br>Siemens AG, Corporate Technology, CT SE 2<br>Corporate Competence Center Embedded Linux<br></font></blockquote></div><br>

------=_Part_10000_16482018.1197987112756--

