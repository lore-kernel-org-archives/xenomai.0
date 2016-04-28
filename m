From: Jeffrey Melville <jmelville@mitre.org>
Message-ID: <57226422.2010707@mitre.org>
Date: Thu, 28 Apr 2016 15:27:30 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] Clarification on EINTR with wrapped select call.
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

Hi,

I wanted to clarify the expected behavior that would cause a wrapped
select() call to return EINTR when using the POSIX skin.

I'm running Xenomai 2.6.4 (actually 2.6 git rev 4f349cf0553, with a99426
cherry-picked) with kernel 3.14.17 on a Zynq and the POSIX skin.

We have a real-time thread (SCHED_FIFO, nonzero priority) that
frequently calls (wrapped) select() on a normal Linux UDP socket. We've
noticed that sometimes, when data is available on the socket, the call
to select will return -1 with errno EINTR. There is no other evidence in
the user application that a signal occurred. I suspect that it may be
related to SIGWINCH/SIGHARDEN but I don't know how this works in much
detail. I haven't been able to confirm this theory yet either. I see
that select does not have to respect SA_RESTART.

With that in mind:
1. Is it expected that a wrapped select() call returns EINTR during
normal mode transitions? It doesn't seem right to me.

2. If this isn't the expected behavior, what would you recommend as a
next debugging step? I suspect that handling every SIGWINCH will result
in a lot of noise.

Thanks,
Jeff

