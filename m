Message-ID: <bc4264770702271525q6d5d164lfa34b421a64eeb70@domain.hid>
Date: Tue, 27 Feb 2007 23:25:24 +0000
From: "roland Tollenaar" <rolandtollenaar@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Subject: [Xenomai-help] warnings and tangled threads.
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

Hi,

Ok I have CAN functionality of some form running in my tasks.
Initializing seems to be successful and I have written some kind of
wrapper to create a can_write() function of my own which also seems to
be -kind of-  working. I have one question and one problem.

I keep on getting this compile warning

In file included from /mnt/appusb/xenomai/include/rtdm/rtcan.h:250,
                 from cancom.cpp:15:
/mnt/appusb/xenomai/include/rtdm/rtdm.h: In function `ssize_t
rt_dev_sendto(int, const void*, size_t, int, const sockaddr*,
socklen_t)':
/mnt/appusb/xenomai/include/rtdm/rtdm.h:323: warning: missing
initializer for member `msghdr::msg_flags'

Its in rtdm.h so I have not looked closely at it yet but I presume I
must be doing something wrong to be getting it?


The problem I have is that I test my code by running rtcanrecv on
rtcan0 while my application also sends on rtcan0.

What happens is that one of the two real-time tasks does not start up.
If I am lucky the one (task1) calling can_write() starts up and then
the messages come through to rtcanrecv. Great. But if I am less lucky
then task 2 runs happily and task1  does nothing. Nothing is received
on rtcanrecv.

If rtcanrecv is not running then my application has no problems. I can
see that it is writing by reading out /proc/rtcan/rtcan0/info looking
at TxCount.

I call can_write() directly after rt_task_wait_period so i did not
think it necessary to use rt_task_shadow or such like in it.
Can_write is implemented in a separate .cpp file to the one in which
it is called. Can this cause memory faults? Must I use mlockall in
can_write() or something?


Thanks for the time.


Kind regards,

Roland.

