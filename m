From: "Meier, Hans" <Hans.Meier@zwick.de>
Date: Mon, 27 Apr 2015 09:39:29 +0000
Message-ID: <d217e7ccba804456a1fe903b1f51f8a7@zue-s-199.zue.zwick.de>
References: <1b27d68cb89340489802b18862a2b2d7@zue-s-199.zue.zwick.de>
 <5539E86A.7000104@web.de> <20150424151841.GM7109@hermes.click-hack.org>
 <553A600B.9010300@web.de> <20150424152642.GN7109@hermes.click-hack.org>
 <553A61E5.4010603@web.de> <20150424153554.GO7109@hermes.click-hack.org>
 <553A6917.1030805@web.de>
In-Reply-To: <553A6917.1030805@web.de>
Content-Language: de-DE
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Xenomai] Corruption after phtread_mutex_destroy
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@web.de>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 2015-04-24 18:03, Jan Kiszka wrote:
> On 2015-04-24 17:35, Gilles Chanteperdrix wrote:
>> On Fri, Apr 24, 2015 at 05:31:49PM +0200, Jan Kiszka wrote:
>>> On 2015-04-24 17:26, Gilles Chanteperdrix wrote:
>>>> On Fri, Apr 24, 2015 at 05:23:55PM +0200, Jan Kiszka wrote:
>>>>> On 2015-04-24 17:18, Gilles Chanteperdrix wrote:
>>>>>> On Fri, Apr 24, 2015 at 08:53:30AM +0200, Jan Kiszka wrote:
>>>>>>> Am 2015-04-23 um 20:42 schrieb Meier, Hans:
>>>>>>>> Hi everybody,
>>>>>>>>
>>>>>>>> First of all thanks a lot for your excellent work, we are using Xe=
nomai=20
>>>>>>>> for about 8 years now in quite a complex application together with=
 ACE=20
>>>>>>>> based on the POSIX skin and most of the time it just works fine.
>>>>>>>>
>>>>>>>> But now we have a situation we think needs to be reported.=20
>>>>>>>>
>>>>>>>> Consider the following:
>>>>>>>> We have a thread H with high priority, a thread L with low priorit=
y and=20
>>>>>>>> a mutex M (recursive, prio-inherit). L locks M and then H tries to=
 lock M,=20
>>>>>>>> L gets boosted until it unlocks M, then H succeeds in locking M, t=
hen H=20
>>>>>>>> unlocks M. If H then immediately destroys and frees M, we get a co=
rruption=20
>>>>>>>> where M's pthread_mutex_t was stored (a byte gets decremented), as=
 soon as=20
>>>>>>>> L gets scheduled again.
>>>>>>>>
>>>>>>>> According to man page PTHREAD_MUTEX_DESTROY(3P), section "Destroyi=
ng=20
>>>>>>>> Mutexes" - close to the end - "Implementations are required to all=
ow an=20
>>>>>>>> object to be destroyed and freed ... immediately after the object =
is=20
>>>>>>>> unlocked". So that is what we do here, we destroy and free the mut=
ex=20
>>>>>>>> immediately after it is unlocked. Certainly in a simple scenario w=
e could=20
>>>>>>>> easily work around this problem by destroying and freeing M later,=
 but=20
>>>>>>>> what if this code is buried deep inside a framework lib (here ACE)=
?=20
>>>>>>>
>>>>>>> Not saying that ACE is to be blamed in this case (until the issue i=
s
>>>>>>> fully understood),
>>>>>>
>>>>>> The issue is fully understood, the mutex is considered in-use as
>>>>>> long as all threads have not exited all the mutex services. In the
>>>>>> case of the example posted, the "worker" thread is still in the
>>>>>> pthread_mutex_unlock service while the other thread is trying to
>>>>>> call pthread_mutex_destroy, which cause pthread_mutex_destroy to
>>>>>> return EINVAL.
>>>>>
>>>>> If the reported pattern is actually equivalent to the pattern that of
>>>>> the application (wasn't clear to me so far), then it is indeed unders=
tood.
>>>>>
>>>>>>
>>>>>> Xenomai 3 does not have this issue.
>>>>>>
>>>>>
>>>>> You mean returning EINVAL instead of EBUSY?
>>>>
>>>> I mean that pthread_mutex_destroy would not return an error and
>>>> destroy the mutex as it should.
>>>
>>> The spec recommends to return EBUSY in case destruction of a locked
>>> mutex is requested.
>>=20
>> The thing is, as the example demonstrate, pthread_mutex_destroy
>> fails while the mutex is unlocked. We are being over zealous here by
>> considering that the mutex is busy because a thread is still in
>> pthread_mutex_unlock.
>=20
> OK, then it makes sense.

It is not only that pthread_mutex_destroy in this case should destroy the=20
mutex and return without error. More than that no manipulation on the=20
pthread_mutex_t structure must occur any more while leaving the=20
pthread_mutex_unlock service with low prio later. I guess this doesn't=20
depend on what pthread_mutex_destroy does internally or what it returns.
Sorry that I didn't point that out more clearly in my initial mail.=20

Hans


