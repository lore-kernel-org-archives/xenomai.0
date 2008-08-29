Message-ID: <48B7D1F1.2080205@domain.hid>
Date: Fri, 29 Aug 2008 12:39:45 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <48B5592B.1090005@domain.hid>	<48B55F7C.5030901@domain.hid>	<48B56685.4060500@domain.hid>	<48B570AF.4090900@domain.hid>	<48B57281.2090109@domain.hid>	<48B57626.8070404@domain.hid>	<48B576F2.5010409@domain.hid>	<48B57BE0.8000701@domain.hid>	<48B57D32.60504@domain.hid>	<48B599DD.6070306@domain.hid>	<48B5A4AB.3030909@domain.hid>	<48B5B9FC.2050900@domain.hid>	<48B5D8EC.90009@domain.hid>	<48B6776E.6030502@domain.hid>	<48B6984B.80804@domain.hid>	<48B79A05.7060203@domain.hid>	<48B79EAB.8000109@domain.hid>	<48B7A3AF.6010802@domain.hid>	<48B7A550.2030001@domain.hid>
	<48B7C31B.1050605@domain.hid> <48B7C438.9020000@domain.hid>
In-Reply-To: <48B7C438.9020000@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [RFC][PATCH 2/3] Switch to handle-based
 fast	mutex owners
Reply-To: rpm@xenomai.org
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Jan Kiszka <jan.kiszka@domain.hid>, xenomai-core <xenomai@xenomai.org>

