MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <18477.53751.771867.378280@domain.hid>
Date: Fri, 16 May 2008 20:27:03 +0200
In-Reply-To: <482DCA2F.9010609@domain.hid>
References: <482DBABA.9010408@domain.hid>
	<18477.50111.565572.591277@domain.hid>
	<482DCA2F.9010609@domain.hid>
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
 > Gilles Chanteperdrix wrote:
 > > Tomas Kalibera wrote:
 > >  > 
 > >  > Hi,
 > >  > 
 > >  > I've noticed an interesting difference regarding primary and secondary 
 > >  > domain runaway tasks. The primary domain ones are detected by Xenomai 
 > >  > watchdog and terminated. The secondary domain ones are not terminated, 
 > >  > but cause a system lockup, because a secondary domain task is always run 
 > >  > in preference of other tasks  (kernel complains by  BUG: soft lockup - 
 > >  > CPU#0 stuck for 11s!). Would there be a way to also detect the secondary 
 > >  > domain runaway threads ? Since the kernel itself can do it, it should be 
 > >  > possible, right ?
 > >
 > > Yes, but if the Linux kernel does it, why would Xenomai reinvent the wheel ?
 > >   
 > Because the wheels behave differently. Xenomai watchdog kills the app 
 > after 4 seconds, kernel just writes a message. This is not nice for 
 > debugging large Xenomai applications. You add a debug printf somewhere 
 > and it makes the system freeze because it switches to secondary domain.  
 > And when the application just does not have full control over when it 
 > runs in primary or secondary domain (i.e. a JVM), this is  somewhat 
 > painful.

I would say the best thing to do then, is to patch the Linux soft-lockup
detector. It will probably be much easier than re-implemeting the whole
thing in Xenomai. And it may even be useful to other people not using
Xenomai.

 > >  > 
 > >  > Now, I've discovered that if I assign the secondary domain task priority 
 > >  > 0, it would not lock up the system. 1 would, 99 would as well. What is 
 > >  > the semantics ? Any secondary domain task with priority above zero runs 
 > >  > in preference of any (non-Xenomai) Linux thread ?
 > >
 > > This is not related to Xenomai, that is the semantic of SCHED_FIFO, also
 > > called fixed priority scheduling.
 > >   
 > Thank you for explaining this. It would be nice if the Xenomai API 
 > documentation could say that the priorities are directly mapped to Linux 
 > priorities and that SCHED_FIFO is used.

I think it is explained in the articles "Life with Adeos" and "Native API
tour".

-- 


					    Gilles.

