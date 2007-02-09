Message-ID: <45CCCD10.9000008@domain.hid>
Date: Fri, 09 Feb 2007 21:35:44 +0200
From: Maksym Veremeyenko <verem@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=KOI8-U; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-help] Strange deadlock.
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Xenomai-help@domain.hid

Hi!

I found dead lock in my program and looking for reason, but i found 
something strange. Is possible mutex state looks like:
[root@domain.hid /]# cat /proc/xenomai/registry/native/mutexes/coll_VDCP_1
=locked by bus_monitor_proc[0] depth=1
+vdcp[0030]m
+bus_monitor_proc[0]

seems bus_monitor_proc[0] locked mutex and want to lock again but its 
blocked.  (i still looking for stack corruption point, but no success.) 
It have the same behavior on two configuration 2.6.17.4 + 2.2.4 and 
2.6.19.2 + 2.3.0 + 1.7-01
i checked with GDB - two task are wating for mutex.
All task perform switching to secondary mode.


Also have a questions:

1. On program start after previous crash i unable to create named mutex, 
because it [-EEXIST], after bind it's unable to operate with it because 
it locked by task from early died program, i have to restart computer. 
Any suggestions?

2. Does exist API function to detect mutex owner?



-- 
________________________________________
Maksym Veremeyenko


