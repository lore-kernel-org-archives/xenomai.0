Message-ID: <50578FF0.8050108@xenomai.org>
Date: Mon, 17 Sep 2012 23:02:40 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <5050E1F2.8090702@free.fr> <5050F04C.6030707@xenomai.org>
	<50521433.9060807@free.fr> <505228B1.9010009@xenomai.org>
	<50577AB4.6050006@free.fr> <50577F11.7050901@xenomai.org>
	<50578C29.8030104@free.fr>
In-Reply-To: <50578C29.8030104@free.fr>
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

On 09/17/2012 10:46 PM, Pierre Quelin wrote:

>=20
> Le 17/09/2012 21:50, Gilles Chanteperdrix a =C3=A9crit :
>> On 09/17/2012 09:32 PM, Pierre Quelin wrote:
>>
>>>>>>> After your answer, I try xenomai 2.6.1 and I increase the size of=
 the
>>>>>>>     private stack pool from 128 to 2048 with the same result.
>>>>>>>
>>>>>>> Is there any limits for the number of threads in Xenomai ?
>>>>>> Not that I know of. There are only a few dynamic allocations in th=
e
>>>>>> various pools you already mentioned. The corresponding options are=
:
>>>>>> XENO_OPT_REGISTRY_NRSLOTS (maximum number of objects in the regist=
ry,
>>>>>> each thread is registered in the registry)
>>>>>> XENO_OPT_SYS_HEAPSZ (system heap, used for various calls to xnmall=
oc)
>>>>>> XENO_OPT_SEM_HEAPSZ (semaphore heap, use for allocating 4 bytes pe=
r
>>>>>> thread + 4 bytes per mutex)
>>>>>>
>>>>>> But anyway, debugging the issue you have should be relatively easy=
 by
>>>>>> adding printfs/printks, starting from src/skins/posix/thread.c (fu=
nction
>>>>>> __wrap_pthread_create), continuing in ksrc/skins/posix/syscall.c,
>>>>>> function __pthread_create, etc...
>>>>> I try to obtain information about my context but all seems to be ok=
=2E
>>>> You have to put a "pause" after the failing call to pthread_create,
>>>> because otherwise if calling exit, when the process fails, all the
>>>> memory it allocated in the various pools is freed.
>>> I found the problem. It seems that the private sem heap is to small.
>>>
>>> I'm not sure about which parameter to increase in kernel menu so at
>>> first I increase :
>>
>> "private sem heap" -> "private semaphores heap", how can this not be c=
lear?
> This link is clear, but I don't understand the link between "private=20
> semaphores heap", "global semaphores heap" and "system heap" ?
> I just try to fix the right values for my context and my application.


There is no link between the various heaps, which is the reason why they
have separate configuration options. Now if the question is to know how
much space in each heap consumes a thread, a mutex, etc... I guess
nobody ever did the computation. For the semaphore heaps at least it is
clear: each thread consumes 4 bytes in the semaphore heap, each mutex
consumes 4 bytes in the private or global heap depending on whether it
is a process-private, or global mutex (for posix mutexes, this is
related to pthread_mutexattr_setpshared).

>>> ? Is calling pthread_set_mode_np (PTHREAD_WARNSW, 0) inhibits the ris=
e
>>> of the signal for a page fault?
>>
>> Yes, it inhibits the rise of the signal for any cause of switch to
>> secondary mode. Quoting the documentation:
>>
>> "PTHREAD_WARNSW, when set, cause the signal SIGXCPU to be sent to the
>> current thread, whenever it involontary switches to secondary mode;"
>>
>> so, obviously, when clear, the SIGXCPU is NOT SENT to the current thre=
ad
>> whenever it involontary switches to secondary mode. What else did you
>> understand when reading this documentation ?
>=20
> I don't understand that a page fault is 'just' a switch to secondary mo=
de.


A switch to secondary mode is devastating for a real-time thread running
in primary mode.
A page fault causes a switch to secondary mode so that the Linux kernel
can handle the page fault, the only alternative is probably crashing, or
suspending the thread that had the fault. SIGXCPU is sent, if you
enabled the PTHREAD_WARNSW bit.

So, PTHREAD_WARNSW should be armed for threads which should stay in
primary mode. The critical ones.

Anyway, it is not really normal to have page faults, using mlockall and
the disabling of on-demand mappings by the I-pipe patch should prevent
page faults from happening. So, it would be interesting to know what
cause these faults.

> Before posting a message on this mailing list I tried to read all=20
> documents on Xenomaiand solve the problem by myself.
> Maybe I did not read the right papers or I did not understand what I=20
> have read and I apologize.


No need to apologize, the mailing list is here so that people can ask
questions. I guess there are more answers (maybe not the good ones) in
the mailing list archives than in the documentation.

Regards.

--=20
                                                                Gilles.


