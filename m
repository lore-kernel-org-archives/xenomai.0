Date: Tue, 14 Jun 2016 22:35:41 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20160614203541.GK23680@hermes.click-hack.org>
References: <5734D4B9.4070900@xenomai.org> <5734D92F.1000206@siemens.com>
 <57350331.1020302@xenomai.org> <57356C0E.6080205@siemens.com>
 <5735D8E0.3040202@xenomai.org> <5735F39A.8050204@siemens.com>
 <57601E35.3010101@siemens.com>
 <5a98b862-5b1f-449c-8989-f7e3d4fe8255@xenomai.org>
 <57603B1C.6070301@siemens.com>
 <20385615-283a-9d68-0203-a2a834d0b97f@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20385615-283a-9d68-0203-a2a834d0b97f@xenomai.org>
Subject: Re: [Xenomai] RTDM syscalls & switching
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, Xenomai <xenomai@xenomai.org>

On Tue, Jun 14, 2016 at 10:11:30PM +0200, Philippe Gerum wrote:
> On 06/14/2016 07:13 PM, Jan Kiszka wrote:
> > On 2016-06-14 17:23, Philippe Gerum wrote:
> >> Restoring the original behavior unconditionally would not be a fix but
> >> only a work-around for your own issue. Finding a better way acceptable
> >> to all parties is on my todo list for the upcoming 3.0.3.
> > 
> > An alternative design to a plain revert of the current->conforming
> > switch could be to enhance conforming to take the scheduling class into
> > account: SCHED_WEAK and SCHED_OTHER should have a NRT as conforming
> > domain while real-time scheduling classes obviously target RT. But I
> > didn't check yet what side effects that may have, nor if there could be
> > relevant impact on syscall performance (unlikely, though).
> > 
> 
> That would not make more sense: SCHED_WEAK/OTHER is about having
> _Xenomai_ threads interfacing with the _Xenomai_ system, without
> competing with real-time threads priority-wise. But this is still about
> running Xenomai services, for synchronizing on real-time events or
> receiving messages from the real-time side. Basically, this requires to
> run from primary mode.
> 
> We need a scheme that:
> 
> - does not allow user-space to select the RTDM handler being called only
> by manipulating its runtime mode, because this would certainly lead to a
> massive mess for the application.
> 
> - does not ask the driver to deal with mode detection on each and every
> (ioctl) request it implements. With the conforming mode applicable to
> all RTDM I/O calls, only the _rt side should return ENOSYS to hand over
> some requests to the nrt side. When a request cannot be processed from
> nrt, then we know the request is wrong/invalid, returning ENOSYS makes
> no sense.
> 
> - possibly restrict the former "current" behavior to some ioctl() calls,
> as specified by the driver, not decided by the application.

I am not sure I have already proposed that, but I am going to try,
sorry if this is the second time. Since RTDM file descriptors are
plain Linux file descriptors, could not the ioctl callback of these
plain linux file descriptors give access to the ioctl_nrt RTDM
callback? This way, in the case which is a problem for Jan, he could
call __real_ioctl and be done with it.

The fact that __real is not portable is not really an issue, you can
wrap that in a macro that adds __real or not like the __RT macro
does.

-- 
					    Gilles.
https://click-hack.org

