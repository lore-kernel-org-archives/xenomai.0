From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <AANLkTinbzuTwXb2nUM+fNMzjVwOnf96VHttBUrx7rG5C@mail.gmail.com>
References: <1276880276.12743.73.camel@domain.hid>
	<4C1BA6F7.9080004@domain.hid>
	<20100805125828.GA22855@domain.hid>
	<1281016845.1706.0.camel@domain.hid>
	<4C5AC77F.1040508@domain.hid>
	<20100805151932.GA25701@domain.hid>
	<1281027097.1706.96.camel@domain.hid>
	<20100806094325.GA11479@domain.hid>
	<1281091438.1706.114.camel@domain.hid>
	<AANLkTinbzuTwXb2nUM+fNMzjVwOnf96VHttBUrx7rG5C@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Sun, 08 Aug 2010 10:50:38 +0200
Message-ID: <1281257438.1706.126.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] [Xenomai-core] [PULL REQUEST] fixes for 2.5.4
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Peter Soetens <peter@domain.hid>
Cc: xenomai@xenomai.org

On Sun, 2010-08-08 at 00:08 +0200, Peter Soetens wrote:
> On Fri, Aug 6, 2010 at 12:43 PM, Philippe Gerum <rpm@xenomai.org> wrote:
> > On Fri, 2010-08-06 at 11:43 +0200, Tschaeche IT-Services wrote:
> >> On Thu, Aug 05, 2010 at 06:51:37PM +0200, Philippe Gerum wrote:
> >> > Why do you see different licenses? The nucleus is GPL, as is GPL each
> >> > and every bit of the Xenomai kernel code. Only userland libs are LGPL.
> >> >
> >> > The decision to give the EXPORT_GPL hint now to in-kernel users is
> >> > precisely there to make this even more clear, and I will extend this to
> >> > all in-kernel interfaces in Xenomai 2.6. The reason why I did not push
> >> > this change to the 2.5.x series is because some legacy Xenomai-based
> >> > apps implemented as non-GPL kernel modules might qualify for the "gray
> >> > area" set, as described in this post:
> >> > http://marc.info/?l=linux-kernel&m=107049625920022&w=2
> >> >
> >> > However, the days when using a dual-kernel system meant running
> >> > application code to kernel land are long gone; we did work quite hard to
> >> > provide flexibility, reliability and good performances in userland over
> >> > time. Therefore, Xenomai 2.6 will strongly advise users to run
> >> > applications in user-space only, and Xenomai 3.x won't export any kernel
> >> > space API to kernel-based applications at all (Of course, RTDM will
> >> > still export an API to build drivers, and to interface with other
> >> > drivers).
> >> >
> >> > If the issue is about driver code, and not application code, then it is
> >> > even simpler: driving peripherals is part of the Linux kernel
> >> > business's, so the GPL rules. If, for any valid or paranoid reason, some
> >> > of the code driving the peripheral could not be disclosed, then there
> >> > are options to move it partly or entirely to userland where LGPL
> >> > applies, even if that may not be the best technical approach.
> >> >
> >> > The bottom line for the Xenomai licensing policy is quite
> >> > straightforward:
> >> >
> >> > - We built our house on the foundations passed on by others, they gave
> >> > us the Linux kernel code, we do abide by their license because we are
> >> > part of their kernel, so our kernel-based code is licensed under the
> >> > terms of the Linux kernel license. People who want to interpret that
> >> > license to fit their licensing requirements are on their own. We did not
> >> > invent the license, we are simply using it and passing it on our own
> >> > users.
> >> >
> >> > - In userland, we provide LGPL interfaces to applications to call our
> >> > real-time nucleus services, the same way the glibc provides LGPL
> >> > interfaces to applications to call standard Linux services.
> >> >
> >> > > did not clarify yet, if our driver code may be open source.
> >> > > i think, it would be appreciated if not.
> >> > >
> >> >
> >> > We can't help in this area, we simply provide some code under a given
> >> > license. Whether the license fits your requirements depends on your
> >> > assessment of the situation only.
> >>
> >> personally i would like GPL used in projects, but companies are afraid
> >> of loosing their intellectual property. Thus, i, in the role of the
> >> consultant, have to find a solution, which you already explained:
> >> move the IP into user space and keep the GPLed module/driver part IP free.
> >
> > Whatever split between kernel/userland support you may want to implement
> > to solve this issue, I would strongly recommend to keep the interrupt
> > handling in the RTDM-based kernel driver, including the device request
> > acknowledgement part.
> >
> > Moving this code to userland would require the thread in charge to
> > always be runnable, so that you don't get either an interrupt flood, or
> > a device collapse because the interrupt handling is either significantly
> > delayed or even stopped. It turns out that such requirement would
> > prevent you from using GDB over the process including the interrupt
> > handling code, since GDB eagerly stops all threads for single-stepping.
> 
> Sorry for the off-topic nitpicking, but GDB 7 supports one-thread-stop/stepping.
> This doesn't in any way shed a different light on Philippe's arguments.
> It's just removing a nit. On a saturday night. While everyone's sleeping.

Is non-stop debugging available for anything else than x86 these days?

> 
> Peter

-- 
Philippe.



