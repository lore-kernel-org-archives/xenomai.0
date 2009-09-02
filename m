From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <Pine.LNX.4.64.0909021418300.22914@domain.hid>
References: <Pine.LNX.4.64.0909021159100.22914@domain.hid>
	<4A9E3AAB.2070404@domain.hid>
	<Pine.LNX.4.64.0909021233110.22914@domain.hid>
	<4A9E4D84.20602@domain.hid>
	<Pine.LNX.4.64.0909021359060.22914@domain.hid>
	<4A9E5424.9070500@domain.hid>
	<Pine.LNX.4.64.0909021418300.22914@domain.hid>
Content-Type: text/plain
Date: Wed, 02 Sep 2009 13:54:43 +0200
Message-Id: <1251892483.3205.143.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Deprecated kernel system calls in xenomai-head
 and new application development paradigm
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "Rus V. Brushkoff" <rus@domain.hid>
Cc: Xenomai help <xenomai@xenomai.org>

On Wed, 2009-09-02 at 14:25 +0300, Rus V. Brushkoff wrote:
> On Wed, 2 Sep 2009, Gilles Chanteperdrix wrote:
> 
> :> :> :Using the RTDM skin.
> :> :> Can you show this paradigm on pipe.c exmaple from Xenomai docs ?
> :> :We are talking about drivers, then just design your driver as you would
> :> :design a Linux driver.
> :> :For instance, you would implement the "write" method of the driver to
> :> :pass data between the user-space task and the driver.
> :>  This is RT driver not simply Linux driver. The previous rt_pipe_read() 
> :> call was running in RT task context. Now it is not clear how this can be 
> :> achieved with new RTDM driver model in kernel space.
> :
> :The write method of an RTDM driver can run in rt context too. If the
> :task which issues the call to "write" is a Xenomai user-space task
> :running in primary mode.
> 
>  Please note - I do not have any Xenomai user-space tasks running - only 
> normal user space programs. The Xenomai-2.4 allows developing of RT driver 
> in kernel space - leaving untouchable user space processes. If such new 
> paradigm need to write the intermediate user-space RT task proxy - than 
> it is wrong. Simply because its adds unneeded complexity to developing RT 
> kernel hardware drivers.

The pipe support is indeed one of a kind, since it shares semantics
between RT and non-RT endpoints, and it should be possible to open the
non-RT side from programs which were _not_ linked against any Xenomai
library. E.g. cat /dev/rtp22 should get any data sent from a RT endpoint
bound to the same pseudo-device.

We will solve this issue by having a RTDM-based driver, implementing the
services of the current RT_PIPE support, eventually taping into the
nucleus core. A kernel-space RTDM driver will be able to send/recv data
via the standard inter-driver RTDM interface - this is what your device
driver should do. A user-space RT application will have access to a
socket-type service access point for sending/receiving packets;
semantics close to the AF_UNIX protocol family should be used there. A
non-RT application will still be able to open its endpoint via the usual
open(2) interface, i.e. such as cat /dev/rtpX works as before.

This work is scheduled for Xenomai v3; v2.5.x still provides the
kernel-based APIs available in earlier releases, and as such it is a bit
early for changing your code. This is also why there is no migration
cookbook from v2 -> v3 yet.
The "deprecated" messages are an early warning so that people notice
that things will change in the next major release, and that it may be a
good idea to reconsider any decision to build _applications_ in
kernel-space; you can still disable those messages via the
CONFIG_XENO_OPT_NOWARN_DEPRECATED switch if they get on your nerves.

> 
> 
> 		Rus
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
-- 
Philippe.



