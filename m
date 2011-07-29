Message-ID: <4E329D0B.50509@domain.hid>
Date: Fri, 29 Jul 2011 13:44:11 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4E299162.8000309@domain.hid> <4E305DAB.80402@domain.hid>
	<4E3194A5.5040709@domain.hid>
In-Reply-To: <4E3194A5.5040709@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] __wrap_clock_gettime
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
Cc: Xenomai core <Xenomai-core@domain.hid>

On 2011-07-28 18:56, Jan Kiszka wrote:
> On 2011-07-27 20:49, Gilles Chanteperdrix wrote:
>> On 07/22/2011 05:04 PM, Jan Kiszka wrote:
>>> Hi Gilles,
>>>
>>> pulling assert_context.c into the common libxenomai created a problem
>>> around picking the right __wrap_clock_gettime. As libpthread_rt depends
>>> on libxenomai, the latter is loaded first and defines the debug version
>>> of __wrap_clock_gettime as the default. There is no chance to pull the
>>> posix skin implementation.
>>>
>>> I don't have a nice idea yes how to resolve this. Options are:
>>>  - drop __wrap_clock_gettime from assert_context.c (affects any skin
>>>    user != posix)
>>>  - put assert_context stuff into separate library again
>>>  - put __wrap_clock_gettime in all skin libs != posix
>>>
>>> I'm favoring the simplest approach ATM, ie. the first one. Other ideas?
>>
>> I agree, but I would have thought __attriibute__((weak)) takes care of
>> this issue.
> 
> The point is that once you have pulled in that weak symbol into a
> process, the dynamic loader won't update it if a non-weak version is
> pulled in via dlopen.

Fiddling with all options again, it turned out that the issue is also
reproducible without any dlopen. This ordering is fine:

-lpthread_rt -lxenomai

This one does not work:

-lxenomai -lpthread_rt

Now the problematic ordering can be achieved in many ways, in our case
by linking a top-level process first against a library with
native+xenomai dependencies and then against one with pthread_rt+xenomai
deps. That is resolvable by reordering, but only if you maintain this
meta-information consistently (IOW, it's doomed to break accidentally
again).

So I've pushed a patch that replaces the code with a comment that
explains the non-existence.

Jan

-- 
Siemens AG, Corporate Technology, CT T DE IT 1
Corporate Competence Center Embedded Linux

