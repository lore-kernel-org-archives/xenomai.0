Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 3 Dec 2007 13:57:22 -0700
Message-ID: <51CAD0CE1504444DBE77CBBE51A0135D375F08@domain.hid>
In-Reply-To: <18260.25837.479943.881970@domain.hid>
References: <51CAD0CE1504444DBE77CBBE51A0135D375D6B@slcmail.slc.mew.int><2ff1a98a0711270657y63482de1ref80ba849f172918@domain.hid><51CAD0CE1504444DBE77CBBE51A0135D375D71@domain.hid><18259.5205.292521.503167@domain.hid><51CAD0CE1504444DBE77CBBE51A0135D375ECE@slcmail.slc.mew.int><2ff1a98a0712030235vfc316b8nff4b1e422db82c96@domain.hid><51CAD0CE1504444DBE77CBBE51A0135D375EEC@slcmail.slc.mew.int><2ff1a98a0712030552y1c9b10b8p54730d45f6245906@domain.hid><51CAD0CE1504444DBE77CBBE51A0135D375EEE@slcmail.slc.mew.int>
	<18260.25837.479943.881970@domain.hid>
From: "Steven Seeger" <sseeger@domain.hid>
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
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

> Ok. We can send the signal only to threads which are part of the same
> application as the faulting thread.

That would be a big help! At least then we can report which application
had the fault. We have a few applications that work together.=20

> To be completely fair, Linux has the same problem: kernel-space has
> pids, user-space has pthread_t, and there is no way to make a
> correspondance between the two. The glibc probably has a way, but
there
> is no public service that makes this available to the user. Xenomai is
> not different from Linux with regard to this issue.

Yes, but Linux is not pretending to blend the existence of kernel and
userspace threads. :)
=20
> Even if we used skin-level (note that the watchdog notification
> mechanism is done at nucleus level for now) services to try and return
a
> thread/task identifier to the user-space, by the time the watchdog
> signal get serviced, this identifier would have become invalid, since
> the watchdog kills the faulting thread.

Well, if the userspace program could register a watchdog handler for
each thread it creates, then it could store a void* with that handler
that's passed back to the userspace application. This handler would have
special meaning to that application, and so the correct behavior can be
performed.=20

> The only way I see to solve your issue is to maintain, in your
> application, a list of running threads, and upon notification from the
> watchdog, poll each thread (using rt_task_inquire(task, NULL) with
> native or pthread_kill(thread, 0) with posix) in order to find which
one
> was killed.

What I suggested above makes the list unnecessary. The only reason this
may have to be done at skin level is because the nucleus can't call a
userspace handler. But, the skin could set up a queue and a thread that
waits on a message from the nucleus saying that a thread was killed, and
then the it could pass data back that is meaningful to the skin
(userspace handler and void* argument) for each registered handler, and
the skin could then call the appropriate function.

What do you think?

Thanks,
Steven


