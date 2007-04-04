Subject: Re: [Xenomai-help] Preemptive scheduling
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <20070403205554.107880@domain.hid>
References: <20070328203115.190280@domain.hid>
	<17930.56329.893396.220621@domain.hid>
	<20070329031758.125210@domain.hid> <460B7CE0.60107@domain.hid>
	<20070403200539.126240@domain.hid> <1175631875.22950.72.camel@domain.hid>
	<20070403205554.107880@domain.hid>
Content-Type: text/plain
Date: Wed, 04 Apr 2007 10:17:33 +0200
Message-Id: <1175674653.4666.9.camel@domain.hid>
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

On Tue, 2007-04-03 at 22:55 +0200, Jack Whorn wrote:
> Hi Philippe,
> 
> thank you for this suggestion!
> 
> You are right, I`m  still using version 2.3. This is due to some adjustments I have made in the Xenomai
>  Sources which prevent me from simply overwriting the old files.
> 
> I have just locked at the source-code, the only occasion I use T_LOCK is in the rt_task_set_mode() call,
>  used as the first argument (clear mask!). So there should not be a T_LOCK at all.
> 
> Nevertheless, if anybody could provide me with the appropriate positions in Xenomai`s source code,
>  I might apply this bugfix manually and find out whether the problem is solved this way.
> 

Changeset r2092 introduced the sleeping scheduler lock for v2.3.x.

> Thank you very much,
> 
> Jack
> 
> 
> -------- Original-Nachricht --------
> Datum: Tue, 03 Apr 2007 22:24:35 +0200
> Von: Philippe Gerum <rpm@xenomai.org>
> An: Jack Whorn <jackwhorn@domain.hid>
> CC: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>, xenomai@xenomai.org
> Betreff: Re: [Xenomai-help] Preemptive scheduling
> 
> > On Tue, 2007-04-03 at 22:05 +0200, Jack Whorn wrote:
> > > Hi Gilles, Hi folks,
> > > 
> > > The data is stored by a thread that periodically issues a single call to
> > > rt_task_set_mode(0, T_PRIMARY, NULL) followed by several file operation
> > calls like fprintf() and finally a call to fflush(NULL) and sync().
> > > 
> > > The application is not a kernel module, so - as far as I see it - it is
> > a user mode thread, and it actually has the highest priority in my system.
> > > 
> > > Does this help understanding the phenomenon?
> > > 
> > 
> > This whole thing reminds me of an issue involving T_LOCK that existed
> > for any version earlier than 2.3.1. The way the scheduler lock (i.e.
> > T_LOCK) was managed at that time would cause unexpectable results (aka
> > "utter mess") to happen whenever a scheduler lock holder thread switches
> > to secondary mode, and thinking about it, this would surely cause a
> > lockup due to a scheduling wreckage. This has been fixed on January 30,
> > by allowing the currently running thread which holds the scheduler lock
> > to sleep.
> > 
> > You may want to try 2.3.1 to check this.
> > 
> > -- 
> > Philippe.
> > 
> 
-- 
Philippe.



