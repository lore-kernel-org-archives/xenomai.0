From: Tobias Marschall <tmarscha@domain.hid>
Date: Fri, 21 Apr 2006 17:11:44 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604211711.44211.tmarscha@domain.hid>
Subject: [Xenomai-help] some questions about alarms
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

Hello,

my application needs (besides doing some other stuff) to set some output 
signals on an interface card at specific points in time. I think such a 
simple thing doesn't deserve its own thread and am considering to use alarms 
for this.

Is it correct that the handler of an alarm is executed with the same priority 
as the thread that created it? Meaning that the alarm execution will be 
delayed if a higher-priority (primary mode) thread is running at the time the 
alarm expires?

In my case it would be most convenient to be able to program an alarm timer 
using an absolute time (date). I didn't find such a function in the API 
documentation (native skin). Is the absense of such a function intended or 
did simply nobody implement it? Is it possible to implement such a function 
by just modifying the native skin?

But perhaps there is a better way to solve my issue. Is there any "best 
practice" for my problem? By now I see to possibilities: 1) Use a 
rt_timer_read in connection with alarms. 2) Spawn a whole thread and use 
rt_task_sleep_until.

Any Ideas?

Best regards and thanks in advance,
Tobias

