Date: Fri, 29 Apr 2016 23:29:55 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20160429212955.GB1781@hermes.click-hack.org>
References: <57226422.2010707@mitre.org>
 <20160429195415.GQ1881@hermes.click-hack.org>
 <5723CD41.4070809@mitre.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5723CD41.4070809@mitre.org>
Subject: Re: [Xenomai] Clarification on EINTR with wrapped select call.
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jeffrey Melville <jmelville@mitre.org>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On Fri, Apr 29, 2016 at 05:08:17PM -0400, Jeffrey Melville wrote:
> On 4/29/2016 3:54 PM, Gilles Chanteperdrix wrote:
> > On Thu, Apr 28, 2016 at 03:27:30PM -0400, Jeffrey Melville wrote:
> >> Hi,
> >>
> >> I wanted to clarify the expected behavior that would cause a wrapped
> >> select() call to return EINTR when using the POSIX skin.
> >>
> >> I'm running Xenomai 2.6.4 (actually 2.6 git rev 4f349cf0553, with a99426
> >> cherry-picked) with kernel 3.14.17 on a Zynq and the POSIX skin.
> >>
> >> We have a real-time thread (SCHED_FIFO, nonzero priority) that
> >> frequently calls (wrapped) select() on a normal Linux UDP socket. We've
> >> noticed that sometimes, when data is available on the socket, the call
> >> to select will return -1 with errno EINTR. There is no other evidence in
> >> the user application that a signal occurred. I suspect that it may be
> >> related to SIGWINCH/SIGHARDEN but I don't know how this works in much
> >> detail. I haven't been able to confirm this theory yet either. I see
> >> that select does not have to respect SA_RESTART.
> >>
> >> With that in mind:
> >> 1. Is it expected that a wrapped select() call returns EINTR during
> >> normal mode transitions? It doesn't seem right to me.
> > 
> > Well, first, calling the wrapped select on plain linux descriptors
> > is kind of stupid: Xenomai core will migrate the task to primary
> 
> I guess that's fair. In reality, the task is calling into a library
> function for a library that we also link against Xenomai in this case.
> The library is used on non-Xenomai systems (for different applications)
> as well and I have tried to minimize the number of ifdefs, leaving plain
> 'select' etc. calls until I have a need to change it.
> 
> > mode, in order to execute the syscall, which will say "there is a
> > linux file descriptor in that set, let us handle it with plain linux
> > syscall", so the wrapped select call will call the plain linux
> > select syscall which will cause the thread to switch to secondary
> 
> I didn't realize it always caused two mode switches until I looked at
> the code further. I figured that the detection of plain Linux fds
> happened in the userspace __wrap_select. Is that impossible because
> userspace doesn't know where RTDM fds start?

__wrap_select being called for plain linux threads is kind of a
corner case, not the main use of __wrap_select, so the check is made
in kernel space in such a way that it can be avoided in the "normal"
case when __wrap_select is called with only file descriptors which
have already been checked. I did not see any way to make the same
thing in user-space.

> 
> > mode (and get a SIGDEBUG signal if it has enabled PTHREAD_WARNSW).
> > Second, EINTR is very much likely returned by the 
> > plain linux select syscall, and not by Xenomai syscall. Third, is
> > not it because you have enabled PTHREAD_WARNSW on that thread?
> 
> I agree that EINTR is most likely being returned by the Linux select
> syscall, but am not entirely clear where the signal is coming from.
> PTHREAD_WARNSW is not enabled on this thread.

You can try and play with pselect, in order to find what value of
pselect signal mask does not cause EINTR to be emitted. Or a more
direct way would be to use the I-pipe tracer and cause a trace
freeze when select returns -EINTR.

-- 
					    Gilles.
https://click-hack.org

