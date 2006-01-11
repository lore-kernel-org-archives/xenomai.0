From: Rodrigo Rosenfeld Rosas <lbocseg@domain.hid>
Subject: Re: [Xenomai-help] PCI Framegrabber real-time driver
Date: Wed, 11 Jan 2006 19:21:05 -0200
References: <200601111655.57020.lbocseg@domain.hid> <43C56124.4040407@domain.hid>
In-Reply-To: <43C56124.4040407@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Message-Id: <200601111921.05544.lbocseg@domain.hid>
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
Cc: xenomai@xenomai.org

Hi Jan, thank you for replying (I was really guessing that your answer woul=
d=20
be the first ;) ).

I'll comment along the message.

>> Hi,
>>
>> ...
>> Let me explain how the driver works. It initializes the board with some
>> PCI writes on startup. It's passed to the kernel the parameter "mem=3D51=
0M"
>> reserving 2Mb for use with the framegrabber through DMA access. I need a
>
>I guess "510M" does not stand for 510 MB... ;)

Sorry, why not? This is taken from Documentation/kernel-parameters.txt:
mem=3Dnn[KMG]     [KNL,BOOT] Force usage of a specific amount of memory
                       Amount of memory to be used when the kernel is not a=
ble
                       to see the whole system memory or for test.
                       [IA-32] Use together with memmap=3D to avoid physical
                       address space collisions. Without memmap=3D PCI devi=
ces
                       could be placed at addresses belonging to unused RAM.

>> continuous physic memory area and I can't get it through kmalloc or
>> similar functions. I map this memory in my programs in user space. So, I
>> basically need to write and read from PCI registers in the drive. But I
>> don't know if it should be better to develop the driver using some
>> existing API or not because I didn't find any API that applies to
>> framegrabbers like v4l does on Linux domain...
>
>There is no such thing like video4RTDM (yet), that's true.

:(

>> Please, what do you suggest about the design of my driver?
>
>Well, if you already have a working driver for standard Linux, I would
>suggest the following:
>
>Split up your driver in the (non-real-time) initialisation work where
>you may use all the useful driver APIs Linux provides you (BTW, how do
>you obtain this continuous memory block?) and a (real-time) runtime part
>where only RTDM functions can be used.

Actually, the great advantage of V4L(2) API is for user space programmers t=
o=20
have a common API. There is too few advantages the API provides for=20
initialization (actually, the API does no hardware initialization, it only =

register the devices to be used by userspace programs). So, the=20
initialization API is useless without the runtime API.

The memory is obtained passing the kernel the parameter "mem=3D510M". So, t=
he=20
kernel won't use the last 2 Mb. I know it is not an elegant solution but it=
's=20
pretty simple and I can't imagine another one... For using this memory in t=
he=20
driver there are two options:
 - The user pass the address to be used by DMA through a module parameter.
 - if no address was specified, try to use the last address with the "dma =
=3D=20
virt_to_phys(high_memory);". Of course, this is dangerous if another driver=
=20
uses the same method and is already using that memory. But I know that in m=
y=20
system this is the only driver that uses that memory.

>Then register a RTDM device, likely some misc device with a nice unique
>name and an instance number postfix, and with open, close, and ioctl
>handlers.
I think that in that cases a mmap handler is very useful too.

>The init stuff, or parts of it, would be moved to the open_nrt=20
>(note the "_nrt") handler, cleanup to close_nrt. Likely the parameters
>that can be passed via rt_dev_open (or plain "open" in the posix skin)
>are not sufficient to configure your device instance. E.g. you may want
>to pass up or down some userspace buffer addresses. Therefore, register
>an ioctl_nrt handler which deals with specific setup-IOCTLs. On the
>other hand, all the synchronisation, buffer flipping, etc. you need to
>perform during runtime from your hard-real-time task has to be
>implemented in an ioctl_rt (note: "_rt") handler.
>
>As there is no magic involved in the rt-part of RTDM - all
>synchronisation mechanisms are standard -, porting the existing semantic
>of your driver over the RTDM API should cause no real problem. But I
>don't know your driver design and its usage, so feel free to point out
>potential issues you see.

Well, there is only one thing I can see at the moment. I would need to rewr=
ite=20
the interrupt part to use a real-time interrupt routine instead of the PCI =

interrupt method, am I right?

>If you like to have a look at a rather simple reference code with all
>the described features included (just without direct hardware acesss),
>check out ksrc/drivers/benchmark/ in the latest Xenomai SVN.
Thank you, I'll check them...

>And if you think the final API design for your framegrabbing hardware
>looks common enough to cover other framegrabbing hardware as well, you
>are warmly welcome to post the concept so that we can discuss making
>this THE real-time framegrabbing device profile (officially reserving an
>RTDM ID and name, including the API header in the Xenomai code base,
>etc.). That could mean your application suddenly becomes portable over
>other hardware - something like video4RTDM...

Unfortunatelly, I think I won't have time at this moment to suggest a commo=
n=20
API for all framegrabbers because I'm bad on time. I have no more than 6=20
months to finish my work on college and I have a lot of other things to=20
implement and some articles to write... But, I might have some time in=20
future...

Thank you,

Rodrigo.

=09

=09
	=09
_______________________________________________________=20
Yahoo! doce lar. Fa=E7a do Yahoo! sua homepage.=20
http://br.yahoo.com/homepageset.html=20



