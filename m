Message-ID: <4887020A.9060700@domain.hid>
Date: Wed, 23 Jul 2008 12:03:54 +0200
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-help] Thread policy and priority in secondary mode
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai-help <xenomai@xenomai.org>

Hello,

when a Xenomai POSIX thread switches to secondary mode, how can I define 
the policy and priority under which it should run under the Linux 
scheduler, especially, with SCHED_FIFO.

The Xenomai POSIX API function pthread_setschedparam() described in

http://www.xenomai.org/documentation/trunk/html/api/group__posix__sched.html#g95276f88e1a2cae7a37f792123a99144

does switch the thread to primary mode when the SCHED_FIFO policy is 
specified and therefore cannot be use for the secondary mode.

Wolfgang.

