Resent-To: Xenomai help <xenomai@xenomai.org>
Resent-Message-Id: <4BB5C23E.4070005@domain.hid>
Message-ID: <4BB5C0D0.5030804@domain.hid>
Date: Fri, 02 Apr 2010 12:02:56 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <20100401230843.GF3755@domain.hid>	
	<4BB53566.3010601@domain.hid> <4BB53643.2080604@domain.hid>	
	<j2yb88603c31004020058i3aae7947s1428f1b87f4b1097@domain.hid>	
	<4BB5B64B.6040803@domain.hid> <4BB5B7C1.4020301@domain.hid>	
	<4BB5B874.5090904@domain.hid>
	<k2pb88603c31004020232z28e10d59vc546b1b8803113f2@domain.hid>
	<4BB5BA2D.1080604@domain.hid> <4BB5C032.1020808@domain.hid>
In-Reply-To: <4BB5C032.1020808@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] New scheduler class
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>

Jan Kiszka wrote:
> Gilles Chanteperdrix wrote:
>> Henri Roosen wrote:
>>> Ok, I might give Jan's proposal a try and could be sufficient for us:a
>>> Xenomai thread with non-RT scheduling class (didn't know that was
>>> possible).
>>>
>>> We just need the thread in the Xenomai domain for being able to access
>>> Xenomai resources, but want it to be scheduled together with the Linux
>>> nice levels. A near IDLE nice level should be ok. We just don't want
>>> that our Xenomai 'idle' thread with a while(1) would prevent Linux to
>>> run.
>> That will happen with SCHED_OTHER if while(1) occurs while running in
>> primary mode.
>>
> 
> Indeed. But that's in fact a deficit of our mapping of non-RT sched
> policies on the Xenomai scheduler. We should not leave, e.g., a
> SCHED_OTHER thread migrated in primary as long as it does not hold any
> resources. We can't perform SCHED_OTHER scheduling in Xenomai, we have
> to push this to Linux.

You have the scheduling classes, you can in fact now implement
SCHED_OTHER the way you like. This SCHED_OTHER as a priority 0
SCHED_FIFO dates back from the time when we had not the scheduling classes.

-- 
					    Gilles.


