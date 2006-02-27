From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17411.18293.205947.507401@domain.hid>
Date: Mon, 27 Feb 2006 19:39:49 +0100
Subject: Re: [Xenomai-help] resume/suspend periodic timing issue
In-Reply-To: <C0284AC8.253E%steve@domain.hid>
References: <C0284AC8.253E%steve@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Steven Seeger <steve@domain.hid>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

Steven Seeger wrote:
 > I seem to have discovered a condition where if I have a thread in periodic
 > timing (system tick of 125000 ns) and my thread suspends itself based on
 > some condition, when I resume the thread later based on user input,
 > rt_task_wait_period() doesn't block until the thread has "caught up" with
 > where it should be. In other words, say I have a thread that is supposed to
 > run every 2 ms. I suspend it for 1 second, and then resume it.
 > rt_task_wait_period() will return immediately 50 times. This can be fixed by
 > calling rt_task_set_periodic() again after the thread's suspend call.
 > 
 > Is there any way around this?

This behaviour is due to the way the overruns are accounted for: not
having called rt_task_wait_period while the periodic timer elapses is
currently considered an abnormal usage of the interface, and counted as
an overrun.

A way around this behaviour is to create an alarm object with
rt_alarm_create, and use rt_alarm_start and rt_alarm_wait for each
shot.

-- 


					    Gilles Chanteperdrix.

