Message-ID: <4357CF67.8080601@domain.hid>
Date: Thu, 20 Oct 2005 19:09:59 +0200
From: =?ISO-8859-15?Q?Ignacio_Garc=EDa_P=E9rez?= <iggarpe@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] timeout in native API calls (cond, sem, mutex,
	etc).
References: <4357C3E1.1040701@domain.hid> <4357C9F7.2060808@domain.hid>
In-Reply-To: <4357C9F7.2060808@domain.hid>
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jan Kiszka <kiszka@domain.hid>
Cc: xenomai@xenomai.org

Jan Kiszka wrote:

>Ignacio Garc=EDa P=E9rez wrote:
> =20
>
>>Hi,
>>
>>While porting my application, I noticed that all synchronization
>>primitives locking calls take a relative timeout as a parameter, right?
>>
>>Of course, I can get the current time, calculate the timeout interval by
>>substracting the current time from the desired timeout moment, and call
>>the function. But wouldn't something like this be possible?:
>>
>>Suppose I want to wait on a semaphore until t=3D1000, and now=3D900.
>>
>>1- I get current time (900).
>>2- I calculate the relative timeout as 1000-900 =3D 100
>>3- I call rt_sem_p(&mysem, 100);
>>
>>In the best case, no preemption will occur between steps 1 and 3, but my
>>thread will still be sleeping not until t=3D1000, but until some time
>>later, t=3D1000+d, where d is the time used by the code in steps 1-3 and
>>into the native skin/nucleus.
>>
>>In the worst case, in addition to that, the thread will be preempted
>>between steps 1 and 3. If it is preempted by another higher priority
>>thread for, say, 50 ticks, and the call in step 3 is actually executed
>>at t=3D950, the thread will be sleeping until t=3D1050+d, which may not be
>>acceptable.
>>
>>What do you think?
>>   =20
>>
>
>That's true, having to convert between absolute and relative time (and
>vice versa) in interruptible contexts can cause problems if the
>application is not prepared for it.
>
>The question is: do you really need that precise timeouts for
>synchronisation primitives?
>
Yes I do. In my application, there is a free-run periodic execution
thread that gets once in a while synchronized to an external event.

This thread waits on a semaphore with an absolute timeout of t, does its
work, calculates t =3D t + period and waits again on the semaphore. If the
external event signals the semaphore, the thread wakes up immediately
and does some slightly different stuff.

The thing is, I want the free-run thread to execute at 2 KHz, this is,
every 5 ms. If I use a relative time, I face the problem I described.

I guess I could get it working properly using a periodic thread, but I'm
sure it's not as simple (and does not "feel" as natural) as just waiting
on the synchronization primitive using an absolute timeout.

I really really think there should be, for each call that takes a
timeout, two version, one that takes a relative timeout and another that
takes an absolute timeout.

Any chances of this being implemented in the current native API?

>Typically, timeouts are used here to detect
>errors (someone else failed to signal), and you don't have to detect
>them that precisely - typically.
> =20
>
I agree.

>An exception is when you want to maintain a single timeout across
>multiple blocking calls. Then you could create a timer instead that
>unblocks your infinitely waiting task when being triggered. Just as
>timing out, unblocking also gives you an error when returning from the
>blocking call.
> =20
>
Sure you can do it that way, but using a timer seems a bit of an
overhead compared to just having absolute timeout API calls.

I sincerely think it would not break the beauty and simplicity of the
native API.

Nacho.

