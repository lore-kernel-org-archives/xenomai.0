Message-ID: <4FD1C67E.5010600@xenomai.org>
Date: Fri, 08 Jun 2012 11:31:42 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <CAKKWdtfz7+pRjjbE6Ev4zJNZpa45axMePyVar+3MyRyMvcp8aA@mail.gmail.com>	<4FCF1517.3010904@xenomai.org>	<CAKKWdtfRyuhDzmvCC-WM66+=ncs+ocbdUuop2TRNThsj6ZAy6g@mail.gmail.com>	<4FCF1ED5.5000403@xenomai.org>	<CAKKWdtd6p2-xHH1FdjVzbX-raNtDkvMemALrQBJMgoTb1dScnw@mail.gmail.com>	<4FCF2751.5070700@xenomai.org>	<4FCF4D05.3070502@xenomai.org>	<4FCF58AF.5040106@xenomai.org>	<4FCF5A4C.60704@xenomai.org>	<4FCF5DED.8060007@xenomai.org>	<4FCF60CD.8000709@xenomai.org>	<4FCF6152.7010002@xenomai.org>	<4FCF62DD.10102@xenomai.org>
	<4FCF68CA.8010206@xenomai.org>	<4FCF713F.1030603@xenomai.org>
	<4FCF7418.4020805@xenomai.org>	<4FCF7576.8030201@xenomai.org>
	<4FCF9A1E.6090706@xenomai.org> <4FCF9AAD.7020707@xenomai.org>
	<4FD1C3EE.1000005@xenomai.org> <4FD1C50D.5010906@xenomai.org>
	<4FD1C60D.401@xenomai.org>
In-Reply-To: <4FD1C60D.401@xenomai.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] xenomai-2.6.0 instrumentation commands not executing
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Xenomai@xenomai.org

