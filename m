From: Bryan Hilterbrand <bhilterbrand@domain.hid>
Date: Wed, 22 Dec 2010 19:11:18 -0700
Message-ID: <D7352E9EB94BE54D8E052C5D9FE093294798D63DD4@domain.hid>
References: <AANLkTimuiAP=dGQSKG2PYJUnGw--1iXBzPJ1325czz-_@domain.hid>
	<1280655383.6700.11.camel@domain.hid>
In-Reply-To: <1280655383.6700.11.camel@domain.hid>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
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
To: Philippe Gerum <rpm@xenomai.org>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On Sunday, 2010-08-01, Philippe Gerum wrote:
> Also note that [userland interrupt] support may introduce serious issues
> down the road,
> like not being able to use gdb over your application; using it in new
> apps is a bad idea in the first place, because interrupt handling is
> fundamentally a kernel thing, and should remain so.
>
> Providing this interface was a mistake, it is now deprecated, and
> scheduled for removal in 3.x. The right approach is to process
> (real-time) interrupts in kernel space from a RTDM driver, waking up a
> userland thread as needed. That thread may wait for events via blocking
> ioctl()/read() requests directed at the driver, thus following the
> standard programming model.

I just discovered this thread, and I'm trying to solve a similar problem.

Philippe, can you point me to a RTDM driver example that uses an interrupt
and blocks the reader? Or is this something that I will need to figure out
myself? A good RTDM example would be a start...

I'm on an older version of Xenomai (2.3) if that makes a difference.

Thank you for any help you can give me!

