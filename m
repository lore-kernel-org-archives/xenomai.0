MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <18260.25837.479943.881970@domain.hid>
Date: Mon, 3 Dec 2007 21:19:57 +0100
In-Reply-To: <51CAD0CE1504444DBE77CBBE51A0135D375EEE@slcmail.slc.mew.int>
References: <51CAD0CE1504444DBE77CBBE51A0135D375D6B@slcmail.slc.mew.int>
	<2ff1a98a0711270657y63482de1ref80ba849f172918@domain.hid>
	<51CAD0CE1504444DBE77CBBE51A0135D375D71@domain.hid>
	<18259.5205.292521.503167@domain.hid>
	<51CAD0CE1504444DBE77CBBE51A0135D375ECE@slcmail.slc.mew.int>
	<2ff1a98a0712030235vfc316b8nff4b1e422db82c96@domain.hid>
	<51CAD0CE1504444DBE77CBBE51A0135D375EEC@slcmail.slc.mew.int>
	<2ff1a98a0712030552y1c9b10b8p54730d45f6245906@domain.hid>
	<51CAD0CE1504444DBE77CBBE51A0135D375EEE@slcmail.slc.mew.int>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Subject: Re: [Xenomai-help] wathcdog
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Steven Seeger <sseeger@domain.hid>
Cc: xenomai@xenomai.org

Steven Seeger wrote:
 > > The rt_task_catch service is only available to kernel-space tasks. In
 > > order to register a handler for SIGRTMAX in user-space, you will have
 > > to use the posix services, i.e. signal or sigaction. Actually, I am
 > > the one to blame since I sent a patch and did not explain how to use
 > > it.
 > 
 > While this is ok, it makes it harder to keep track of which application
 > a thread was created in. If we're running 4 applications, it'd be nice
 > to know which one failed. (While this could also be done by just
 > printing the thread name, it still seems a little odd.)

Ok. We can send the signal only to threads which are part of the same
application as the faulting thread.

 > 
 > There seems to be a disconnect with regard to Xenomai threads and Linux
 > userspace applications. This is unfortunate because Xenomai is supposed
 > to blend the two.

To be completely fair, Linux has the same problem: kernel-space has
pids, user-space has pthread_t, and there is no way to make a
correspondance between the two. The glibc probably has a way, but there
is no public service that makes this available to the user. Xenomai is
not different from Linux with regard to this issue.

Even if we used skin-level (note that the watchdog notification
mechanism is done at nucleus level for now) services to try and return a
thread/task identifier to the user-space, by the time the watchdog
signal get serviced, this identifier would have become invalid, since
the watchdog kills the faulting thread.

What I planned to do is pass, using the siginfo structure, the pid of
the killed thread. But I am afraid it will not be of much help either:
the gettid service, though implemented in kernel-space is not
implemented in the glibc, so you have no way of knowing the pid of a
particular thread.

The only way I see to solve your issue is to maintain, in your
application, a list of running threads, and upon notification from the
watchdog, poll each thread (using rt_task_inquire(task, NULL) with
native or pthread_kill(thread, 0) with posix) in order to find which one
was killed.

-- 


					    Gilles Chanteperdrix.

