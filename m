MIME-Version: 1.0
In-Reply-To: <50D2E611.1040404@xenomai.org>
References: <CAPpP=rPyuKK5Sr9mxXFw+KMhD3g1F+Q5=d8Xm7nQS6hF5OCebw@mail.gmail.com>
	<50D08B74.1010809@xenomai.org> <50D08C0A.10502@xenomai.org>
	<CAPpP=rPi6NvBV6OAfLM3Ynym2FWtO_i7iyKx0hT7eYJLUT+8Bg@mail.gmail.com>
	<50D099A2.3080407@xenomai.org>
	<CAPpP=rO9JjAeWS7evj9u-bVOZuS79NxVJhtLOUJRpFn1zRCb5w@mail.gmail.com>
	<50D0CFB9.9050602@xenomai.org>
	<CAPpP=rNbsH+iXBrK+vs3CZG3T0sxOw-NZ1Px=1unOLjZq3QgAQ@mail.gmail.com>
	<50D1CFD0.9080500@xenomai.org>
	<CAPpP=rNtKwL3ifNx5iABmzXpKpSeYuHnw8asRY8xiicpvn4P2g@mail.gmail.com>
	<50D2E611.1040404@xenomai.org>
Date: Wed, 2 Jan 2013 09:21:35 +0100
Message-ID: <CAPpP=rNZq3to+=JuMfsCONT=Ss8cTic91-00-2ci8i+qArWZiQ@mail.gmail.com>
From: alex alex <duch.alexandre@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: Re: [Xenomai] [Page fault - POSIX skin] Interraction between malloc
 en nanosleep
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai <xenomai@xenomai.org>

> >> If you want to avoid  mode when using malloc, pre-allocate some memory
> for
> >> RT tasks,
> >> then use a custom allocator (not malloc), such as the TLSF allocator for
> >> instance.
> >>
> >
> >
> > Actually I carry out a frameworks portage so unfortunately I can not
> change
> > the malloc function.
>
> Yes you can, simply use the same --wrap technique as Xenomai.
>

I wrapped the malloc,calloc, realloc and free functions with those of the
TLSF allocator and I don't have the page fault any more then the rtdm
semaphore works properly since I stay in the primary mode.

Thank you for your advices.

Alex.
