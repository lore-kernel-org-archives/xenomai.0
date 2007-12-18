Message-ID: <7289437c0712180216m525ebd6dm5d5f2adab0973636@domain.hid>
Date: Tue, 18 Dec 2007 11:16:03 +0100
From: "Perrine Martignoni" <perrmart@domain.hid>
In-Reply-To: <2ff1a98a0712180210v3d19c774t744f77d0f60f7b89@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_9427_33268662.1197972963963"
References: <7289437c0712140324s41dd3255u9534c606bc510ec7@domain.hid>
	<476792F5.6030108@domain.hid>
	<2ff1a98a0712180210v3d19c774t744f77d0f60f7b89@domain.hid>
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
To: xenomai-help <xenomai@xenomai.org>, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>

------=_Part_9427_33268662.1197972963963
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

>
> Sorry, I don't specify that I work on PowerQuick2Pro, no more on ARM.
>



>
>
> A special note about ARM: to get DMA to work on ARM, you will need to
> flush the cache before passing a buffer to hardware with data for
> hardware, or invalidate the cache before passing the buffer to
> hardware for the hardware to write data to it. That is because
> peripherals, when they access processor RAM, do not access it through
> the processor cache.
>
> Another thing about ARMs is that most of them (the old ones, those
> that everybody uses) have a VIVT cache, which means that if the same
> piece of memory is mapped at two different different addresses, it has
> a different cache depending on the virtual address used to address
> this piec e of memory. Sharing memory between user-space processes
> works because the context switch routine flushes the cache entirely
> (ever wondered why the context switch took so long on ARM ?).
>
> When you allocate a heap and map it in user-space, the heap is mapped
> at two different addresses, one in kernel-space and one in user-space.
> If you flush/invalidate the cache through the heap address in
> kernel-space, it will not work, you have to invalidate/flush the cache
> through the user-space address. And I do not think that calling the
> cache invalidate/flush instructions from user-space will work, they
> are probably privileged instructions.
>
> So, the conclusion is that if you want your DMA to work, you will have
> to invalidate/flush the cache in the method (probably ioctl ?)
> triggering the DMA, using the user-space mapping address of the heap.
> --
>                                               Gilles Chanteperdrix
>

------=_Part_9427_33268662.1197972963963
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div class="gmail_quote"><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"><div><div class="Wj3C7c">Sorry, I don&#39;t specify that I work on PowerQuick2Pro, no more on ARM.
</div></div></blockquote><div><br>&nbsp;</div><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"><div><div class="Wj3C7c"><br><br></div></div>A special note about ARM: to get DMA to work on ARM, you will need to
<br>flush the cache before passing a buffer to hardware with data for<br>hardware, or invalidate the cache before passing the buffer to<br>hardware for the hardware to write data to it. That is because<br>peripherals, when they access processor RAM, do not access it through
<br>the processor cache.<br><br>Another thing about ARMs is that most of them (the old ones, those<br>that everybody uses) have a VIVT cache, which means that if the same<br>piece of memory is mapped at two different different addresses, it has
<br>a different cache depending on the virtual address used to address<br>this piec e of memory. Sharing memory between user-space processes<br>works because the context switch routine flushes the cache entirely<br>(ever wondered why the context switch took so long on ARM ?).
<br><br>When you allocate a heap and map it in user-space, the heap is mapped<br>at two different addresses, one in kernel-space and one in user-space.<br>If you flush/invalidate the cache through the heap address in<br>kernel-space, it will not work, you have to invalidate/flush the cache
<br>through the user-space address. And I do not think that calling the<br>cache invalidate/flush instructions from user-space will work, they<br>are probably privileged instructions.<br><br>So, the conclusion is that if you want your DMA to work, you will have
<br>to invalidate/flush the cache in the method (probably ioctl ?)<br>triggering the DMA, using the user-space mapping address of the heap.<br>--<br><font color="#888888"> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; Gilles Chanteperdrix
<br></font></blockquote></div><br>

------=_Part_9427_33268662.1197972963963--