Gilles Chanteperdrix wrote:
> Jan Kiszka wrote:
>> Gilles Chanteperdrix wrote:
>>> Jan Kiszka wrote:
>>>> Gilles Chanteperdrix wrote:
>>>>> Jan Kiszka wrote:
>>>>>> Gilles Chanteperdrix wrote:
>>>>>>> Philippe Gerum wrote:
>>>>>>>> Gilles Chanteperdrix wrote:
>>>>>>>>> Jan Kiszka wrote:
>>>>>>>>>> Gilles Chanteperdrix wrote:
>>>>>>>>>>> Jan Kiszka wrote:
>>>>>>>>>> ...
>>>>>>>>>>>> I think I'm getting closer to the issue. Our actual problem comes from
>>>>>>>>>>>> the fact that the xnsynch_owner is easily out of sync with the real
>>>>>>>>>>>> owner, it even sometimes points to a former owner:
>>>>>>>>>>>>
>>>>>>>>>>>> Thread A releases a mutex on which thread B pends. It wakes up B,
>>>>>>>>>>>> causing it to become the new xnsynch owner, and clears the claimed bit
>>>>>>>>>>>> as there are no further sleepers. B returns, and when it wants to
>>>>>>>>>>>> release the mutex, it does this happily in user space because claimed is
>>>>>>>>>>>> not set. Now the fast lock variable is 'unlocked', while xnsynch still
>>>>>>>>>>>> reports B being the owner. This is no problem as the next time two
>>>>>>>>>>>> threads fight over this lock the waiter will simply overwrite the
>>>>>>>>>>>> xnsynch_owner before it falls asleep. But this "trick" doesn't work for
>>>>>>>>>>>> waiters that have been robbed. They will spin inside xnsynch_sleep_on
>>>>>>>>>>>> and stumble over this inconsistency.
>>>>>>>>>>>>
>>>>>>>>>>>> I have two approaches in mind now: First one is something like
>>>>>>>>>>>> XNSYNCH_STEALNOINFORM, i.e. causing xnsynch_sleep_on to not set XNROBBED
>>>>>>>>>>>> so that the robbed thread spins one level higher in the skin code -
>>>>>>>>>>>> which would have to be extended a bit.
>>>>>>>>>>> No, the stealing is the xnsynch job.
>>>>>>>>>>>
>>>>>>>>>>>> Option two is to clear xnsynch_owner once a new owner is about to return
>>>>>>>>>>>> from kernel with the lock held while there are no more xnsynch_sleepers.
>>>>>>>>>>>> That should work with even less changes and save us one syscall in the
>>>>>>>>>>>> robbed case. Need to think about it more, though.
>>>>>>>>>>> In fact the only time when the owner is required to be in sync is when
>>>>>>>>>>> PIP occurs, and this is guaranteed to work, because when PIP is needed a
>>>>>>>>>>> syscall is emitted anyway. To the extent that xnsynch does not even
>>>>>>>>>>> track the owner on non PIP synch (which is why the posix skin originally
>>>>>>>>>>>  forcibly set the synch owner, and it was simply kept to get the fastsem
>>>>>>>>>>> stuff working).
>>>>>>>>>>>
>>>>>>>>>>> Ok. And what about the idea of the xnsynch bit to tell him "hey, the
>>>>>>>>>>> owner is tracked in the upper layer, go there to find it".
>>>>>>>>>> I'm yet having difficulties to imagine how this should look like when
>>>>>>>>>> it's implemented. Would it be simpler than my second idea?
>>>>>>>>>>
>>>>>>>>>> Anyway, here is a patch (on top of my handle-based lock series) for the
>>>>>>>>>> approach that clears xnsynch_owner when there are no waiters. At least
>>>>>>>>>> it causes no regression based on your test, but I haven't checked lock
>>>>>>>>>> stealing yet. In theory, everything still appears to be fine to me. This
>>>>>>>>>> approach basically restores the state we find when some thread just
>>>>>>>>>> acquired the lock in user space.
>>>>>>>>> Yes, I did not think about the stealing when writing my test, but I
>>>>>>>>> think it could be a good idea to add it to the test, especially if you
>>>>>>>>> want to port the test to the native API.
>>>>>>>>>
>>>>>>>>> I let Philippe decide here. He is the one who did the stealing stuff and
>>>>>>>>> probably knows better.
>>>>>>>>>
>>>>>>>> Currently, the xnsynch strongly couples PIP and ownership, which seems to impede
>>>>>>>> your various proposals. I would suggest to decouple that: the basic property of
>>>>>>>> some xnsynch that we may want to handle is exclusiveness, then dynamic priority
>>>>>>>> inheritance is another property, that could stack its own semantics on top of
>>>>>>>> exclusiveness.
>>>>>>>>
>>>>>>>> XNSYNCH_EXCLUSIVE would cover all ownership-related actions, XNSYNCH_PIP would
>>>>>>>> simply add dynamic priority management. Non exclusive object would not require
>>>>>>>> any xnsynch_set_owner() handling.
>>>>>>>>
>>>>>>>> Just to give a clear signal here: I will happily consider any change to the
>>>>>>>> xnsynch object that may ease the implementation of fast ownership handling (i.e.
>>>>>>>> userland-to-userland transfer). The only thing is that such code is very much
>>>>>>>> prone to regressions, so a testsuite must come with core changes in that area,
>>>>>>>> but I guess you know that already.
>>>>>>> Ok. I think unit_mutex.c is a good start. It only lacks testing
>>>>>>> XNROBBED.
>>>>>> My colleague sent me an extension. It's native-only so far, but it
>>>>>> already pointed out a bug in my try-acquire implementation that should
>>>>>> be present in posix as well (trylock must go through the slow path).
>>>>> I do not see why. If mutex lock can lock without a syscall, the same
>>>>> goes for trylock.
>>>> Lock stealing requires the slow path.
>>> Ah ok. I thought you mean that trylock had to go systematically through
>>> syscall.
>>>
>>> As for lock stealing, I already said that it was not tested in the
>>> current test.
>> In fact, that bug is also present the current native skin (SVN, 2.4.x
>> should suffer as well). Probably also current 2.4.x posix is affected,
>> at least from a first glance.
> 
> Well, yes, now that you mention it, calling xnsynch_sleep_on does not
> seem obvious for the implementation of a trylock.
>

Don't even try calling xnsynch_sleep_on with a nonblocking-type timeout.

> And by the way, I think that with the mutex/xnsynch shared owner, we can
> implement stealing without a syscall.
> 


-- 
Philippe.

