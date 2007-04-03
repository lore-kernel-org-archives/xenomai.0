Subject: Re: [Xenomai-help] Preemptive scheduling
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <20070403200539.126240@domain.hid>
References: <20070328203115.190280@domain.hid>
	<17930.56329.893396.220621@domain.hid>
	<20070329031758.125210@domain.hid> <460B7CE0.60107@domain.hid>
	<20070403200539.126240@domain.hid>
Content-Type: text/plain
Date: Tue, 03 Apr 2007 22:24:35 +0200
Message-Id: <1175631875.22950.72.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
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
To: Jack Whorn <jackwhorn@domain.hid>
Cc: xenomai@xenomai.org

On Tue, 2007-04-03 at 22:05 +0200, Jack Whorn wrote:
> Hi Gilles, Hi folks,
> 
> The data is stored by a thread that periodically issues a single call to
> rt_task_set_mode(0, T_PRIMARY, NULL) followed by several file operation calls like fprintf() and finally a call to fflush(NULL) and sync().
> 
> The application is not a kernel module, so - as far as I see it - it is a user mode thread, and it actually has the highest priority in my system.
> 
> Does this help understanding the phenomenon?
> 

This whole thing reminds me of an issue involving T_LOCK that existed
for any version earlier than 2.3.1. The way the scheduler lock (i.e.
T_LOCK) was managed at that time would cause unexpectable results (aka
"utter mess") to happen whenever a scheduler lock holder thread switches
to secondary mode, and thinking about it, this would surely cause a
lockup due to a scheduling wreckage. This has been fixed on January 30,
by allowing the currently running thread which holds the scheduler lock
to sleep.

You may want to try 2.3.1 to check this.

-- 
Philippe.



