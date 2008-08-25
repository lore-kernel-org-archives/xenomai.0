Message-ID: <48B2E31A.2020109@domain.hid>
Date: Mon, 25 Aug 2008 18:51:38 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <48B2D1C4.5010306@domain.hid> <48B2E115.4070107@domain.hid>
In-Reply-To: <48B2E115.4070107@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] Fast native mutexes vs. RT_MUTEX_INFO.lockcnt
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: rpm@xenomai.org
Cc: xenomai-core <xenomai@xenomai.org>

Philippe Gerum wrote:
> Jan Kiszka wrote:
>> Hi,
>>
>> next issue on my way towards fast native mutexes: as mutexes are now
>> mostly acquired in user space, the recursion counter lockcnt will only
>> be maintained in the context of the owning thread (at best: its process)
>> in user space. No update on the kernel-side lockcnt will take place
>> anymore, thus rt_mutex_inquire can only return 0 or 1, no > 1. Is it OK
>> to break the ABI here?
>>
> 
> I think so, we might lose some debug information, but that's the price for much
> better performances. I can't imagine any sane code iterating lockcnt-times
> blindly to unlock a mutex it owns until it is free. Nah, of course not...

Hmm, we could rename 'lockcnt' to 'locked' so that no one can stumble
accidentally over this change...

Jan

-- 
Siemens AG, Corporate Technology, CT SE 2
Corporate Competence Center Embedded Linux

