Message-ID: <4DB2F8D8.2070505@domain.hid>
Date: Sat, 23 Apr 2011 18:05:44 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <537545.221302614089218.JavaMail.SYSTEM@pc-msalvini>
In-Reply-To: <537545.221302614089218.JavaMail.SYSTEM@pc-msalvini>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] rt_task_join() small issue on not-joinable task
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Mauro Salvini <mauro.salvini@domain.hid>
Cc: xenomai@xenomai.org

Mauro Salvini wrote:
> Hi to all,
> 
> I'm running Xenomai 2.5.5.2 IPipe 2.7-04 on kernel 2.6.35.7-x86.
> 
> I have a main real time task that creates a thread: this thread calls
> rt_task_shadow() to turns itself into real-time task I discovered
> this: if I exit from this task and then call rt_task_join() on it
> from main task, rt_task_join() returns 0 instead -EINVAL as expected
> (T_JOINABLE flag does not exist for rt_task_shadow() function). Is it
> correct a behavior?

Why would not it be correct? I mean, Linux threads are joinable by
default, so, it is normal that rt_task_join succeeds. Now, we can
implement a different behaviour, but for what reason?

-- 
                                                                Gilles.

