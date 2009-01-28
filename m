Message-ID: <49809266.3090706@domain.hid>
Date: Wed, 28 Jan 2009 17:14:14 +0000
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <498085C2.7090604@domain.hid> <49809064.9050807@domain.hid>
In-Reply-To: <49809064.9050807@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] trunk: xnsched_set_policy seems to set only cprio
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: rpm@xenomai.org
Cc: Jan Kiszka <jan.kiszka@domain.hid>, xenomai-core <xenomai@xenomai.org>

Philippe Gerum wrote:
> Jan Kiszka wrote:
>> Hi,
>>
>> unfortunately I'm forced to switch to other bugs, but I found out a bit
>> more about the issue that pthread_getschedparam doesn't return the
>> correct policy&prio under trunk - at least when called from threads
>> created via pthread_create as SCHED_FIFO:
>>
>> Such threads start with SCHED_OTHER, but then the propagation via
>> do_setsched_event and finally xnsched_set_policy only seems to affect
>> thread.cprio, not bprio. Will see if I can continue debugging this
>> later, but maybe /someone/ already knows what goes wrong...
>>
> 
> With the new scheduler infrastructure, ->bprio tends to be used solely as a
> priority backup area when dealing with PIP; but at the same time, some skins
> still consider it as an always up-to-date location where to find the nominal
> priority of a thread, so this hunk should help in keeping things compatible with
> 2.4.x:

Yes, the posix spec specifically ask that the priority as set by
pthread_setschedparam is returned, and not the boosted priority in case
of PIP.

-- 
                                                 Gilles.

