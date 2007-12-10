MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <18269.46631.20493.787763@domain.hid>
Date: Mon, 10 Dec 2007 22:56:55 +0100
In-Reply-To: <475DB21C.8040800@domain.hid>
References: <4757EBAE.4050608@domain.hid>
	<2ff1a98a0712060544x6e1e8c11q52e9417fb096e4b7@domain.hid>
	<475801AA.3060300@domain.hid>
	<2ff1a98a0712060621k436f32b7sc1d1cfe53bea8f18@domain.hid>
	<475952CD.3020003@domain.hid>
	<18265.47545.897637.377869@domain.hid>
	<18265.50385.343346.558000@domain.hid>
	<475C6454.2090002@domain.hid>
	<18268.29130.406826.933528@domain.hid>
	<475D5923.2050701@domain.hid>
	<2ff1a98a0712100755l5c091420oe4d86ecd919992a4@domain.hid>
	<475DB21C.8040800@domain.hid>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Subject: Re: [Xenomai-core] How to cancel a Xenomai POSIX thread
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Wolfgang Grandegger <wg@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

Wolfgang Grandegger wrote:
 > Gilles Chanteperdrix wrote:
 > > On Dec 10, 2007 4:20 PM, Wolfgang Grandegger <wg@domain.hid> wrote:
 > >> Gilles Chanteperdrix wrote:
 > >>> Wolfgang Grandegger wrote:
 > >>   # ./kill_pthread
 > >>   Starting high_prio_task
 > >>   low_prio_task: policy=1 prio=10
 > >>   Killed low_prio task: count=172709970, overruns=0
 > >>
 > >>   [1]+  Stopped                 ./kill_pthread
 > > 
 > > What you are observing is probably a difference between linuxthreads
 > > and NPTL: with linuxthreads, SIGSTOP can be sent to a particular
 > > thread and will cause this thread only to stop. With NPTL, it seems
 > > that the effect of SIGSTOP is global, it affects the entire process. I
 > > will test tonight on my x86 box to see if I observe the same effect.
 > 
 > Ah, the man page says:
 > 
 >  Note  that  pthread_kill()  only causes the signal to be handled in the
 >  context of the given thread; the signal action  (termination  or  stop-
 >  ping) affects the process as a whole.

I can confirm the same effect on plain Linux. So, the newly added
pthread_kill is not to blame (yet).

-- 


					    Gilles Chanteperdrix.

