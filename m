Message-ID: <4D513427.6050707@domain.hid>
Date: Tue, 08 Feb 2011 13:16:39 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <AANLkTinvryUHtzDWQa9j=Z83jNe1FbJtRYaqMHNORfvp@domain.hid>	
	<4D5039AD.2070205@domain.hid>	
	<AANLkTincD+0eKF7tM8aj5s4tepF0KwQ6xkJ52G1Lq4iT@mail.gmail.com>	
	<4D50433D.1040804@domain.hid>	
	<AANLkTi=SfPm6HVK2abFWV8uAd5wWnWv9vf0mkby8282r@domain.hid>	
	<1297154320.2023.6.camel@domain.hid>	
	<AANLkTim4Q_F5wY77TBH5T0oT3P2X2pex7B-8cr6Q+XyS@mail.gmail.com>	
	<1297156556.2023.9.camel@domain.hid> <4D513278.4090606@domain.hid>
	<1297167172.2023.11.camel@domain.hid>
In-Reply-To: <1297167172.2023.11.camel@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Exception handlers in primary domain /
 user-space signals
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

Philippe Gerum wrote:
> On Tue, 2011-02-08 at 13:09 +0100, Gilles Chanteperdrix wrote:
>> Philippe Gerum wrote:
>>> On Tue, 2011-02-08 at 10:10 +0100, Henri Roosen wrote:
>>>> On Tue, Feb 8, 2011 at 9:38 AM, Philippe Gerum <rpm@xenomai.org> wrote:
>>>>> On Tue, 2011-02-08 at 09:21 +0100, Henri Roosen wrote:
>>>>>> On Mon, Feb 7, 2011 at 8:08 PM, Gilles Chanteperdrix
>>>>>> <gilles.chanteperdrix@xenomai.org> wrote:
>>>>>>> Henri Roosen wrote:
>>>>>>>> On Mon, Feb 7, 2011 at 7:27 PM, Gilles Chanteperdrix
>>>>>>>> <gilles.chanteperdrix@xenomai.org> wrote:
>>>>>>>>> Henri Roosen wrote:
>>>>>>>>>> We are using signal handlers for catching exceptions which our
>>>>>>>>>> application is allowed to make and which we know how to handle.
>>>>>>>>>>
>>>>>>>>>> The current Xenomai implementation is to switch to the secondary
>>>>>>>>>> domain and call the handlers from there.
>>>>>>>>>> Unfortunately this takes too much time for our application and we
>>>>>>>>>> would like to handle the exception without the switch to the secondary
>>>>>>>>>> domain, in primary domain.
>>>>>>>>>>
>>>>>>>>>> Can anyone give some advice how to implement that?
>>>>>>>>>> Will "user-space signals" which was planned for Xenomai 2.6 fulfill this need?
>>>>>>>>>> Is there already code available for user-space signals?
>>>>>>>>> In the 2.5 series, we added some code to support signals. The signals
>>>>>>>>> are multiplexed per-skin in kernel-space, and demultiplexed in
>>>>>>>>> user-space, upon exit of system calls. We implemented a unit test of
>>>>>>>>> this functionality with the "sigtest" skin and user-space test, but they
>>>>>>>>> only work upon return from system calls.
>>>>>>>>>
>>>>>>>>> Then we added support for the "mayday" page, which made us realize, that
>>>>>>>>> maybe implementing signals handling at any time, not only when returning
>>>>>>>>> from system calls, was possible. But then came the realization that in
>>>>>>>>> order to implement that, we would have to fiddle with the FPU, which is
>>>>>>>>> an area where we have a certain tradition for not getting the things
>>>>>>>>> right at the first attempt. So, we kind of stopped here.
>>>>>>>>>
>>>>>>>>> So, if you want some ad-hoc signals upon return from system call, the
>>>>>>>>> task is pretty easy. If you want the full posix signals interface, then
>>>>>>>>> things are going to be a bit harder.
>>>>>>>>>
>>>>>>>> I am afraid it's going to be a bit harder; we would need it when the
>>>>>>>> exception occurs and that is in most cases not at a place in the code
>>>>>>>> where there is a system call :-(.
>>>>>>> What kind of exception is it? Could not the exception be signalled at
>>>>>>> the next system call?
>>>>>> Our customers provide the application code, we provide more or less
>>>>>> the framework. Customers can install exception handlers for for
>>>>>> instance floating point exceptions (SIGFPE).
>>>>>> Besides that we provide a means of tracing the application code, which
>>>>>> is handled by breakpoints in the code which then does some bookkeeping
>>>>>> and lets the task run again. Of course that has some overhead also
>>>>>> when using our old OS, but Linux-Xenomai has so much overhead because
>>>>>> of the secondary domain switch. Therefore we would like to handle it
>>>>>> in primary domain.
>>>>> Connect a high priority shadow task in userland to an exception handler
>>>>> installed in kernel space via some synchronization (semaphore, event,
>>>>> whatever). The handler would be called upon exception, then would wake
>>>>> up your task in userland, which would preempt immediately any other task
>>>>> activity due to its higher priority. This would not entail any mode
>>>>> switch, only a fast context switch between Xenomai contexts.
>>>>>
>>>>> Over this "exception server" task context, you should be able to execute
>>>>> any kind of user-space handler to mimic the POSIX signal interface as
>>>>> much as required. Of course this would not run over the faulting context
>>>>> like POSIX signals do (unless SIGEV_THREAD is used), but this might be
>>>>> ok for your purpose.
>>>>>
>>>> Unfortunately we do need the faulting context for the SIGFPE signal
>>>> and SIGTRAP (x86) / SIGILL (arm) signals...
>>>
>>> It's too much to ask in the current implementation. There is no quick
>>> fix to this, I mean if you want to have a standard signal frame to
>>> exploit in userland. Otherwise, you could pull some relevant bits from
>>> the exception frame in kernel space (you have the struct pt_regs of the
>>> faulting context avail there), and pass them through your
>>> synchronization mechanism to userland, so as to fake some kind of
>>> pseudo-signal frame.
>> All this is certainly doable, but even without Xenomai, going to
>> kernel-space in case of exception then building a signal frame, going
>> back to user-space, executing the signal handler, then returning from
>> the signal (possibly going to kernel-space again) is not exactly a light
>> operation. So, surely, exceptions should remain exceptional and using
>> them routinely does not look like the right thing to do.
> 
> No, you missed the point. The idea is not to forge a stack frame in
> kernel space. The idea is to propagate enough information to userland in
> order to provide whatever bits are needed there.

I was not talking about the Xenomai case specifically, but since Henri
would like to have the full signals implementation with Xenomai, this
does a apply to Xenomai too.


-- 
                                                                Gilles.

