Message-ID: <4B72E0D3.50004@domain.hid>
Date: Wed, 10 Feb 2010 17:37:39 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4B72DB97.1020203@domain.hid> <4B72DF9F.9090103@domain.hid>
In-Reply-To: <4B72DF9F.9090103@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] xnselect_destroy fails to wake up waiters
List-Id: Xenomai life and development <xenomai.xenomai.org>
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
>> Hi Gilles,
>>
>> I tend to think that xnselect_destroy should signal an event on the
>> dying fd instead of just clearing the binding. The task blocking on
>> select currently does not get a hint that the fd is dead and will block
>> on select until some other event arrives. That's unfortunately not
>> standard conforming.
> 
> Ok. Got it, I was mixing xnselect_destroy and xnselector_destroy. Yes,
> right, something should be done. What is supposed to happen? Is it
> supposed to be signaled as an exceptional condition?
> 

It should be signaled so that the caller tries to read/write/whatever
and then gets the information that the fd is down.

Jan

-- 
Siemens AG, Corporate Technology, CT T DE IT 1
Corporate Competence Center Embedded Linux

