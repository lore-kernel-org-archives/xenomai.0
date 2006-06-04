Message-ID: <44831F4A.70806@domain.hid>
Date: Sun, 04 Jun 2006 19:58:34 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [RFC] shadow threads with prio 0 / SCHED_NORMAL
References: <4446B348.10403@domain.hid>
In-Reply-To: <4446B348.10403@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

Jan Kiszka wrote:
> Hi,
> 
> this is an experimental hack to open the non-rt priority levels of Linux
> to Xenomai shadow threads, i.e. allow shadows to be scheduled under
> SCHED_NORMAL when in secondary mode. The scenario are typical borderline
> threads between RT and non-RT: they share a critical code path with RT
> threads, maybe mutex protected, but they are mostly time-sharing threads
> which do not need SCHED_FIFO for this.

Merged the nucleus and native API changes, thanks. The POSIX skin still 
needs to be updated to use those new timesharing Xenomai-enabled threads 
though.

-- 

Philippe.

