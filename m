From: Jeff Weber <jweber@domain.hid>
Content-Type: text/plain
Date: Mon, 09 Oct 2006 11:38:57 -0500
Message-Id: <1160411937.6268.14.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-help] 3rd party task mode switches and inquiries
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Xenomai <xenomai@xenomai.org>

I have a need for task t1 to switch task t2 to and from primary mode,
using the native API.  The rt_task_set_mode() API does not have an
argument for the target task, and assumes the current task.  How can I
initiate a 3rd party task mode switch?

On a related note, the task info returned from rt_task_inquire() does
not indicate task mode switches in the corresponding T_PRIMARY (0x200)
bit, which is the bit used to command the mode switch.  However, a mode
switch can be seen in the 0x100 status bit, which corresponds to the
XNRELAX bit, (not in the public native/task.h API).  What's the best way
to inquire if an arbitrary task is in primary or secondary mode?

I am using Xenomai-2.2.0.

thanks,
	Jeff Weber


