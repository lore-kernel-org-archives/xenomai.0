Message-ID: <4B72E428.6000606@domain.hid>
Date: Wed, 10 Feb 2010 17:51:52 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4B72DB97.1020203@domain.hid> <4B72DF9F.9090103@domain.hid>
	<4B72E0D3.50004@domain.hid>
In-Reply-To: <4B72E0D3.50004@domain.hid>
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
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

Jan Kiszka wrote:
> Gilles Chanteperdrix wrote:
>> Jan Kiszka wrote:
>>> Hi Gilles,
>>>
>>> I tend to think that xnselect_destroy should signal an event on the
>>> dying fd instead of just clearing the binding. The task blocking on
>>> select currently does not get a hint that the fd is dead and will block
>>> on select until some other event arrives. That's unfortunately not
>>> standard conforming.
>> Ok. Got it, I was mixing xnselect_destroy and xnselector_destroy. Yes,
>> right, something should be done. What is supposed to happen? Is it
>> supposed to be signaled as an exceptional condition?
>>
> 
> It should be signaled so that the caller tries to read/write/whatever
> and then gets the information that the fd is down.

Looks to me like you get a wakeup for nothing... From the spec:
http://www.opengroup.org/onlinepubs/009695399/functions/select.html

I do not see anything specified for the fds closure.

>From a "high level" point of view (meaning, only waving hands), by using
select you ask to be notified when a file descriptor is ready to be read
or written. When a descriptor is closed, it is neither ready to be read,
or written, so there does not seem to be any reason to wake up.

>From an implementation point of view. An application using select is
usually single threaded, and the same thread handles the file
descriptors closure, and the call to select, so this thread is well
aware that the descriptor is closed before calling select again. Now, if
the application is multi-threaded, and share the fd_set containing the
set of polled fds, when the fd is closed it is removed from this shared
fdset, and will be taken into account at next call to select by the
other threads (the ones that did not call close), in the mean time, I
see no reason to wake them up.

Maybe instead of "not standard conforming", you meant "that is not the
way Linux does it" ?

-- 
					    Gilles.

