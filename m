From: "Chen, Hongzhan" <hongzhan.chen@intel.com>
Subject: RE: gdb  test failure debug status update
Date: Mon, 10 May 2021 02:16:18 +0000
Message-ID: <DM5PR11MB1852B35093E1376C58FD8E33F2549@DM5PR11MB1852.namprd11.prod.outlook.com>
References: <DM5PR11MB18525F69E34389DE7A8EE49BF2409@DM5PR11MB1852.namprd11.prod.outlook.com>
 <87mtti3325.fsf@xenomai.org> <87k0om32jb.fsf@xenomai.org>
 <DM5PR11MB1852E0C420E68BFB8CAFEE21F25F9@DM5PR11MB1852.namprd11.prod.outlook.com>
 <DM5PR11MB1852D3221BDFC752C9CC1946F25E9@DM5PR11MB1852.namprd11.prod.outlook.com>
 <87bl9w2pkm.fsf@xenomai.org> <875z042odb.fsf@xenomai.org>
 <DM5PR11MB18527EA509FB99BF50D1ACFFF25E9@DM5PR11MB1852.namprd11.prod.outlook.com>
 <DM5PR11MB18529649C47BF241930A2217F25E9@DM5PR11MB1852.namprd11.prod.outlook.com>
 <8735v82jmd.fsf@xenomai.org>
 <DM5PR11MB18521837E79C031B621080A8F2589@DM5PR11MB1852.namprd11.prod.outlook.com>
 <DM5PR11MB1852AB3F24A4FDE042C14E8FF2579@DM5PR11MB1852.namprd11.prod.outlook.com>
 <87zgx3pzp9.fsf@xenomai.org> <87wns7pzkl.fsf@xenomai.org>
In-Reply-To: <87wns7pzkl.fsf@xenomai.org>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>



>Philippe Gerum <rpm@xenomai.org> writes:
>
>> Chen, Hongzhan <hongzhan.chen@intel.com> writes:
>>
>>>>>
>>>>>>>-----Original Message-----
>>>>>>>From: Xenomai <xenomai-bounces@xenomai.org> On Behalf Of Chen, Hongz=
han via Xenomai
>>>>>>>Sent: Friday, April 30, 2021 4:07 PM
>>>>>>>To: Philippe Gerum <rpm@xenomai.org>
>>>>>>>Cc: xenomai@xenomai.org
>>>>>>>Subject: RE: gdb test failure debug status update
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>>>-----Original Message-----
>>>>>>>>From: Philippe Gerum <rpm@xenomai.org>=20
>>>>>>>>Sent: Friday, April 30, 2021 4:01 PM
>>>>>>>>To: Chen, Hongzhan <hongzhan.chen@intel.com>
>>>>>>>>Cc: xenomai@xenomai.org
>>>>>>>>Subject: Re: gdb test failure debug status update
>>>>>>>>
>>>>>>>>
>>>>>>>>Philippe Gerum <rpm@xenomai.org> writes:
>>>>>>>>
>>>>>>>>> Chen, Hongzhan <hongzhan.chen@intel.com> writes:
>>>>>>>>>
>>>>>>>>>> The final xnthread_relaxed call path is like this asm_sysv_apic_=
timer_interrupt ->handle_irq_pipelined_finish=20
>>>>>>>>>> ->dovetail_call_mayday ->handle_oob_mayday>xnthread_relax.=20
>>>>>>>>>> That means that handle_irq_pipelined_finish is called under OOB =
condition of arch_pipeline_entry in
>>>>>>>>>>  arch/x86/kernel/irq_pipeline.c.  Does that means that kernel en=
try/exit code is never called after return from=20
>>>>>>>>>> xnthread_relax to handle_irq_pipelined_finish then to asm_sysv_a=
pic_timer_interrupt?  Even I enforce to=20
>>>>>>>>>> call  dovetail_request_ucall before calling final xnthread_relax=
 system would not try to switch back to primary mode
>>>>>>>>>> because kernel exit code is never called in this case?
>>>>>>>>>>
>>>>>>>>>
>>>>>>>>> The IRQ frame is indeed kept from unwinding until the preempted t=
ask
>>>>>>>>> context returns from irq_exit_pipeline(), which branches to the C=
obalt
>>>>>>>>> rescheduling procedure. From the Dovetail interface POV,
>>>>>>>>> irq_exit_pipeline() is called by handle_irq_pipelined_finish() to=
 allow
>>>>>>>>> the companion core to perform post-IRQ chores, such as running it=
s own
>>>>>>>>> rescheduling procedure.
>>>>>>>>>
>>>>>>>>> IOW, if task @foo is preempted by an IRQ, then suspended in oob c=
ontext
>>>>>>>>> as a result of what the interrupt handler just did for it (e.g. r=
aising
>>>>>>>>> XNDBGSTOP, XNRELAX, XNPEND, XNSUSP in its state), then
>>>>>>>>> handle_irq_pipelined_finish()->irq_exit_pipeline()->xnsched_run()=
 will
>>>>>>>>> cause the @foo context to switch away, effectively preventing
>>>>>>>>> handle_irq_pipelined_finish() to return, until @foo resumes execu=
tion
>>>>>>>> eventually.
>>>>>>
>>>>>> ln handle_irq_pipelined_finish, irq_exit_pipeline would at first  be=
 executed and it=20
>>>>>> handle dovetail_call_mayday in the end. But issue happen after run d=
ovetail_call_mayday=20
>>>>>> because it call final xnthread_relax before gdb test failue.
>>>>>>
>>>>>
>>>>>Can you add WARN_ON(1) to dovetail_call_mayday() and report about the
>>>>>output? TIA,
>>>>>
>>>>>--=20
>>>>>Philippe.
>>>>>
>>>>=20
>>>>Please check following output.
>>>
>>> Hi Philippe,
>>>
>>> Please let me know if you have new patch or other thing to let me try.
>>>
>>
>> I spent hours of this issue, and there may be a wrong basic assumption
>> done in the smokey/gdb test. Specifically, handle_sigwake_event()
>> un-stops the debuggee (lifting XNDBGSTOP), then sends a mayday notice to

Current handle_sigwake_event call register_debugged_thread to suspend
all threads including smokey thread that be subordinated to same process wh=
en hi-thread get sigwake
event. Logically , we should relax all threads that be subordinated to same=
 process after
get mayday event because we already specifically handle it before and then =
ask xnthread schedule to=20
schedule correct thread to run(which would schedule hi-thread at first fina=
lly and get correct behavior). Is this idea  OK?

Regards

Hongzhan Chen =20


>> make sure that debuggee re-enters the kernel asap for leaving the oob
>> stage. What might happen between these two events might not be as
>> well-defined as this test expects (e.g. what if the debugger might be
>
>I meant the _debuggee_ (obvously not the debugger in this case)
>
>> able to run more user code before the mayday trap is enforced?).
>>
>> I'll keep on debugging that stuff and let you know.
>
>
>--=20
>Philippe.

