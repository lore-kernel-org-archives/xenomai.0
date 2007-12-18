Message-ID: <2ff1a98a0712180210v3d19c774t744f77d0f60f7b89@domain.hid>
Date: Tue, 18 Dec 2007 11:10:10 +0100
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <476792F5.6030108@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
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
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>

On Dec 18, 2007 10:29 AM, Jan Kiszka <jan.kiszka@domain.hid> wrote:
>
> Perrine Martignoni wrote:
> > Hi,
> >
> > Currently, I write an RTDM module and I would like to do DMA and mmap to
> > perform transfers who have hard constraints.
> > I would like to know if there is an example in a driver who would help me to
> > do this.
>
> There is code using the related rtdm_mmap_to_user service, but it is
> unpublished. So let me sketch to basic patter:
>
> 1. Define some IOCTL that allocate the DMA area statically and maps it
>    to the requesting user's address space with rtdm_mmap_to_user.
>
> 2. Register pieces of the DMA buffer with the hardware and let it
>    perform the transfer
>
> 3. Signal the transfer completion to the user (who may be waiting on it
>    in some other IOCTL)
>
> 4. The user signals via an IOCTL (may be the same as in 3.) that he's
>    done with some piece of the buffer so that it can be reused with the
>    hardware.
>
> 5. Goto 2.

A special note about ARM: to get DMA to work on ARM, you will need to
flush the cache before passing a buffer to hardware with data for
hardware, or invalidate the cache before passing the buffer to
hardware for the hardware to write data to it. That is because
peripherals, when they access processor RAM, do not access it through
the processor cache.

Another thing about ARMs is that most of them (the old ones, those
that everybody uses) have a VIVT cache, which means that if the same
piece of memory is mapped at two different different addresses, it has
a different cache depending on the virtual address used to address
this piec e of memory. Sharing memory between user-space processes
works because the context switch routine flushes the cache entirely
(ever wondered why the context switch took so long on ARM ?).

When you allocate a heap and map it in user-space, the heap is mapped
at two different addresses, one in kernel-space and one in user-space.
If you flush/invalidate the cache through the heap address in
kernel-space, it will not work, you have to invalidate/flush the cache
through the user-space address. And I do not think that calling the
cache invalidate/flush instructions from user-space will work, they
are probably privileged instructions.

So, the conclusion is that if you want your DMA to work, you will have
to invalidate/flush the cache in the method (probably ioctl ?)
triggering the DMA, using the user-space mapping address of the heap.
-- 
                                               Gilles Chanteperdrix

