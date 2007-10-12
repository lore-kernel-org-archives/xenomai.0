Date: Fri, 12 Oct 2007 23:51:52 +0200
From: Stelian Pop <stelian@domain.hid>
Message-ID: <20071012215152.GA17187@domain.hid>
References: <470E8BFE.4070804@domain.hid> <1192179524.5149.23.camel@domain.hid>
	<470F3B03.1040501@domain.hid>
	<20071012110054.GA26325@domain.hid>
	<470FD0AC.6040700@domain.hid> <470FD795.9070008@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <470FD795.9070008@domain.hid>
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

On Fri, Oct 12, 2007 at 10:22:45PM +0200, Stelian Pop wrote:

> Or even go crazy and activate SMP again ?

Would have been too easy:

# modprobe xeno_native
Xenomai: native skin init failed, code -19.

This is with all relevant options on (HPET, HIRES, SMP, NO_HZ).
I guess I'll have to take one step at a time.

-- 
Stelian Pop <stelian@domain.hid>    

