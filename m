References: <5601A1A1.2020506@siemens.com> <560263A0.4080208@sigmatek.at>
 <56026810.8040300@sigmatek.at> <56028093.6050805@siemens.com>
 <56050985.2060002@sigmatek.at> <560A8632.3020107@sigmatek.at>
 <560AB4C7.3050508@xenomai.org> <561256C6.4070508@sigmatek.at>
 <561264DD.2020803@xenomai.org> <5614DF5C.200@sigmatek.at>
 <5614E0C7.6000309@xenomai.org> <56152AED.6050407@sigmatek.at>
 <561539EB.9090301@xenomai.org> <56161B52.1070903@sigmatek.at>
 <561E043C.1020002@sigmatek.at> <561E0F30.4000800@xenomai.org>
 <5624B9E5.2040305@sigmatek.at>
From: =?UTF-8?Q?Harald_Fe=c3=9fl?= <harald.fessl@sigmatek.at>
Message-ID: <5628E3EB.5040109@sigmatek.at>
Date: Thu, 22 Oct 2015 15:26:03 +0200
MIME-Version: 1.0
In-Reply-To: <5624B9E5.2040305@sigmatek.at>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] Fwd: Re: Problem that the Linux scheduler is not
 called for some ms
Reply-To: harald.fessl@sigmatek.at
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: rpm@xenomai.org, xenomai@xenomai.org

