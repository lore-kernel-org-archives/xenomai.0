From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <4C5D3D59.3050208@domain.hid>
References: <AANLkTi=yDXty82va8JGzmRA453e021EvomyYitaQTCTg@domain.hid>
	<4C5D0F40.1070104@domain.hid>
	<1DDE5D7F-58F5-4919-A4B4-5FCAD385E679@domain.hid>
	<4C5D3724.1000908@domain.hid>
	<B6A5952D-4182-4D39-B28E-0D9BAE2872C4@domain.hid>
	<4C5D3D59.3050208@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Sat, 07 Aug 2010 13:36:36 +0200
Message-ID: <1281180996.1706.118.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] migration scenario to xenomai
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Xenomai help <xenomai@xenomai.org>

On Sat, 2010-08-07 at 13:02 +0200, Gilles Chanteperdrix wrote:
> Guenter Ebermann wrote:
> > Hi Gilles,
> > 
> > Gilles Chanteperdrix wrote:
> >> Guenter Ebermann wrote:
> >>> Yeah, I understand your point with generic interface and device driver
> >>> separation. And I really like the way this happens under linux/xenomai. I am
> >>> also willing to write new drivers which are usable by a broader public using
> >>> these design principles. But the communication stack I am gona use (AUTOSAR
> >>> FlexRay stack) does not follow them. AUTOSAR (www.autosar.org) specs defines
> >>> the Interfaces and layers of the whole communcation system for cars. It does
> >>> not involve kernel/userspace separation, but it also does not mix the low-level
> >>> code with application code. Low level code is only implemented in the device
> >>> drivers (CAN, LIN, FlexRay), but the interface to the upper level stack is not
> >>> generic (as in linux with device drivers) - it is different for each kind of
> >>> lower layer device (CAN, LIN, FlexRay) to gain the best performance from each
> >>> of them.
> >> Well, it looks to me like you can implement the interface between driver
> >> and user-space with standard posix interface (especially ioctl), and
> >> then implement the AUTOSAR interfaces as a user-space library relying on
> >> this posix interface.
> > 
> > Yes, this will work for the send direction for LIN and CAN very fine. But
> > receive operation happens via function calls (RxIndications) from driver to
> > upper layer. Also send direction of FLEXRAY is a call from driver to upper
> > layer with a request to fill the buffers.
> > 
> > Can I make callbacks from xenomai rtdm into a xenomai app in user space?
> > Or can I register C-callbacks with ioctrl at driver?
> 
> The support to have this is almost in place, we call it user-space
> signals, because this is essentially the way posix signals are
> implemented, but it applies to any type of user-space callback triggered
> by a kernel-space action.
> 
> With the current method, the callback would be called only when
> returning from a system call, but with the "mayday" support, implemented
> in Xenomai 2.5.4, we have a way to have the callbacks being able to
> interrupt any piece of code. The support we have currently is only the
> core support, we need some window-dressing for the RTDM skin, though.
> 
> But all this can be sorted out pretty quickly if need be.

Until this is available, a straightforward approach would be to create
some server thread of high priority in the receiving application,
waiting for indications on a blocking ioctl() call dequeuing them from
kernel space, then running the userland callback as required.

-- 
Philippe.



