Message-ID: <4DDE8DC9.2020905@domain.hid>
Date: Thu, 26 May 2011 19:28:41 +0200
From: Jonas Witt <jonas.witt@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-help] Huge clock drift
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

Hi all,

i am having a problem concerning the clock drift under load:

# /usr/xenomai/bin/clocktest
== Tested clock: 0 (CLOCK_REALTIME)
CPU      ToD offset [us] ToD drift [us/s]      warps max delta [us]
--- -------------------- ---------------- ---------- --------------
   0          775571614.0       166776.858          0            0.0


It remains in the hundreds of MILLIseconds, changing constantly. My 
setup consists of an embedded Intel Atom board (1.6GHz Z530 processor) 
with a 2.6.32.7 kernel and Xenomai 2.5.2. Latencies under load are 
reasonable. Mean latency < 10us. Maximum latency < 40us.

Without load the ToD offset is approximately constant over time with a 
ToD drift in the range of 10 microseconds (strangely after a while this 
settles in a range of 2 microseconds). Does anyone have an idea how this 
can be caused? As a workaround I currently use rt_timer_read() in all 
relevant programs (also the non-realtime ones), since I need consistent 
timestamps between realtime and non-realtime tasks.

One other (maybe unrelated) strange behavior is occasional secondary 
mode switches when calling rt_queue_read(...).

Any help would be appreciated. Thanks in advance!

Cheers,
Jonas


