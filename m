MIME-Version: 1.0
Sender: davide.faconti@gmail.com
From: Davide Faconti <faconti@icarustechnology.com>
Date: Sun, 24 Mar 2013 23:01:23 +0100
Message-ID: <CAPRNvtSqfrtXW1L=W6_OTtenk+YyR_RWbPjrwRXYqEwN00P1rQ@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: [Xenomai] CAN bus on beaglebone
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Dear Xenomai users and developers,

finally I managet to have a working xenomai (Kernel 3.2.21, xenomai
2.6.2.1) on my beloved Beaglebone.

Everything works fine BUT I can't get my CAN bus working.
Partly this is not a surprise, since I don't think that RTCAN
currently support the D_CAN on Beaglebone (am I right?)

> rtcanconfig rtcan0 --verbose --baudrate=125000 start
> mode: start (0x1)
> Can't get interface index for rtcan0, code = -19

What is disappointing is that the other Socketcan, that in theory it
is also installed, isn't working anymore.

I can get the device can0 "up" writing the command

> ip link set can0 up type can bitrate 125000

But when I try to actually open de device I get the error

> Socket: Protocol not supported

Is there anyone that as any idea of what is going on and how I could fix it?
According to Google no one has tried already to use Xenomai +
Beaglebone + CAN  ;)

Davide Faconti

