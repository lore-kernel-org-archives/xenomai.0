Message-ID: <4718C00B.9040607@domain.hid>
Date: Fri, 19 Oct 2007 16:32:43 +0200
From: Johan Borkhuis <j.borkhuis@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-help] Replacement of taskDelay(0) call
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Xenomai help <xenomai@xenomai.org>


When using VxWorks we used "taskDelay(0)" to invoke the scheduler. 
Within Xenomai this call was translated into "rt_task_yield()". However, 
when using a number of tasks at the same priority using this mechanism 
the watchdog timeout kicks in and kills the Xenomai task(s). This also 
happens when a rt_task_sleep is used with a delay < 100 usec.

Is there a possibility to trigger the watchdog to avoid the killing of 
the tasks?

Kind regards,
    Johan Borkhuis


