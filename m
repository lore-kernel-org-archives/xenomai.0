Message-ID: <43C80626.6090007@domain.hid>
Date: Fri, 13 Jan 2006 20:57:26 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] PCI Framegrabber real-time driver
References: <200601111655.57020.lbocseg@domain.hid>	<200601111921.05544.lbocseg@domain.hid>
	<43C58755.2040407@domain.hid> <200601131224.55609.lbocseg@domain.hid>
In-Reply-To: <200601131224.55609.lbocseg@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
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

Rodrigo Rosenfeld Rosas wrote:
>> Yes, this is a way to obtain this continous memory. The other, more
>> organised way is via the old bigphysarea patch. It's still being update
>> even for 2.6 (http://pv105234.reshsg.uci.edu/~jfeise/Downloads/zr36120).
>> Anyway, as long as you are alone with this requirement on your system,
>> this is the simpler way to go.
> 
> I really want to avoid every unnecessary patch to the kernel, so I prefer on 
> not depending in other patches then ipipe. And the initial idea was to provide 
> the (non-rt) driver to normal users that have the DT3153 framegrabber in 
> binary module. I will not do that, but we asked the specifications and told 
> them we would send them the final source code for them to distribute the 
> module drivers but there is no obligation... The only requirement is that we 
> can not redistribute the specifications...
> 
>>> I think that in that cases a mmap handler is very useful too.
>> Maybe, maybe not. The mmap interface, especially its current low-end
>> side on Linux, contains a lot dynamics and tight relations to the
>> mm-subsystem to use it directly in hard-RT contexts. So far I think it
>> would be overkill to define this interface just to pass some user memory
>> region to a RTDM driver. I rather vote for specialised new interfaces in
>> this cases, typically based on IOCTLs.
> 
> The problem with IOCTLs and read/write interfaces is that I need to copy the 
> large memory block each time I need a frame... But I could also ask for the 
> physical memory address with an IOCTL and use the /dev/mem device for reading 
> the memory. But the device is not real-time... How could I share this memory 
> with userspace RT-programs in a deterministic way? Of course I would need 

Set up the memory mapping between kernel and user space during (non-rt)
initialisation. This means that you have to create some mapping from the
physical block into the user space address range. I think
remap_pfn_range() or io_remap_page_range() should do this after mapping
the physical memory into the address space of the kernel (ioremap()).
But I suggest LDD3 on this topic as a better reference.

> some syncronization method like mutex or another one to avoid begin a new 
> capture while the user is reading the memory... But it is not a problem since 
> most RT-applications do not need to share the framegrabber. So they should 
> ask for a frame, use it, and then ask for another one... I know there are 
> ways to avoid waiting for the frame to be acquired doing a continuous capture 
> and stopping it when the user needs to read the memory... I'm not concerned 
> with this design for now...
> 
>> See, touching the mm in hard RT code is at least "tricky". You drag a
>> lot of external compexity into your RT subdomain without real need. It
>> simply that you then have to take much more code into account to gain
>> certainty if your system is actually deterministic. Tight mm-relation is
>> e.g. one reason why userspace locking services (futexes) are even on
>> PREEMPT_RT still fishy regarding hard-RT - but this is a different topic.
> 
> I can't understand why sharing that memory should be so complex...

As long as it's static, it's trivial. But as soon as you have to
synchronise with potential changes of your process' mm, it starts to
cause problems. Again, the concept of setting up the mapping during
non-rt init of your driver and then using it in RT context is safe.

> 
>>> Well, there is only one thing I can see at the moment. I would need to
>>> rewrite the interrupt part to use a real-time interrupt routine instead of
>>> the PCI interrupt method, am I right?
>> Don't know. Maybe you could sketch the data flow of a typical frame
>> capturing cycle. Does the application trigger it by polling and then
>> blocks until the result arrived?
> 
> An interrupt can occur when a frame capture finishes. Unless I set the board 
> to not generate interrupts...
> 
>> Or is the update continously going on? 
> It can be set to syncronous or asyncronous mode...
> 
>> How does an application know if a frame is up-to-date, is currently
>> being updated, or whatever? Sorry, I never worked with such hardware
>> before and only have a rough idea of it.
> By reading the registers in the PCI board the driver can get the acquire 
> status (capturing, finished, etc).

... and single this event by unblocking some potentially waiting user
space, which was blocked in some related IOCTL of your driver. So, as
Jeroen suggested as well, let the user register two or more exchange
buffers, set up a shared memory region, and provide in IOCTL interface
to inform the user about updates.

> 
> Well, let me explain what my problem is. I'm developing a framework for 
> developing rt applications for mobile robots. OROCOS seemed too complex for 

Welcome to the club - we are working on the same topic at my institute.

> me... For testing the framework I built a simple robot with an optical 
> encoder on the weels. I developed an odometry system based on the encoder 
> sensors that worked well. I would like to write an application that does 
> position and speed control by using the images taken by the framegrabber and 
> compare the result with the odometry system for making a conceptual proof of 
> my framework for my master-thesis work.

Sounds very interesting. Would be interesting to hear, when this works,
what precision can be achieved with your hardware.

> 
> I'd like to thank for all support you, Jeroen and Gilles are giving me.
> 
> Rodrigo.
> 
> 

Jan

