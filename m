From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17978.13988.907236.43534@domain.hid>
Date: Thu, 3 May 2007 21:23:16 +0200
In-Reply-To: <4639F400.8050401@domain.hid>
References: <4639D724.5010702@domain.hid>
	<4639F400.8050401@domain.hid>
Subject: Re: [Xenomai-help] Latency calculation and test
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Johan Borkhuis <j.borkhuis@domain.hid>, Xenomai-help@domain.hid

Gilles Chanteperdrix wrote:
 > Johan Borkhuis wrote:
 > > When running multiple threads within this program (without load) the 
 > > values range from -5 usec to +5 usec, with an average of around 0 usec. 
 > > But with more RT tasks I see a very high latency once in a while (over 
 > > 400 usec).
 > > 
 > > Below is the example of such a test run with 10 threads/tasks:
 > >  T: 0 ( 1305) P:80 I:1000 O: 0 Min:   -2.404 Avg: -0.001 Max:   1.873
 > >  T: 1 ( 1306) P:79 I:1000 O: 0 Min:   -3.052 Avg: -0.001 Max:   1.584
 > >  T: 2 ( 1307) P:78 I:1000 O: 0 Min:   -5.694 Avg:  0.000 Max:  18.282
 > >  T: 3 ( 1308) P:77 I:1000 O: 0 Min:   -5.166 Avg:  0.046 Max: 479.782
 > >  T: 4 ( 1309) P:76 I:1000 O: 0 Min:   -2.595 Avg:  0.036 Max: 368.310
 > >  T: 5 ( 1310) P:75 I:1000 O: 0 Min:   -1.731 Avg: -0.001 Max:   1.633
 > >  T: 6 ( 1311) P:74 I:1000 O: 0 Min: -481.273 Avg: -0.001 Max: 490.352
 > >  T: 7 ( 1312) P:73 I:1000 O: 0 Min: -273.947 Avg: -0.001 Max: 277.717
 > >  T: 8 ( 1313) P:72 I:1000 O: 0 Min:  -47.016 Avg: -0.001 Max:  45.789
 > >  T: 9 ( 1314) P:71 I:1000 O: 0 Min:  -22.968 Avg: -0.001 Max:  29.572
 > > (P=Priority, I=interval, O=overruns)
 > > 
 > > When looking at the detailed information, I see that the latencies occur 
 > > when a higher priority task is ending. Is there some specific reason for 
 > > this, or is there some kind of configuration problem with my setup?
 > 
 > Let us suppose that the timers of task 0 and task 2 occur at the same
 > time. task 2 will have to wait for task 0 to finish its printing job or
 > for task 0 to reach a suspension point before being able to run. If this
 > is the reason of the latencies you are observing, disabling root thread
 > priority coupling should improve the situation.

No, the display is done by cyclictest main thread, not by the
measurement threads.

-- 


					    Gilles Chanteperdrix.

