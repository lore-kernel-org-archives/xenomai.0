MIME-Version: 1.0
In-Reply-To: <CAMJ=MEe4oXvtaR29RBueXzoUYrmpt0GpCbqb-uW9j0fTksnC_g@domain.hid>
References: <CAMJ=MEcVJCdP4wukwhqL83Ejorprnz32PB3vbpOK584GT1mkvg@domain.hid>
	<4F646AA9.1010809@domain.hid>
	<CAMJ=MEe4oXvtaR29RBueXzoUYrmpt0GpCbqb-uW9j0fTksnC_g@domain.hid>
Date: Tue, 27 Mar 2012 13:38:08 +0200
Message-ID: <CAMJ=MEc7XydTXOPQ-d6JUPT-mh8Z9ubg-NkDovA-YFWvF_xRaw@domain.hid>
From: Ronny Meeus <ronny.meeus@domain.hid>
Content-Type: multipart/mixed; boundary=f46d0444e9a3c4fd0504bc37ec39
Subject: Re: [Xenomai-help] [Xenomai-core] xenomai-forge: round-robin
	scheduling in pSOS skin
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai-help <xenomai@xenomai.org>

--f46d0444e9a3c4fd0504bc37ec39
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

[ In my last mail I did not put xenomai-help in CC, corrected by this. ]

On Sat, Mar 17, 2012 at 11:52 PM, Ronny Meeus <ronny.meeus@domain.hid> wrote=
:
> On Sat, Mar 17, 2012 at 11:42 AM, Philippe Gerum <rpm@xenomai.org> wrote:
>> On 03/08/2012 03:30 PM, Ronny Meeus wrote:
>>>
>>> Hello
>>>
>>> I'm are using the xenomai-forge pSOS skin (Mercury).
>>> My application is running on a P4040 (Freescale PPC with 4 cores).
>>> Some code snippets are put in this mail but the complete testcode is
>>> also attached.
>>>
>>> I have a test task that just consumes the CPU:
>>>
>>> int run_test =3D 1;
>>> static void perform_work(u_long counter,u_long b,u_long c,u_long d)
>>> {
>>> =A0 int i;
>>> =A0 while (run_test) {
>>> =A0 =A0 for (i=3D0;i<100000;i++);
>>> =A0 =A0 (*(unsigned long*)counter)++;
>>> =A0 }
>>> =A0 while (1) tm_wkafter(1000);
>>> }
>>>
>>> If I create 2 instances of this task with the T_SLICE option set:
>>>
>>> =A0 =A0 t_create("WORK",10,0,0,0,&tid);
>>> =A0 =A0 t_start(tid,T_TSLICE, perform_work, args);
>>>
>>>
>>> I see that only 1 task is consuming CPU.
>>>
>>> # taskset 1 ./roundrobin.exe&
>>> # =A0 =A00"000.543| [main] SCHED_RT priorities =3D> =A0[1 .. 99]
>>> =A0 =A00"000.656| [main] SCHED_RT.99 reserved for IRQ emulation
>>> =A0 =A00"000.692| [main] SCHED_RT.98 reserved for scheduler-lock emulat=
ion
>>> 0 -> =A06602
>>> 1 -> =A00
>>>
>>> If I adapt the code so that I call in my init the threadobj_start_rr
>>> function, I see that the load is equally distributed over the 2
>>> threads:
>>>
>>> # taskset 1 ./roundrobin.exe&
>>> # =A0 =A00"000.557| [main] SCHED_RT priorities =3D> =A0[1 .. 99]
>>> =A0 =A00"000.672| [main] SCHED_RT.99 reserved for IRQ emulation
>>> =A0 =A00"000.708| [main] SCHED_RT.98 reserved for scheduler-lock emulat=
ion
>>> 0 -> =A03290
>>> 1 -> =A03291
>>>
>>> Here are the questions:
>>> - why is the threadobj_start_rr function not called from the context
>>> of the init of the psos layer.
>>
>>
>> Because threadobj_start_rr() was originally designed to activate round-r=
obin
>> for all threads (some RTOS like VxWorks expose that kind of API), not on=
 a
>> per-thread basis. This is not what pSOS wants.
>>
>> The round-robin API is in state of flux for mercury, only the cobalt one=
 is
