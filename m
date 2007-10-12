Message-ID: <470F37C8.4090301@domain.hid>
Date: Fri, 12 Oct 2007 11:00:56 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <470E8BFE.4070804@domain.hid>
In-Reply-To: <470E8BFE.4070804@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [PATCH] fix hw-timer setup/cleanup for i386
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: Xenomai-core@domain.hid

Philippe,

Jan Kiszka wrote:
> This patch for SVN trunk fixes most of the current bugs around hardware
> timer takeover and release from/to Linux. Tested and found working here
> (including SMP):
> - 2.6.22, APIC, highres=off, nohz=off
> - 2.6.22, APIC, highres=on, nohz=on
> - 2.6.20, APIC
> 
> Tests to be done:
> - 2.6.22, PIT (currently building...)
> - 2.6.20, PIT

To close this topic: Also the tests with APIC switched off were
successfully completed yesterday. So the logic should be fine now, ...

> 
> Things became quite complex in i386/hal.c now. Some of this complexity
> might be avoidable if RTHAL_APIC_TIMER_VECTOR equalled
> LOCAL_TIMER_VECTOR. What's the reason for this? Is it something related
> to pre-highres times of Linux (ie. 2.6.20 and earlier)? Can we overcome
> it, at least for recent kernels?
> 
> So, while this patch may work correctly, my feeling is it needs yet
> another round of polishing, also looking for now possibly outdated comments.
> 

...just this aspect needs to be addressed.

Jan

-- 
Siemens AG, Corporate Technology, CT SE 2
Corporate Competence Center Embedded Linux

