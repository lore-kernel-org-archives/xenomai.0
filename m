Message-ID: <48BD4507.9090508@domain.hid>
Date: Tue, 02 Sep 2008 15:52:07 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <48BD409B.8000309@domain.hid> <48BD4142.5060301@domain.hid>
In-Reply-To: <48BD4142.5060301@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [PATCH] POSIX: Fix race when setting claimed bit
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
> Jan Kiszka wrote:
>> Patch 2 of my fast lock series actually also contained an attempt to fix
>> a race I spotted in the code that atomically sets the claimed bit. I
>> forgot about this fact and even, worse, I only replace the original race
>> with another one.
>>
>> So here comes a new attempt to fix the issue that the lock owner and/or
>> the claimed bit can change between trylock and the cmpxchg under nklock.
>> Please have a look and cross-check the logic.
>>
>> The patch applies on top of vanilla SVN, so my series has to be rebased
>> and the fix has to be ported to native as well - where we just found it
>> in the field.
> 
> Could you explain the race ?

We read the owner in pse51_mutex_trylock_internal. In
pse51_mutex_timedlock_internal under nklock, we check that old value for
the claimed bit. If the old value happened to have it set, we continue
happily without worries. But it may have been cleared meanwhile _before_
we entered the nklock.

I previously tried to fix this by re-reading the lock value, but then I
failed to account for the case that the value may have become NULL
meanwhile. The new version should cover both cases.

Jan

-- 
Siemens AG, Corporate Technology, CT SE 2
Corporate Competence Center Embedded Linux