On 06/08/2012 11:29 AM, Philippe Gerum wrote:
> On 06/08/2012 11:25 AM, Gilles Chanteperdrix wrote:
>> On 06/08/2012 11:20 AM, Philippe Gerum wrote:
>>> On 06/06/2012 08:00 PM, Gilles Chanteperdrix wrote:
>>>> On 06/06/2012 07:57 PM, Gilles Chanteperdrix wrote:
>>>>> On 06/06/2012 05:21 PM, Philippe Gerum wrote:
>>>>>> On 06/06/2012 05:15 PM, Gilles Chanteperdrix wrote:
>>>>>>> On 06/06/2012 05:03 PM, Philippe Gerum wrote:
>>>>>>>> On 06/06/2012 04:27 PM, Gilles Chanteperdrix wrote:
>>>>>>>>> On 06/06/2012 04:02 PM, Gilles Chanteperdrix wrote:
>>>>>>>>>> On 06/06/2012 03:55 PM, Gilles Chanteperdrix wrote:
>>>>>>>>>>> On 06/06/2012 03:53 PM, Philippe Gerum wrote:
>>>>>>>>>>>> On 06/06/2012 03:41 PM, Gilles Chanteperdrix wrote:
>>>>>>>>>>>>> On 06/06/2012 03:25 PM, Philippe Gerum wrote:
>>>>>>>>>>>>>> On 06/06/2012 03:18 PM, Gilles Chanteperdrix wrote:
>>>>>>>>>>>>>>> On 06/06/2012 02:28 PM, Philippe Gerum wrote:
>>>>>>>>>>>>>>>> On 06/06/2012 11:48 AM, Philippe Gerum wrote:
>>>>>>>>>>>>>>>>> On 06/06/2012 11:18 AM, ali hagigat wrote:
>>>>>>>>>>>>>>>>>> Much appreciate for the reply, Mr. Gerum. Here is the
>>>>>>>>>>>>>>>>>> result of ldd
>>>>>>>>>>>>>>>>>> command:
>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>> http://www.xenomai.org/pipermail/xenomai-help/2011-12/msg00012.html
>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> Alternatively, this patch may work as well (not tested,
>>>>>>>>>>>>>>>> but this
>>>>>>>>>>>>>>>> looks like a former issue we had with aggressive
>>>>>>>>>>>>>>>> optimizers):
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> diff --git a/src/skins/posix/init.c
>>>>>>>>>>>>>>>> b/src/skins/posix/init.c
>>>>>>>>>>>>>>>> index 7a338a0..9c7849e 100644
>>>>>>>>>>>>>>>> --- a/src/skins/posix/init.c
>>>>>>>>>>>>>>>> +++ b/src/skins/posix/init.c
>>>>>>>>>>>>>>>> @@ -43,6 +43,7 @@ void pse51_clock_init(int);
>>>>>>>>>>>>>>>> static __attribute__ ((constructor))
>>>>>>>>>>>>>>>> void __init_posix_interface(void)
>>>>>>>>>>>>>>>> {
>>>>>>>>>>>>>>>> + volatile pthread_t tid = pthread_self();
>>>>>>>>>>>>>>>> #ifndef CONFIG_XENO_LIBS_DLOPEN
>>>>>>>>>>>>>>>> struct sched_param parm;
>>>>>>>>>>>>>>>> int policy;
>>>>>>>>>>>>>>>> @@ -80,14 +81,14 @@ void __init_posix_interface(void)
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> /* Don't use auto-shadowing if we are likely invoked
>>>>>>>>>>>>>>>> from dlopen. */
>>>>>>>>>>>>>>>> #ifndef CONFIG_XENO_LIBS_DLOPEN
>>>>>>>>>>>>>>>> - err =
>>>>>>>>>>>>>>>> __real_pthread_getschedparam(pthread_self(),&policy,&parm);
>>>>>>>>>>>>>>>> + err = __real_pthread_getschedparam(tid,&policy,&parm);
>>>>>>>>>>>>>>>> if (err) {
>>>>>>>>>>>>>>>> fprintf(stderr, "Xenomai Posix skin init: "
>>>>>>>>>>>>>>>> "pthread_getschedparam: %s\n", strerror(err));
>>>>>>>>>>>>>>>> exit(EXIT_FAILURE);
>>>>>>>>>>>>>>>> }
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> - err = __wrap_pthread_setschedparam(pthread_self(),
>>>>>>>>>>>>>>>> policy,&parm);
>>>>>>>>>>>>>>>> + err = __wrap_pthread_setschedparam(tid, policy,&parm);
>>>>>>>>>>>>>>>> if (err) {
>>>>>>>>>>>>>>>> fprintf(stderr, "Xenomai Posix skin init: "
>>>>>>>>>>>>>>>> "pthread_setschedparam: %s\n", strerror(err));
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> There should not be any issue here, as the pthread_self()
>>>>>>>>>>>>>>> is passed as
>>>>>>>>>>>>>>> an argument to the called functions, the syscall is not
>>>>>>>>>>>>>>> inlined directly.
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> Did you get any disassembly of the faulty code when
>>>>>>>>>>>>>> suggesting
>>>>>>>>>>>>>> -fno-omit-frame-pointer last time you did?
>>>>>>>>>>>>>>
>>>>>>>>>>>>> No, but I had experienced the problem first hand.
>>>>>>>>>>>>>
>>>>>>>>>>>>
>>>>>>>>>>>> It would be interesting to know why we have to force a frame
>>>>>>>>>>>> pointer in
>>>>>>>>>>>> there. I'm not comfortable with voodoo fixing, that bug
>>>>>>>>>>>> might bite later
>>>>>>>>>>>> on as gcc's optimizer is unlikely to become less aggressive
>>>>>>>>>>>> over time.
>>>>>>>>>>>>
>>>>>>>>>>> Ah this, I know. I have posted a mail where I explained the
>>>>>>>>>>> problem. I
>>>>>>>>>>> am a bit in a short schedule here, will post the link tonight.
>>>>>>>>>>>
>>>>>>>>>> http://xenomai.org/pipermail/xenomai-core/2011-08/msg00029.html
>>>>>>>>>>
>>>>>>>>>
>>>>>>>>> In the mails following this one, I found how to fix the
>>>>>>>>> assembly to work
>>>>>>>>> in the omit-frame-pointer case. The real problem is that, at
>>>>>>>>> compilation
>>>>>>>>> time, we have no command-line #defined variable telling us whether
>>>>>>>>> compiling with frame pointers enabled. And it does not seem
>>>>>>>>> easy to
>>>>>>>>> write a configure test script, which tests whether frame
>>>>>>>>> pointers are
>>>>>>>>> enabled or not.
>>>>>>>>>
>>>>>>>>
>>>>>>>> I'd suggest that at some point, we move all the syscall
>>>>>>>> trampolines out
>>>>>>>> of line, and specifically build the resulting file forcing
>>>>>>>> -fno-omit-frame-pointer. Such inlining will always be fragile
>>>>>>>> until we
>>>>>>>> actually control the way that compilation unit is built,
>>>>>>>> regardless of
>>>>>>>> the general settings for CFLAGS.
>>>>>>>>
>>>>>>> In the current 2.6 repository, we force -fno-omit-frame-pointer
>>>>>>> on x86_32.
>>>>>>>
>>>>>>
>>>>>> Yes, but that is crappy. The point is that we don't want to force
>>>>>> this
>>>>>> for all userland bits. We'd only need this for syscall trampolines.
>>>>>>
>>>>> We currently have different flags for compiling xenomai than for
>>>>> passing
>>>>> to the applications (via xeno-config). The problem is that I am not
>>>>> sure
>>>>> it will not break for instance calling "backtrace" in gdb when
>>>>> breaking
>>>>> inside a xenomai function.
>>>>>
>>>> (mixing code compiled without frame pointers with code compiled with
>>>> frame pointers I mean).
>>>>
>>>
>>> The only issue is with frame elimination starting with -O2 and above,
>>> otherwise the backtraces are clean over gdb (just checked), at least
>>> there does not seem to be any additional problem introduced by mixing bp
>>> and no-bp. At any rate, -O0 -g is recommended to get clean and detailed
>>> (back)traces anyway, and this is what we pick when --enable-debug is
>>> given.
>>>
>>> We should move each existing inline XENOMAI_SYS/SKINCALL macro into its
>>> own C trampoline, group all trampolines into separate compilation units,
>>> and build each of these units with -fno-omit-frame-pointer
>>> unconditionally.
>>>
>>> -forge is a good candidate for this, since the number of syscall
>>> trampolines shrunk dramatically compared to 2.x. If any issue would be
>>> easily detected based on the output of the new "slackspot" tracer we
>>> have there.
>>>
>> It looks to me like we can simply build xenomai libraries with
>> -fno-omit-frame-pointer, and compile the rest without this option. After
>> all, implementation of xenomai services are little more than syscall
>> trampolines.
>>
>
> This is true for 2.x, however -forge will need the other approach.
>

Unless you only mean lib/cobalt for 3.x, in which case I would agree.

-- 
Philippe.