>> stable. This is why RR is not yet activated despite T_SLICE is recognize=
d.
>>
>>
>>> - why is the roundrobin implemented in this way? If the tasks would be
>>> mapped on the SCHED_RR instead of the SCHED_FF the Linux scheduler
>>> would take care of this.
>>
>>
>> Nope. We need per-thread RR intervals, to manage multiple priority group=
s
>> concurrently, and we also want to define that interval as we see fit for
>> proper RTOS emulation. POSIX does not define anything like
>> sched_set_rr_interval(), and the linux kernel applies a default fixed
>> interval to all threads from the SCHED_RR class (100ms IIRC).
>>
>> So we have to emulate SCHED_RR over SCHED_FIFO plus a per-thread virtual
>> timer.
>>
>
> OK I understand.
>
>>
>>> On the other hand, once the threadobj_start_rr function is called from
>>> my init, and I create the tasks in T_NOTSLICE mode, the time-slicing
>>> is still done.
>>
>>
>> Because you called threadobj_start_rr().
>>
>
> Yes, indeed I called threadobj_start_rr to install the virtual timer
> and to attach the signal handler, but the tasks are not running in
> time-sliced mode. This means that the flag THREADOBJ_ROUNDROBIN is not
> set within the thread object so I do not understand why I still see
> the timeslicing being applied.
> It looks to me that once the timer fires and the signal handler is
> called, there is a context switch made anyhow.
>

I was studying the code in more detail this time and I observed
something which is strange to me.
In the function threadobj_start_rr, both the round-robin virtual timer
mechanism is installed and also the round-robin flag is set for all
tasks currently existing in the system (This is what I missed before).
Also from that moment on, all new tasks are running on round-robin
mode, independent of the flags specified during the task creation. The
only exception to this is that when a task calls t_mode to disable
round-robin, in this case the round-robin is disabled. So for me this
is not completely consistent and certainly not to what the user
expects.


I did a change and introduced a new function: threadobj_start_global_rr
The patch is attached to the mail.

I basically have split the installation of the signal handler and the
activation of the round-robin mode for all tasks into 2 parts.
The original function  threadobj_start_rr just installs the signal
handler and starts the timer with the interval that the user has
specified.
The newly introduced function (threadobj_start_global_rr) marks all
tasks as round-robin active and all future tasks will also be marked.
By splitting the logic of this function it is possible to work in a
mode where the tasks itself (based on the flags given during
task-creation or via t_mode) decides on the mode in which it wants to
run or the application can decide that the round-robin will be
activated globally (by calling  threadobj_start_global_rr once during
init for example). In the latter case the round-robin activation
because global for all threads in the application process.

I tested the change in my version and it looks like it behaves like it
should be.

Thanks
---
Ronny

--f46d0444e9a3c4fd0504bc37ec39
Content-Type: application/octet-stream; name="global_rr.patch"
Content-Disposition: attachment; filename="global_rr.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_h0avb4t80

LS0tIGEvbGliL2NvcHBlcnBsYXRlL3RocmVhZG9iai5jCTIwMTEtMTAtMTIgMTI6MTE6MDQuMDAw
MDAwMDAwICswMjAwCisrKyBiL2xpYi9jb3BwZXJwbGF0ZS90aHJlYWRvYmouYwkyMDEyLTAzLTI3
IDEyOjAxOjM4LjAwMDAwMDAwMCArMDIwMApAQCAtNTcyLDE1ICs1NzIsMjIgQEAKIAlyZXR1cm4g
MDsKIH0KIAoraW50IHRocmVhZG9ial9zdGFydF9nbG9iYWxfcnIodm9pZCkKK3sKKwlpbnQgcmV0
OworCXJldCA9IHRocmVhZG9ial9zZXRfcnIoTlVMTCwgJmdsb2JhbF9xdWFudHVtKTsKKwlpZiAo
cmV0KQorCQlyZXR1cm4gX19idChyZXQpOworCXJldHVybiAwOworfQorCiBpbnQgdGhyZWFkb2Jq
X3N0YXJ0X3JyKHN0cnVjdCB0aW1lc3BlYyAqcXVhbnR1bSkKIHsKIAlzdHJ1Y3QgaXRpbWVydmFs
IHZhbHVlLCBvdmFsdWU7CiAJc3RydWN0IHNpZ2FjdGlvbiBzYTsKIAlpbnQgcmV0OwogCi0JcmV0
ID0gdGhyZWFkb2JqX3NldF9ycihOVUxMLCBxdWFudHVtKTsKLQlpZiAocmV0KQotCQlyZXR1cm4g
X19idChyZXQpOworCWdsb2JhbF9xdWFudHVtID0gKnF1YW50dW07CiAKIAl2YWx1ZS5pdF9pbnRl
cnZhbC50dl9zZWMgPSBxdWFudHVtLT50dl9zZWM7CiAJdmFsdWUuaXRfaW50ZXJ2YWwudHZfdXNl
YyA9IHF1YW50dW0tPnR2X25zZWMgLyAxMDAwOwo=
--f46d0444e9a3c4fd0504bc37ec39--

