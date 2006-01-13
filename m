Content-Disposition: inline
From: Rodrigo Rosenfeld Rosas <lbocseg@domain.hid>
Subject: Re: [Xenomai-help] PCI Framegrabber real-time driver
Date: Fri, 13 Jan 2006 13:11:55 -0200
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Message-Id: <200601131311.55640.lbocseg@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
Cc: xenomai@xenomai.org

>> >>>continuous physic memory area and I can't get it through kmalloc
>
>I did a quick check and I could easily allocate a 2MB contiguous,
>aligned buffer on my system using the following calls. (See DMA-
>mapping.txt in your kernel Documentation folder):
>
>struct pci_dev *p;
>
>...
>
>pci_set_master(p);
>pci_set_consistent_dma_mask(p, DMA_32BIT_MASK);
>pci_alloc_consistent(p, 2097152, &phys_ptr);
>
>...

I'll take a look on this approach, but I think that the other is more robust
because this one can fail if it does not find an contiguous block of 2Mb
(actually I'm using about 1,2M on my driver for now...) due to memory
fragmentation... I remember I tried this way some time before when I had
256Mb but could only alloc 512kb of contiguous memory (7 was the maximum
order I could get)... It seemed to me that the kernel has changed since
there. It was not possible to get an order superior to 8 and now I think the
default maximum is order 11... (PAGE_SIZE<<order) I think page size is 4kb
for x86.

>You can also get the irq line number here from p->irq . Use this for
>rtdm_irq_request().
>
>> >>>Please, what do you suggest about the design of my driver?
>
>1. Use RTDM and write a kernel module. It allows you to write a
>specific test program on it, which you can reuse later on every
>occasion where you need to know whether the driver or the program
>contains causes a problem. You can also shut an RTDM driver down
>manually if your RT program ever bails out 'ungracefully'.

Ok, I'm new to RTDM but I think I'll end up using it...

>2. Use 2 framebuffers and implement a ping-pong buffer, so that the
>grabber may fill in a second buffer while you're using the contents of
>number one. Avoid copying of the data.

There is an option, but it would increase the complexity of both the driver
and user code because the user should know what memory is in the turn... And
that is not the only way to avoid copying the data. I can run the acquires =
on
asyncronous way. The advantage of the ping-pong buffer is that I wouldn't
need to wait for a frame capture to complete (the board can do 30fps [frames
per second]) depending on how I design the driver... I'll think better on
this approach.

>3. Remember to use the PCI DMA API. It is the easiest way to guarantee
>that CPU L1/2 caching is not going to fool you some day. You do not
>want to mess yourself with MTRR and friends (?) on the CPU. (Something
>I think may be a serious issue when using tricks like the ones
>mentioned earlier.)

You are talking about specifying the mem option (is it the trick you
 mention)? Well I need to read more about this topic before discussing it
 with you. I do not know how this caching works nor MTRR...

>4. Use portable functions to access your PCI card, such as read[b/w/l]
>() and write[b/w/l]().

Yes, I already use them.

>Don't do *(unsigned int *)ptr =3D val. Where
>needed, use memory write barriers such as wmb(), to avoid instruction
>reordering by the compiler.

I forgot this when first designed my driver but I'll take a better look on
this. Do you know about what situations could take the code to be executed =
in
a different order? I mean, reads and writes to PCI registers could be done =
in
a different order then I've told to the driver?

>5. Don't catch interrupts that weren't meant for you. If your ISR gets
>called, check some status register of your card to see if it was the
>cause of the interrupt. If so, finish with return(RTDM_IRQ_ENABLE).
>Otherwise, return(RTDM_IRQ_PROPAGATE), so other handlers may catch it
>(and reset the possibly shared IRQ line, which is never going to be
>deasserted otherwise (=3D=3D stuck)).

I think it is dangerous to share the interrupt with other non-rt drivers. If
the non-rt driver disables the interrupt for a while, the hard rt-driver wi=
ll
give wrong result. Unless it was possible to not allow the interrupt to be
disabled by non-rt drivers, it is too dangerous to share the interrupt line.

>BTW, when specifying mem=3D510M, how would you access the range 510-512
>without causing a segmentation fault ?

Why should it cause a segmentation fault? The mem=3D510M parameter only inf=
orms
the kernel to not use that memory but it allows manual use of that memory by
a module or so. But kmalloc  won't alloc that memory.

Thank you Jeroen, you helped me a lot.

Best regards,
Rodrigo.

=09

=09
	=09
_______________________________________________________=20
Yahoo! doce lar. Fa=E7a do Yahoo! sua homepage.=20
http://br.yahoo.com/homepageset.html=20



