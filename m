References: <582ADD06.5000901@numalliance.com>
 <7485f9e5-cba3-4766-e263-04c8e98e3ec0@xenomai.org>
From: =?UTF-8?Q?St=c3=a9phane_Ancelot?= <sancelot@numalliance.com>
Message-ID: <b40ea31f-248e-7754-de55-d527b9b994d7@numalliance.com>
Date: Tue, 22 Nov 2016 16:57:41 +0100
MIME-Version: 1.0
In-Reply-To: <7485f9e5-cba3-4766-e263-04c8e98e3ec0@xenomai.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] ipipe trace understanding
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>, "xenomai@xenomai.org" <xenomai@xenomai.org>



Le 18/11/2016 =E0 19:17, Philippe Gerum a =E9crit :
> On 11/15/2016 11:01 AM, St=E9phane ancelot wrote:
>> Hi,
>>
>> In order to solve my realtime pb, I  have a bit  some problems to
>> understand my ipipe trace that has been frozen.
>>
>> My task should normally spend almost 200us to run and in this case, it
>> spends more than 500us.
>>
>> My task starts at -723 and stops at -14.
>>
>> I made some comments in the trace, but have problem understanding wher=
e
>> is the biggest problem.
>>
> [snip]
>
>> (__cobalt_mq_timedreceive+0x25c)
>> :|  + begin   0x80000000  -439      0.220  hard_local_irq_disable+0x16
>> (__xnlock_get_irqsave.constprop.11+0x9)
>> :|  # func                -438      0.493  __put_fd+0x0 (rtdm_fd_put+0=
x22)
>> :|  # func                -438      0.206  __ipipe_restore_head+0x0
>> (__xnlock_put_irqrestore.constprop.10+0x67)
>> :|  + end     0x80000000  -438! 423.494  hard_local_irq_enable+0x17
>> (__ipipe_restore_head+0x70)
> This section denotes a transition to user-space, the application code
> resumes from a mq_timedreceive() call, running for 423 us before issuin=
g
> another Cobalt syscall:
There is something I can't understand at the moment :
The problem arises when we maximize, move minimize  gui applications we=20
developped.

I have not managed to activate the problem doing the same thing using=20
other programs in my system (eg glxgears, terminals...), or maybe I=20
don't have enough system load.

I have had a look at /proc/xenomai/sched/stat .
I found our gui application was heavily incrementing the MSW counter,=20
but this is not a realtime task, only gui that refresh some memory data
linked on xenomai heap memory areas.

My question : could it be possible that task disturbs the realtime one ?=20
it seems ...
This graphic task uses the FOX graphic api, I have had a look at it's=20
source code and found it was heavily using signal() and gettimeofday()=20
system calls .....

>> :   + func                 -14+   2.201  ipipe_fastcall_hook+0x0
>> (system_call_after_swapgs+0x6b)
>> :   + func                 -12      0.543  handle_head_syscall+0x0
>> (ipipe_fastcall_hook+0x18)
>>
> Of course, assuming x86 is your target architecture, this might be a SM=
I
> event happening during this transition too, but I would investigate the
> most probable (and fixable) cause first.

