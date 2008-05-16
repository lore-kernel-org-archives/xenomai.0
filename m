Message-ID: <482DBABA.9010408@domain.hid>
Date: Fri, 16 May 2008 12:47:54 -0400
From: Tomas Kalibera <kalibera@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-help] runaway secondary tasks lock up
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

I've noticed an interesting difference regarding primary and secondary 
domain runaway tasks. The primary domain ones are detected by Xenomai 
watchdog and terminated. The secondary domain ones are not terminated, 
but cause a system lockup, because a secondary domain task is always run 
in preference of other tasks  (kernel complains by  BUG: soft lockup - 
CPU#0 stuck for 11s!). Would there be a way to also detect the secondary 
domain runaway threads ? Since the kernel itself can do it, it should be 
possible, right ?

Now, I've discovered that if I assign the secondary domain task priority 
0, it would not lock up the system. 1 would, 99 would as well. What is 
the semantics ? Any secondary domain task with priority above zero runs 
in preference of any (non-Xenomai) Linux thread ?

And asking from the other end, how to write polling (secondary domain) 
applications in Xenomai ? Should it have priority 0 ?

Thanks,
Tomas



