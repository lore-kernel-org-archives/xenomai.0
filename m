Message-ID: <4E00A530.1060601@domain.hid>
Date: Tue, 21 Jun 2011 16:05:36 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <3FF315C710820E47A04E55C6F7D9B0AD7FE9FF@AREXCH02.mra.roland-man.biz>	
	<1308044391.2699.2.camel@domain.hid>	
	<3FF315C710820E47A04E55C6F7D9B0AD7FEA2C@AREXCH02.mra.roland-man.biz>	
	<1308387052.2122.14.camel@domain.hid> <4DFCABDA.6000702@domain.hid>	
	<1308406918.2122.24.camel@domain.hid>	
	<3FF315C710820E47A04E55C6F7D9B0AD7FECDA@AREXCH02.mra.roland-man.biz>	
	<1308652557.2125.45.camel@domain.hid>	
	<3FF315C710820E47A04E55C6F7D9B0AD7FECF6@domain.hid>	
	<4E008174.2060305@domain.hid>	
	<3FF315C710820E47A04E55C6F7D9B0AD7FED23@domain.hid>
	<1308662104.2125.50.camel@domain.hid>
In-Reply-To: <1308662104.2125.50.camel@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Xenomai 2.5.6 with PPC-Kernel 2.4.25
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

On 06/21/2011 03:15 PM, Philippe Gerum wrote:
> On Tue, 2011-06-21 at 15:05 +0200, roderik.wildenburg@domain.hid
> wrote:
>>> But more importantly, since, the time when we print the result is so
>>> imprecise, some variations are normal, so, chances are that the 2%
>>> variation is normal.
>>>
>>
>> Ok. Here is a switchtest with Xenomai 2.4.9 on PPC-Kernel 2.4.25 and indeed fluctuation is again about 2%.
>> But the number of context switches is just about 25% of switchtest from Xeno 2.5.6 on a PPC-2.6.34. Did you change the tasks period from 2.4.9 to 2.5.6?
>> So, if the gurus say this variation is within the normal bandwidth it is ok for me.
> 
> The number of switches is related to the number of tasks running in this
> test, nofpu reduces this number. So that is ok. The problem with this
> test is that switches/sec values are sampled by a regular linux thread
> which nanosleeps, so at least over 2.4, the delay is not accurate. So
> the number of switches observed can't be either.

The task which nanosleeps does not really sample the number of context
switches, it is part of the context switches chain, and simply prints
the number when it sees that the last time the number was printed is
more than 1s ago. So, how many context switches happen depends greatly
on how many time the context switches chain passed by this task, and so
is not regular.

The switchtest code also changed between 2.4 and 2.6, which is why you
can not compare the numbers.

Pay no attention to the number of context switches. All which matters is
that this number increase over time, this is why we print them.

-- 
					    Gilles.

