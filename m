Message-ID: <4E6A6BC0.4080308@domain.hid>
Date: Fri, 09 Sep 2011 21:40:48 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <BE5655A7-935E-4ABC-8D95-188D7D00C125@domain.hid>
In-Reply-To: <BE5655A7-935E-4ABC-8D95-188D7D00C125@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Linux scheduling question
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jeremy Friesner <jaf@domain.hid>
Cc: xenomai@xenomai.org

On 09/09/2011 09:08 PM, Jeremy Friesner wrote:
> Hi all,
> 
> In the bad old days, when I was running my software on a 233MHz
> PowerPC computer with (non-Xenomai) Linux, I could instantly hang the
> machine using the following code:
> 
> struct sched_param schedparam; memset(&schedparam, 0,
> sizeof(schedparam)); schedparam.sched_priority = 11; if
> (sched_setscheduler(0, SCHED_RR, &schedparam) != 0)
> perror("sched_setscheduler"); while(1) {/* spin forever, wheee! */}
> 
> To recover I would have to power-cycle, since there was no way to
> kill the spinning process.
> 
> Now my software runs on a quad-core Xeon under Xenomai, so I would
> expect that it would take four simultaneous instances of the above to
> hang the Linux layers of the machine (the Xenomai real-time bits
> should still run, of course).  However, that is not what I am
> seeing.... I can run 4, 8, or even 12 SCHED_RR (or SCHED_FIFO)
> spinning processes like the above, and my regular (SCHED_OTHER) Linux
> process continue to respond (albeit sometimes rather slowly).
> 
> Can anyone hazard a guess as to why I'm unable to spin my Linux OS to
> death?  I'm curious... :^)

That is because SCHED_FIFO and SCHED_RR tasks can only use
/proc/sys/kernel/sched_rt_runtime_us every
/proc/sys/kernel/sched_rt_period_us.

-- 
                                                                Gilles.

