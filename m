Message-ID: <4B956133.5070203@domain.hid>
Date: Mon, 08 Mar 2010 21:42:27 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4B8D9711.5090704@domain.hid>
	<CF7FB0793253794F9F45991443E5FE2006483DE99F@us194mx002.tycoelectronics.net>
	<4B914F4B.1040205@domain.hid>
	<CF7FB0793253794F9F45991443E5FE20076A70F4C0@domain.hid>
	<4B95463D.2040705@domain.hid>
	<CF7FB0793253794F9F45991443E5FE20076A70F4C1@domain.hid>
In-Reply-To: <CF7FB0793253794F9F45991443E5FE20076A70F4C1@domain.hid>
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
> Yes with the xenomai-2.5 branch latest as of 1900 UTC everything works without error including the mutex-torture tests (output below):
> 
> root@domain.hid# ./mutex-torture-native
> simple_wait
> recursive_wait
> timed_mutex
> mode_switch
> pi_wait
> lock_stealing
> NOTE: lock_stealing mutex_trylock: not supported
> simple_condwait
> recursive_condwait
> Test OK
> root@domain.hid# ./mutex-torture-posix 
> simple_wait
> recursive_wait
> errorcheck_wait
> timed_mutex
> mode_switch
> pi_wait
> lock_stealing
> NOTE: lock_stealing mutex_trylock: not supported
> simple_condwait
> recursive_condwait
> Test OK
> root@domain.hid# 
> 
> pthread_set_mode_np(NULL, PTHREAD_WARNSW) also works with this branch. Thank you for the help.

You also have cond-torture-posix, and cond-torture-native, which should
test, among other things, the fix for the condition variable bug you had.

-- 
					    Gilles.

