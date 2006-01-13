From: Rodrigo Rosenfeld Rosas <lbocseg@domain.hid>
Subject: Re: [Xenomai-help] PCI Framegrabber real-time driver
Date: Fri, 13 Jan 2006 19:53:46 -0200
References: <200601111655.57020.lbocseg@domain.hid>
	<200601131224.55609.lbocseg@domain.hid> <43C80626.6090007@domain.hid>
In-Reply-To: <43C80626.6090007@domain.hid>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200601131953.46146.lbocseg@domain.hid>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
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

>> How could I
>> share this memory with userspace RT-programs in a deterministic way?
>Set up the memory mapping between kernel and user space during (non-rt)
>initialisation. This means that you have to create some mapping from the
>physical block into the user space address range. I think
>remap_pfn_range() or io_remap_page_range() should do this after mapping
>the physical memory into the address space of the kernel (ioremap()).
>But I suggest LDD3 on this topic as a better reference.

Of course. You are right. I will only need this at initialization so I=20
shouldn't bore about that.

>> I can't understand why sharing that memory should be so complex...
>
>As long as it's static, it's trivial. But as soon as you have to
>synchronise with potential changes of your process' mm, it starts to
>cause problems. Again, the concept of setting up the mapping during
>non-rt init of your driver and then using it in RT context is safe.

Right.

>> By reading the registers in the PCI board the driver can get the acquire
>> status (capturing, finished, etc).
>
>... and single this event by unblocking some potentially waiting user
>space, which was blocked in some related IOCTL of your driver.

Sorry, I didn't understand this phrase... My ioctl's never block...

>So, as Jeroen suggested as well, let the user register two or more exchange
>buffers, set up a shared memory region, and provide in IOCTL interface
>to inform the user about updates.

Do you mean by using polling or by a more efficient mechanism? I mean, how =
can=20
I use an IOCTL interface like a condition variable?

>> Well, let me explain what my problem is. I'm developing a framework for
>> developing rt applications for mobile robots. OROCOS seemed too complex
>> for
>
>Welcome to the club - we are working on the same topic at my institute.

:)

>> me... For testing the framework I built a simple robot with an optical
>> encoder on the weels. I developed an odometry system based on the encoder
>> sensors that worked well. I would like to write an application that does
>> position and speed control by using the images taken by the framegrabber
>> and compare the result with the odometry system for making a conceptual
>> proof of my framework for my master-thesis work.
>
>Sounds very interesting. Would be interesting to hear, when this works,
>what precision can be achieved with your hardware.

I'll let you know when I finish it -- if I finish! ;)

Best regards,

Rodrigo.

=09

=09
	=09
_______________________________________________________=20
Yahoo! doce lar. Fa=E7a do Yahoo! sua homepage.=20
http://br.yahoo.com/homepageset.html=20



