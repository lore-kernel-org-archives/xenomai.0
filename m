Message-ID: <481F3495.2010906@domain.hid>
Date: Mon, 05 May 2008 18:23:49 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <481F2B6A.802@domain.hid> <481F3110.1050407@domain.hid>
	<2ff1a98a0805050912m60cf9d03o308bec827236b10a@domain.hid>
In-Reply-To: <2ff1a98a0805050912m60cf9d03o308bec827236b10a@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] Houston, we have a circular problem
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Xenomai-core@domain.hid

Gilles Chanteperdrix wrote:
> On Mon, May 5, 2008 at 6:08 PM, Philippe Gerum <rpm@xenomai.org> wrote:
>>  do_schedule_event() is the culprit when it reads the pending signals on the
>>  shared queue (XNDEBUG check for rearming the timers),
> 
> A stupid suggestion: if we know that the spinlock is always locked
> when calling do_schedule_event, maybe we can simply avoid the lock
> there ?

Would be the best solution - but I don't think so. After reading a bit
more into the lockdep output, I think the issue is that _some_other_
task my hold the siglock and then acquire our rq_lock, but not
necessarily along a similar code path we took to acquire the siglock now.

Jan

-- 
Siemens AG, Corporate Technology, CT SE 2
Corporate Competence Center Embedded Linux

