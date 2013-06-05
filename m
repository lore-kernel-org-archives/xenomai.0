MIME-Version: 1.0
In-Reply-To: <51AEF87A.8060506@xenomai.org>
References: <CAONLcG3gGo=vPGe+x_XBhs2ovXF9nzSkq+jvGP8zZR4daa0_4g@mail.gmail.com>
	<51AEF0A5.6010402@xenomai.org>
	<CAMJ=MEe-gaqb-wUeVPnx-9O+bL+LyCBsndrBucji5c9vqwiJDQ@mail.gmail.com>
	<51AEF87A.8060506@xenomai.org>
Date: Wed, 5 Jun 2013 11:51:29 +0200
Message-ID: <CAONLcG0x0GWn0PQN3_5S6LfUbf8fMXzRVR82Udt9=C4yHZEJhg@mail.gmail.com>
From: Tom Philips <tom.philips1311@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: Re: [Xenomai] [xenomai-forge] psos: crash while stressing event
	timers
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Philippe,

I tried the asserts you suggested and here's the output:

+++
xenomai: timerobj.c:308: timerobj_start: Assertion
`timer_getoverrun(tmobj->timer) >= 0' failed.
Aborted (core dumped)
+++


So this means the call to timer_getoverrun() fails.
Then I did some further investigation.
I changed the code in timerobj_start() to this:


+++
  if (__RT(timer_settime(tmobj->timer, TIMER_ABSTIME, it, NULL))) {
    int error = errno;
    errno = 0;
    if (timer_getoverrun(tmobj->timer) < 0) {
      __bt(-errno);           => @ line 311
    }
/*  assert(timer_getoverrun(tmobj->timer) >= 0); */
    assert(it->it_value.tv_sec >= 0 && it->it_value.tv_nsec < 1000000000);
    assert(it->it_interval.tv_sec >= 0 && it->it_interval.tv_nsec <
1000000000);
    return __bt(-error);      => @ line 316
  }
+++


This gives following (strange) result:
(The 'tm_evafter(x,y) returned' traces are from my test app)


+++
------------------------------------------------------------------------------
[ ERROR BACKTRACE: thread 0.0 ]

   #0  EINVAL in timerobj_start(), timerobj.c:316
=> #1  EINVAL in timerobj_start(), timerobj.c:311
------------------------------------------------------------------------------
tm_evafter(0,0) returned 75 (errno 22): tmid=3066037456
------------------------------------------------------------------------------
[ ERROR BACKTRACE: thread 4.0 ]

=> #0  EINVAL in timerobj_start(), timerobj.c:316
------------------------------------------------------------------------------
tm_evafter(4,0) returned 75 (errno 0): tmid=67192088
------------------------------------------------------------------------------
[ ERROR BACKTRACE: thread 4.0 ]

   #0  EINVAL in timerobj_start(), timerobj.c:316
=> #1  EINVAL in timerobj_start(), timerobj.c:311
------------------------------------------------------------------------------
tm_evafter(4,0) returned 75 (errno 22): tmid=67191880
+++


So timer_getoverrun() fails and sets errno to EINVAL (22)
This can only mean that the given timerid is (or has become) invalid.

But timer_getoverrun() does not always fail when timer_settime() fails.
My rough estimate is that 1 out of 20 times timer_getoverrun()
does not fail when timer_settime() fails.

Might it be that there is a race condition between the above code
and the code excuted at timer elapse (i.e. were the timer is destroyed)?

---
Tom
