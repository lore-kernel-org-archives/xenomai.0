Message-ID: <49771D9E.4080204@domain.hid>
Date: Wed, 21 Jan 2009 13:05:34 +0000
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <5D63919D95F87E4D9D34FF7748CE2C2A017769AB@ARVMAIL1.mra.roland-man.biz>
In-Reply-To: <5D63919D95F87E4D9D34FF7748CE2C2A017769AB@ARVMAIL1.mra.roland-man.biz>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] How to use Xenomai libraries with "normal" (non
 Xenomai) linux processes ?
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: roderik.wildenburg@domain.hid
Cc: xenomai@xenomai.org

roderik.wildenburg@domain.hid wrote:
>>> From this scenario deduce the following questions :
>>>=20
>>> 1.) Linking a linux-process with a Xenomai-library "transforms"
>>> the linux process to a Xenomai-process/task. Is this true ?
>> Yes, and you need this to be able to call Xenomai services.
>=20
> O.k. I thought so.
>=20
>> For your issue, we could probably use the existing process priority
>>  instead of forcing SCHED_OTHER, 0. But for this to work, we have
>> to be sure that the "sysup" process does not call=20
>> sched_setscheduler too late after the creation of the process, IOW,
>> there is a race condition.
>=20
> I don=B4t understand this. Isn=B4t this a contradiction to your answer =
in
> 2.) ? I thought sched_setscheduler does not work for Xenomai tasks
> and in our testcase we could see that scheduling policy isn=B4t set as
> expected (to SCHED_FIFO).

Currently the posix skin library does, in init.c:
       parm.sched_priority =3D 0;
        err =3D __wrap_pthread_setschedparam(pthread_self(), SCHED_OTHER,=

                                           &parm);

We could replace this with:
	err =3D pthread_getschedparam(pthread_self(), &policy, &parm);
	if (err)
		...
	err =3D __wrap_pthread_setschedparam(pthread_self(),
					   policy, &parm);

But sched_setscheduler could be called after that, so this is racy.


>=20
>> But I still do not understand why you can not handle this in the
>> xenomai library. For instance by passing the priority to an
>> initialization function. You would avoid the race.
>>=20
>=20
> The process "linuxwithxenolib" does not know anything about the
> priority, as "sysup" manages the scheduling parameters for him (reads
> configuration file,...; this has mainly historic reasons (ported from
> other OS)), therfore "linuxwithxenolib" can not pass the priority to
> my library. This is not realy very beautiful and I think we have to
> think about it.
>=20
>=20
>>> 2.) Is there a way to influence the priority and scheduling
>> policy of
>>> a Xenomai-task from outside the task (from an other task (like=20
>>> "sysup"); like sched_setscheduler can do for linux processes) ?
>> No.
> O.K. I probably have to accept this. So we have to think about an
> other solution (probably set the priority within "linuxwithxenolib").
>=20
>=20
>>> 3.) As soon as a Xenomai-systemcall (e.g. clock_gettime,
>>> sem_post, sem_wait) is executed in this process the process is
>>> scheduled in primary mode ?
>> For some services, yes, for others no. You can find the information
>> in the online documentation.
>>=20
>>> 4.) Is there a way, to force back a process to secondary mode
>>> (after the Xenomai-systemcall has been executed) ?
>> Yes, but no, you do not want to do that. Xenomai automatically
>> switches the process when needed.
>>=20
>=20
> But yes, I want, I want, I want  ;-)) Think about the following
> scenario: 1)"linuxwithxenolib" calls my xenomai-library. 2)Due to a
> xenomai systemcall in my library "linuxwithxenolib" switches to
> primary mode 3)"linuxwithxenolib" leaves my library function=20
> 4)"linuxwithxenolib" is still in primary mode and acts as a realtime
> task till it calls a linux-systemcall. This isn=B4t the way
> "linuxwithxenolib" should act. It should be scheduled by linux as
> often and as long as possible. 5)So, if I could force secondary mode
> at the end of my library function everything would be fine.
>=20
> So how can I force secondary mode ?

The point is that if you force it to secondary mode, and the next system
call is in fact a xenomai syscall, xenomai will switch the thread to
primary mode again. So, you have two useless mode switches which you
could have avoided if you had not forcibly switched to secondary mode.
Note that even if a xenomai thread is running in secondary mode and has
a priority higher than another xenomai thread running in primary mode,
the one running in secondary mode will run. So, you should not use
primary mode and secondary mode to decide which thread should run, you
should use the priorities.

--=20
                                                 Gilles.


