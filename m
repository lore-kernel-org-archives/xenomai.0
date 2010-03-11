Message-ID: <4B991999.1070406@domain.hid>
Date: Thu, 11 Mar 2010 17:26:01 +0100
From: Daniele Nicolodi <daniele@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] Analogy a4l_ioctl_bufinfo() bug?
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

Hello. As reported in the xenomai-help mailing list I'm investigating
why a4l_mmap() is not supported for the ni pcimio driver. Hacking on the
driver I discovered that, apparently, the only problem in supporting
mmap of the device buffer is in the a4l_ioctl_bufinfo() function.

In my interpretation, this function does more than what it promises.
>From the documentation it looks like it just has to return the current
buffer size. However, if my understanding is correct, it also copies
data to/from the hardware FIFO to the device buffer. It is unclear to me
why this is necessary.

In doing so it uses the __munge() function, around line 630 in buffer.h.
This function in turns uses the driver specific munge function. In the
case of the ni pcimio driver this function is ni_ai_munge16() in
mio_common.c. This function expects to be called when a valid command
has been sent to the subdevice, because it unconditionally deferences
cmd->nb_chan, around line 1385.

However, when the a4l_ioctl_bufinfo() function is called, there is no
check that a valid command has been sent to the device, and generally it
 hasn't. This causes a kernel OOPS for trying to deference a NULL pointer.

My hacky solution has been to introduce a check, with an early return,
for a NULL cmd. I'm sure this is not the right solution.

However, to solve the problem properly, I need to understand why
a4l_ioctl_bufinfo() has to mess with the buffer data, when it is only
interested into the buffer dimensions.

Thanks. Cheers,
-- 
Daniele

