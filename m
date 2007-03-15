Date: Thu, 15 Mar 2007 19:34:52 +0100
Message-Id: <451485795@domain.hid>
MIME-Version: 1.0
From: Jochen Behnke <JK.Behnke@domain.hid>
Subject: Re: [Xenomai-help] App with pthreads using rt_task_shadow locks up
Content-Type: text/plain; charset=iso-8859-15
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
To: rpm@xenomai.org
Cc: xenomai@xenomai.org

Hello Philippe,

thanks for your response.

> On Thu, 2007-03-15 at 17:17 +0100, Jochen Behnke wrote:
> > Hello,
> > 
> > after hours of searching, I have finally found the problem. 
> > It was a bug in my "SimpleRPC" library. The thread function, responsible for the "lockup", mainly constists of an endless loop ( while(pObj->nRun) ) that polls a request queue. This was not a problem as long as this thread was a standard pthread. Turning this thread into a real-time task by adding a call to rt_task_shadow at the beginning of the thread function (before the while loop) resulted in a frozen linux system.
> > 
> > I used to work with the following system
> > Gentoo Linux
> > Linux Kernel 2.6.17 (IPIPE 1.4)
> > Xenomai 2.2.3
> > 
> > Now that I know, that upgrading to Xenomai 2.3.0 is not a problem, I plan to upgrade to the 2.3.x branch.
> > 
> 
> You may detect such kind of issues switching on the
> CONFIG_XENO_OPT_WATCHDOG option in the kernel configuration. Normally,
> this would pull the brake after more than 4 seconds of uninterrupted
> real-time activity in primary mode (i.e. without yielding control to the
> regular Linux activities).

That's great. I will check this out.

BTW, is there an easy way, other than reboot,  to release xenomai ressources (mutexes,...) that have not been freed after an application crash ? 

Thanks in advance.

Jochen


> 
> > 
> > Regards
> > 
> > Jochen
> > 
> > 
> > > 
> > > Hello Gilles,
> > > 
> > > > Jochen Behnke wrote:
> > > > > Hello Gilles,
> > > > > 
> > > > > thanks for your response. 
> > > > > At the moment I try to cut down my application to the minimum.
> > > > > I also will install the latest version of the xenomai 2.2.x branch (2.2.5) and check whether I can reproduce the fault.  As I noticed that some functions have been changed (rt_mutex_lock/unlock no longer exist in Xenomai 2.3.x, they obviously have been renamed for some reason) I would rather stick to the 2.2.x branch. Is that reasonable in your opinion ?
> > > > > Will the 2.2.x branch be maintained in the future ?
> > > > > 
> > > > > Thanks again.
> > > > > 
> > > > > Jochen
> > > > 
> > > > Please do not forget to CC the list.
> > > I'm sorry. I just used the wrong reply button.
> > > 
> > > > 
> > > > rt_mutex_lock/rt_mutex_unlock were renamed
> > > > rt_mutex_acquire/rt_mutex_release to avoid a conflict, as documented in
> > > > API.CHANGES
> > > I will have a look at this.
> > > 
> > > > 
> > > > Please try with Xenomai 2.3.0, or better with trunk. The aim of this
> > > > check is for us to avoid chasing bugs that were already solved. For
> > > > example if you are using fork() in your application, only I-pipe patches
> > > > in the trunk will solve your problem.
> > > At the moment I don't use fork() but I can try using 2.3.x.
> > > I hope that I don't have to change too much code on my side.
> > > 
> > > As soon as I have results, I'll post them here.
> > > 
> > > Jochen
> > > 
> > > 
> > > _______________________________________________
> > > Xenomai-help mailing list
> > > Xenomai-help@domain.hid
> > > https://mail.gna.org/listinfo/xenomai-help
> > > 
> > 
> > _______________________________________________
> > Xenomai-help mailing list
> > Xenomai-help@domain.hid
> > https://mail.gna.org/listinfo/xenomai-help
> -- 
> Philippe.

_____________________________________________________________________
Der WEB.DE SmartSurfer hilft bis zu 70% Ihrer Onlinekosten zu sparen!
http://smartsurfer.web.de/?mc=100071&distributionid=000000000066


