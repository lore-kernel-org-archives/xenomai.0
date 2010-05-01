Message-ID: <4BDC332E.2010804@domain.hid>
Date: Sat, 01 May 2010 15:57:02 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <E1O78nO-0008PE-EK@xenomai.org>
In-Reply-To: <E1O78nO-0008PE-EK@xenomai.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [Xenomai-git] Jan Kiszka : native: Improve fault
 tolerance /wrt multiple task deletions
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

GIT version control wrote:
> Module: xenomai-jki
> Branch: for-upstream
> Commit: 5d2fa6c7578683e036d88bc6dbb6a7f458dfe705
> URL:    http://git.xenomai.org/?p=xenomai-jki.git;a=commit;h=5d2fa6c7578683e036d88bc6dbb6a7f458dfe705
> 
> Author: Jan Kiszka <jan.kiszka@domain.hid>
> Date:   Wed Apr 28 15:08:11 2010 +0200
> 
> native: Improve fault tolerance /wrt multiple task deletions
> 
> As we may pass the pthread handle of an RT_TASK directly to glibc, we
> may trigger a SIGSEGV if the underlying thread was already terminated.
> Try to catch this application mistakes by clearing the handle at least
> in that task descriptor which successfully ran rt_task_delete or
> rt_task_join.
> 
> Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>

Ok. I have tested this patch (though I could not find whether it was
discussed on the mailing list). And in fact, it looks to me like it
turns an application error into a silently working application. So, I
would propose:
- to use 0x8 instead of 0, to cause a segfault if an invalid handle is
used, without any risk of side effect (such as killing or joining the
wrong task if ever a pthread_t is reused)
- if Xenomai is compiled with --enable-debug, return -EINVAL, or use an
assert if such a value is encountered.


-- 
					    Gilles.

