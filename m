Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 May 2007 16:59:15 -0000
Message-ID: <DD39B5C3F4963040ADC9768BE7E430CB01EB2198@domain.hid>
In-Reply-To: <0B45E93C5FF65740AEAE690BF3848B7A4AB0D1@domain.hid>
References: <0B45E93C5FF65740AEAE690BF3848B7A4AB0D1@domain.hid>
From: "Daniel Schnell" <daniel.schnell@domain.hid>
Subject: Re: [Xenomai-help] memcpy performance on Xenomai
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Fillod Stephane <stephane.fillod@domain.hid>
Cc: xenomai@xenomai.org

Hi,


To 1.)
doing memset() on the buffers makes a change ... Now the performance is =
as bad as with mlockall() :(
Which means the Linux VM without mlockall makes somehow an optimization =
for uninitialized heap buffers.
Actually nothing to blame on Xenomai here.

The reason I was looking at the memcpy native performance was because I =
found Xenomai Posix message queues somewhat slow:
In two tasks where one is receiving a 32 kBytes msg and the other =
sending to this task 32 kbytes of data, I have an average cycle time of =
more than 1 ms.
Looking at the memcpy performance of my system tells me something:
Memcpy(32 KB) ->  400 us
Two msg_send(32KB) cannot be less than 2x400 us + 2 ctx switch away, =
probably even more because we have to write first to Kernel memory, then =
the ctx switch, then copying from Kernel memory to user buffer, than ctx =
switch. This simply means I cannot use msg queues for anything bigger =
than 1K, which means I have to use shared memory for that.
As you proposed in another mail maybe it makes a difference to use an =
own memcpy implementation for ppc which does no read on write.


To 2.)
I don't have a recent glibc, so that is no option. I can wait however =
for the new clock_gettime() of Xenomai and use in between the =
rt_timer_tsc function.




Best regards,

Daniel Schnell.

-----Original Message-----
From: Fillod Stephane [mailto:stephane.fillod@domain.hid
Sent: 15. ma=ED 2007 15:59
To: Daniel Schnell
Cc: xenomai@xenomai.org
Subject: RE: [Xenomai-help] memcpy performance on Xenomai

That's puzzling. Can it be explained?
Have you tried a memset of buf1&buf2 before the first osa_now_timespec?


>2.) rt_timer_tsc
>If I use clock_gettime() this needs 3100 ns, If I use rt_timer_tsc()=20
>this needs 74 (!) ns.

Have you tried clock_gettime with *_HR clock like CLOCK_MONOTONIC_HR ?
You have to have a recent glibc to get benefit from that.
One of those clock rely on timebase tsc instead of issuing an expensive =
syscall.

Regards,
--
Stephane

