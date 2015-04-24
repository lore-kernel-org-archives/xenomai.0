Message-ID: <553A61E5.4010603@web.de>
Date: Fri, 24 Apr 2015 17:31:49 +0200
From: Jan Kiszka <jan.kiszka@web.de>
MIME-Version: 1.0
References: <1b27d68cb89340489802b18862a2b2d7@zue-s-199.zue.zwick.de>
 <5539E86A.7000104@web.de> <20150424151841.GM7109@hermes.click-hack.org>
 <553A600B.9010300@web.de> <20150424152642.GN7109@hermes.click-hack.org>
In-Reply-To: <20150424152642.GN7109@hermes.click-hack.org>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] Corruption after phtread_mutex_destroy
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 2015-04-24 17:26, Gilles Chanteperdrix wrote:
> On Fri, Apr 24, 2015 at 05:23:55PM +0200, Jan Kiszka wrote:
>> On 2015-04-24 17:18, Gilles Chanteperdrix wrote:
>>> On Fri, Apr 24, 2015 at 08:53:30AM +0200, Jan Kiszka wrote:
>>>> Am 2015-04-23 um 20:42 schrieb Meier, Hans:
>>>>> Hi everybody,
>>>>>
>>>>> First of all thanks a lot for your excellent work, we are using Xenom=
ai =

>>>>> for about 8 years now in quite a complex application together with AC=
E =

>>>>> based on the POSIX skin and most of the time it just works fine.
>>>>>
>>>>> But now we have a situation we think needs to be reported. =

>>>>>
>>>>> Consider the following:
>>>>> We have a thread H with high priority, a thread L with low priority a=
nd =

>>>>> a mutex M (recursive, prio-inherit). L locks M and then H tries to lo=
ck M, =

>>>>> L gets boosted until it unlocks M, then H succeeds in locking M, then=
 H =

>>>>> unlocks M. If H then immediately destroys and frees M, we get a corru=
ption =

>>>>> where M's pthread_mutex_t was stored (a byte gets decremented), as so=
on as =

>>>>> L gets scheduled again.
>>>>>
>>>>> According to man page PTHREAD_MUTEX_DESTROY(3P), section "Destroying =

>>>>> Mutexes" - close to the end - "Implementations are required to allow =
an =

>>>>> object to be destroyed and freed ... immediately after the object is =

>>>>> unlocked". So that is what we do here, we destroy and free the mutex =

>>>>> immediately after it is unlocked. Certainly in a simple scenario we c=
ould =

>>>>> easily work around this problem by destroying and freeing M later, bu=
t =

>>>>> what if this code is buried deep inside a framework lib (here ACE)? =

>>>>
>>>> Not saying that ACE is to be blamed in this case (until the issue is
>>>> fully understood),
>>>
>>> The issue is fully understood, the mutex is considered in-use as
>>> long as all threads have not exited all the mutex services. In the
>>> case of the example posted, the "worker" thread is still in the
>>> pthread_mutex_unlock service while the other thread is trying to
>>> call pthread_mutex_destroy, which cause pthread_mutex_destroy to
>>> return EINVAL.
>>
>> If the reported pattern is actually equivalent to the pattern that of
>> the application (wasn't clear to me so far), then it is indeed understoo=
d.
>>
>>>
>>> Xenomai 3 does not have this issue.
>>>
>>
>> You mean returning EINVAL instead of EBUSY?
> =

> I mean that pthread_mutex_destroy would not return an error and
> destroy the mutex as it should.

The spec recommends to return EBUSY in case destruction of a locked
mutex is requested. That seems to have changed from the 2004 edition of
the spec where it was more prominently listed as "may fail if...".
Returning EINVAL is wrong, though.

Jan


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: OpenPGP digital signature
URL: <http://www.xenomai.org/pipermail/xenomai/attachments/20150424/1cc324a=
5/attachment.sig>
