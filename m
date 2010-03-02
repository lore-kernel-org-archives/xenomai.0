Message-ID: <4B8D57D4.3040200@domain.hid>
Date: Tue, 02 Mar 2010 19:24:20 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4B8D55AD.9090901@domain.hid> <4B8D5768.7080402@domain.hid>
In-Reply-To: <4B8D5768.7080402@domain.hid>
Content-Type: text/plain; charset=UTF-8
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
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

Jan Kiszka wrote:
> Jan Kiszka wrote:
>> Gilles,
>>
>> can you (or someone else) confirm this:
>>
>> # mutex-torture-posix
>> simple_wait
>> simple mutex_lock 1: 1 (Operation not permitted)
>>
>> I'm on a x86_64 target (2.6.32.8 with latest I-pipe), Xenomai is
>> unpatched git head.
>>
> 
> Looks like a bug in the test case: We do not wrap sched_setscheduler
> which it uses, and my config does not auto-shadow main. Fix will follow.

The test works here, but fails in cond_signaler, mutex_lock 2, just
checked out v2.5.1 to see if we already had the bug.

> 
> Jan
> 


-- 
					    Gilles.

