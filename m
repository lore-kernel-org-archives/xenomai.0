Message-ID: <4B95463D.2040705@domain.hid>
Date: Mon, 08 Mar 2010 19:47:25 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4B8D9711.5090704@domain.hid>
	<CF7FB0793253794F9F45991443E5FE2006483DE99F@us194mx002.tycoelectronics.net>
	<4B914F4B.1040205@domain.hid>
	<CF7FB0793253794F9F45991443E5FE20076A70F4C0@domain.hid>
In-Reply-To: <CF7FB0793253794F9F45991443E5FE20076A70F4C0@domain.hid>
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
> I configured and built with linux-2.6.32.7 and xenomai-jki for-upstream snapshot: f98569c8eec5df605f806ff58e789668720805ee. I noticed that you removed the PTHREAD_WARNSW so I removed the call to pthread_set_mode_np to remove the following errors:
> 
> PosixThread/PosixThread.cpp:1607: error: 'PTHREAD_WARNSW' was not declared in this scope
> PosixThread/PosixThread.cpp:1607: error: 'pthread_set_mode_np' was not declared in this scope

This should come with #include <pthread.h>, provided you use
xeno-config --posix-cflags (soon to be deprecated way)
or xeno-config --skin=posix --cflags
to get the compilation flags.

> 
> I am able to run all of my user space application code and unit test
code which uses CanFestival open source CAN library. I am also able to
run the xeno-test which runs to completion with no errors. When I run
the mutex-torture tests I still get the following errors which I have
not looked into in more detail yet:
> 
> 
> root@domain.hid# ./mutex-torture-native
> simple_wait
> recursive_wait
> timed_mutex
> FAILURE: timed_waiter, waited 4.110 us
> root@domain.hid# ./mutex-torture-posix
> simple_wait
> recursive_wait
> errorcheck_wait
> timed_mutex
> FAILURE: timed_mutex mutex_destroy: 22 (Invalid argument)
> 
> I am now looking at xenomai-rpm branch which one is close to 2.5.2 release?

the master branch of the xenomai-2.5 repository. As explained here:
http://www.xenomai.org/index.php/Main_Page

in the "Fetching the source code repositories"

-- 
					    Gilles.

