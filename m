Message-ID: <4BC86E70.1010707@domain.hid>
Date: Fri, 16 Apr 2010 16:04:32 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <E1O2jBF-0000vQ-JB@xenomai.org> <4BC855E6.106@domain.hid>	
	<4BC85899.90700@domain.hid>
	<1271423429.2365.719.camel@domain.hid>
In-Reply-To: <1271423429.2365.719.camel@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [Xenomai-git] Wolfgang Mauerer : RTDM: Fix
 potential NULL pointer dereference
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai-core <xenomai@xenomai.org>

Philippe Gerum wrote:
> On Fri, 2010-04-16 at 14:31 +0200, Jan Kiszka wrote:
>> Gilles Chanteperdrix wrote:
>>> GIT version control wrote:
>>>> Module: xenomai-jki
>>>> Branch: for-upstream
>>>> Commit: 55ebde80258b5b6c3d29d37b5f30a3199faf0881
>>>> URL:    http://git.xenomai.org/?p=xenomai-jki.git;a=commit;h=55ebde80258b5b6c3d29d37b5f30a3199faf0881
>>>>
>>>> Author: Wolfgang Mauerer <wolfgang.mauerer@domain.hid>
>>>> Date:   Tue Mar 30 11:13:33 2010 +0200
>>>>
>>>> RTDM: Fix potential NULL pointer dereference
>>>>
>>>> The rework in 95278926edc559d4 misses the case that context can be NULL,
>>>> which can (and has) triggered a kernel oops. Take care of this case.
>>>>
>>>> Signed-off-by: Wolfgang Mauerer <wolfgang.mauerer@domain.hid>
>>>> Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>
>>> I still think that fix is a useles waste of time. Let us merge
>>> Philippe's patches instead.
>> Please accept that Philippe's patch is orthogonal to this bug.
>>
>> And it didn't work as-is. I'll post a rework which has the same benefit
>> (avoiding to poll on pending context references) - once it is tested.
> 
> You mean that your current implementation, does poll, right? Because
> mine does not, that was the point of it, also to solve races in
> cross-context management IIRC.

Polling is part of the RTDM API: If a driver requests it via EAGAIN, we
have to provide it. We may deprecate this feature long-term, but for now
there are no drop-in replacements available and we have drivers in the
field that make use of it.

> That patch dates back to the 2.5 -rc
> cycle, when I needed it to have a decent behavior while working on the
> RTIPC stuff. It should not be that difficult to forward port it to
> -head, I guess. Let me know if I can help.

Thanks. The patch is done, it just waits for the final tests as I wrote.
I would be happy if you could test it as well if you have something that
nicely stresses e.g. RTIPC in this domain.

Jan

-- 
Siemens AG, Corporate Technology, CT T DE IT 1
Corporate Competence Center Embedded Linux

