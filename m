Message-ID: <48E4EE52.2000202@domain.hid>
Date: Thu, 02 Oct 2008 17:52:50 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <48E4EE00.5080409@domain.hid>
In-Reply-To: <48E4EE00.5080409@domain.hid>
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
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

Jan Kiszka wrote:
> Quick question $customer stumbled over: Shouldn't the user space part of
> rt_task_set_priority also (or rather?) adjust the Linux priority of the
> caller? My impression is yes. Actually, translating the native priority
> to sched_setscheduler parameters and calling that service would be
> better, no?

I believe Philippe already fixed that in trunk.

-- 
                                                 Gilles.

