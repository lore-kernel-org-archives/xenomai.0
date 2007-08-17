Message-ID: <46C590D5.1060507@domain.hid>
Date: Fri, 17 Aug 2007 14:13:09 +0200
From: Dirk Eibach <eibach@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Time for rt_mutex_acquire
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Xenomai help <xenomai@xenomai.org>

gilles.chanteperdrix@xenomai.org wrote:
> On 8/17/07, Dirk Eibach <eibach@domain.hid> wrote:
>> gilles.chanteperdrix@xenomai.org wrote:
>>> Dirk Eibach wrote:
>>>  > Hello,
>>>  >
>>>  > I'm wondering how long a rt_mutex_acquire is supposed to take on a PPC405
>>>  > platform. I'm getting times about 50 usec here, which is too much for my
>>>  > application. Is anything wrong in my kernel/xenomai configuration or is
>>>  > this time to expected?
>>>
>>> How do you measure this ? Are you sure the mutex is free when you try to
>>> acquire it ?
>>>
>> I prepared a small testcase. It shows about 8.300 ticks, which is about 30
>> usec on my platform (266MHz).
> 
> Did you try to call ppc_getcounter twice in a raw to measure the
> overhead of this function ?

Calling ppc_getcounter twice in a raw results in 116 ticks.

Cheers.
-- 
Dirk Eibach
Entwicklung
Guntermann & Drunck GmbH Systementwicklung




