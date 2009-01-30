Message-ID: <498305CC.9060601@domain.hid>
Date: Fri, 30 Jan 2009 14:51:08 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <ba9b368a0901292128x57de0b4dj4cb701db49bb2059@domain.hid>
In-Reply-To: <ba9b368a0901292128x57de0b4dj4cb701db49bb2059@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Watchdog process
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Daniel Adams <dadams81@domain.hid>
Cc: xenomai@xenomai.org

Daniel Adams wrote:
> Hi,
> 
> I've written a watchdog process which expects a token (semaphore) to be
> touch every Nms by waiting on the semaphore with a timeout. If the task
> timeouts out on the semaphore I need it to cause a hardware reset. Previous
> RTOSes I've used have had direct access to the COP/Watchdog timer hardware

It's funny, because people generally consider memory protection as a
good thing. In any case, you can use /dev/mem to access your hardware in
user-space, our use iopl/ioperm and inb/outb if it is ISA hardware.

> where the process would tickle the COP or just spin wait for reset once an
> deadline had been missed. I understand that I can get similar behaviour by
> essentially starving the Linux kernel of processor time which causes the NMI
> watchdog to not be tickled, but this timeout is in the order of seconds. The
> application I'm working on is safety critical and needs to cause a system
> reset in < 1 sec.
> 
> Is this possible with Xenomai? If so, can some one point me the direction of
> how to achieve it.

You could do this outside of xenomai: implement a Linux watchdog driver
for your watchdog hardware. Then you can use the existing Linux watchdog
program, or you can modify it to try and get the semaphore. Running the
watchdog program as a plain Linux task is a better idea as running it as
a Xenomai task, because this way, if ever Xenomai starves Linux, you
will get the expected behaviour.

-- 
					    Gilles.

