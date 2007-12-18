Message-ID: <7289437c0712180641l76eefc20x92ccd393c8aa8e50@domain.hid>
Date: Tue, 18 Dec 2007 15:41:04 +0100
From: "Perrine Martignoni" <perrmart@domain.hid>
In-Reply-To: <4767D7A4.7070008@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_10068_23667942.1197988864651"
References: <7289437c0712140324s41dd3255u9534c606bc510ec7@domain.hid>
	<476792F5.6030108@domain.hid>
	<7289437c0712180212l6d47beb5r5766386d333456c1@domain.hid>
	<4767C175.7060907@domain.hid>
	<7289437c0712180611i45662e10k1f02c66e584ec99b@domain.hid>
	<4767D7A4.7070008@domain.hid>
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

------=_Part_10068_23667942.1197988864651
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Ok thanks.

On Dec 18, 2007 3:22 PM, Jan Kiszka <jan.kiszka@domain.hid> wrote:

> Perrine Martignoni wrote:
> > So, if I understand, I have to use the Dma Api of Linux (linux/dma-
> mapping.h)
> > to allocate a dma buffer and then call rtdm_mmap_to_user to map it in
> user
> > space.
> > Isn't it disadvantageous to do it in regular Linux ?
>
> Of course, memory allocation and releasing must never happen over RT
> context, but rather during (non-RT) open/close etc.
>
> Mapping/unmapping is a trivial and safe operation on many archs, but not
> on all (beware of some IOMMU being involved, then mapping becomes
> indeterministic). If unsure, check for your target if it is running
> through complex and potentially memory-allocating code paths, e.g. via
> lxr.linux.no. If there are problems (not expected on today's mid- to
> low-end HW), you have to manage also the mappings during init and keep
> them during runtime. Standard pattern for RT development.
>
> Jan
>
> --
> Siemens AG, Corporate Technology, CT SE 2
> Corporate Competence Center Embedded Linux
>

------=_Part_10068_23667942.1197988864651
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Ok thanks.<br><br><div class="gmail_quote">On Dec 18, 2007 3:22 PM, Jan Kiszka &lt;<a href="mailto:jan.kiszka@domain.hid">jan.kiszka@domain.hid</a>&gt; wrote:<br><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
<div class="Ih2E3d">Perrine Martignoni wrote:<br>&gt; So, if I understand, I have to use the Dma Api of Linux (linux/dma-mapping.h)<br>&gt; to allocate a dma buffer and then call rtdm_mmap_to_user to map it in user<br>&gt; space.
<br>&gt; Isn&#39;t it disadvantageous to do it in regular Linux ?<br><br></div>Of course, memory allocation and releasing must never happen over RT<br>context, but rather during (non-RT) open/close etc.<br><br>Mapping/unmapping is a trivial and safe operation on many archs, but not
<br>on all (beware of some IOMMU being involved, then mapping becomes<br>indeterministic). If unsure, check for your target if it is running<br>through complex and potentially memory-allocating code paths, e.g. via<br><a href="http://lxr.linux.no" target="_blank">
lxr.linux.no</a>. If there are problems (not expected on today&#39;s mid- to<br>low-end HW), you have to manage also the mappings during init and keep<br>them during runtime. Standard pattern for RT development.<br><div><div>
</div><div class="Wj3C7c"><br>Jan<br><br>--<br>Siemens AG, Corporate Technology, CT SE 2<br>Corporate Competence Center Embedded Linux<br></div></div></blockquote></div><br>

------=_Part_10068_23667942.1197988864651--

