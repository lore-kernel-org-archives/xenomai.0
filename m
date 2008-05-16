MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <18477.50111.565572.591277@domain.hid>
Date: Fri, 16 May 2008 19:26:23 +0200
In-Reply-To: <482DBABA.9010408@domain.hid>
References: <482DBABA.9010408@domain.hid>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Subject: Re: [Xenomai-help] runaway secondary tasks lock up
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Tomas Kalibera <kalibera@domain.hid>
Cc: xenomai@xenomai.org

Tomas Kalibera wrote:
 > 
 > Hi,
 > 
 > I've noticed an interesting difference regarding primary and secondary 
 > domain runaway tasks. The primary domain ones are detected by Xenomai 
 > watchdog and terminated. The secondary domain ones are not terminated, 
 > but cause a system lockup, because a secondary domain task is always run 
 > in preference of other tasks  (kernel complains by  BUG: soft lockup - 
 > CPU#0 stuck for 11s!). Would there be a way to also detect the secondary 
 > domain runaway threads ? Since the kernel itself can do it, it should be 
 > possible, right ?

Yes, but if the Linux kernel does it, why would Xenomai reinvent the wheel ?

 > 
 > Now, I've discovered that if I assign the secondary domain task priority 
 > 0, it would not lock up the system. 1 would, 99 would as well. What is 
 > the semantics ? Any secondary domain task with priority above zero runs 
 > in preference of any (non-Xenomai) Linux thread ?

This is not related to Xenomai, that is the semantic of SCHED_FIFO, also
called fixed priority scheduling.

 > 
 > And asking from the other end, how to write polling (secondary domain) 
 > applications in Xenomai ? Should it have priority 0 ?

The best way to write polling applications with Xenomai is not to write
polling applications at all. Polling makes your processor burning hot,
does not scale well, and is a really poor programming style, really.

-- 


					    Gilles.

