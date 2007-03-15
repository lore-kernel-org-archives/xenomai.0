Subject: Re: [Xenomai-help] App with pthreads using rt_task_shadow locks up
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <451485795@domain.hid>
References: <451485795@domain.hid>
Content-Type: text/plain
Date: Thu, 15 Mar 2007 19:51:52 +0100
Message-Id: <1173984712.8193.53.camel@domain.hid>
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
To: Jochen Behnke <JK.Behnke@domain.hid>
Cc: xenomai@xenomai.org

On Thu, 2007-03-15 at 19:34 +0100, Jochen Behnke wrote:
> Hello Philippe,
> 
> thanks for your response.
> 
> > On Thu, 2007-03-15 at 17:17 +0100, Jochen Behnke wrote:
> > > Hello,
> > > 
> > > after hours of searching, I have finally found the problem. 
> > > It was a bug in my "SimpleRPC" library. The thread function, responsible for the "lockup", mainly constists of an endless loop ( while(pObj->nRun) ) that polls a request queue. This was not a problem as long as this thread was a standard pthread. Turning this thread into a real-time task by adding a call to rt_task_shadow at the beginning of the thread function (before the while loop) resulted in a frozen linux system.
> > > 
> > > I used to work with the following system
> > > Gentoo Linux
> > > Linux Kernel 2.6.17 (IPIPE 1.4)
> > > Xenomai 2.2.3
> > > 
> > > Now that I know, that upgrading to Xenomai 2.3.0 is not a problem, I plan to upgrade to the 2.3.x branch.
> > > 
> > 
> > You may detect such kind of issues switching on the
> > CONFIG_XENO_OPT_WATCHDOG option in the kernel configuration. Normally,
> > this would pull the brake after more than 4 seconds of uninterrupted
> > real-time activity in primary mode (i.e. without yielding control to the
> > regular Linux activities).
> 
> That's great. I will check this out.
> 
> BTW, is there an easy way, other than reboot,  to release xenomai ressources (mutexes,...) that have not been freed after an application crash ? 
> 

This depends on the skin being used. The native one does not free the
resources upon application exit yet (this feature is on the todo list
for the upcoming 2.4 though), OTOH the POSIX skin does. A work-around
with the native skin is to use constructs like the following one in your
app to recycle the left overs; not pretty, but works, until we provide
an automated support:

if (rt_mutex_bind("some_mutex", &mutex_desc, ...) == 0) {
	rt_mutex_delete(&mutex_desc);
}
err = rt_mutex_create("some_mutex", &mutex_desc);

-- 
Philippe.



