Message-ID: <470E5724.3000100@domain.hid>
Date: Thu, 11 Oct 2007 19:02:28 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <FDBBB5CC70676540B3EF7CFE83FD94E0B47607@domain.hid>
In-Reply-To: <FDBBB5CC70676540B3EF7CFE83FD94E0B47607@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] Xenomai on Xscale (Linux 2.6.20)
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: ROSSIER Daniel <Daniel.Rossier@domain.hid>
Cc: xenomai@xenomai.org

ROSSIER Daniel wrote:
> Hi everyone,
> 
> I'm taking over the original thread from Patrick concerning the port of
> Xenomai on Xscale with Linux 2.6.20. Briefly summarized, the boot
> process actually freezes after a while right after the nucleus has been
> started.
> 
> I've investigated the issue over the last hours, and I came up with the
> following conclusion: it seems that the problem is due to a endless loop
> in do_gettimeofday in arch/arm/kernel/time.c. Here is the code:
> 
> "...
> do {
> 		seq = read_seqbegin_irqsave(&xtime_lock, flags);
> 		usec = system_timer->offset();
> 		sec = xtime.tv_sec;
> 		usec += xtime.tv_nsec / 1000;
> 	} while (read_seqretry_irqrestore(&xtime_lock, seq, flags));
> ..."
> 
> If I remove the do { } while loop with the call to
> read_seqbegin_irqsave(), then the boot process is going ahead (I got a
> suspicious error like "I-pipe: Detected illicit call from domain
> 'Xenomai' " but it might well be normal with such a modification.

Please post the full oops about that "illicit call". It may point to an
otherwise hidden invalid usage of Linux services over the Xenomai domain
and explain the lock-up.

Jan

-- 
Siemens AG, Corporate Technology, CT SE 2
Corporate Competence Center Embedded Linux

