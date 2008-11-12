Message-ID: <491A99E9.9020300@domain.hid>
Date: Wed, 12 Nov 2008 09:55:05 +0100
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
References: <491805AE.1060809@domain.hid>
	<52e18582a48da6c08ed88bbce325aed8.squirrel@domain.hid>
	<491829F9.2050305@domain.hid>
	<c54f288fee2b8a5ee68a00c27056c6ed.squirrel@domain.hid>
	<491883AF.4080901@domain.hid>
	<38dc4158684af6886f4e464c964a557d.squirrel@domain.hid>
	<4918940F.30201@domain.hid> <491A0B3A.9020702@domain.hid>
In-Reply-To: <491A0B3A.9020702@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Mode switch when using RT heap on ARM
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
Cc: xenomai-help <xenomai@xenomai.org>

Gilles Chanteperdrix wrote:
> Wolfgang Grandegger wrote:
>> Gilles Chanteperdrix wrote:
>>> Wolfgang Grandegger wrote:
>>>> Gilles Chanteperdrix wrote:
>>>>> Wolfgang Grandegger wrote:
>>>>>> Gilles Chanteperdrix wrote:
>>>>>>> Wolfgang Grandegger wrote:
>>>>>>>> Hello,
>>>>>>>>
>>>>>>>> I realized that accessing memory allocated with rt_heap_alloc()
>>>>>>>> causes
>>>>>>>> mode switches on ARM i.mx31. The attached patch provides a demo
>>>>>>>> program
>>>>>>>> to demonstrate the problem, which actually does *not* show up on my
>>>>>>>> PowerPC TQM5200 board.
>>>>>>> On ARM, we normally map the heaps uncacheable, this should not be
>>>>>>> necessary on ARMv6, but I am afraid we then get the fault on first
>>>>>>> access.
>>>>>> Is each cache-line of the heap not touched automatically when the heap
>>>>>> gets created? I thought it's necessary for other archs as well.
>>>>> No, the thing which comes near to this is the workaround in I-pipe of
>>>>> the
>>>>> way pages are write-protected upon fork. But this happens only upon
>>>>> fork.
>>>>> I am not sure I understand all the subtleties of ARM memory management,
>>>>> but I think this fault on first write is the way the "dirty" bit is
>>>>> implemented.
>>>> Well, it seems not to be that simple. My attached rtheap example program
>>>> behaves the following way:
>>>>
>>>> - Heap-mode=0: I see plenty of mode switches also for read-only:
>>> Maybe that is expected on ARM ? But what I do not understand is that you
>>> get 300 modes switches where as your example makes two faults every 10ms
>>> during 10 seconds, so, you should see something like 1000 modes switches.
>> And even more because the program writes/reads at the beginning and end
>> of the buffer. I realized that as well. Not every read/write seems to
>> provoke a mode switch.
>>
>>>>   # cat /proc/xenomai/stat ;sleep 10; cat /proc/xenomai/stat
>>>>   CPU  PID    MSW        CSW        PF    STAT       %CPU  NAME
>>>>     0  0      0          2951       0     00400080   99.7  ROOT
>>>>     0  929    102        398        3     00300184    0.0  rtheap
>>>>     0  0      0          23005      0     00000000    0.1  IRQ29: [timer]
>>>>   CPU  PID    MSW        CSW        PF    STAT       %CPU  NAME
>>>>     0  0      0          4287       0     00400080   99.4  ROOT
>>>>     0  929    435        1734       3     00300184    0.4  rtheap
>>>>     0  0      0          25010      0     00000000    0.1  IRQ29: [timer]
>>>>
>>>> - Heap-mode=H_NONCACHED: I see just 2 mode switches but the system
>>>>   gets very slow:
>>> That is expected. But where do you get the 2 mode switches ?
>> When the task writes to the heap memory for the first time. And I just
>> realized that the write/read to the end of the buffer makes real
>> trouble. The task seems to hang (or wait for something):
>>
>> -bash-3.2# cat sched
>> CPU  PID    PRI      PERIOD     TIMEOUT    TIMEBASE  STAT       NAME
>>   0  0       99      0          0          master    R          ROOT
>>   0  1114    99      100000000  0          master    X          rtheap
>>
>> At the same time the system gets slow.
>>
>> So far I understood from your comments that rtheap is not really usable
>> on ARM, right? What other option do I have?
> 
> I need to double check, but I am almost sure that we do not get faults
> with uncacheable heaps on ARM < 6, because we use such heaps for fast
> mutexes.
> 
> So, what you observe is probably an ARMv6 or VIPT cache effect.
> 
> Now, from your program, it seems that you use rtheaps as real-time
> allocator. This is overkill, rtheaps are designed to share memory
> between kernel-space and user-space. For other usages, you probably do
> not need rtheaps.

I need to dynamically allocate and free memory in a real-time task. I
thought that the RT heap is exactly for that purpose but that seems not
to be case. I actually need to implement my own simply allocater using
malloc'ed memory.

> Nevertheless, I agree that they need fixing on ARMv6.

Looks like.

Wolfgang.



