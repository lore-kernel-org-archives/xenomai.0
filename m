Message-ID: <48F855DB.3070300@domain.hid>
Date: Fri, 17 Oct 2008 11:07:39 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <20081016154620.320953568@domain.hid>	<20081016154621.644116499@domain.hid>
	<48F7A064.20404@domain.hid> <48F7C5D1.3010500@domain.hid>
In-Reply-To: <48F7C5D1.3010500@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [PATCH 08/12] Use fast xnsynch with native skin
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
Cc: xenomai@xenomai.org

Jan Kiszka wrote:
> Gilles Chanteperdrix wrote:
>> Jan Kiszka wrote:
>>
>> Same remark for the #ifdefs.
> 
> Yes, but most cases (maybe except for owner checking) are unavoidable
> due to heavy differences. I hope that we may have only FASTXNSYCH archs
> one day.
> 
>> I also do not understand your modification
>> of rt_cond_wait_inner, this code is very tense; posix and native had the
>> same bug in this area at different times, so this change should probably
>> be made separately.
> 
> Which modification precisely (damn, I need to find out what makes quilt
> cause this attachment confusion)? Note that lockcnt tracking changed
> with this patch: the lock owner himself is in charge of maintaining it,
> not some thread handing the lock over.
> 
> That said, I would happily analyse the case that broke before. I will
> also check if I can break out the lockcnt maintenance change, but I
> think to recall that it was coupled to the fast path changes.

The point is that in case of rt_cond_wait, the mutex must unlock
completely regardless of the current lock count. So, the count is set to
1 before calling the function which unlocks the last level of the
recursion count. As far as I can see, you removed the part which sets
the counter to 1.

-- 
                                                 Gilles.

