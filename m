Message-ID: <7289437c0712180212l6d47beb5r5766386d333456c1@domain.hid>
Date: Tue, 18 Dec 2007 11:12:52 +0100
From: "Perrine Martignoni" <perrmart@domain.hid>
In-Reply-To: <476792F5.6030108@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_9424_7887443.1197972772584"
References: <7289437c0712140324s41dd3255u9534c606bc510ec7@domain.hid>
	<476792F5.6030108@domain.hid>
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

------=_Part_9424_7887443.1197972772584
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Thanks for the explanation.
But how can I do to allocate the DMA area ? with the Dma-api of Linux or
Xenomai offers the possibility to do this ? and what about memory heap with
H_DMA ?
I'm a bit confused with all of this.

On Dec 18, 2007 10:29 AM, Jan Kiszka <jan.kiszka@domain.hid> wrote:

> Perrine Martignoni wrote:
> > Hi,
> >
> > Currently, I write an RTDM module and I would like to do DMA and mmap to
> > perform transfers who have hard constraints.
> > I would like to know if there is an example in a driver who would help
> me to
> > do this.
>
> There is code using the related rtdm_mmap_to_user service, but it is
> unpublished. So let me sketch to basic patter:
>
> 1. Define some IOCTL that allocate the DMA area statically and maps it
>   to the requesting user's address space with rtdm_mmap_to_user.
>
> 2. Register pieces of the DMA buffer with the hardware and let it
>   perform the transfer
>
> 3. Signal the transfer completion to the user (who may be waiting on it
>   in some other IOCTL)
>
> 4. The user signals via an IOCTL (may be the same as in 3.) that he's
>   done with some piece of the buffer so that it can be reused with the
>   hardware.
>
> 5. Goto 2.
>
> HTH,
> Jan
>
>

------=_Part_9424_7887443.1197972772584
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Thanks for the explanation.<br>But how can I do to allocate the DMA area ? with the Dma-api of Linux or Xenomai offers the possibility to do this ? and what about memory heap with H_DMA ?<br>I&#39;m a bit confused with all of this.
<br><br><div class="gmail_quote">On Dec 18, 2007 10:29 AM, Jan Kiszka &lt;<a href="mailto:jan.kiszka@domain.hid">jan.kiszka@domain.hid</a>&gt; wrote:<br><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
<div><div></div><div class="Wj3C7c">Perrine Martignoni wrote:<br>&gt; Hi,<br>&gt;<br>&gt; Currently, I write an RTDM module and I would like to do DMA and mmap to<br>&gt; perform transfers who have hard constraints.<br>&gt; I would like to know if there is an example in a driver who would help me to
<br>&gt; do this.<br><br></div></div>There is code using the related rtdm_mmap_to_user service, but it is<br>unpublished. So let me sketch to basic patter:<br><br>1. Define some IOCTL that allocate the DMA area statically and maps it
<br> &nbsp; to the requesting user&#39;s address space with rtdm_mmap_to_user.<br><br>2. Register pieces of the DMA buffer with the hardware and let it<br> &nbsp; perform the transfer<br><br>3. Signal the transfer completion to the user (who may be waiting on it
<br> &nbsp; in some other IOCTL)<br><br>4. The user signals via an IOCTL (may be the same as in 3.) that he&#39;s<br> &nbsp; done with some piece of the buffer so that it can be reused with the<br> &nbsp; hardware.<br><br>5. Goto 2.<br>
<br>HTH,<br><font color="#888888">Jan<br><br></font></blockquote></div><br>

------=_Part_9424_7887443.1197972772584--

