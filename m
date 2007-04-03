Content-Type: text/plain; charset="us-ascii"
Date: Tue, 03 Apr 2007 22:05:39 +0200
From: "Jack Whorn" <jackwhorn@domain.hid>
In-Reply-To: <460B7CE0.60107@domain.hid>
Message-ID: <20070403200539.126240@domain.hid>
MIME-Version: 1.0
References: <20070328203115.190280@domain.hid>
	<17930.56329.893396.220621@domain.hid>
	<20070329031758.125210@domain.hid> <460B7CE0.60107@domain.hid>
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
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

Hi Gilles, Hi folks,

The data is stored by a thread that periodically issues a single call to
rt_task_set_mode(0, T_PRIMARY, NULL) followed by several file operation calls like fprintf() and finally a call to fflush(NULL) and sync().

The application is not a kernel module, so - as far as I see it - it is a user mode thread, and it actually has the highest priority in my system.

Does this help understanding the phenomenon?

Regards,

Jack

> Jack Whorn wrote:
> > Hi Gilles,
> > 
> > 
> >>Once your program enters this infinte loop, it never gets out, so :
> >>- your assumption that "t_task_set_mode periodically clears T_LOCK and
> >>  T_SHIELD and sets T_RRB" is false;
> > 
> > 
> > Yeah, I just realized that it does this only once. According to
> http://snail.fsffrance.org/www.xenomai.org/documentation/branches/v2.0.x/html/api/group__task.html#ga44But
> I think that the arguments used in the rt_task_set_mode() -call are
> correct. Isn't that sufficient for the Linux OS to catch e.g. keyboard
> interrupts?
> > 
> > 
> >>- even if higher priority task runs, Linux, which is Xenomai idle task
> >>  never runs, so the system locks up.
> > 
> > 
> > Gotcha, that sounds sensible to me.
> > 
> > Actually, the higher-priority task uses some linux-system calls to store
> data to hard disk. This does no longer take place as soon as the infinite
> loop is entered. I expected priority coupling to solve that. Where is my
> error in reasoning?
> 
> Maybe storing data to the disk requires a kernel thread to flush them.
> If this thread never has a chance to run, then your data are written in
> the cache but never flushed to the disk. I may be wrong, but I am almost
> sure that if you let Linux run, everything will go as expected.
> 
> If I am wrong, please, send us a self-contained example program which
> demonstrates the behaviour you observed.
> 
> -- 
>                                                  Gilles Chanteperdrix

-- 
"Feel free" - 10 GB Mailbox, 100 FreeSMS/Monat ...
Jetzt GMX TopMail testen: http://www.gmx.net/de/go/topmail

