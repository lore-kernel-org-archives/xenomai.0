Message-Id: <30BB8CC3-2A26-47D0-AB58-323057C5756E@comcast.net>
From: Steven Seeger <steven.seeger@domain.hid>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Mime-Version: 1.0 (Apple Message framework v930.3)
Date: Tue, 24 Mar 2009 18:15:12 -0400
Subject: [Xenomai-core] tsc/ticks question
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

rt_task_set_periodic() says the period parameter is expressed in clock  
ticks.

We have tsc being used as clockdev now, while pit is timerdev. We are  
getting -EINVAL from all these routines.

/proc/xenomai/latency is 4200

I notice that in module.c, nklatency is printed with  
xnarch_tsc_to_ns(nklatency) so it seems that nklatency is stored in  
tsc. However, because I'm using ns2ticks for my function call (which  
per the documention should be in clock ticks) it fails because our  
ticks are 320.

Just pointing this out.

Steven


