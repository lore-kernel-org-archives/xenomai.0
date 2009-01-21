Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 21 Jan 2009 10:53:35 +0100
Message-ID: <5D63919D95F87E4D9D34FF7748CE2C2A01776901@domain.hid>
In-Reply-To: <4975EAF5.2000604@domain.hid>
From: <roderik.wildenburg@domain.hid>
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
To: gilles.chanteperdrix@xenomai.org
Cc: xenomai@xenomai.org


> It is not your job to decide the priority of a xenomai thread when it
> runs in secondary mode, you have to set the xenomai=20
> scheduler's priority
> of the thread, and xenomai itself will change the priority for linux
> scheduler. The way to do this is to call pthread_setschedparam in the
> "linuxwithxenolib" process.

You would be right if I would design a new process, but =
"linuxwithxenolib" is an existing (Linux) process which is just linked =
with my Xenomai-library and should be influenced as few as possible by =
my library (this process still should act as an prioritzed Linux process =
as far as possible). This process, and several others, are spawned by =
"sysup" and "sysup" sets the priority and the scheduling policy (to =
SCHED_FIFO) of the spawned processes. This is an existing mechanism (!) =
and could not changed easily, as it would have backlash to many other =
processes (and people -whose Xenomai skills are poor- developing these =
processes, ).
Additional to these ordinary Linux processes we have several pure =
Xenomai-processes, which of course, use pthread_setschedparam to set =
their scheduling parameters. These pure Xenomai-processes are also using =
my Xenomai-library.

>From this scenario deduce the following questions :

1.) Linking a linux-process with a Xenomai-library "transforms" the =
linux process to a Xenomai-process/task. Is this true ?

2.) Is there a way to influence the priority and scheduling policy of a =
Xenomai-task from outside the task (from an other task (like "sysup"); =
like sched_setscheduler can do for linux processes) ?

3.) As soon as a Xenomai-systemcall (e.g. clock_gettime, sem_post, =
sem_wait) is executed in this process the process is scheduled in =
primary mode ?

4.) Is there a way, to force back a process to secondary mode (after the =
Xenomai-systemcall has been executed) ?

Thank you for your patience and endurance in understanding my problem =
(my english probabliy isn=B4t very helpfull for this).

Roderik

