Message-ID: <4E01CA75.90201@domain.hid>
Date: Wed, 22 Jun 2011 12:56:53 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4E01B55C.7030507@domain.hid> <4E01C5B1.3020307@domain.hid>
	<4E01CA10.1090703@domain.hid>
In-Reply-To: <4E01CA10.1090703@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] User space stack pre-faulting
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: Xenomai core <Xenomai-core@domain.hid>

On 06/22/2011 12:55 PM, Jan Kiszka wrote:
> On 2011-06-22 12:36, Gilles Chanteperdrix wrote:
>> On 06/22/2011 11:26 AM, Jan Kiszka wrote:
>>> Hi Gilles,
>>>
>>> do you remember reasons for only pre-faulting the main thread's stack?
>>> The desire to avoid wasting resources by forcing all stacks into memory?
>>>
>>> I've the requirement on my table to provide a generic solution of all
>>> shadow threads. I think this should be possible using pthread_getattr_np
>>> and walking the stack page-wise, but I may miss some pitfall.
>>
>> Last time I checked, only the main thread stack was mapped on demand.
>> Other threads have mmaped stacks, which are made present by mlockall,
>> so, do not need faulting.
> 
> That's definitely not the case in general. Customer has just confirmed
> that pre-faulting thread stacks avoids first-access domain switches.

self-contained test case please.

> 
> Jan
> 


-- 
                                                                Gilles.

