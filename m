References: <582ADD06.5000901@numalliance.com>
 <7485f9e5-cba3-4766-e263-04c8e98e3ec0@xenomai.org>
 <b40ea31f-248e-7754-de55-d527b9b994d7@numalliance.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <0490bf7c-6cac-b464-4768-e4986e9ef85e@xenomai.org>
Date: Wed, 23 Nov 2016 11:07:21 +0100
MIME-Version: 1.0
In-Reply-To: <b40ea31f-248e-7754-de55-d527b9b994d7@numalliance.com>
Content-Type: text/plain; charset="windows-1252"
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
To: =?UTF-8?Q?St=c3=a9phane_Ancelot?= <sancelot@numalliance.com>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 11/22/2016 04:57 PM, St=E9phane Ancelot wrote:
>=20
>=20
> Le 18/11/2016 =E0 19:17, Philippe Gerum a =E9crit :
>> On 11/15/2016 11:01 AM, St=E9phane ancelot wrote:
>>> Hi,
>>>
>>> In order to solve my realtime pb, I  have a bit  some problems to
>>> understand my ipipe trace that has been frozen.
>>>
>>> My task should normally spend almost 200us to run and in this case, it
>>> spends more than 500us.
>>>
>>> My task starts at -723 and stops at -14.
>>>
>>> I made some comments in the trace, but have problem understanding where
>>> is the biggest problem.
>>>
>> [snip]
>>
>>> (__cobalt_mq_timedreceive+0x25c)
>>> :|  + begin   0x80000000  -439      0.220  hard_local_irq_disable+0x16
>>> (__xnlock_get_irqsave.constprop.11+0x9)
>>> :|  # func                -438      0.493  __put_fd+0x0
>>> (rtdm_fd_put+0x22)
>>> :|  # func                -438      0.206  __ipipe_restore_head+0x0
>>> (__xnlock_put_irqrestore.constprop.10+0x67)
>>> :|  + end     0x80000000  -438! 423.494  hard_local_irq_enable+0x17
>>> (__ipipe_restore_head+0x70)
>> This section denotes a transition to user-space, the application code
>> resumes from a mq_timedreceive() call, running for 423 us before issuing
>> another Cobalt syscall:
> There is something I can't understand at the moment :
> The problem arises when we maximize, move minimize  gui applications we
> developped.
>=20
> I have not managed to activate the problem doing the same thing using
> other programs in my system (eg glxgears, terminals...), or maybe I
> don't have enough system load.

If the issue only arises when your GUI code runs but does not with other
graphic code such as glxgears, then this rules out an issue with the GPU
driver (e.g. eager cache invalidation).

>=20
> I have had a look at /proc/xenomai/sched/stat .
> I found our gui application was heavily incrementing the MSW counter,
> but this is not a realtime task, only gui that refresh some memory data
> linked on xenomai heap memory areas.
>=20

Consider the interactions betwen that GUI code and the real-time code.
If data are shared, maybe some synchronization mechanism exists (sema4,
mutex?) to serialize accesses between both worlds? If so, are you sure
that the GUI is not delaying the rt activity just by holding that lock?

> My question : could it be possible that task disturbs the realtime one ?
> it seems ...

If your GUI app shows mode switches, then some of its threads may share
resources with the time-critical side. Make sure that they do so
properly, i.e. without creating priority inversions.

> This graphic task uses the FOX graphic api, I have had a look at it's
> source code and found it was heavily using signal() and gettimeofday()
> system calls .....

This is not related, those calls are exclusively handled by the regular
kernel and won't delay the real-time co-kernel.

--=20
Philippe.

