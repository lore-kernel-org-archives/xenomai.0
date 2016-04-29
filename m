Date: Fri, 29 Apr 2016 21:54:15 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20160429195415.GQ1881@hermes.click-hack.org>
References: <57226422.2010707@mitre.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <57226422.2010707@mitre.org>
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

On Thu, Apr 28, 2016 at 03:27:30PM -0400, Jeffrey Melville wrote:
> Hi,
> 
> I wanted to clarify the expected behavior that would cause a wrapped
> select() call to return EINTR when using the POSIX skin.
> 
> I'm running Xenomai 2.6.4 (actually 2.6 git rev 4f349cf0553, with a99426
> cherry-picked) with kernel 3.14.17 on a Zynq and the POSIX skin.
> 
> We have a real-time thread (SCHED_FIFO, nonzero priority) that
> frequently calls (wrapped) select() on a normal Linux UDP socket. We've
> noticed that sometimes, when data is available on the socket, the call
> to select will return -1 with errno EINTR. There is no other evidence in
> the user application that a signal occurred. I suspect that it may be
> related to SIGWINCH/SIGHARDEN but I don't know how this works in much
> detail. I haven't been able to confirm this theory yet either. I see
> that select does not have to respect SA_RESTART.
> 
> With that in mind:
> 1. Is it expected that a wrapped select() call returns EINTR during
> normal mode transitions? It doesn't seem right to me.

Well, first, calling the wrapped select on plain linux descriptors
is kind of stupid: Xenomai core will migrate the task to primary
mode, in order to execute the syscall, which will say "there is a
linux file descriptor in that set, let us handle it with plain linux
syscall", so the wrapped select call will call the plain linux
select syscall which will cause the thread to switch to secondary
mode (and get a SIGDEBUG signal if it has enabled PTHREAD_WARNSW).
Second, EINTR is very much likely returned by the 
plain linux select syscall, and not by Xenomai syscall. Third, is
not it because you have enabled PTHREAD_WARNSW on that thread?

> 
> 2. If this isn't the expected behavior, what would you recommend as a
> next debugging step? I suspect that handling every SIGWINCH will result
> in a lot of noise.

I would recommend using __real_select with fdset containing only
Linux file descriptors, in order to avoid the two mode switches per
call. You can not mix Linux file descriptors with Xenomai file
descriptors in fdset anyway, and have to have separate select loops
for the two types of descriptors, as outlined here:
https://xenomai.org/2014/08/porting-a-linux-application-to-xenomai-dual-kernel/#IO_multiplexing_with_select

Regards.

-- 
					    Gilles.
https://click-hack.org

