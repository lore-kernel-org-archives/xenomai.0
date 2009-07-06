Message-ID: <4A52231C.6040906@domain.hid>
Date: Mon, 06 Jul 2009 18:15:24 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4A4DE69D.1010105@domain.hid> <4A5222E9.2070105@domain.hid>
In-Reply-To: <4A5222E9.2070105@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] Commit 6346c046b1
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

Gilles Chanteperdrix wrote:
> Jan Kiszka wrote:
>> Hi Philippe,
>>
>> what problem did you had to address with commit 6346c046b1? I'm asking
>> as it most probably breaks what e7d889f56c tried to fix (e.g. double
>> definitions of PTHREAD_PRIO_* with recent glibcs).
> 
> The problem was that with uclibc, pthread_mutexattr_set_prio_inherit

pthread_mutexatt_setprotocol

> existed, but PTHREAD_PRIO_INHERIT did not exit, so the posix
> mutex-torture test was not compiling. Which is why, we replaced with:
> #ifndef PTHREAD_PRIO_INHERIT
> #define PTHREAD_PRIO_INHERIT
> #endif
> 
> which should work as long as this piece of code is put after the
> #include_next<pthread.h>
> But maybe we forgot that...
> 
> Besides, I use recent libc (and I believe with -Wall -W) and do not see
> any warning . Would you be compiling with g++ or with special flags?


-- 
                                          Gilles


