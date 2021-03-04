References: <87v9a7z0xh.fsf@xenomai.org>
 <20210304113653.45432-1-florian.bezdeka@siemens.com>
 <20210304113653.45432-2-florian.bezdeka@siemens.com>
From: Philippe Gerum <rpm@xenomai.org>
Subject: Re: [y2038][RFC PATCH 1/2] y2038: Fixing the sem_timedwait syscall
 for 32 bit systems
In-reply-to: <20210304113653.45432-2-florian.bezdeka@siemens.com>
Date: Thu, 04 Mar 2021 16:11:58 +0100
Message-ID: <87pn0fymv5.fsf@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Florian Bezdeka <florian.bezdeka@siemens.com>
Cc: xenomai@xenomai.org, jan.kiszka@siemens.com, chensong@kylinos.cn


Florian Bezdeka <florian.bezdeka@siemens.com> writes:

> On systems using 32 bit for time_t the sem_timedwait syscall was broken
> because the function used for copying the timeout value from userspace
> to kernel (=sem_fetch_timeout()) was always copying
> sizeof(struct timespec64).
>
> A 32 bit application (or more specific an application with 4 byte
> time_t) would only provide sizeof(struct old_timespec32).
>
> Notable changes:
>   - The copy operation from userspace to kernel is now already done in
>     the syscall handler. So it is always done. Previously it was copied
>     over and validated before the first use (when used at all).
>     So we have some additional instructions now that may be
>     unnecessary, but that simplifies the code.

Nack, there is a reason for this postponed copy of timespecs up to the
point where they are actually needed. This patch would break POSIX
compliance for some users. Please see the last sentence in the
Description of sem_timedwait()
https://pubs.opengroup.org/onlinepubs/009696699/functions/sem_timedwait.html

I agree that the standard says "need not be checked", not "must not be
checked" which may make this implementation-defined, but some test
suites Xenomai runs against do expect this to pass.

-- 
Philippe.

