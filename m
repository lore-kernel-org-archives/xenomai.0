Message-ID: <48E4F2E9.2020909@domain.hid>
Date: Thu, 02 Oct 2008 18:12:25 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <48E4EE00.5080409@domain.hid> <48E4EE52.2000202@domain.hid>
In-Reply-To: <48E4EE52.2000202@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] rt_task_set_priority vs. Linux priority
Reply-To: rpm@xenomai.org
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Jan Kiszka <jan.kiszka@domain.hid>, xenomai-core <xenomai@xenomai.org>

Gilles Chanteperdrix wrote:
> Jan Kiszka wrote:
>> Quick question $customer stumbled over: Shouldn't the user space part of
>> rt_task_set_priority also (or rather?) adjust the Linux priority of the
>> caller? My impression is yes. Actually, translating the native priority
>> to sched_setscheduler parameters and calling that service would be
>> better, no?
> 

The nucleus does this for us, but that is not enough due to the glibc caching
priority levels.

> I believe Philippe already fixed that in trunk.
> 

Mostly yes, but properly only for task creation/shadowing requests. There is
still a problem with the glibc caching the priority level with set_priority()
calls, since we only rely on the nucleus, without telling the glibc about the
change. However, this would trigger a secondary mode switch.

AFAIC, I don't see how changing priorities on the fly within a time critical
section could be considered as good programming practice; this would tend to
indicate that somebody is playing with priorities to paper over an application
design issue. For that reason, enduring a mode switch upon
rt_task_set_priority() calls (and friends) would be ok for me. But that's
certainly debatable.

-- 
Philippe.

