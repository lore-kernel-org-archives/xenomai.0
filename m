MIME-Version: 1.0
From: Ronny Meeus <ronny.meeus@gmail.com>
Date: Thu, 28 Feb 2013 20:19:14 +0100
Message-ID: <CAMJ=MEfo5EU2mnM4=JDNU4QXX00W=0aC2+m5LucPYiN39W5wcQ@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: [Xenomai] Xenomai-forge: thread using 100% cpu load
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hello

we are using the PSOS interface of Xenomai forge, running completely
in user-space using the mercury code.
We deploy our application on different processors, one product is
running on PPC multicore (P4040, P4080, P4034) and another one on
Cavium (8 core device).
The Linux version we use is 2.6.32 but I would assume that this is not
so relevant.

Our Xenomai application is running on one of the cores (affinity is
set), while the other cores are running other code.

On both architectures we recently start to see issues that one thread
is consuming 100% of the core on which the application is pinned.
The thread that monopolizes the core is the thread internally used to
manage the timers, running at the highest priority.
The trigger for running into this behavior is currently unclear.
If we only start a part of the application (platform management only),
the issue is not observed.
We see this on both an old version of Xenomai and a very recent one
(pulled from the git repo yesterday).

I will continue to debug this issue in the coming days and try isolate
the code that is triggering it, but I can use hints from the
community.
Debugging is complex since once the load starts, the debugger is not
reacting anymore.
If I put breakpoints in the functions that are called when the timer
expires (both oneshot and periodic), the process starts to clone
itself and I endup with tens of them.

Has anybody seen an issue like this before or does somebody has some
hints on how to debug this problem?

Many thanks.

---
Ronny

