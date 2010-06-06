Message-ID: <4C0B9846.7050203@domain.hid>
Date: Sun, 06 Jun 2010 14:44:54 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <E1OKZdD-0003ml-45@domain.hid> <4C095876.3060605@domain.hid>
	<4C099329.6000303@domain.hid> <4C0A49C4.8000509@domain.hid>
	<4C0A9AB9.7030602@domain.hid> <4C0A9C2A.1030002@domain.hid>
	<4C0AA224.6060409@domain.hid> <4C0AA2F0.6050201@domain.hid>
	<4C0AA3EC.7040106@domain.hid> <4C0AA548.6070409@domain.hid>
	<4C0AB7BA.7000100@domain.hid>
In-Reply-To: <4C0AB7BA.7000100@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [Xenomai-git] Jan Kiszka : native: Rework
 handling of pthread carrier thread
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
>> Jan Kiszka wrote:
>>> Gilles Chanteperdrix wrote:
>>>> Not being able to join a deleted task undermines seriously the utility
>>>> of rt_task_join... What is it useful for, then?
>>> See the doc: You join or delete, but not both.
>> Looks to me like a workaround: you are not able to handle properly the
>> life-cycle of an RT_TASK, so you changed the rules... is there really no
>> other way?
> 
> First of all, it turns a SEGV into a proper error code. Moreover,
> rt_task_join now officially finalizes the object for native (it always
> did technically!), as does pthread_join for POSIX. No rule changed, just
> rule documentation and violation detection added. One may argue about
> join after delete, but for what use case such a change of rt_task_delete
> semantic?

rt_task_delete, pthread_cancel, pthread_detach are not synchronous,
after one of these calls, you do not have any guarantee that the
ressources attached to a thread are free for re-use. After pthread_join,
you do.

So, the question is what is more important, to have a way to wait for
the ressources attached to a thread to be freed? Or to avoid
segmentation faults in broken application?

I do not generally mind segmentation faults in broken applications if we
can not avoid them without breaking other applications. A segmentation
fault is one of the simplest things to debug.

However, I do not have a strong opinion on this, it is just an open
question. More generally, I would like us to discuss once and for all
about the semantic of the various calls and their effect on the RT_TASK
duration, instead of changing this semantic every release and risk
breaking non-broken applications (I mean, the one which do not segfault).

-- 
					    Gilles.

