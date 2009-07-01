Message-ID: <4A4B34D3.3090004@domain.hid>
Date: Wed, 01 Jul 2009 12:05:07 +0200
From: Nocia <nocia.one@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] How to get the next periodic task awakening
Reply-To: nocia.one@domain.hid
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

Hi all,

I'm a beginer in the Xenomai world.


I'm working on the Xenomai kernel in order to minimize the power
consumption, for my university final project
(/http/://xenomaiote.googlecode.com).

To do that I'm trying to implement OTE (one time extension).


For OTE, I need to know if tasks are in the ready queue that I can do
with countpq(&sched->readyq)

However I have also to know when the next periodic task will wake up to
know the available time that I can use to extends the current task.

But I didn't find this information.

I try this following things in the schedule function xnpod_schedule (pod.c):


To get the next timer that will wake up :

xntimerq_head(&sched->timerqueue)


To get the date of the next wake up :

xntimerh_date(&timer->aplink)


Then I compare this date with the date of the next ingoing task (except
the root task) with xnarch_get_cpu_tsc()


But the results aren't convincing :

Jul 1 11:13:23 rt-nocia kernel: [ 252.872275] now: 263916522565

Jul 1 11:13:23 rt-nocia kernel: [ 252.872285] Name thread out : trivial2

Jul 1 11:13:23 rt-nocia kernel: [ 252.872292] Name thread in : ROOT/0

Jul 1 11:13:23 rt-nocia kernel: [ 252.872297] nb in queue 0

Jul 1 11:13:23 rt-nocia kernel: [ 252.872303] next event *263920282098*

Jul 1 11:13:23 rt-nocia kernel: [ 252.872317]

Jul 1 11:13:24 rt-nocia kernel: [ 253.879348] now: *264923529578*

Jul 1 11:13:24 rt-nocia kernel: [ 253.879362] Name thread out : ROOT/0

Jul 1 11:13:24 rt-nocia kernel: [ 253.879369] Name thread in : trivial

Jul 1 11:13:24 rt-nocia kernel: [ 253.879374] nb in queue 1


The next event is 263920282098 and when the task is scheduling, the
current time is 264923529578.


Maybe it's because I have to get the second timer ?


Thanks in advance for any help!


Lucien


