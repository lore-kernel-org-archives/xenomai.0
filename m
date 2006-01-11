Message-ID: <43C58755.2040407@domain.hid>
Date: Wed, 11 Jan 2006 23:31:49 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] PCI Framegrabber real-time driver
References: <200601111655.57020.lbocseg@domain.hid> <43C56124.4040407@domain.hid>
	<200601111921.05544.lbocseg@domain.hid>
In-Reply-To: <200601111921.05544.lbocseg@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigDC3A3CD85269443EDCD1342F"
Sender: jan.kiszka@domain.hid
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Rodrigo Rosenfeld Rosas <lbocseg@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigDC3A3CD85269443EDCD1342F
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Rodrigo Rosenfeld Rosas wrote:
> Hi Jan, thank you for replying (I was really guessing that your answer would 
> be the first ;) ).

How did you? ;)

> 
> I'll comment along the message.
> 
> 
>>>Hi,
>>>
>>>...
>>>Let me explain how the driver works. It initializes the board with some
>>>PCI writes on startup. It's passed to the kernel the parameter "mem=510M"
>>>reserving 2Mb for use with the framegrabber through DMA access. I need a
>>
>>I guess "510M" does not stand for 510 MB... ;)
> 
> 
> Sorry, why not? This is taken from Documentation/kernel-parameters.txt:
> mem=nn[KMG]     [KNL,BOOT] Force usage of a specific amount of memory
>                        Amount of memory to be used when the kernel is not able
>                        to see the whole system memory or for test.
>                        [IA-32] Use together with memmap= to avoid physical
>                        address space collisions. Without memmap= PCI devices
>                        could be placed at addresses belonging to unused RAM.
> 

Argh, I confused something here.

Yes, this is a way to obtain this continous memory. The other, more
organised way is via the old bigphysarea patch. It's still being update
even for 2.6 (http://pv105234.reshsg.uci.edu/~jfeise/Downloads/zr36120).
Anyway, as long as you are alone with this requirement on your system,
this is the simpler way to go.

> 
>>>continuous physic memory area and I can't get it through kmalloc or
>>>similar functions. I map this memory in my programs in user space. So, I
>>>basically need to write and read from PCI registers in the drive. But I
>>>don't know if it should be better to develop the driver using some
>>>existing API or not because I didn't find any API that applies to
>>>framegrabbers like v4l does on Linux domain...
>>
>>There is no such thing like video4RTDM (yet), that's true.
> 
> 
> :(
> 
> 
>>>Please, what do you suggest about the design of my driver?
>>
>>Well, if you already have a working driver for standard Linux, I would
>>suggest the following:
>>
>>Split up your driver in the (non-real-time) initialisation work where
>>you may use all the useful driver APIs Linux provides you (BTW, how do
>>you obtain this continuous memory block?) and a (real-time) runtime part
>>where only RTDM functions can be used.
> 
> 
> Actually, the great advantage of V4L(2) API is for user space programmers to 
> have a common API. There is too few advantages the API provides for 
> initialization (actually, the API does no hardware initialization, it only 
> register the devices to be used by userspace programs). So, the 
> initialization API is useless without the runtime API.
> 
> The memory is obtained passing the kernel the parameter "mem=510M". So, the 
> kernel won't use the last 2 Mb. I know it is not an elegant solution but it's 
> pretty simple and I can't imagine another one... For using this memory in the 
> driver there are two options:
>  - The user pass the address to be used by DMA through a module parameter.
>  - if no address was specified, try to use the last address with the "dma = 
> virt_to_phys(high_memory);". Of course, this is dangerous if another driver 
> uses the same method and is already using that memory. But I know that in my 
> system this is the only driver that uses that memory.
> 
>>Then register a RTDM device, likely some misc device with a nice unique
>>name and an instance number postfix, and with open, close, and ioctl
>>handlers.
> 
> I think that in that cases a mmap handler is very useful too.
> 

Maybe, maybe not. The mmap interface, especially its current low-end
side on Linux, contains a lot dynamics and tight relations to the
mm-subsystem to use it directly in hard-RT contexts. So far I think it
would be overkill to define this interface just to pass some user memory
region to a RTDM driver. I rather vote for specialised new interfaces in
this cases, typically based on IOCTLs.

See, touching the mm in hard RT code is at least "tricky". You drag a
lot of external compexity into your RT subdomain without real need. It
simply that you then have to take much more code into account to gain
certainty if your system is actually deterministic. Tight mm-relation is
e.g. one reason why userspace locking services (futexes) are even on
PREEMPT_RT still fishy regarding hard-RT - but this is a different topic.

> 
>>The init stuff, or parts of it, would be moved to the open_nrt 
>>(note the "_nrt") handler, cleanup to close_nrt. Likely the parameters
>>that can be passed via rt_dev_open (or plain "open" in the posix skin)
>>are not sufficient to configure your device instance. E.g. you may want
>>to pass up or down some userspace buffer addresses. Therefore, register
>>an ioctl_nrt handler which deals with specific setup-IOCTLs. On the
>>other hand, all the synchronisation, buffer flipping, etc. you need to
>>perform during runtime from your hard-real-time task has to be
>>implemented in an ioctl_rt (note: "_rt") handler.
>>
>>As there is no magic involved in the rt-part of RTDM - all
>>synchronisation mechanisms are standard -, porting the existing semantic
>>of your driver over the RTDM API should cause no real problem. But I
>>don't know your driver design and its usage, so feel free to point out
>>potential issues you see.
> 
> 
> Well, there is only one thing I can see at the moment. I would need to rewrite 
> the interrupt part to use a real-time interrupt routine instead of the PCI 
> interrupt method, am I right?
> 

Don't know. Maybe you could sketch the data flow of a typical frame
capturing cycle. Does the application trigger it by polling and then
blocks until the result arrived? Or is the update continously going on?
How does an application know if a frame is up-to-date, is currently
being updated, or whatever? Sorry, I never worked with such hardware
before and only have a rough idea of it.

> 
>>If you like to have a look at a rather simple reference code with all
>>the described features included (just without direct hardware acesss),
>>check out ksrc/drivers/benchmark/ in the latest Xenomai SVN.
> 
> Thank you, I'll check them...
> 
> 
>>And if you think the final API design for your framegrabbing hardware
>>looks common enough to cover other framegrabbing hardware as well, you
>>are warmly welcome to post the concept so that we can discuss making
>>this THE real-time framegrabbing device profile (officially reserving an
>>RTDM ID and name, including the API header in the Xenomai code base,
>>etc.). That could mean your application suddenly becomes portable over
>>other hardware - something like video4RTDM...
> 
> 
> Unfortunatelly, I think I won't have time at this moment to suggest a common 
> API for all framegrabbers because I'm bad on time. I have no more than 6 
> months to finish my work on college and I have a lot of other things to 
> implement and some articles to write... But, I might have some time in 
> future...

Nevermind, this discussion can already collect interesting aspects and
new ideas. Maybe others, e.g. from the (RT-)FireWire framegrabbing side
will pick this once up.

Jan

--------------enigDC3A3CD85269443EDCD1342F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFDxYdVniDOoMHTA+kRArXaAJ4untkhQ7ExPm66nLl2RTyGCytz3wCcDkCr
9++YN4ntoikIcRu2w57ouag=
=0T1O
-----END PGP SIGNATURE-----

--------------enigDC3A3CD85269443EDCD1342F--

