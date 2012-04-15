Message-ID: <4F8B5DFD.8050502@domain.hid>
Date: Mon, 16 Apr 2012 01:47:09 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAOiXNkC0xXveRSBe-YR1OV_2ZF7qZ-xPzWLjKa5b2PP5MaufLg@domain.hid>	<4F8B4B4E.7000202@domain.hid>
	<CAOiXNkDXL94Y17EghAZAOLh4PFSFfFoJNnEbguLxFY054reUhA@mail.gmail.com>
In-Reply-To: <CAOiXNkDXL94Y17EghAZAOLh4PFSFfFoJNnEbguLxFY054reUhA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] RTDM or native Xenomai API
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Andrey Nechypurenko <andreynech@domain.hid>
Cc: Xenomai help <xenomai@xenomai.org>

On 04/16/2012 12:53 AM, Andrey Nechypurenko wrote:
> Hi Gilles,
> 
> Thank you very much for such low-latency reply! :-)
> 
>> RTDM is the API of choice for developing drivers for real-time
>> applications using xenomai.
> 
> Please correct me if I just misunderstand something here, but as I
> understand, RTDM is an abstraction layer with concrete implementation
> using xenomai API. As stated in the referenced paper from Jan Kiszka,
> the original reason for introducing this layer was to achieve
> portability across different RT solutions for Linux. Since that time,
> a lot of considered RT solutions becomes irrelevant. In fact, I would
> say, there are only Xenomai and preempt_rt. If this assumption is
> true, then I can not see the advantages of the additional layer unless
> it is more then just an abstraction layer. Does RTDM API makes certain
> tasks easier/better compared to the similar native xenomai API? Just
> to give concrete example - what is the advantage of using
> rtdm_task_init() vs. rt_task_create or xnintr_init() vs.
> rtdm_irq_request()?

The native API is designed to write applications, not drivers. The RTDM
API is designed to write drivers. Using the native API in user-space is
deprecated, the native API is made for user-space. RTDM is not an
additional layer, RTDM uses the same primitives as the native API, and
so does the posix API. So, there is no additional overhead involved.
rtdm_task_init is the way to create a kernel-space thread, but what rtdm
brings is not really that, this is only a building block, what RTDM
brings is the infrastructure which make the dialog possible between the
application and the driver. On the driver side, you implement
open/read/write/ioctl callbacks, and magically, these functions get
called when the application calls open/read/write/ioctl in user-space.

> 
>> Also note that in the case of omap3, gptimers may be used to generate
>> PWM without software assistance. And that the gpio kernel functions are
>> safe to be used in real-time context.
> 
> We already using 2 available hardware PWM generators. The experiment
> with GPIO was mainly to start collecting experience with Xenomai and
> see how far the one can go in user space. Now, I want to make the next
> step and write kernel module which is doing the same. That is why the
> question about RTDM.

We are going to continue with the PWM example to help you understand
what we encourage you to do. You can make an RTDM driver which will
allow to control the GPIOs from user-space, as you probably already
found out, this will incur a high jitter to the PWM signal. Not only
that, but it will also make the application code depend on hardware
details (the number of the GPIOS, the duty cycle). What your application
really want to control is the motor speed, so, what you should do is an
RTDM driver, which generates the PWM using GPIOS, in kernel-space,
according to instructions given by the application (via write or ioctl)
about the target motor speed. You no longer have any jitter problem, and
now the application is completely ignorant of the hardware details, it
controls what it wants to control: the motor speed.

If you split the code this way (drivers in kernel-space, using RTDM,
application in user-space, using the native or posix api), you only have
to modify drivers when changing hardware, and you can write several
applications using the same hardware without having to rewrite every
time the interactions with hardware.

That is the way things are done with linux, there is no reason not to do
the same with xenomai.

The famous example which does not do that in the linux world is the X
server, and even this is changing as more and more interactions with
graphic driver are moving to kernel-space.

-- 
                                                                Gilles.

