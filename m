MIME-Version: 1.0
In-Reply-To: <50969840.5010705@xenomai.org>
References: <CAOiXNkCw3e4mK7XeNif2MM5Ub2__xK8UKxaPNRzzMQUbWdhYRg@mail.gmail.com>
	<ff881ad96344018ff2cbf9f8211d7603.squirrel@www.xenomai.org>
	<CAOiXNkBMKNbXOAThav8L9esyRMLBHPk7uFg5fRPhifR_Sg4rXA@mail.gmail.com>
	<9d3ef55df641c8657ce09c6f6e023e4a.squirrel@www.xenomai.org>
	<CAOiXNkA8u2TjB7FXoJh7opxasgCvnuFkuqOEPZ=tCMz-f-HMpQ@mail.gmail.com>
	<2b4941d6b09c5560d4074bc644ded41d.squirrel@www.xenomai.org>
	<CAOiXNkC=C6A=Mfhqx2rjg61D9UaOB55bnm-n5mOArsmpXdU-sg@mail.gmail.com>
	<50958A57.8010902@xenomai.org>
	<CAOiXNkAQxitHg=uQRhL-+h1vNGRQh-3-JXaOz78NmvwdtqDTdA@mail.gmail.com>
	<50958DD4.1000702@xenomai.org>
	<CAOiXNkANO_1205mweCok_34Z_fQgLFRtg4w4xehNj3X+xOpfQw@mail.gmail.com>
	<50969840.5010705@xenomai.org>
Date: Sun, 4 Nov 2012 17:43:50 +0100
Message-ID: <CAOiXNkDY0aofK=woRrF8+Uh0LZVPjx8qVLB6DUVS+xhmKsyB3g@mail.gmail.com>
From: Andrey Nechypurenko <andreynech@googlemail.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] rt_task_create fails when running over ssh
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

On 4 November 2012 17:30, Gilles Chanteperdrix
<gilles.chanteperdrix@xenomai.org> wrote:
> On 11/04/2012 05:13 PM, Andrey Nechypurenko wrote:
>
>> On 3 November 2012 22:34, Gilles Chanteperdrix
>> <gilles.chanteperdrix@xenomai.org> wrote:
>>> On 11/03/2012 10:32 PM, Andrey Nechypurenko wrote:
>>>
>>>>> Use the DESTDIR environment variable (you can look inside xeno-config=
 to
>>>>> see how it works, it should be pretty obvious).
>>>>
>>>> Thanks for the hint. I'll definitely try. However I doubt that it
>>>> would solve the issue with rt_task_create() since I were actually
>>>> copy-pasting the output from xeno-config and only change the -I and -L
>>>> flags to reflect my directory structure.
>>>
>>>
>>> Yes, I also doubt that very much. What about the arm/thumb issue?
>>
>> I've run strace and found the following line in the output when
>> starting the programm over ssh:
>> sched_setscheduler(440, SCHED_FIFO, { 99 }) =3D -1 EPERM (Operation not =
permitted)
>> I assume, that this call is the part of rt_task_create(). In contrast,
>> the same call gets no errors if running in the serial console. Really
>> strange to me.
>>
>> My attempts to change corresponding priorities with ulimit command or
>> setrlimit() function does not solve the issue. So it seams like ssh
>> server limits some permissions somehow which causes rt_task_create()
>> to fail.

> Did you check if your compiler compiles thumb code or arm code by default=
?

objdump says: file format elf32-littlearm
and file says: ELF 32-bit LSB executable, ARM, version 1 (SYSV)

> You can run ulimit to check the current limits.
> And it would be interesting to run the "whoami" command or use getuid()
> in the program to check whether you are really running as the root user.

$ ulimit -a
core file size          (blocks, -c) 0
data seg size           (kbytes, -d) unlimited
scheduling priority             (-e) 0
file size               (blocks, -f) unlimited
pending signals                 (-i) 79200
max locked memory       (kbytes, -l) 64
max memory size         (kbytes, -m) unlimited
open files                      (-n) 1024
pipe size            (512 bytes, -p) 8
POSIX message queues     (bytes, -q) 819200
real-time priority              (-r) 0
stack size              (kbytes, -s) 8192
cpu time               (seconds, -t) unlimited
max user processes              (-u) 79200
virtual memory          (kbytes, -v) unlimited
file locks                      (-x) unlimited

Running ulimit -r unlimited does not helps. I've also tried the
following code before calling rt_task_create():


  printf("User id: %i\n", getuid());
  getrlimit(RLIMIT_RTPRIO, &resource_limit);
  printf("Previous limits: soft=3D%lld; hard=3D%lld\n",
	 (long long) resource_limit.rlim_cur, (long long) resource_limit.rlim_max)=
;
  printf("Max FIFO priority is: %i .\n Setting max limit to 99\n",
sched_get_priority_max(SCHED_FIFO));
  resource_limit.rlim_cur =3D 99;
  resource_limit.rlim_max =3D 99;
  if(0 !=3D setrlimit(RLIMIT_RTPRIO, &resource_limit))

The output is:

User id: 0
Previous limits: soft=3D0; hard=3D0
Max FIFO priority is: 99 .
 Setting max limit to 99

setrlimit() does not return the error, but still rt_task_create()
fails. I found the following post in the internet, which might explain
the reason since I am also using systemd (Angstrom).

Question

I have a daemon that calls pthread_setschedparam() to set the thread
priority. On a system using systemd (OpenSuse 12.1), this fails,
because sched_setscheduler() returns EPERM.

>From what I understand systemd doesn=92t use the permissions set in
/etc/security/limits.conf any more where I used to be able to allow
this.

How can I allow a deamon to change RT priorities when using systemd ?
Asked by Gene Vincent

Answer

First read =93man systemd.exec=94 and next experiment with LimitRTPRIO and
LimitRTTIME or CPUSchedulingPolicy, CPUSchedulingPriority
CPUSchedulingResetOnFork in daemon service file.


--
Andrey.

