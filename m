Message-ID: <46543DDE.7030001@domain.hid>
Date: Wed, 23 May 2007 15:13:02 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <46543091.3040308@domain.hid> <465434B9.6010805@domain.hid>
	<4654386C.6060309@domain.hid>
In-Reply-To: <4654386C.6060309@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] loading module
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Rodolfo <rolfetas@domain.hid>
Cc: xenomai@xenomai.org

Rodolfo wrote:
> //timer_period_counts=rt_timer_set_mode(rt_timer_ns2tsc(timer_period_ns));

See
http://www.xenomai.org/documentation/branches/v2.3.x/html/api/group__native__timer.html#gffcb5eaef6c3a64a05445f6dafdbb155

the parameter of rt_timer_set_mode is a count of nanoseconds.

>     //rt_task_set_periodic(&thread, expected,
> rt_timer_ns2tsc(task_period_ns));

the task period passed to rt_task_set_periodic is a count of ticks,
which should be obtained with rt_timer_ns2ticks.

-- 
                                                 Gilles Chanteperdrix

