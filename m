Message-ID: <48E4F63C.9040206@domain.hid>
Date: Thu, 02 Oct 2008 18:26:36 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <48E4EE00.5080409@domain.hid>
	<48E4EE52.2000202@domain.hid>	<48E4F2E9.2020909@domain.hid>
	<48E4F457.4000004@domain.hid> <48E4F596.6070302@domain.hid>
In-Reply-To: <48E4F596.6070302@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] rt_task_set_priority vs. Linux priority
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

Jan Kiszka wrote:
> Gilles Chanteperdrix wrote:
>> Philippe Gerum wrote:
>>> AFAIC, I don't see how changing priorities on the fly within a time critical
>>> section could be considered as good programming practice; this would tend to
>>> indicate that somebody is playing with priorities to paper over an application
>>> design issue.
>> So, you mean PIP papers over application design issues ? Just kidding...
> 
> In this case, we face an operation mode switch of the thread: It use to
> due high prio work in primary mode only, now its finished and what to

"It used to do [...] and wants to [...]" - hell...

> flush its data to Linux, but without causing troubles to the Linux
> schedule due to its SCHED_FIFO level.

Jan

-- 
Siemens AG, Corporate Technology, CT SE 2
Corporate Competence Center Embedded Linux

