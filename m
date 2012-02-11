Message-ID: <4F36B4A5.8080202@domain.hid>
Date: Sat, 11 Feb 2012 19:34:13 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: [Adeos-main] ipipe_request_tickdev issue
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/options/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Adeos <adeos-main@gna.org>


Hi,

I found this out a long time ago on AT91 and worked around it but am
starting to see the same issue on hardware which hardware timer does not
wrap as fast: when xenomai calls ipipe_request_tickdev, the clockevent
structure max_delta_ns member is set to ULONG_MAX, but on most ARM
platforms, the reason for max_delta_ns is not only the timer hardware
limit, it is also necessary to call eg. update_sched_clock at least once
every max_delta_ns in order to avoid the hardware counter wrapping
without the system noticing it.

What do you think is the best way to avoid this issue? I would propose
simply removing the line which does:
	evtdev->max_delta_ns = ULONG_MAX;
in ipipe_request_tickdev, but maybe someone else sees a better solution.

-- 
                                                                Gilles.

