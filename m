Message-ID: <7289437c0712140750i176b34e9r8b3b5e16af52c92a@domain.hid>
Date: Fri, 14 Dec 2007 16:50:41 +0100
From: "Perrine Martignoni" <perrmart@domain.hid>
In-Reply-To: <0B45E93C5FF65740AEAE690BF3848B7A4AB2DF@rennsmail04.eu.thmulti.com>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_1331_19233182.1197647441466"
References: <0B45E93C5FF65740AEAE690BF3848B7A4AB2DF@rennsmail04.eu.thmulti.com>
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

------=_Part_1331_19233182.1197647441466
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I don't know how memory heaps really work but it seems that memory heaps are
shared between user and kernel spaces.
So, if I do like this I don't need mmap, am I wrong ?
How is done the DMA transfer after ?

Thanks

On Dec 14, 2007 2:59 PM, Fillod Stephane <stephane.fillod@domain.hid>
wrote:

> Perrine Martignoni wrote:
> >Currently, I write an RTDM module and I would like to do DMA and mmap
> to perform transfers who have hard constraints.
> >I would like to know if there is an example in a driver who would help
> me to do this.
>
> I'm looking for the same need, except I'm not using RTDM, and everything
> is in userland. Using the attached patch against Xenomai 2.4.0, I hope
> to make it to work with something like this:
>
>        RT_HEAP_INFO info;
>        RT_HEAP heap;
>        void *user_addr;        /* DMA buffer, user access */
>        unsigned long dma_addr; /* for use with the DMA controller */
>
>        /* Allocate memory, suitable for DMA. This occurs before
> entering RT land. */
>        err = rt_heap_create (&heap,
>                        name,
>                        heapsz,
>                        H_SHARED|H_DMA);
>        if (err) { /* ... */ }
>
>        err = rt_heap_alloc (&heap, 0, TM_INFINITE, &user_addr);
>        if (err) { /* ... */ }
>
>        err = rt_heap_inquire (&heap, &info);
>        if (err) { /* ... */ }
>
>        dma_addr = info.phys_addr;
>
> Any comments?
> --
> Stephane
>

------=_Part_1331_19233182.1197647441466
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I don&#39;t know how memory heaps really work but it seems that memory heaps are shared between user and kernel spaces.<br>So, if I do like this I don&#39;t need mmap, am I wrong ?<br>How is done the DMA transfer after ?<br>
<br>Thanks<br><br><div class="gmail_quote">On Dec 14, 2007 2:59 PM, Fillod Stephane &lt;<a href="mailto:stephane.fillod@domain.hid">stephane.fillod@domain.hid</a>&gt; wrote:<br><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
<div><div></div><div class="Wj3C7c">Perrine Martignoni wrote:<br>&gt;Currently, I write an RTDM module and I would like to do DMA and mmap<br>to perform transfers who have hard constraints.<br>&gt;I would like to know if there is an example in a driver who would help
<br>me to do this.<br><br></div></div>I&#39;m looking for the same need, except I&#39;m not using RTDM, and everything<br>is in userland. Using the attached patch against Xenomai 2.4.0, I hope<br>to make it to work with something like this:
<br><br> &nbsp; &nbsp; &nbsp; &nbsp;RT_HEAP_INFO info;<br> &nbsp; &nbsp; &nbsp; &nbsp;RT_HEAP heap;<br> &nbsp; &nbsp; &nbsp; &nbsp;void *user_addr; &nbsp; &nbsp; &nbsp; &nbsp;/* DMA buffer, user access */<br> &nbsp; &nbsp; &nbsp; &nbsp;unsigned long dma_addr; /* for use with the DMA controller */<br><br> &nbsp; &nbsp; &nbsp; &nbsp;/* Allocate memory, suitable for DMA. This occurs before
<br>entering RT land. */<br> &nbsp; &nbsp; &nbsp; &nbsp;err = rt_heap_create (&amp;heap,<br> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;name,<br> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;heapsz,<br> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;H_SHARED|H_DMA);<br> &nbsp; &nbsp; &nbsp; &nbsp;if (err) { /* ... */ }<br><br>
 &nbsp; &nbsp; &nbsp; &nbsp;err = rt_heap_alloc (&amp;heap, 0, TM_INFINITE, &amp;user_addr);<br> &nbsp; &nbsp; &nbsp; &nbsp;if (err) { /* ... */ }<br><br> &nbsp; &nbsp; &nbsp; &nbsp;err = rt_heap_inquire (&amp;heap, &amp;info);<br> &nbsp; &nbsp; &nbsp; &nbsp;if (err) { /* ... */ }<br><br> &nbsp; &nbsp; &nbsp; &nbsp;dma_addr = 
info.phys_addr;<br><br>Any comments?<br>--<br><font color="#888888">Stephane<br></font></blockquote></div><br>

------=_Part_1331_19233182.1197647441466--

