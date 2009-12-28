Message-ID: <352932.35036.qm@domain.hid>
Date: Mon, 28 Dec 2009 01:59:41 -0800 (PST)
From: Yigal Goldberger <yigal_gold@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: [Xenomai-help] signaling to a thread waiting on an event in the
	kernel
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

I want to have the ability to restart a process at all times.
I have a situation where a thread is waiting on an event in the kernel with : 
rtdm_event_timedwait(&args,0,NULL)  - infinite wait (I need this infinite wait ...) 

and I cannot restart it with  :

kill(Pid,SIGTERM) .

from a different process .

Suggestions are most welcome.

Yigal Goldberger.




      

