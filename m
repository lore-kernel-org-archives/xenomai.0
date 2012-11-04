Message-ID: <5096A7AB.3020508@xenomai.org>
Date: Sun, 04 Nov 2012 18:36:43 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAOiXNkCw3e4mK7XeNif2MM5Ub2__xK8UKxaPNRzzMQUbWdhYRg@mail.gmail.com>	<ff881ad96344018ff2cbf9f8211d7603.squirrel@www.xenomai.org>	<CAOiXNkBMKNbXOAThav8L9esyRMLBHPk7uFg5fRPhifR_Sg4rXA@mail.gmail.com>	<9d3ef55df641c8657ce09c6f6e023e4a.squirrel@www.xenomai.org>	<CAOiXNkA8u2TjB7FXoJh7opxasgCvnuFkuqOEPZ=tCMz-f-HMpQ@mail.gmail.com>	<2b4941d6b09c5560d4074bc644ded41d.squirrel@www.xenomai.org>	<CAOiXNkC=C6A=Mfhqx2rjg61D9UaOB55bnm-n5mOArsmpXdU-sg@mail.gmail.com>	<50958A57.8010902@xenomai.org>	<CAOiXNkAQxitHg=uQRhL-+h1vNGRQh-3-JXaOz78NmvwdtqDTdA@mail.gmail.com>	<50958DD4.1000702@xenomai.org>	<CAOiXNkANO_1205mweCok_34Z_fQgLFRtg4w4xehNj3X+xOpfQw@mail.gmail.com>	<50969840.5010705@xenomai.org>	<CAOiXNkDY0aofK=woRrF8+Uh0LZVPjx8qVLB6DUVS+xhmKsyB3g@mail.gmail.com>	<5096A058.30204@xenomai.org>
	<CAOiXNkA36u_=B4KCgshbY_DN=PJ0hiX9PTWecJC+KjG817N3Yw@mail.gmail.com>
In-Reply-To: <CAOiXNkA36u_=B4KCgshbY_DN=PJ0hiX9PTWecJC+KjG817N3Yw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] rt_task_create fails when running over ssh
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Andrey Nechypurenko <andreynech@googlemail.com>
Cc: xenomai@xenomai.org

On 11/04/2012 06:14 PM, Andrey Nechypurenko wrote:

> On 4 November 2012 18:05, Gilles Chanteperdrix
> <gilles.chanteperdrix@xenomai.org> wrote:
>> On 11/04/2012 05:43 PM, Andrey Nechypurenko wrote:
>>
>>> On 4 November 2012 17:30, Gilles Chanteperdrix
>>> <gilles.chanteperdrix@xenomai.org> wrote:
>>>> On 11/04/2012 05:13 PM, Andrey Nechypurenko wrote:
>>>>
>>>>> On 3 November 2012 22:34, Gilles Chanteperdrix
>>>>> <gilles.chanteperdrix@xenomai.org> wrote:
>>>>>> On 11/03/2012 10:32 PM, Andrey Nechypurenko wrote:
>>>>>>
>>>>>>>> Use the DESTDIR environment variable (you can look inside xeno-config to
>>>>>>>> see how it works, it should be pretty obvious).
>>>>>>>
>>>>>>> Thanks for the hint. I'll definitely try. However I doubt that it
>>>>>>> would solve the issue with rt_task_create() since I were actually
>>>>>>> copy-pasting the output from xeno-config and only change the -I and -L
>>>>>>> flags to reflect my directory structure.
>>>>>>
>>>>>>
>>>>>> Yes, I also doubt that very much. What about the arm/thumb issue?
>>>>>
>>>>> I've run strace and found the following line in the output when
>>>>> starting the programm over ssh:
>>>>> sched_setscheduler(440, SCHED_FIFO, { 99 }) = -1 EPERM (Operation not permitted)
>>>>> I assume, that this call is the part of rt_task_create(). In contrast,
>>>>> the same call gets no errors if running in the serial console. Really
>>>>> strange to me.
>>>>>
>>>>> My attempts to change corresponding priorities with ulimit command or
>>>>> setrlimit() function does not solve the issue. So it seams like ssh
>>>>> server limits some permissions somehow which causes rt_task_create()
>>>>> to fail.
>>>
>>>> Did you check if your compiler compiles thumb code or arm code by default?
>>>
>>> objdump says: file format elf32-littlearm
>>> and file says: ELF 32-bit LSB executable, ARM, version 1 (SYSV)
>>
>>
>> The result is the same with thumb code. In order to know if a binary is
>> thumb or arm, run objdump and check if the binary contains 16 bits
>> instructions.
>>
>>>
>>>> You can run ulimit to check the current limits.
>>>> And it would be interesting to run the "whoami" command or use getuid()
>>>> in the program to check whether you are really running as the root user.
>>>
>>> $ ulimit -a
>>
>>
>> What about whoami or id (it would be nice if did not have to ask the
>> same questions 3 times)?
> 
> From my *previous* post:
> 
> printf("User id: %i\n", getuid()); <<<<<<<<< ist it what you were asking for?
>   getrlimit(RLIMIT_RTPRIO, &resource_limit);
>   printf("Previous limits: soft=%lld; hard=%lld\n",
>          (long long) resource_limit.rlim_cur, (long long)
> resource_limit.rlim_max);
> 
> The output is:
> 
> User id: 0 <<<<<<<<<<<<<<<<<<<<< ist it what you were asking for?
> Previous limits: soft=0; hard=0
> Max FIFO priority is: 99 .
>  Setting max limit to 99


Yes, in an obfuscated way.

> 
> As I found here: https://bugzilla.redhat.com/show_bug.cgi?id=655321
> ----
> In the meantime, you can avoid the problem by disabling the cpu cgroup
> from /etc/systemd/system.conf. That is, change
> #DefaultControllers=cpu
> into
> DefaultControllers=
> ----
> 
> Changing systemd.conf as suggested above solved the problem.


Fine.

-- 
                                                                Gilles.

