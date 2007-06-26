From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <467FBC67.8030805@domain.hid>
References: <467FBC67.8030805@domain.hid>
Content-Type: text/plain
Date: Tue, 26 Jun 2007 09:26:39 +0200
Message-Id: <1182842799.18525.9.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-help] Xenomai and mlockall
Reply-To: rpm@xenomai.org
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Johan Borkhuis <j.borkhuis@domain.hid>
Cc: Xenomai-help@domain.hid

On Mon, 2007-06-25 at 15:00 +0200, Johan Borkhuis wrote:
> I am trying to run my Xenomai application as non-root. I disabled 
> XENO_OPT_SECURITY_ACCESS to allow non-root users to run Xenomai 
> applications. However, this causes my application to exit with the error:
> 
> Xenomai: process memory not locked (missing mlockall?)
> 
> Is there a way to avoid this error? I am running on an embedded system 
> without swap and without disk, so there is no real need for mlock or 
> mlockall.
> 

swap is not the only source of page faults, ondemand application/library
loading is another one.

> Is there a way to "tweak" the CAP_IPC_LOCK capability of the system or 
> the task so that I can run mlockall call, or is there a way to disable 
> this check on Xenomai?

No way to disable it, since doing so would basically make your system
dysfunctional by risking page faults while not running over a regular
Linux context (i.e. Xenomai's primary domain).

IOW, you do want mlockall() to be in effect for Xenomai apps.

Hint: If you think some process is overconsuming locked memory, you may
want to have a look at /proc/<pid>/maps for the process in question, and
check the size of the various segments listed there, and especially the
stack related one.

> 
> Kind regards,
>     Johan Borkhuis
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
-- 
Philippe.