Am 19.10.2015 um 11:37 schrieb Harald Feßl:
> Am 14.10.2015 um 10:15 schrieb Philippe Gerum:
>> On 10/14/2015 09:29 AM, Harald Feßl wrote:
>>> Am 08.10.2015 um 09:29 schrieb Harald Feßl:
>>>> Am 07.10.2015 um 17:27 schrieb Philippe Gerum:
>>>>> On 10/07/2015 04:23 PM, Harald Feßl wrote:
>>>>>> Am 07.10.2015 um 11:07 schrieb Philippe Gerum:
>>>>>>> On 10/07/2015 11:01 AM, Johann Obermayr wrote:
>>>>>>>> Am 05.10.2015 um 13:54 schrieb Philippe Gerum:
>>>>>>>>> On 10/05/2015 12:53 PM, Johann Obermayr wrote:
>>>>>>>>>> Am 29.09.2015 um 17:56 schrieb Philippe Gerum:
>>>>>>>>>>> On 09/29/2015 02:38 PM, Johann Obermayr wrote:
>>>>>>>>>>>> Am 25.09.2015 um 10:44 schrieb Harald Feßl:
>>>>>>>>>>>>> Hi
>>>>>>>>>>>>>
>>>>>>>>>>>>> I have done a ipipe trace for some working and one non 
>>>>>>>>>>>>> working
>>>>>>>>>>>>> cycle.
>>>>>>>>>>>>> The trace is stopped after the non working cycle.
>>>>>>>>>>>>> I have marked the working cycles with green and the non 
>>>>>>>>>>>>> working
>>>>>>>>>>>>> cycle
>>>>>>>>>>>>> with red in my graphical trace.
>>>>>>>>>>>>> The ipipe trace and graphical trace are stopped at the same
>>>>>>>>>>>>> time.
>>>>>>>>>>>>>
>>>>>>>>>>>>> After the non working cycle the system is working correct
>>>>>>>>>>>>> again for
>>>>>>>>>>>>> some seconds or minutes.
>>>>>>>>>>>>>
>>>>>>>>>>>>> I think the problem is, that the migration of the task 
>>>>>>>>>>>>> "cyclic"
>>>>>>>>>>>>> from
>>>>>>>>>>>>> xenomai to linux, needs sometimes some ms.
>>>>>>>>>>>>>
>>>>>>>>>>>>> Harald
>>>>>>>>>>>>>
>>>>>>>>>>>>> Harald Fessl
>>>>>>>>>>>>> Betriebssystem
>>>>>>>>>>>>> ________________________________
>>>>>>>>>>>>>
>>>>>>>>>>>>> SIGMATEK GmbH & Co KG
>>>>>>>>>>>>> Sigmatekstraße 1
>>>>>>>>>>>>> 5112 Lamprechtshausen
>>>>>>>>>>>>> Österreich / Austria
>>>>>>>>>>>>>
>>>>>>>>>>>>> Tel.:  +43/6274/4321-0
>>>>>>>>>>>>> Fax:  +43/6274/4321-18
>>>>>>>>>>>>> E-Mail: harald.fessl@sigmatek.at
>>>>>>>>>>>>> http://www.sigmatek-automation.com
>>>>>>>>>>>>>
>>>>>>>>>>>>> ***********************Please
>>>>>>>>>>>>> note:************************************
>>>>>>>>>>>>> This email and all attachments are confidential and intended
>>>>>>>>>>>>> solely for
>>>>>>>>>>>>> the person or entity to whom it is addressed. If you are 
>>>>>>>>>>>>> not the
>>>>>>>>>>>>> named
>>>>>>>>>>>>> addressee you must not make this email and all attachments
>>>>>>>>>>>>> accessible
>>>>>>>>>>>>> to any other person. If you have received this email in error
>>>>>>>>>>>>> please
>>>>>>>>>>>>> delete it together with all attachments.
>>>>>>>>>>>>> *********************************************************************** 
>>>>>>>>>>>>>
>>>>>>>>>>>>>
>>>>>>>>>>>>>
>>>>>>>>>>>>>
>>>>>>>>>>>>>
>>>>>>>>>>>>> Am 23.09.2015 um 12:36 schrieb Jan Kiszka:
>>>>>>>>>>>>>> On 2015-09-23 10:51, Harald Feßl wrote:
>>>>>>>>>>>>>>> Hi
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> The linux tasks are not blocked (not all).
>>>>>>>>>>>>>>> I think the problem is , that the linux scheduler function
>>>>>>>>>>>>>>> in the
>>>>>>>>>>>>>>> kernel
>>>>>>>>>>>>>>> is not called for some ms.
>>>>>>>>>>>>>>> I have also traced the calls to the scheduler function
>>>>>>>>>>>>>>> "static int __sched __schedule(void)"
>>>>>>>>>>>>>>> and sometimes when the decribed problem occur this 
>>>>>>>>>>>>>>> function is
>>>>>>>>>>>>>>> not
>>>>>>>>>>>>>>> called while no linux task are running.
>>>>>>>>>>>>>> If no task is runnable, there is also no reason to invoke
>>>>>>>>>>>>>> schedule.
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> Please post a ftrace log of your system, covering both a
>>>>>>>>>>>>>> working
>>>>>>>>>>>>>> and a
>>>>>>>>>>>>>> non-working cycle, including cobalt* and at least sched 
>>>>>>>>>>>>>> and irq
>>>>>>>>>>>>>> events.
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> Jan
>>>>>>>>>>>>>>
>>>>>>>>>>>> Hello Philippe and Xenomai forum,
>>>>>>>>>>>>
>>>>>>>>>>>> we have some trouble with a xenomai task (cyclic with prio 30)
>>>>>>>>>>>> after
>>>>>>>>>>>> switching to secondary domain.
>>>>>>>>>>>> Linux ARM 3.0, Xenomai 2.6.2.1, and CONFIG_XENO_OPT_PRIOCPL=y.
>>>>>>>>>>> PRIOCPL should be disabled, and all tests redone in this 
>>>>>>>>>>> context.
>>>>>>>>>>>
>>>>>>>>>> Hello,
>>>>>>>>>>
>>>>>>>>>> the result is the same.
>>>>>>>>>> Some time your cyclic task will not schedule after switching to
>>>>>>>>>> secondary domain.
>>>>>>>>>>
>>>>>>>>> I just noticed you were using 2.6.2.1. Several bugs in the domain
>>>>>>>>> switch
>>>>>>>>> mechanism have been fixed since then until 2.6.4, and the latter
>>>>>>>>> still
>>>>>>>>> suffers a recently SMP rescheduling issue already fixed in the 
>>>>>>>>> 2.6.x
>>>>>>>>> maintenance branch.
>>>>>>>>>
>>>>>>>>> You should try running your code on top of that branch before 
>>>>>>>>> diving
>>>>>>>>> any
>>>>>>>>> deeper, I suspect you might be facing a bug that has been fixed
>>>>>>>>> already.
>>>>>>>>>
>>>>>>>> Hello,
>>>>>>>>
>>>>>>>> we have test it with Linux 3.10.53 (Freescale) and Xenomai 2.6.4.
>>>>>>>> But we see the same problem.
>>>>>>>>
>>>>>>> Ok, so please send a trace freeze with that configuration 
>>>>>>> illustrating
>>>>>>> the problem, with PRIOCPL disabled. The previous traces you sent
>>>>>>> include
>>>>>>> RPI noise, which makes their interpretation uncertain.
>>>>>>>
>>>>>> Hello Philippe
>>>>>>
>>>>>> I am working with Johann at the same problem.
>>>>>> We don't know what you mean with RPI noise.
>>>>>> Is there a kernel switch to turn of some trace records.
>>>>> I mean the traces generated by the PRIOCPL option. This one needs 
>>>>> to be
>>>>> disabled.
>>>> Ok, attached there is a ipipe trace without PRIOCPL.
>>>> The trace was stopped after the "cyclic" task was not called for more
>>>> than 3 ms.
>>>> The configuration is still the same as Johann has described.
>>>>
>>> Hello Philippe
>>>
>>> Have you seen any problems in our ipipe trace, which I sent last week ?
>>>
>> >From those traces, the cyclic task is waiting for an event to happen
>> before your watchdog pulls the break:
>>
>> :   + func                -256      0.743  rtdm_event_wait+0x14
>> (lrtdrv_timing_wait+0xa0 [sigmatek_lrt])
>> :   + func                -255+   1.193 rtdm_event_timedwait+0x14
>> (rtdm_event_wait+0x2c)
>>
>> Looking at the timestamps, I can't see any 3 ms stall period for that
>> task, at the very least it still happens to run a few hundreds of µs
>> before your instrumentation code triggers an inactivity timeout.
>>
>> However, that cyclic task invoked a secondary mode call earlier from its
>> processing loop, which caused a relax:
>>
>> :   +*func                -892+   1.083  hisyscall_event+0x14
>> (ipipe_syscall_hook+0x80)
>> :   +*func                -891      0.843  xnshadow_relax+0x14
>> (hisyscall_event+0x238)
>>
>> which eventually ended by a switch back to primary mode:
>>
>> :|  *+func                -282+   1.130 xnpod_resume_thread+0x14
>> (gatekeeper_thread+0x208)
>> :|  *+[  589] cyclic: 30  -281+   1.403 xnpod_resume_thread+0xe8
>> (gatekeeper_thread+0x208)
>> :|  *+func                -280      0.984 __ipipe_restore_head+0x10
>> (gatekeeper_thread+0x2c0)
>> :    +func                -279      0.947  __xnpod_schedule+0x14
>> (gatekeeper_thread+0x2a8)
>>
>> Nothing really bad from the traces at first sight, although your system
>> seems quite loaded, and some patterns tend to favor thundering herds 
>> effect:
>>
>>     +*func                -986      0.889 __rtdm_synch_flush+0x10
>> (period_update+0xd8 [sigmatek_lrt])
>> :|  #*func                -985      0.828  xnsynch_flush+0x14
>> (__rtdm_synch_flush+0xd0)
>> :|  #*func                -985      0.851 xnpod_resume_thread+0x14
>> (xnsynch_flush+0x124)
>> :|  #*[  589] cyclic: 30  -984      0.904 xnpod_resume_thread+0xe8
>> (xnsynch_flush+0x124)
>> :|  #*func                -983+   1.120 xnpod_resume_thread+0x14
>> (xnsynch_flush+0x124)
>> :|  #*[  587] Loader: 29  -982      0.891 xnpod_resume_thread+0xe8
>> (xnsynch_flush+0x124)
>> :|  #*func                -981      0.780 xnpod_resume_thread+0x14
>> (xnsynch_flush+0x124)
>> :|  #*[  593] backgrou 0  -980      0.992 xnpod_resume_thread+0xe8
>> (xnsynch_flush+0x124)
>>
> Hallo Philippe
>
> Sorry about the last ipipe trace I sent. The trace buffer was 
> configured to small and so the problem was not traced.
> In this ipipe trace I have seen what occur, but I don't know why.
> At line 252366 the cyclic task will suspended.
> :|  # [  610] cyclic: 30 -9119      0.677  __xnpod_schedule+0x14c 
> (xnpod_suspend_thread+0x434)
> At line 261530 the cyclic task will resumed again. Between these two 
> calls are about 10ms.
> :|  *+[  610] cyclic: 30  -528+   1.486  xnpod_resume_thread+0xd4 
> (gatekeeper_thread+0x1d8)
>
>
> Note: You wrote the system seems to be very loaded.
> The cpu load is only very high while the ipipe tracing is running.
>
> Harald
>
>
Hello Philippe

Is it possible that you can have a short view to the trace I have sent 
on monday.
We dont know what can be wrong in that case.

Harald


