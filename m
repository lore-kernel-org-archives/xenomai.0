Message-ID: <6ee4c8380604190827q76a1442du59c90b2515f71cdd@domain.hid>
Date: Wed, 19 Apr 2006 11:27:00 -0400
From: "Brian L." <bluczkie@domain.hid>
Sender: zorander@domain.hid
Subject: Re: [Xenomai-help] General question on Native Skin tasks
In-Reply-To: <44455471.8090001@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
References: <6ee4c8380604161110y3c937a74t9186bad2d9af2058@domain.hid>
	<4443992C.5000808@domain.hid>
	<6ee4c8380604181253t235363a9v79d91b57bea4575a@domain.hid>
	<44455471.8090001@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai@xenomai.org

> Why do you create the non-rt threads also via rt_task_create? This just
> introduces unneeded load on the RT subsystem.

I was under the impression that to interact with xenomai objects
(RT_QUEUE, RT_MUTEX, etc), I needed to be in a xenomai thread. I
assumed that because every mutex implementation I've seen has relied
heavily on the underlying thread library (i.e. to sleep or yield) and
mixing thread libraries seemed like a bad idea.

So, is this what you're suggesting:

- Link against pthreads AND native
- Start non-realtime threads using pthread_create and real-time
threads using rt_task_create/rt_task_start
- use RT_MUTEX's/RT_QUEUE's for situations in which there is
contention/communication among realtime and nonrealtime threads
- use pthreads mutexes/queues for situations of
contention/communication among non-realtime threads

It sounds workable to me, assuming the queues/mutexes/etc. don't stop
working when both threading libraries are involved.

