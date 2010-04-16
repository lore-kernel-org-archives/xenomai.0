Message-ID: <4BC85EF5.3000008@domain.hid>
Date: Fri, 16 Apr 2010 14:58:29 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <E1O2jBF-0000vQ-JB@xenomai.org> <4BC855E6.106@domain.hid>
	<4BC85899.90700@domain.hid>
In-Reply-To: <4BC85899.90700@domain.hid>
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
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

Jan Kiszka wrote:
> Gilles Chanteperdrix wrote:
>> GIT version control wrote:
>>> Module: xenomai-jki
>>> Branch: for-upstream
>>> Commit: 55ebde80258b5b6c3d29d37b5f30a3199faf0881
>>> URL:    http://git.xenomai.org/?p=xenomai-jki.git;a=commit;h=55ebde80258b5b6c3d29d37b5f30a3199faf0881
>>>
>>> Author: Wolfgang Mauerer <wolfgang.mauerer@domain.hid>
>>> Date:   Tue Mar 30 11:13:33 2010 +0200
>>>
>>> RTDM: Fix potential NULL pointer dereference
>>>
>>> The rework in 95278926edc559d4 misses the case that context can be NULL,
>>> which can (and has) triggered a kernel oops. Take care of this case.
>>>
>>> Signed-off-by: Wolfgang Mauerer <wolfgang.mauerer@domain.hid>
>>> Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>
>> I still think that fix is a useles waste of time. Let us merge
>> Philippe's patches instead.
> 
> Please accept that Philippe's patch is orthogonal to this bug.
> 
> And it didn't work as-is. I'll post a rework which has the same benefit
> (avoiding to poll on pending context references) - once it is tested.

Ok. I am fine with any variation as long as:
- close returns immediately even if the request is not taken into
account immediately;
- the file descriptor index is available again as soon as close returns;
- the kernel objects attached to the file descriptor are destroyed when
the last reference to it is closed.

In shoft: POSIX conformance.

-- 
					    Gilles.

