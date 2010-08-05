Date: Thu, 5 Aug 2010 16:51:11 +0200
From: Tschaeche IT-Services <services@domain.hid>
Message-ID: <20100805145111.GB22855@domain.hid>
References: <20100511142653.GA22374@domain.hid>
	<4BE983C0.9010909@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4BE983C0.9010909@domain.hid>
Subject: [Xenomai-help] Forcing a task to run in secondary mode if no RT
	resources are acquired
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

Hi,

On Tue, May 11, 2010 at 06:20:16PM +0200, Jan Kiszka wrote:
> > 1. When Cyclic-/Background-task acquires an RT-mutex it migrates
> >    from Linux to Xenomai scheduler. When releasing the mutex,
> >    the task should be forced to migrate back to Linux scheduler.
> > 
> >    How to achieve that?
> > 
> >    By calling Linux-Syscall getpid()?
> 
> That's the workaround for now, true solution is not yet available
> (Philippe is on it).
> > 
> >    Is there a Xenomai flag (rt_task_set_mode()) doing that automatically,
> >    after all RT-resources are released? Which version 2.4.10/2.5.x?
> > 
> >    Do we have to use the patch mentioned in the thread?
> 
> That patch is targeting the (now unsupported) 2.4 series. The official
> solution will be for 2.5.x or some 2.6.x.

What we need is a background task running in secondary domain which is able to claim
rt-resources (e.g. xenomai mutices, for synchonisation with RT tasks sending data).
While it's holding maybe multiple resources it should run in primary domain, but when releasing
the last rt resource it should automatically migrate back to secondary domain.

At the moment our solution for that problem would be to hook into each claim/release
function of Xenomai, add a list management to monitor the release of the last resource,
and, if the task does not hold any resource anymore, call a Linux syscall to force migration
to Linux domain.

We would appreciate a proper solution into Xenomai, since Xenomai seems to do
the same in the kernel structures. If we decide to start to patch Xenomai,
we would like to have our changes integrated into Xenomai.
Can you give us a hint to docs for a good starting point (apart from the patch
mentioned above)?

Regards,

	Olli

