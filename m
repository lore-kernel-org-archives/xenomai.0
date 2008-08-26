Message-ID: <48B405D5.2050305@domain.hid>
Date: Tue, 26 Aug 2008 15:32:05 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <48B313B5.9050308@domain.hid>	<48B32E0C.7000105@domain.hid>	<48B33926.9060808@domain.hid>	<48B3B999.6000707@domain.hid>	<48B3BE60.4020709@domain.hid>	<48B3C1B3.2050404@domain.hid>
	<48B3C443.9000704@domain.hid>	<48B3FBBE.4050204@domain.hid>
	<48B40037.1030708@domain.hid> <48B4017A.906@domain.hid>
	<48B4029A.4070103@domain.hid>
In-Reply-To: <48B4029A.4070103@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] xnregistry_fetch & friends
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
Cc: xenomai-core <xenomai@xenomai.org>

Gilles Chanteperdrix wrote:
> Gilles Chanteperdrix wrote:
>> Jan Kiszka wrote:
>>> Gilles Chanteperdrix wrote:
>>>> Jan Kiszka wrote:
>>>>> BTW, I'm also preparing a patch to overcome hash chain registrations for
>>>>> anonymous (handle-only) objects as I need more of them (one for each
>>>>> thread) for fast mutexes - to avoid fiddling with kernel pointers in
>>>>> userland.
>>>> Ok. You will have a problem mangling a registry handle with the claimed
>>>> bit. Or maybe we can assume that the bit 31 is not used or something ?
>>> That's precisely my plan, use the highest bit (2^32 registry slots are
>>> fairly unlikely even on 64 bit).
>>>
>>>> And by the way, I had an idea of removing the duplication of the owner
>>>> field between an xnsynch and a mutex object, this would allow saving a
>>>> syscall when a situation of mutex stealing happened. Using a handle
>>>> would prevent this. But I am not so sure it is a good idea now (namely
>>>> because it would move some compare-and-swap the owner logic to the
>>>> xnsynch API).
>>> How could you save one of the two syscalls on lock stealing? By
>>> introducing another bit in the fast lock word that indicates something
>>> like XNWAKEN? On first sight, this shouldn't require moving everything
>>> into xnsynch (though generic fast locks were not that bad...) nor
>>> interfere with handle-based lock words.
>> The problem is that when the thread that did the stealing unlocks the
>> mutex, xnsynch_wakeup_one_sleeper must be called to set the xnsynch
>> owner to NULL, so that the robbed thread will succeed in getting the
>> xnsynch. But for xnsynch_wakeup_one_sleeper to be called, we must issue
>> the syscall. If the owner was shared between the mutex and the xnsynch,
>> the owner could be set to NULL by the mutex unlock from user-space.
> 
> That is what the "sleepers" field in the pse51_mutex_t structure is for.
> 

OK, this all sounds like fast-lock awareness would have to be taught to
xnsynch first. But that would also open the chance to teach it that
handles are stored inside the lock word, no pointers.

However, that's stuff for a second round. I will have to focus on
getting the native skin straight. Well, maybe this will already
introduce thread handles to the POSIX skin (due to common
__xn_sys_current)...

Jan

-- 
Siemens AG, Corporate Technology, CT SE 2
Corporate Competence Center Embedded Linux

