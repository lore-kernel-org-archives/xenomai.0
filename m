Content-Type: text/plain; charset="us-ascii"
Date: Thu, 29 Mar 2007 05:17:58 +0200
From: "Jack Whorn" <jackwhorn@domain.hid>
In-Reply-To: <17930.56329.893396.220621@domain.hid>
Message-ID: <20070329031758.125210@domain.hid>
MIME-Version: 1.0
References: <20070328203115.190280@domain.hid>
	<17930.56329.893396.220621@domain.hid>
Subject: Re: [Xenomai-help] Preemptive scheduling
Content-Transfer-Encoding: 7bit
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>

Hi Gilles,

> Once your program enters this infinte loop, it never gets out, so :
> - your assumption that "t_task_set_mode periodically clears T_LOCK and
>   T_SHIELD and sets T_RRB" is false;

Yeah, I just realized that it does this only once. According to http://snail.fsffrance.org/www.xenomai.org/documentation/branches/v2.0.x/html/api/group__task.html#ga44But I think that the arguments used in the rt_task_set_mode() -call are correct. Isn't that sufficient for the Linux OS to catch e.g. keyboard interrupts?

> - even if higher priority task runs, Linux, which is Xenomai idle task
>   never runs, so the system locks up.

Gotcha, that sounds sensible to me.

Actually, the higher-priority task uses some linux-system calls to store data to hard disk. This does no longer take place as soon as the infinite loop is entered. I expected priority coupling to solve that. Where is my error in reasoning?

> In short, maybe you have observed some scheduling problems, but your
> example does not demonstrate them. Such misuse of Xenomai should be
> caught by the watchdog, if you enable it.

I might try that watchdog, thanks for this hint!

Regards,

Jack
-- 
"Feel free" - 5 GB Mailbox, 50 FreeSMS/Monat ...
Jetzt GMX ProMail testen: http://www.gmx.net/de/go/promail

