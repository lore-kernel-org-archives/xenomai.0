Message-ID: <4D89A769.7020106@domain.hid>
Date: Wed, 23 Mar 2011 08:55:21 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <AANLkTinyoHF6tNGv5OvMEByYG1Eof8PSo9tnRO+_xEAd@domain.hid>
In-Reply-To: <AANLkTinyoHF6tNGv5OvMEByYG1Eof8PSo9tnRO+_xEAd@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] Help:Is the latency test right?
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: alamo hwuang <lovealamo@domain.hid>
Cc: xenomai@xenomai.org

alamo hwuang wrote:
> Hi , I am using the xenomai to build the paltform and getting a latency test
> results.
> 
> RTT|  00:00:01  (periodic user-mode task, 100 us period, priority 99)
> RTH|----lat min|----lat avg|----lat max|-overrun|---msw|---lat best|--lat
> worst
> RTD|     -2.362|     -2.179|      0.017|       0|     0|     -2.428|
> 3.189
> 
> How can I read the meaning of those results ?
> 
> and Are those results are correct???

It depends on what platform you are running. But from the results you
get, you are probably running latency on x86_64, without any load. The
results you get doing so are probably meaningless. If you wonder about
the negative latencies, they simply mean that your system is not
calibrated correctly.

The latency tool measures the wake up latency of user-space/kernel-space
task by using the timer services, so, in fact, the timer wake-up
latency. However, in order to compensate for the constant overhead of
the thread wake-up path, the timer services anticipate. So, when you ask
for a thread to be woken up at time T, the timer will tick at
T - compensation
So, that when the task is finally woken up, it will appear to have woken
up at a time close to T.
This anticipation may be chosen with /proc/xenomai/latency

A system running Xenomai has to be calibrated, an anticipation has to be
chosen according to what you want, and what your system can do. So, you
should do:

echo 0 > /proc/xenomai/latency
This will disable the anticipation.

Then run latency under load for a long time.

Then according to the results given by the test, and what you need for
your application, echo the value you choose to /proc/xenomai/latency.

The value the latency test will give you with a null anticipation is the
scheduling latency.

Xenomai pick some default value for this anticipations which comes from
boards on which we test it, which can result on negative latencies on
other boards.


> 
> what is the max size of  a xenomai task stack size?

Xenomai relies on the glibc to create threads. So, the rule for stack
sizes are no different for a Xenomai task than for any non real-time
task on the system. But beware of mlockall (see the TROUBLESHOOTING
guide on this subject).

Please note that for such questions, the xenomai-help mailing list is
more appropriate.

-- 
                                                                Gilles.

