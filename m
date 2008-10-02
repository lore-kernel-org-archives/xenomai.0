Message-ID: <48E4F172.3000400@domain.hid>
Date: Thu, 02 Oct 2008 18:06:10 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <48E4EE00.5080409@domain.hid> <48E4EE52.2000202@domain.hid>
In-Reply-To: <48E4EE52.2000202@domain.hid>
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
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai-core <xenomai@xenomai.org>

Gilles Chanteperdrix wrote:
> Jan Kiszka wrote:
>> Quick question $customer stumbled over: Shouldn't the user space part of
>> rt_task_set_priority also (or rather?) adjust the Linux priority of the
>> caller? My impression is yes. Actually, translating the native priority
>> to sched_setscheduler parameters and calling that service would be
>> better, no?
> 
> I believe Philippe already fixed that in trunk.
> 

Hmmm... but we are on trunk, just a few weeks old...

The scenario, as far as I understood it, is that rt_task_set_priority is
called from primary context. But the propagation in
xnpod_renice_thread_inner targets relaxed contexts only. Probably that's
the core of the issue. We need to propagate the modification when
migrating next time. Maybe some flag "update Linux prio" so that we only
go that way when actually required.

BTW, strike my idea of using plain sched_setscheduler - would kick us
out of primary mode unconditionally.

Jan

-- 
Siemens AG, Corporate Technology, CT SE 2
Corporate Competence Center Embedded Linux

