From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17504.65186.650064.785243@domain.hid>
Date: Tue, 9 May 2006 22:42:10 +0200
Subject: Re: [Xenomai-core] [bug] lock-up by failing rt_task_spawn/create
In-Reply-To: <4460FC50.6030904@domain.hid>
References: <4460FC50.6030904@domain.hid>
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
 > BTW, this reminds me the ask for a merging plan of the kgdb support for
 > ipipe - this bug was tracked down via kgdb...

There are some issues with the kgdb patch:
- it does not work if the nucleus is compiled as a module, because it
  uses xnpod_current_thread()
- it does not work on SMP because the kgdb patch uses
  smp_processor_id(), which does not work on SMP over Xenomai domain.

-- 


					    Gilles Chanteperdrix.

