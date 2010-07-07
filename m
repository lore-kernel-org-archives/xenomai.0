MIME-Version: 1.0
In-Reply-To: <4C345529.8010309@domain.hid>
References: <AANLkTilmN6HTqYAcEv5qTqYhpjgBiMYQAPvPwCnynAHu@domain.hid>
	<4C345529.8010309@domain.hid>
Date: Wed, 7 Jul 2010 18:49:21 +0800
Message-ID: <AANLkTimmMGLKCyhiLBdDafSvkGlldwI17Xb2Y-XCx1bV@mail.gmail.com>
From: Everett Wang <everteq@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] task management, multi-thread, multi-core
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

On Wed, Jul 7, 2010 at 6:21 PM, Gilles Chanteperdrix
<gilles.chanteperdrix@xenomai.org> wrote:
> Everett Wang wrote:
>> Hi All,
>>
>> I am working on a navigation program that has two realtime tasks. One
>> is a high priority one executed in a higher frequency. Another task
>> runs about 1/10th of the first one, but requires substantially more
>> CPU computations. I am using an atom board which has dual threads
>> capability. I am worried that the second task can block the execution
>> of the first one until it finishs all the calculations. Can this
>> happen in a dual thread and/or dual core CPU? If yes, should I break
>> the task two into small chunks and let the task one to send a trigger
>> to
>> execute one chunk at a time? I know it is not xenomai specific
>> question and I have tried to read manual or other documents trying to
>> figure
>> it out.
>
> You did not tell us how was the priority of the second task, but since
> you told us that the first task was high priority, I have to guess that
> the second task is lower priority.
>
> On an uni-processor machine, the priorities are used by the scheduler to
> schedule your tasks, so, if a low priority task could prevent a high
> priority task from running, the scheduler would need to be fixed.
>
> On a multi-processor machine, you have to set the "affinity" of the
> tasks to pin the tasks on a given cpu. On each cpu, tasks are scheduled
> following their priorities.

Thanks Gilles, you are so nice. Yes, the second task is at lower priority. =
I did
state accurately. If the second task is running already, when the
higher priority
task is waiting for an outside event, then the event comes, the high
priority task
has to wait until the lower priority one to finish?

>>
>> I have read that tasks require more resources than threads in Linux.
>> The inter-threads communication is also more efficient than that of
>> tasks. Are these also true for xenomai realtime OS? Should I create
>> threads instead of tasks?
>>
>>
>> Any suggestions are welcome. Thanks for reading. :-)
>
> task is an informal term which may mean process or thread depending on
> the context. So, I guess what you mean is "process" instead of task. The
> difference between processes and threads is that changing context
> between processes requires changing the memory mapping, which is an
> heavy operation. On the other hand, processes provide an isolation that
> threads do not provide. So, choosing threads or processes is not only a
> matter of performances (otherwise, we would all run Linux without MMU,
> since in that case, everything is essentially a thread).
>

You are right again. Sorry for the confusing. I meant process instead
of the task.
Do you mean that if I need memory isolation, I use process, if I am sure my=
 code
has no memory problem, I should choose thread for better performance? Or it
is more complex than this?

Have a nice day,

Everett
>>
>> Everett
>>
>> _______________________________________________
>> Xenomai-help mailing list
>> Xenomai-help@domain.hid
>> https://mail.gna.org/listinfo/xenomai-help
>>
>
>
> --
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0Gilles.
>

