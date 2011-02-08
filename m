MIME-Version: 1.0
In-Reply-To: <4D50433D.1040804@domain.hid>
References: <AANLkTinvryUHtzDWQa9j=Z83jNe1FbJtRYaqMHNORfvp@domain.hid>
	<4D5039AD.2070205@domain.hid>
	<AANLkTincD+0eKF7tM8aj5s4tepF0KwQ6xkJ52G1Lq4iT@mail.gmail.com>
	<4D50433D.1040804@domain.hid>
Date: Tue, 8 Feb 2011 09:21:55 +0100
Message-ID: <AANLkTi=SfPm6HVK2abFWV8uAd5wWnWv9vf0mkby8282r@domain.hid>
From: Henri Roosen <henriroosen@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
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
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

On Mon, Feb 7, 2011 at 8:08 PM, Gilles Chanteperdrix
<gilles.chanteperdrix@xenomai.org> wrote:
> Henri Roosen wrote:
>> On Mon, Feb 7, 2011 at 7:27 PM, Gilles Chanteperdrix
>> <gilles.chanteperdrix@xenomai.org> wrote:
>>> Henri Roosen wrote:
>>>> We are using signal handlers for catching exceptions which our
>>>> application is allowed to make and which we know how to handle.
>>>>
>>>> The current Xenomai implementation is to switch to the secondary
>>>> domain and call the handlers from there.
>>>> Unfortunately this takes too much time for our application and we
>>>> would like to handle the exception without the switch to the secondary
>>>> domain, in primary domain.
>>>>
>>>> Can anyone give some advice how to implement that?
>>>> Will "user-space signals" which was planned for Xenomai 2.6 fulfill th=
is need?
>>>> Is there already code available for user-space signals?
>>> In the 2.5 series, we added some code to support signals. The signals
>>> are multiplexed per-skin in kernel-space, and demultiplexed in
>>> user-space, upon exit of system calls. We implemented a unit test of
>>> this functionality with the "sigtest" skin and user-space test, but the=
y
>>> only work upon return from system calls.
>>>
>>> Then we added support for the "mayday" page, which made us realize, tha=
t
>>> maybe implementing signals handling at any time, not only when returnin=
g
>>> from system calls, was possible. But then came the realization that in
>>> order to implement that, we would have to fiddle with the FPU, which is
>>> an area where we have a certain tradition for not getting the things
>>> right at the first attempt. So, we kind of stopped here.
>>>
>>> So, if you want some ad-hoc signals upon return from system call, the
>>> task is pretty easy. If you want the full posix signals interface, then
>>> things are going to be a bit harder.
>>>
>> I am afraid it's going to be a bit harder; we would need it when the
>> exception occurs and that is in most cases not at a place in the code
>> where there is a system call :-(.
>
> What kind of exception is it? Could not the exception be signalled at
> the next system call?

Our customers provide the application code, we provide more or less
the framework. Customers can install exception handlers for for
instance floating point exceptions (SIGFPE).
Besides that we provide a means of tracing the application code, which
is handled by breakpoints in the code which then does some bookkeeping
and lets the task run again. Of course that has some overhead also
when using our old OS, but Linux-Xenomai has so much overhead because
of the secondary domain switch. Therefore we would like to handle it
in primary domain.

>
>>
>> I was thinking of adding a hook in Xenomai's exception handler before
>> it makes the switch to the secondary domain... but that would of
>> course be a very ugly hack and I don't know if it can be done. Do you
>> have a suggestion?
>>
>> What are the plans with the full posix signals interface?
>
> Plans were to get it during the 2.6 branch, but of course if someone is
> able to contribute it before, there is no problem.

I would like to help out of course, but first would like some quick
tests if it would be feasible in our application. Any hints on that?

Thanks,
Henri.

>
>>
>> Thanks,
>>> --
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Gilles.
>>>
>>
>
>
> --
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Gilles.
>

