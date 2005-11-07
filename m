From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17263.53196.315176.630084@domain.hid>
Date: Mon, 7 Nov 2005 23:06:04 +0100
Subject: RE: [Xenomai-help] number-crunching execution jitter
In-Reply-To: <2F8EE677D406514ABE53EF9C0934A666017CAF3E@anubis2.clb.tcfr.thales>
References: <2F8EE677D406514ABE53EF9C0934A666017CAF3E@anubis2.clb.tcfr.thales>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Dominique.RAGOT@fr.thalesgroup.com
Cc: xenomai@xenomai.org

Dominique.RAGOT@fr.thalesgroup.com wrote:
 > In the meantime I modified the benchmark with a call to the routine
 > pthread_set_mode_np(0, PTHREAD_SHIELD) immediately after thread is
 > created, and observes a huge reduction in execution jitter, but at
 > the expense of wakeup jitter. So I concluded the interrupt shield was
 > definitely not doing much without this call. Am I wrong ? 

I guess Philippe and Stephane gave you answers regarding the way to
activate the shield (I did not check if pthread_set_mode fails when the
shield was disabled at compilation time and is used at run time, if not,
maybe it would be a good idea ?).

Now about the wakeup jitter, if you are still using the "cruncher" as in
RTAI/Fusion, what is called "nanosleep jitter" may not be a precise
measurement of the wakeup latency. A better measurement of the
scheduling latency using the POSIX skin is obtained using the
clock_nanosleep call with the TIMER_ABSTIME flag, pass an absolute time,
and measure the difference between this time and the wakeup time.

Also note that CLOCK_MONOTONIC will give better accuracy than
CLOCK_REALTIME, since it is using the tsc even when system timer is in
periodic mode.

-- 


					    Gilles Chanteperdrix.

