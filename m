Message-ID: <4B8D5768.7080402@domain.hid>
Date: Tue, 02 Mar 2010 19:22:32 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4B8D55AD.9090901@domain.hid>
In-Reply-To: <4B8D55AD.9090901@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] Posix mutex unit test fails on git head
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai-core <xenomai@xenomai.org>

Jan Kiszka wrote:
> Gilles,
> 
> can you (or someone else) confirm this:
> 
> # mutex-torture-posix
> simple_wait
> simple mutex_lock 1: 1 (Operation not permitted)
> 
> I'm on a x86_64 target (2.6.32.8 with latest I-pipe), Xenomai is
> unpatched git head.
> 

Looks like a bug in the test case: We do not wrap sched_setscheduler
which it uses, and my config does not auto-shadow main. Fix will follow.

Jan

-- 
Siemens AG, Corporate Technology, CT T DE IT 1
Corporate Competence Center Embedded Linux

