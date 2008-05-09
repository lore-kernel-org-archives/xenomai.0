Message-ID: <48241C40.1020503@domain.hid>
Date: Fri, 09 May 2008 11:41:20 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <48241735.1050400@domain.hid> <482419AC.1060706@domain.hid>
In-Reply-To: <482419AC.1060706@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [PATCH] avoid deadlock-prone sighand_lock
	in	do_schedule_event
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
Cc: Xenomai-core@domain.hid

Philippe Gerum wrote:
> Jan Kiszka wrote:
>> This has been posted earlier already: Fix deadlocks when debugging
>> Xenomai applications via gdb by removing any attempt to acquire
>> sighand_lock (while holding rq_lock). This patch also cleans up the now
>> unused lock wrapper.
>>
>> Unless someone complains, I'm going to merge this later today into trunk
>> and 2.4.x.
>>
> 
> It's already in.

Indeed, missed it. May I remove the wrapper?

Jan

-- 
Siemens AG, Corporate Technology, CT SE 2
Corporate Competence Center Embedded Linux

