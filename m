Message-ID: <4B914F4B.1040205@domain.hid>
Date: Fri, 05 Mar 2010 19:36:59 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4B8D9711.5090704@domain.hid>
	<CF7FB0793253794F9F45991443E5FE2006483DE99F@us194mx002.tycoelectronics.net>
In-Reply-To: <CF7FB0793253794F9F45991443E5FE2006483DE99F@us194mx002.tycoelectronics.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [pull request] Fixes and workarounds for the
	cond issues
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: "Charlton, John" <john.charlton@domain.hid>
Cc: "'jan.kiszka@domain.hid'" <jan.kiszka@domain.hid>, xenomai-core <xenomai@xenomai.org>

Charlton, John wrote:
> I merged some changes from git://git.xenomai.org/xenomai-jki.git for-upstream  to my xenomai-2.5.1 release distribution
> to include the rt_cond_wait and pthread_cond_[timed]wait work arounds.  I also merged changes to the mutex_torture.c.  Everything builds and most tests seem to pass but I get the following output from the mutex-torture tests:

You are probably missng the changes for recursive_cond_wait for the
posix skin which were commited in the development branch. You do not see
it because the new mutex-torture tests were added before the recursive
cond test.

> 
> root@domain.hid# ./mutex-torture-native
> simple_wait
> recursive_wait
> timed_mutex
> FAILURE: timed_waiter, waited 3.870 us
> root@domain.hid# ./mutex-torture-posix
> simple_wait
> recursive_wait
> errorcheck_wait
> timed_mutex
> FAILURE: timed_mutex mutex_destroy: 22 (Invalid argument)
> 
> Do you have suggestions on how to resolve these errors hopefully without moving to the full development branch?

This kind of thing is exactly the reason why I told I would work quietly
on this issue. Things will be ready on monday, but it would help us a
great deal if you could test the development branch on monday, at the
same time as when we are validating it on our test platforms.

Can not do better right now.

-- 
					    Gilles.

