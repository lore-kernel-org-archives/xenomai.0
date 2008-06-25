Content-Type: text/plain; charset="us-ascii"
Date: Wed, 25 Jun 2008 17:49:36 +0200
From: "Karl Reichert" <Karl-Trampe@domain.hid>
Message-ID: <20080625154936.18590@domain.hid>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-help] Problems with Threads and RTnet
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
Cc: RTnet-users@domain.hid

Hello list,

I have some problems with RTnet and threads. I create two thread via rt_task_spawn(), one is sending and one is receiving (non-blocking) frames over rtnet.

Each task is existed with return (I also tried rt_task_delete()) and the main-function is waiting for task-termination via rt_task_join().

When I run this program the first time, everything is fine. When I run it a second time without rebooting, I can't receive any more frames (returnvalue -1).

So it seems that the termination of the tasks and the main-function from the first run failed to free the "RTnet resources", too.

Any idea, what I'am doing wrong?

Thanks in advance
(... and good luck to the german team, for all the soccer fans out there)
Karl
-- 
von Karl Reichert


