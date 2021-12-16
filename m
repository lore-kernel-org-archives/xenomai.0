MIME-Version: 1.0
From: C Smith <csmithquestions@gmail.com>
Date: Wed, 15 Dec 2021 23:37:00 -0800
Message-ID: <CA+K1mPHJgjwb7NOM2xL62bmuwGix7LEYoa3Ars8ig9Kr9K1AfQ@mail.gmail.com>
Subject: common clocks RTDM/user-RT
Content-Type: text/plain; charset="UTF-8"
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai List <xenomai@xenomai.org>

I'm porting a real time userspace (Cobalt) app from Xenomai 2.6 to
Xeno 3.1 (on x86). The goal is to see how much time has passed since
the last char was received from the 16550A serial driver.

In Xenomai 2, my RT userspace app was able via ioctl to read the
timestamp the 16550A serial driver provides
(rx_event.rxpend_timestamp) and compare it to a timestamp from
rt_timer_read() in the userspace app.

In Xenomai 3 however, this comparison is no longer valid. They are
both nanosecond timers but can't be directly compared because the RTDM
timer has a large offset compared to rt_timer_read().

Is there a way of accessing the RTDM timer and getting a timestamp
from within my realtime userspace app which would match the serial
driver's timestamp?

thanks, -C Smith

PS: I'll respond about the CAN patch and a few other things in other threads.

