Message-ID: <4BDC41EF.4050004@domain.hid>
Date: Sat, 01 May 2010 16:59:59 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <E1O78nO-0008PE-EK@xenomai.org> <4BDC332E.2010804@domain.hid>
	<4BDC357A.30803@domain.hid>
In-Reply-To: <4BDC357A.30803@domain.hid>
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

Jan Kiszka wrote:
> Gilles Chanteperdrix wrote:
>> GIT version control wrote:
>>> Module: xenomai-jki
>>> Branch: for-upstream
>>> Commit: 5d2fa6c7578683e036d88bc6dbb6a7f458dfe705
>>> URL:    http://git.xenomai.org/?p=xenomai-jki.git;a=commit;h=5d2fa6c7578683e036d88bc6dbb6a7f458dfe705
>>>
>>> Author: Jan Kiszka <jan.kiszka@domain.hid>
>>> Date:   Wed Apr 28 15:08:11 2010 +0200
>>>
>>> native: Improve fault tolerance /wrt multiple task deletions
>>>
>>> As we may pass the pthread handle of an RT_TASK directly to glibc, we
>>> may trigger a SIGSEGV if the underlying thread was already terminated.
>>> Try to catch this application mistakes by clearing the handle at least
>>> in that task descriptor which successfully ran rt_task_delete or
>>> rt_task_join.
>>>
>>> Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>
>> Ok. I have tested this patch (though I could not find whether it was
>> discussed on the mailing list). And in fact, it looks to me like it
>> turns an application error into a silently working application.
> 
> Then there is probably something broken: rt_task_delete is supposed to
> return -EIDRM of the passed handle no longer exists. That's at least
> what the doc says. The point of this patch is to turn an application
> crash into a proper error return value (and that not only for
> --enable-debug).

After some investigation, it turns out that opaque2 == 0 is already
useful for another case: when rt_task_delete'ing a thread belonging to
another process than the current process. So, by attaching two meanings
to this value, we introduce a regression.

-- 
					    Gilles.

