From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <D7352E9EB94BE54D8E052C5D9FE093294798D63DD4@domain.hid>
References: <AANLkTimuiAP=dGQSKG2PYJUnGw--1iXBzPJ1325czz-_@domain.hid>
	<1280655383.6700.11.camel@domain.hid>
	<D7352E9EB94BE54D8E052C5D9FE093294798D63DD4@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 23 Dec 2010 10:11:46 +0100
Message-ID: <1293095506.22129.118.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Problems with user_irq.c Native example
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Bryan Hilterbrand <bhilterbrand@domain.hid>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On Wed, 2010-12-22 at 19:11 -0700, Bryan Hilterbrand wrote:
> On Sunday, 2010-08-01, Philippe Gerum wrote:
> > Also note that [userland interrupt] support may introduce serious issues
> > down the road,
> > like not being able to use gdb over your application; using it in new
> > apps is a bad idea in the first place, because interrupt handling is
> > fundamentally a kernel thing, and should remain so.
> >
> > Providing this interface was a mistake, it is now deprecated, and
> > scheduled for removal in 3.x. The right approach is to process
> > (real-time) interrupts in kernel space from a RTDM driver, waking up a
> > userland thread as needed. That thread may wait for events via blocking
> > ioctl()/read() requests directed at the driver, thus following the
> > standard programming model.
> 
> I just discovered this thread, and I'm trying to solve a similar problem.
> 
> Philippe, can you point me to a RTDM driver example that uses an interrupt
> and blocks the reader? Or is this something that I will need to figure out
> myself? A good RTDM example would be a start...
> 

The interrupt-related doc starts here:
http://www.xenomai.org/documentation/xenomai-2.3/html/api/group__rtdmirq.html


> I'm on an older version of Xenomai (2.3) if that makes a difference.
> 

Here is an example, driving a 16550 UART. You will find an interaction
between the IRQ handler and the ioctl code, via the "ioc_event" RTDM
even object. The ioctl() code blocks the caller until the event is
posted from the handler, I guess your are looking after something
similar.
http://git.xenomai.org/?p=xenomai-2.3.git;a=blob;f=ksrc/drivers/serial/16550A.c;h=59236ae7b9edfa855701acb99d82f2721e23a866;hb=ea356248b8730fe8126ade4a1f8e49d179352310

I guess you keep stuck on 2.3.x because your fixture is deployed, but
really, unless you are perfectly happy with this release, you should
consider moving to 2.5.5.2 when/if any unexplained or weird bug happens.
Older kernels that were fashionable in 2007 are still supported by the
latest 2.5.x.

> Thank you for any help you can give me!

-- 
Philippe.



