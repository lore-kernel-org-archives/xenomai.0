Message-ID: <496F1041.20306@domain.hid>
Date: Thu, 15 Jan 2009 10:30:25 +0000
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <496F0DBE.5010108@domain.hid>
In-Reply-To: <496F0DBE.5010108@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] Pending patches
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

Jan Kiszka wrote:
> Hi,
> 
> currently I have the following six patches in my assorted queue
> (git://git.kiszka.org/xenomai.git queue/assorted). All have been posted
> before, I just rebased them since then a few times. Should I repost
> any/all of them (would be no problem), or are some already queued for
> potential merge?
> 
> Jan
> 
> (...)
> commit a631ab2c531d5e381ba8a0a59bf301a0276d9f99
> Author: Jan Kiszka <jan.kiszka@domain.hid>
> Date:   Thu Jan 15 11:10:24 2009 +0100
> 
>     POSIX: Do not auto-shadow main with dlopen enabled
>     
>     Don't perform auto-shadowing in POSIX skin if we might be loaded via
>     dlopen. Otherwise the wrong thread, the undefined dlopen caller, may be
>     (re-)shadowed, assigning wrong scheduling settings.
>     
>     Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>
> 
>  src/skins/posix/init.c |   43 ++++++++++++++++++++++++++++---------------
>  1 files changed, 28 insertions(+), 15 deletions(-)
> 
> commit 91ae3da822ca558804bf33be4d164ea4c2667c1b
> Author: Jan Kiszka <jan.kiszka@domain.hid>
> Date:   Thu Jan 15 11:10:24 2009 +0100
> 
>     Replace --without-__tread with --enable-dlopen-skins
>     
>     In practice, you only want to disable __thread support when Xenomai skin
>     libraries should be loadable via dlopen. Therefore rename the related
>     configure switch accordingly.
>     
>     Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>
> 

Nack these two ones: one of the gcc bugs I have found on ARM is related
to __thread (http://gcc.gnu.org/bugzilla/show_bug.cgi?id=38815). So,
even though I have found a work around for the bug, I am not sure that
it works all the time, so disabling __thread on ARM is safer. Especially
since __thread does not bring any performance improvement over
pthread_(get|set)specific on ARM.

> commit 028d4766a38b6937d9a2c02a20022e3ee5b67b55
> Author: Jan Kiszka <jan.kiszka@domain.hid>
> Date:   Thu Jan 15 11:10:24 2009 +0100
> 
>     POSIX: Fix initialization of SCHED_RR threads
>     
>     Passing SCHED_RR as policy to pthread_create has currently not the
>     desired effect. The kernel part expects that user space adjusts the
>     policy and prio via __pse51_thread_setschedparam after setting up the
>     shadow. And this is what the patch does by calling the wrapped
>     pthread_setschedparam instead of the real one.
>     
>     Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>
> 
>  src/skins/posix/thread.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> commit 71666ce04ef216d281fe86ee82a5560c2b57c6dd
> Author: Jan Kiszka <jan.kiszka@domain.hid>
> Date:   Thu Jan 15 11:10:24 2009 +0100
> 
>     Handle priority changes of SCHED_RR tasks
>     
>     If shadowed Linux tasks with SCHED_RR policy change their priority,
>     do_setsched_event currenty ignores this. Extend the condition to catch
>     this case as well.
>     
>     Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>
> 
>  ksrc/nucleus/shadow.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 

Nack these two ones too. Philippe implemented a SCHED_RR working over
aperiodic mode. I think the POSIX skin needs fixing, but not that way.
We should have the thread run with SCHED_FIFO in secondary mode even if
it runs under round-robin in primary mode. And when we have done that,
we do not need the second patch, since a shadow linux task will always
run with SCHED_FIFO.

-- 
                                                 Gilles.

