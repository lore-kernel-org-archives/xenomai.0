Message-ID: <48D688EE.7010404@domain.hid>
Date: Sun, 21 Sep 2008 19:48:30 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <48CE7BD7.6060504@domain.hid> <48D620DB.2070101@domain.hid>
In-Reply-To: <48D620DB.2070101@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [RFC][PATCH] Factor out xnsynch_acquire/release
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

Jan Kiszka wrote:
> Jan Kiszka wrote:
>> Slowly moving on toward generic fast mutex support for Xenomai, this
>> patch is a proposal to address the increasing divergence of
>> owner-tracking vs. owner-less xnsynch objects.
>>
>> The services dealing with the former will likely include a new, lockless
>> prologues for the mutex fastpath. At the the same time, this additional
>> code should not disturb too much in those cases where we do not track
>> ownership (condition variables, events, semaphores etc.). Moreover, I
>> noticed that some of the existing code assumes XNSYNCH_NOPIP means no
>> ownership, which is surely not true. The already visible effect is that
>> lock stealing is needlessly restricted to XNSYNCH_PIP.
>>
>> Going through the API, I dug out three diverging services and replaced
>> them with two new ones:
>>
>> Owner-less xnsynch objects:
>> - xnsynch_sleep_on
>> - xnsynch_wakeup_one_sleeper
>> - xnsynch_wakeup_this_sleeper
>>
>> Owner-tracking xnsynch objects:
>> - xnsynch_acquire
>> - xnsynch_release
>>
>> The latter type of objects are marked with the new flag XNSYNCH_OWNER,
>> used only for debugging and code documentation purposes in the current
>> implementation.
> 
> Any comments on this? I plan to resume the work on fast xnsynch once
> this building block is clarified (or replaced by an alternative).

I have to admit that I have to dig into my e-mails to find back all the
patches to which I have not answered, and this is hard. Is it easy for
you to repost all of them in a unique thread ?

-- 
					    Gilles.

