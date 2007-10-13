Date: Sat, 13 Oct 2007 18:12:11 +0200
From: Stelian Pop <stelian@domain.hid>
Message-ID: <20071013161211.GB24909@domain.hid>
References: <470E8BFE.4070804@domain.hid> <1192179524.5149.23.camel@domain.hid>
	<470F3B03.1040501@domain.hid>
	<20071012110054.GA26325@domain.hid>
	<470FD0AC.6040700@domain.hid> <470FD795.9070008@domain.hid>
	<20071012215152.GA17187@domain.hid>
	<1192226314.6499.174.camel@domain.hid>
	<1192285734.8592.4.camel@domain.hid> <4710D953.1030604@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4710D953.1030604@domain.hid>
Subject: Re: [Xenomai-core] [PATCH] fix hw-timer setup/cleanup for i386
Reply-To: Stelian Pop <stelian@domain.hid>
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
Cc: Xenomai-core@domain.hid

On Sat, Oct 13, 2007 at 04:42:27PM +0200, Jan Kiszka wrote:

> Where do you get ENODEV? On nucleus startup? Please provide
> /proc/timer_list output of the working and non-working setups.

It turns out that I had the Linux NMI watchdog enabled (nmi_watchdog=1
on the command line) and this was causing the -ENODEV problems. Once
removed, I'm able to boot and successfully run all configurations: UP,
UP + APIC, UP + APIC + IO_APIC, SMP. And the latencies are back to normal.

Maybe we should detect that the NMI watchdog is enabled and issue a
warning message, this would save others a few hours and many kernel
builds...

This is with your timer cleanup patch, of course.

> PS: For unknown reasons your mails don't make it to my web.de address,
> only to the list. Do you get any error messages?

I did get one saying:
	<jan.kiszka@domain.hid>: host mx-ha02.web.de[217.72.192.188] refused to talk to me:
	554 Transaction failed. For explanation visit
	http://freemail.web.de/reject/?ip=88.191.70.230

I didn't investigate yet what's happenning.

-- 
Stelian Pop <stelian@domain.hid>    

