Message-ID: <4976FEA7.5010707@domain.hid>
Date: Wed, 21 Jan 2009 10:53:27 +0000
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <5D63919D95F87E4D9D34FF7748CE2C2A01776901@domain.hid>
In-Reply-To: <5D63919D95F87E4D9D34FF7748CE2C2A01776901@domain.hid>
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
>> It is not your job to decide the priority of a xenomai thread when
>> it runs in secondary mode, you have to set the xenomai scheduler's
>> priority of the thread, and xenomai itself will change the priority
>> for linux scheduler. The way to do this is to call
>> pthread_setschedparam in the "linuxwithxenolib" process.
>=20
> You would be right if I would design a new process, but
> "linuxwithxenolib" is an existing (Linux) process which is just
> linked with my Xenomai-library and should be influenced as few as
> possible by my library (this process still should act as an
> prioritzed Linux process as far as possible). This process, and
> several others, are spawned by "sysup" and "sysup" sets the priority
> and the scheduling policy (to SCHED_FIFO) of the spawned processes.
> This is an existing mechanism (!) and could not changed easily, as it
> would have backlash to many other processes (and people -whose
> Xenomai skills are poor- developing these processes, ). Additional to
> these ordinary Linux processes we have several pure
> Xenomai-processes, which of course, use pthread_setschedparam to set
> their scheduling parameters. These pure Xenomai-processes are also
> using my Xenomai-library.
>=20
> From this scenario deduce the following questions :
>=20
> 1.) Linking a linux-process with a Xenomai-library "transforms" the
> linux process to a Xenomai-process/task. Is this true ?

Yes, and you need this to be able to call Xenomai services.

For your issue, we could probably use the existing process priority
instead of forcing SCHED_OTHER, 0. But for this to work, we have to be
sure that the "sysup" process does not call sched_setscheduler too late
after the creation of the process, IOW, there is a race condition.

But I still do not understand why you can not handle this in the xenomai
library. For instance by passing the priority to an initialization
function. You would avoid the race.

>=20
> 2.) Is there a way to influence the priority and scheduling policy of
> a Xenomai-task from outside the task (from an other task (like
> "sysup"); like sched_setscheduler can do for linux processes) ?

No.

>=20
> 3.) As soon as a Xenomai-systemcall (e.g. clock_gettime, sem_post,
> sem_wait) is executed in this process the process is scheduled in
> primary mode ?

For some services, yes, for others no. You can find the information in
the online documentation.

>=20
> 4.) Is there a way, to force back a process to secondary mode (after
> the Xenomai-systemcall has been executed) ?

Yes, but no, you do not want to do that. Xenomai automatically switches
the process when needed.

>=20
> Thank you for your patience and endurance in understanding my problem
> (my english probabliy isn=B4t very helpfull for this).
>=20
> Roderik


--=20
                                                 Gilles.


