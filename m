Message-ID: <50579107.7070208@xenomai.org>
Date: Mon, 17 Sep 2012 23:07:19 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <5050E1F2.8090702@free.fr>
	<5050F04C.6030707@xenomai.org>	<50521433.9060807@free.fr>
	<505228B1.9010009@xenomai.org>	<50577AB4.6050006@free.fr>
	<50577F11.7050901@xenomai.org>	<50578C29.8030104@free.fr>
	<50578FF0.8050108@xenomai.org>
In-Reply-To: <50578FF0.8050108@xenomai.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] posix skin pthread_create issue
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Pierre Quelin <pierre.quelin@free.fr>
Cc: pierre.quelin@solystic.com, xenomai@xenomai.org

On 09/17/2012 11:02 PM, Gilles Chanteperdrix wrote:

> On 09/17/2012 10:46 PM, Pierre Quelin wrote:
>=20
>>
>> Le 17/09/2012 21:50, Gilles Chanteperdrix a =C3=A9crit :
>>> On 09/17/2012 09:32 PM, Pierre Quelin wrote:
>>>
>>>>>>>> After your answer, I try xenomai 2.6.1 and I increase the size o=
f the
>>>>>>>>     private stack pool from 128 to 2048 with the same result.
>>>>>>>>
>>>>>>>> Is there any limits for the number of threads in Xenomai ?
>>>>>>> Not that I know of. There are only a few dynamic allocations in t=
he
>>>>>>> various pools you already mentioned. The corresponding options ar=
e:
>>>>>>> XENO_OPT_REGISTRY_NRSLOTS (maximum number of objects in the regis=
try,
>>>>>>> each thread is registered in the registry)
>>>>>>> XENO_OPT_SYS_HEAPSZ (system heap, used for various calls to xnmal=
loc)
>>>>>>> XENO_OPT_SEM_HEAPSZ (semaphore heap, use for allocating 4 bytes p=
er
>>>>>>> thread + 4 bytes per mutex)
>>>>>>>
>>>>>>> But anyway, debugging the issue you have should be relatively eas=
y by
>>>>>>> adding printfs/printks, starting from src/skins/posix/thread.c (f=
unction
>>>>>>> __wrap_pthread_create), continuing in ksrc/skins/posix/syscall.c,=

>>>>>>> function __pthread_create, etc...
>>>>>> I try to obtain information about my context but all seems to be o=
k.
>>>>> You have to put a "pause" after the failing call to pthread_create,=

>>>>> because otherwise if calling exit, when the process fails, all the
>>>>> memory it allocated in the various pools is freed.
>>>> I found the problem. It seems that the private sem heap is to small.=

>>>>
>>>> I'm not sure about which parameter to increase in kernel menu so at
>>>> first I increase :
>>>
>>> "private sem heap" -> "private semaphores heap", how can this not be =
clear?
>> This link is clear, but I don't understand the link between "private=20
>> semaphores heap", "global semaphores heap" and "system heap" ?
>> I just try to fix the right values for my context and my application.
>=20
>=20
> There is no link between the various heaps, which is the reason why the=
y
> have separate configuration options. Now if the question is to know how=

> much space in each heap consumes a thread, a mutex, etc... I guess
> nobody ever did the computation. For the semaphore heaps at least it is=

> clear: each thread consumes 4 bytes in the semaphore heap, each mutex
> consumes 4 bytes in the private or global heap depending on whether it
> is a process-private, or global mutex (for posix mutexes, this is
> related to pthread_mutexattr_setpshared).
>=20
>>>> ? Is calling pthread_set_mode_np (PTHREAD_WARNSW, 0) inhibits the ri=
se
>>>> of the signal for a page fault?
>>>
>>> Yes, it inhibits the rise of the signal for any cause of switch to
>>> secondary mode. Quoting the documentation:
>>>
>>> "PTHREAD_WARNSW, when set, cause the signal SIGXCPU to be sent to the=

>>> current thread, whenever it involontary switches to secondary mode;"
>>>
>>> so, obviously, when clear, the SIGXCPU is NOT SENT to the current thr=
ead
>>> whenever it involontary switches to secondary mode. What else did you=

>>> understand when reading this documentation ?
>>
>> I don't understand that a page fault is 'just' a switch to secondary m=
ode.
>=20
>=20
> A switch to secondary mode is devastating for a real-time thread runnin=
g
> in primary mode.
> A page fault causes a switch to secondary mode so that the Linux kernel=

> can handle the page fault, the only alternative is probably crashing, o=
r
> suspending the thread that had the fault. SIGXCPU is sent, if you
> enabled the PTHREAD_WARNSW bit.
>=20
> So, PTHREAD_WARNSW should be armed for threads which should stay in
> primary mode. The critical ones.
>=20
> Anyway, it is not really normal to have page faults, using mlockall and=

> the disabling of on-demand mappings by the I-pipe patch should prevent
> page faults from happening. So, it would be interesting to know what
> cause these faults.


Again, due to the C++ static objects constructors "feature", it may=20
simply be that you start using Xenomai before the call to mlockall, and=20
you simply somehow fail to see the signal sent by Xenomai, because it=20
is also SIGXCPU and the handler you installed does not check the reason=20
sent by Xenomai, for instance, the following commit, fixes exactly this=20
issue for the latency test:

http://git.xenomai.org/?p=3Dxenomai-2.6.git;a=3Dcommitdiff;h=3Dd8c2bccce5=
de41a4b183c9a140dc12b0a2606261;hp=3D9afc3bce3770089083fa5d1bca596b53f5c7d=
058

--=20
                                                                Gilles.


